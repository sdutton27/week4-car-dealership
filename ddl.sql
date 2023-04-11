-- create customers table
CREATE TABLE customers(
    customer_id SERIAL,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    phone NUMERIC(10),
    email VARCHAR(50),
    date_added TIMESTAMP
);

--set default for date_added
ALTER TABLE customers
ALTER date_added SET DEFAULT NOW();

--make sure customer_id is PRIMARY KEY
ALTER TABLE customers
ADD PRIMARY KEY (customer_id);

-- COMMENTS
COMMENT ON TABLE customers IS 'Table containing customers';
COMMENT ON COLUMN customers.customer_id IS 'id of the customer';
COMMENT ON COLUMN customers.first_name IS 'first name of the customer';
COMMENT ON COLUMN customers.last_name IS 'last name of the customer';
COMMENT ON COLUMN customers.phone IS 'phone number of the customer';
COMMENT ON COLUMN customers.email IS 'email of the customer';
COMMENT ON COLUMN customers.date_added IS 'date the customer was added to the system';

-- create cars table
CREATE TABLE cars(
    vin_num INTEGER,
    make VARCHAR(50),
    model VARCHAR(50),
    year INTEGER,
    used BOOLEAN,
    base_cost MONEY,
    for_sale BOOLEAN,
    customer_id INTEGER DEFAULT null
);

/* update for_sale default to true
so by default, a car is for sale */
ALTER TABLE cars
ALTER for_sale SET DEFAULT true;

/* update base_cost default to null
so by default, a car does not have a base cost */
ALTER TABLE cars
ALTER base_cost SET DEFAULT null;

-- make sure vin num is unique
ALTER TABLE cars
ADD UNIQUE(vin_num);

--set vin_num as primary key
ALTER TABLE cars
ADD PRIMARY KEY (vin_num);

-- if customer is deleted, then also delete their car(s)
ALTER TABLE cars
ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE;

-- just kidding ^ -- we don't want customers to be able to be deleted
ALTER TABLE cars
ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE RESTRICT;

-- COMMENTS
COMMENT ON TABLE cars IS 'Table containing cars (that have been for sale/worked on)';
COMMENT ON COLUMN cars.vin_num IS 'VIN of the car';
COMMENT ON COLUMN cars.make IS 'make of the car';
COMMENT ON COLUMN cars.model IS 'model of the car';
COMMENT ON COLUMN cars.year IS 'year of the car';
COMMENT ON COLUMN cars.used IS 'if the car is used';
COMMENT ON COLUMN cars.base_cost IS 'base cost of the car';
COMMENT ON COLUMN cars.for_sale IS 'if the car is for sale';
COMMENT ON COLUMN cars.customer_id IS 'id of the customer who owns the car';

CREATE TABLE employees(
    employee_id SERIAL,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    job_title VARCHAR(20),
    email VARCHAR(50),
    birthday DATE,
    pin_code NUMERIC(4),
    phone NUMERIC(10)
);

-- make sure pin code is unique
ALTER TABLE employees
ADD UNIQUE(pin_code);

-- set primary key
ALTER TABLE employees
ADD PRIMARY KEY (employee_id);

-- COMMENTS
COMMENT ON TABLE employees IS 'Table containing employees';
COMMENT ON COLUMN employees.employee_id IS 'employee ID of the employee';
COMMENT ON COLUMN employees.first_name IS 'first name of the employee';
COMMENT ON COLUMN employees.last_name IS 'last name of the employee';
COMMENT ON COLUMN employees.job_title IS 'job title of the employee';
COMMENT ON COLUMN employees.email IS 'email of the employee';
COMMENT ON COLUMN employees.birthday IS 'birthday of the employee';
COMMENT ON COLUMN employees.pin_code IS 'pin code of the employee';
COMMENT ON COLUMN employees.phone IS 'phone number of the employee';

-- create invoices table
CREATE TABLE invoices(
    invoice_id SERIAL,
    date TIMESTAMP,
    customer_id INTEGER,
    employee_id INTEGER, -- note: this is the MAIN employee associated with an invoice. there can be multiple, through service_done_by
    vin_num INTEGER,
    amount MONEY,
    car_sale BOOLEAN
);

-- set default date to now
ALTER TABLE invoices
ALTER date SET DEFAULT NOW();

-- set primary key
ALTER TABLE invoices
ADD PRIMARY KEY (invoice_id);

-- if a we try to delete a customer, we keep the invoice but the customer is set to null
ALTER TABLE invoices ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE SET NULL;

-- we do not want to delete invoices 
-- if we try to delete an employee, we keep the invoice but the employee is set to null
ALTER TABLE invoices ADD FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE SET NULL;

-- if we delete a vin, we want to keep its invoices so we just set the vin to null
ALTER TABLE invoices ADD FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE SET NULL;

-- just kidding -- we don't want to be able to delete anything, so we keep all records
ALTER TABLE invoices ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE RESTRICT;
ALTER TABLE invoices ADD FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE RESTRICT;
ALTER TABLE invoices ADD FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE RESTRICT;

-- COMMENTS
COMMENT ON TABLE invoices IS 'Table containing invoices';
COMMENT ON COLUMN invoices.invoice_id IS 'invoice ID of the invoice';
COMMENT ON COLUMN invoices.date IS 'date of the invoice';
COMMENT ON COLUMN invoices.customer_id IS 'customer ID for the customer associated with the invoice';
COMMENT ON COLUMN invoices.employee_id IS 'employee ID of the employee who wrote the invoice';
COMMENT ON COLUMN invoices.vin_num IS 'VIN for the car associated with the invoice';
COMMENT ON COLUMN invoices.amount IS 'amount of money due according to the invoice';
COMMENT ON COLUMN invoices.car_sale IS 'if the invoice is a car sale';

-- create service_tickets table
CREATE TABLE service_tickets(
    service_id SERIAL PRIMARY KEY,
    service_done VARCHAR(50),
    invoice_id INTEGER,
    FOREIGN KEY (invoice_id) REFERENCES invoices(invoice_id),
    vin_num INTEGER,
    FOREIGN KEY (vin_num) REFERENCES cars(vin_num),
    date_start DATE,
    date_finish DATE
);

-- COMMENTS
COMMENT ON TABLE service_tickets IS 'Table containing service tickets';
COMMENT ON COLUMN service_tickets.service_id IS 'service ticket ID of the service ticket';
COMMENT ON COLUMN service_tickets.service_done IS 'service(s) done on the car';
COMMENT ON COLUMN service_tickets.invoice_id IS 'invoice ID for the invoice associated with the service ticket';
COMMENT ON COLUMN service_tickets.vin_num IS 'VIN for the car associated with the service ticket';
COMMENT ON COLUMN service_tickets.date_start IS 'date the service ticket was pulled';
COMMENT ON COLUMN service_tickets.date_finish IS 'date the services were finished';

-- create service_done_by table
CREATE TABLE service_done_by(
    employee_id INTEGER,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    service_id INTEGER,
    FOREIGN KEY (service_id) REFERENCES service_tickets(service_id)
);

-- COMMENTS
COMMENT ON TABLE service_done_by IS 'Table containing who did what service';
COMMENT ON COLUMN service_done_by.employee_id IS 'ID for employee who did a service';
COMMENT ON COLUMN service_done_by.service_id IS 'ID for what service that employee did';