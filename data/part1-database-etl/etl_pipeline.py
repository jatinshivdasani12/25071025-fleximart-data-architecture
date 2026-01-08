# --------------------
# Imports
# --------------------
import pandas as pd
from pathlib import Path
from sqlalchemy import create_engine, text

# --------------------
# Database config
# --------------------
DB_URL = "mysql+mysqlconnector://root:jatinshiv19@localhost:3306/fleximart"
engine = create_engine(DB_URL)

# --------------------
# Paths
# --------------------
BASE_DIR = Path(__file__).resolve().parent
DATA_DIR = BASE_DIR / "data"

# ---------------------------
# Extract
# ---------------------------
def extract_customers():
    df = pd.read_csv(DATA_DIR / "customers_raw.csv")
    return df

# ---------------------------
# Transform
# ---------------------------
def transform_customers(df):
    # Remove duplicates
    df = df.drop_duplicates()

    # Clean phone numbers
    def clean_phone(phone):
        if pd.isna(phone):
            return None
        phone = str(phone).replace("-", "").replace(" ", "")
        if phone.startswith("+91"):
            return phone
        if phone.startswith("0"):
            phone = phone[1:]
        return "+91" + phone

    df['phone'] = df['phone'].apply(clean_phone)

    # Convert registration_date to proper format
    df['registration_date'] = pd.to_datetime(
        df['registration_date'],
        errors='coerce'
    ).dt.date

    # Drop rows with missing email (DB constraint)
    df = df[df['email'].notna()]
    return df

# --------------------
# Products ETL
# --------------------

def extract_products():
    return pd.read_csv(DATA_DIR / "products_raw.csv")

def transform_products(df):
    df = df.drop_duplicates()

    df['price'] = pd.to_numeric(df['price'], errors='coerce')

    df = df.dropna(subset=['product_name', 'price'])
    return df

def load_products(df):
    df.to_sql(
        name='products',
        con=engine,
        if_exists='append',
        index=False
    )
def extract_sales():
    return pd.read_csv(DATA_DIR / "sales_raw.csv")
def transform_sales(df):
    df = df.copy()

    # Remove duplicate transactions
    df = df.drop_duplicates(subset=['transaction_id'])

    # Drop rows with missing foreign keys
    df = df.dropna(subset=['customer_id', 'product_id'])

    # Normalize date
    df['transaction_date'] = pd.to_datetime(
        df['transaction_date'],
        errors='coerce',
        dayfirst=False
    ).dt.date

    # Convert numeric fields
    df['quantity'] = pd.to_numeric(df['quantity'], errors='coerce')
    df['unit_price'] = pd.to_numeric(df['unit_price'], errors='coerce')

    # Remove invalid numeric rows
    df = df.dropna(subset=['quantity', 'unit_price'])

    # Calculate subtotal
    df['subtotal'] = df['quantity'] * df['unit_price']

    # Remove cancelled orders
    df = df[df['status'] != 'Cancelled']

    return df
def load_orders(df):
    orders_df = df.groupby(
        ['customer_id', 'transaction_date', 'status'],
        as_index=False
    )['subtotal'].sum()

    orders_df.rename(
        columns={
            'transaction_date': 'order_date',
            'subtotal': 'total_amount'
        },
        inplace=True
    )

    orders_df.to_sql(
        name='orders',
        con=engine,
        if_exists='append',
        index=False
    )

    return orders_df
def load_order_items(df, orders_df):
    order_items_df = df.merge(
        orders_df,
        on=['customer_id'],
        how='left'
    )

    order_items_df = order_items_df[[
        'product_id',
        'quantity',
        'unit_price',
        'subtotal'
    ]]

    order_items_df.to_sql(
        name='order_items',
        con=engine,
        if_exists='append',
        index=False
    )
# ----------------------
# Database helpers
# ----------------------
def clear_products_table():
    with engine.begin() as conn:
        conn.execute(text("DELETE FROM products"))

def clear_customers_table():
    with engine.begin() as conn:
        conn.execute(text("DELETE FROM customers"))

def load_customers(df):
    customers_df = df[
    [
        'customer_id',
        'first_name',
        'last_name',
        'email',
        'phone',
        'city',
        'registration_date'
    ]
]


# --------------------
# Main
# --------------------
def main():
    # Customers
    clear_customers_table()
    customers = extract_customers()
    customers_clean = transform_customers(customers)
    load_customers(customers_clean)
    print("Customers data loaded into MySQL successfully")

    # Products
    clear_products_table()
    products = extract_products()
    products_clean = transform_products(products)
    load_products(products_clean)
    print("Products data loaded into MySQL successfully")

    # Sales
    sales = extract_sales()
    sales_clean = transform_sales(sales)
    orders_df = load_orders(sales_clean)
    load_order_items(sales_clean, orders_df)
    print("Sales data loaded into MySQL successfully")


if __name__ == "__main__":
    main()
