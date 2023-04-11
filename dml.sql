
/**
 * This function adds a customer to the customers table.
 */
CREATE OR REPLACE FUNCTION add_customer(
    -- remove SERIAL value since this is automatically generated
    f_name VARCHAR(20),
    l_name VARCHAR(20),
    phone NUMERIC(10),
    email VARCHAR(50),
    -- also we don't want date_added since we will do this here
    date_added TIMESTAMP DEFAULT now()
    )
    RETURNS VOID
    LANGUAGE plpgsql
    AS
    $MAIN$ 
    BEGIN
        --insert into the customers table
        INSERT INTO customers(first_name, last_name, phone, email, date_added)
        VALUES(f_name, l_name, phone, email, date_added);
    END
    $MAIN$
    ;

-- add customers
SELECT add_customer('Jason', 'Bourne', 1231231234, 'jbourne@gmail.com');
SELECT add_customer('James', 'Bond', 0070071007, '007@gmail.com');
SELECT add_customer('Peter', 'Parker', 9998887777, 'pparker@gmail.com');
SELECT add_customer('Bruce', 'Banner', 4445556666, 'incredible-hulk@gmail.com');
SELECT add_customer('Tony', 'Stark', 1112223333, 'tstark@starkindustries.com');
SELECT add_customer('Pepper', 'Potts', 5554443333, 'ppotts@gmail.com');
SELECT add_customer('Thor', 'Odinson', 1234567890, 'todinson@gmail.com');

-- Function was edited so that timestamp was a default value, need to drop old version of function
DROP FUNCTION add_customer(VARCHAR, VARCHAR, NUMERIC, VARCHAR);

-- add more customers
SELECT add_customer('Clark', 'Kent', 3334449999, 'justclarkkent@gmail.com', NOW()::TIMESTAMP);
SELECT add_customer('Bruce', 'Wayne', 1313331111, 'batman@gmail.com');

-- just to check data
SELECT * FROM customers;

/**
 * This function adds a car to the cars table.
 */
CREATE OR REPLACE FUNCTION add_car(
    vin_num INTEGER,
    make VARCHAR(50),
    model VARCHAR(50),
    year INTEGER,
    used BOOLEAN,
    base_cost MONEY DEFAULT null,
    for_sale BOOLEAN DEFAULT true, -- this way cars are defaulted to be for sale
    customer_id INTEGER DEFAULT null -- use this to make sure that we can make cars not attached to customers
    )
    RETURNS VOID
    LANGUAGE plpgsql
    AS
    $MAIN$ 
    BEGIN
        --insert into the customers table
        INSERT INTO cars(vin_num, make, model, year, used, base_cost, for_sale, customer_id)
        VALUES(vin_num, make, model, year, used, base_cost, for_sale, customer_id);
    END
    $MAIN$
    ;

-- add cars
SELECT add_car(1234, 'Honda', 'Civic', 2004, true, '$6495');
SELECT add_car(007, 'Aston Martin', 'DB5', 1964, true, null, false, 2);
SELECT add_car(505930, 'Ford', 'F-150', 2022, false, '$40900');
SELECT add_car(446688, 'Chevrolet', 'Equinox', 2023, false, '$34069');
SELECT add_car(123123, 'Toyota', 'Corolla', 2023, false, '$23488');
SELECT add_car(123444, 'Audi', 'R8', 2017, true, '$137804');
SELECT add_car(100100, 'GMC', 'Acadia', 2003, true, null, false, 3);
SELECT add_car(40305, 'Hyundai', 'Tuscon', 2021, true, null, false, 5);
SELECT add_car(23456, 'Jeep', 'Wrangler', 2019, true, null, false, 5);
SELECT add_car(55344, 'Lexus', 'RX-350', 2023, true, null, false, 6);
SELECT add_car(900494, 'Mitsubishi', 'Lancer', 2021, true, null, false, 8);
SELECT add_car(688488, 'Chevrolet', 'Impala', 1980, true, null, false, 9);

-- just to check data
SELECT * FROM cars;

/**
 * This function adds an employee to the employees table.
 */
CREATE OR REPLACE FUNCTION add_employee(
    -- can't put employee ID since it is SERIAL
    f_name VARCHAR(20),
    l_name VARCHAR(20),
    job VARCHAR(20),
    email VARCHAR(50),
    birthday DATE,
    pin NUMERIC(4),
    phone NUMERIC(10)
    )
    RETURNS VOID
    LANGUAGE plpgsql
    AS
    $MAIN$ 
    BEGIN
        --insert into the employees table
        INSERT INTO employees(first_name, last_name, job_title, email, birthday, pin_code, phone)
        VALUES(f_name, l_name, job, email, birthday, pin, phone);
    END
    $MAIN$
    ;

-- add employees
SELECT add_employee('Robert', 'Parr', 'Mechanic', 'bobparr@gmail.com', '06/14/1965', 0614, 5053934567);
SELECT add_employee('Mike', 'Wazowski', 'Salesperson', 'wazowski@monsters.inc', '01/19/1980', 1243, 5554443333);
SELECT add_employee('Linguini', 'Alfredo', 'Front Desk', 'lalfredo@ratatouille.com', '08/04/1986', 1512, 2221119999);
SELECT add_employee('Alberto', 'Scorfano', 'Mechanic', 'albertos@gmail.com', '03/29/2010', 4902, 5755755755);
SELECT add_employee('Buzz', 'Lightyear', 'Mechanic', 'toinfinityandbeyond@gmail.com', '09/03/1984', 9493, 9099094944);
SELECT add_employee('James', 'Sullivan', 'Salesperson', 'sulley@monsters.inc', '05/12/1975', 4444, 9058384923);
SELECT add_employee('Randall', 'Boggs', 'Salesperson', 'randall@monsters.inc', '11/05/1978', 6767, 1119998484);
SELECT add_employee('Edna', 'Mode', 'Apprentice', 'edna@mode.co', '11/03/1970', 6633, 1002006633);

-- just to check data
SELECT * FROM employees;

/**
 * This function adds an invoice to the invoices table.
 */
CREATE OR REPLACE FUNCTION add_invoice(
    -- can't put invoice id since it is serial
    customer_id INTEGER,
    employee_id INTEGER, -- note this is just the Main employee attached with an invoice
    vin_num INTEGER,
    amount MONEY,
    car_sale BOOLEAN, 
    date TIMESTAMP DEFAULT NOW()
    )
    RETURNS VOID
    LANGUAGE plpgsql
    AS
    $MAIN$ 
    BEGIN
        --insert into the employees table
        INSERT INTO invoices(customer_id, employee_id, vin_num, amount, car_sale, date)
        VALUES(customer_id, employee_id, vin_num, amount, car_sale, date);
    END
    $MAIN$
    ;

-- note that the employee ID is just the one who signed off on the service ticket. we can have multiple 
SELECT add_invoice(6, 5, 55344, '$376.50', false);
SELECT add_invoice(2, 1, 7, '$64.39', false);
SELECT add_invoice(3, 6, 100100, '$5905', false);
SELECT add_invoice(5, 6, 40305, '$31354', false);
SELECT add_invoice(5, 1, 23456, '$693.43', false);
SELECT add_invoice(8, 4, 900494, '$15.90', false);
SELECT add_invoice(9, 2, 688488, '$1000000', false);
SELECT add_invoice(5, 4, 40305, '$567.98', false);

-- forgot to make the car sale boolean true for entries that are car sales
UPDATE invoices 
SET car_sale = true 
WHERE vin_num = 100100 or vin_num = 40305 or vin_num = 688488;

-- just to check data
SELECT * FROM invoices;

/**
 * This function adds a service ticket to the service tickets table.
 */
CREATE OR REPLACE FUNCTION add_service_ticket(
    -- can't put service id
    service_done VARCHAR(50),
    invoice_id INTEGER,
    vin_num INTEGER,
    date_start DATE,
    date_finish DATE
    )
    RETURNS VOID
    LANGUAGE plpgsql
    AS
    $MAIN$ 
    BEGIN
        --insert into the employees table
        INSERT INTO service_tickets(service_done, invoice_id, vin_num, date_start, date_finish)
        VALUES(service_done, invoice_id, vin_num, date_start, date_finish);
    END
    $MAIN$
    ;

-- add service tickets
SELECT add_service_ticket('Replace brake system', 1, 55344, '03/14/2021', '03/14/2021');
SELECT add_service_ticket('Replace broken headlight', 2, 7, '07/25/2022', '07/25/2022');
SELECT add_service_ticket('Replace rear tires', 5, 23456, '01/23/2023', '01/23/2023');
SELECT add_service_ticket('Repair puncture in left rear tire', 6, 900494, '01/29/2023', '01/29/2023');
SELECT add_service_ticket('Replace A/C System', 8, 40305, '03/25/2023', '03/25/2023');

-- just to check data
SELECT * FROM service_tickets;

/**
 * This function adds an employee/service to the service_done_by table.
 */
CREATE OR REPLACE FUNCTION add_service_done_by(
    employee_id INTEGER,
    service_id INTEGER
    )
    RETURNS VOID
    LANGUAGE plpgsql
    AS 
    $MAIN$
    BEGIN
        INSERT INTO service_done_by(employee_id, service_id)
        VALUES(employee_id, service_id);
    END
    $MAIN$
    ;

--service 1
SELECT add_service_done_by(5, 1);
SELECT add_service_done_by(4, 1);
--service 2
SELECT add_service_done_by(1, 2);
SELECT add_service_done_by(8, 2);
--service 3 INVOICE 5
SELECT add_service_done_by(1, 3);
SELECT add_service_done_by(5, 3);
--service 4 INVOICE 6
SELECT add_service_done_by(4, 4);
SELECT add_service_done_by(5, 4);
--service 5 DONE INVOICE 8
SELECT add_service_done_by(1, 5);
SELECT add_service_done_by(4, 5);
SELECT add_service_done_by(8, 5);

-- just to check data
SELECT * FROM service_done_by;