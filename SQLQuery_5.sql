CREATE Table tags(
  id INT IDENTITY(1,1) primary key,
  tag_name VARCHAR(255) NOT NULL,
  icon TEXT,
  created_at DATETIME,
  updated_at DATETIME,
  created_by UNIQUEIDENTIFIER,
  updated_by UNIQUEIDENTIFIER 
);

CREATE Table categories (
  id UNIQUEIDENTIFIER primary key,
  parent_id UNIQUEIDENTIFIER FOREIGN key REFERENCES categories(id),
  category_name varchar(255),
  category_description text,
  icon text,
  image_path text,
  active BIT,
  created_at DATETIME,
  updated_at DATETIME,
  created_by UNIQUEIDENTIFIER,
  updated_by UNIQUEIDENTIFIER
);

CREATE Table staff_accounts (
  id UNIQUEIDENTIFIER primary key,
  first_name varchar(100),
  last_name varchar(100),
  phone_number varchar(100),
  email varchar(255),
  password_hash text,
  active BIT,
  profile_img text,
  registered_at DATETIME,
  updated_at DATETIME,
  created_by UNIQUEIDENTIFIER,
  updated_by  UNIQUEIDENTIFIER
);

CREATE Table products(
  id UNIQUEIDENTIFIER primary key,
  product_name varchar(255),
  SKU varchar(255),
  regular_price numeric,
  discount_price numeric,
  quantity integer,
  short_description varchar(255),
  product_description text,
  product_weight numeric,
  product_note varchar(255),
  published BIT,
  created_at DATETIME,
  updated_at DATETIME,
  created_by UNIQUEIDENTIFIER,
  updated_by UNIQUEIDENTIFIER
);

CREATE TABLE variants(
    id UNIQUEIDENTIFIER PRIMARY KEY,
    product_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES products(id)
);
CREATE TABLE variant_values(
    id UNIQUEIDENTIFIER PRIMARY KEY,
    variant_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES variants(id),
    price NUMERIC,
    quantity INTEGER
);

CREATE TABLE product_tags(
    tag_id INTEGER FOREIGN KEY REFERENCES tags(id),
    product_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES products(id)
    
);

Create Table product_categories(
  category_id UNIQUEIDENTIFIER PRIMARY KEY,
  product_id UNIQUEIDENTIFIER
);

CREATE TABLE roles(
    id INT IDENTITY(1, 1) PRIMARY Key,
    role_name VARCHAR(255),
    privileges TEXT,
    created_at DATETIME,
    updated_at DATETIME,
    created_by UNIQUEIDENTIFIER,
    updated_by UNIQUEIDENTIFIER
);

CREATE TABLE staff_roles(
    staff_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES staff_accounts(id),
    role_id INTEGER FOREIGN KEY REFERENCES roles(id)
    PRIMARY KEY (staff_id,role_id)
);

CREATE TABLE notifications(
    id UNIQUEIDENTIFIER PRIMARY KEY,
    account_name UNIQUEIDENTIFIER FOREIGN KEY REFERENCES staff_accounts(id),
    title VARCHAR(100),
    content TEXT,
    seen BIT,
    created_at DATETIME,
    recelve_time DATETIME,
    notification_expiry_date DATE
);


CREATE TABLE slideshows(
    id UNIQUEIDENTIFIER PRIMARY KEY,
    destination_url TEXT,
    image_url TEXT,
    clicks SMALLINT,
    created_at DATETIME,
    updated_at DATETIME,
    created_by UNIQUEIDENTIFIER,
    updated_by UNIQUEIDENTIFIER
);

CREATE TABLE attributes(
    id UNIQUEIDENTIFIER PRIMARY KEY,
    attribute_name VARCHAR(255),
    created_at DATETIME,
    updated_at DATETIME,
    created_by UNIQUEIDENTIFIER,
    updated_by UNIQUEIDENTIFIER
);

CREATE TABLE coupons(
    id UNIQUEIDENTIFIER PRIMARY KEY,
    code VARCHAR(255),
    coupon_description TEXT,
    discount_value NUMERIC,
    discont_type VARCHAR(50),
    times_used INTEGER,
    max_usage INTEGER,
    coupon_start_date DATETIME,
    coupon_end_date DATETIME,
    created_at DATETIME,
    updated_at DATETIME,
    created_by UNIQUEIDENTIFIER,
    updated_by UNIQUEIDENTIFIER
);

CREATE TABLE product_coupons(
    coupon_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES coupons(id),
    product_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES products(id)
    PRIMARY KEY (coupon_id,product_id)
);

CREATE TABLE customers(
    id UNIQUEIDENTIFIER PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR (100),
    phone_number VARCHAR(255),
    email TEXT,
    password_hash TEXT,
    active BIT,
    registered_at DATETIME,
    created_at DATETIME
);

CREATE TABLE customer_addresses(
    id UNIQUEIDENTIFIER PRIMARY KEY,
    customer_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES customers(id),
    address_line1 TEXT,
    address_line2 TEXT,
    postal_code VARCHAR(255),
    country VARCHAR(255),
    city VARCHAR(255),
    phone_number VARCHAR(255)
);

CREATE TABLE order_statuses(
    id INT IDENTITY(1, 1) PRIMARY Key,
    status_name VARCHAR(255),
    color VARCHAR(50),
    privacy VARCHAR(50),
    created_at DATETIME,
    updated_at DATETIME,
    created_by UNIQUEIDENTIFIER,
    updated_by UNIQUEIDENTIFIER
);

CREATE TABLE orders(
    id UNIQUEIDENTIFIER PRIMARY KEY,
    coupon_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES coupons(id),
    customer_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES customers(id),
    order_status_id INTEGER FOREIGN KEY REFERENCES order_statuses(id),
    order_approved_at DATETIME,
    order_delivered_at DATETIME,
    order_delivered_carrier_date DATETIME,
    created_at DATETIME
);

CREATE TABLE galleries(
    id UNIQUEIDENTIFIER PRIMARY KEY,
    product_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES products(id),
    image_path TEXT,
    thumbnail BIT,
    display_order SMALLINT,
    created_at DATETIME,
    updated_at DATETIME,
    created_by UNIQUEIDENTIFIER,
    updated_by UNIQUEIDENTIFIER
);

CREATE TABLE sells(
    id UNIQUEIDENTIFIER PRIMARY KEY,
    product_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES products(id),
    price FLOAT,
    quantity SMALLINT
);

CREATE TABLE shippings(
    id INT  PRIMARY Key IDENTITY(1, 1),
    name TEXT,
    active BIT,
    icon_path TEXT,
    created_at DATETIME,
    updated_at DATETIME,
    created_by UNIQUEIDENTIFIER,
    updated_by UNIQUEIDENTIFIER
);

CREATE TABLE product_shippings(
    product_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES products(id),
    shipping_id INTEGER FOREIGN KEY REFERENCES shippings(id),
    ship_charge NUMERIC,
    free BIT,
    estimated NUMERIC
    PRIMARY KEY(product_id,shipping_id)
);
CREATE TABLE cards(
    id UNIQUEIDENTIFIER PRIMARY KEY,
    customer_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES customers(id)
);

CREATE TABLE card_items(
    id UNIQUEIDENTIFIER,
    card_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES cards(id),
    product_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES products(id),
    quantity SMALLINT
    PRIMARY KEY (card_id,product_id)
);

CREATE TABLE order_items(
    id UNIQUEIDENTIFIER,
    product_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES products(id),
    order_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES orders(id),
    price NUMERIC,
    quantity INTEGER,
    shipping_id INTEGER FOREIGN KEY REFERENCES shippings(id)
    PRIMARY KEY(product_id,order_id)
);

CREATE TABLE product_attributes(
    product_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES products(id),
    attribute_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES attributes(id)
    PRIMARY KEY (product_id,attribute_id)
);

CREATE TABLE attribute_values(
    id UNIQUEIDENTIFIER PRIMARY KEY,
    attribute_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES attributes(id),
    attribute_value VARCHAR(255),
    color VARCHAR(50)
);

CREATE TABLE variant_attribute_values(
    variant_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES variants(id),
    attribute_value_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES attribute_values(id)
    PRIMARY KEY (variant_id,attribute_value_id)
);