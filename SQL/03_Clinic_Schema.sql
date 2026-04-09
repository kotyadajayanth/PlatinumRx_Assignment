CREATE TABLE clinics (
    cid TEXT,
    clinic_name TEXT,
    city TEXT,
    state TEXT,
    country TEXT
);

CREATE TABLE customers (
    uid TEXT,
    name TEXT,
    mobile TEXT
);

CREATE TABLE clinic_sales (
    oid TEXT,
    uid TEXT,
    cid TEXT,
    amount REAL,
    datetime TEXT,
    sales_channel TEXT
);

CREATE TABLE expenses (
    eid TEXT,
    cid TEXT,
    description TEXT,
    amount REAL,
    datetime TEXT
);