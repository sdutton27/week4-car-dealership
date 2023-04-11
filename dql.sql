-- Some example join tables we can build to test that this is working

-- Gets customers' names and their cars for all cars before 2020
SELECT customers.first_name, customers.last_name, cars.make, cars.model, cars.year
FROM customers
INNER JOIN cars
ON customers.customer_id = cars.customer_id
WHERE year < 2020
ORDER BY customers.last_name;

-- Gets the employees who worked on each service
SELECT service_done_by.service_id, employees.first_name, employees.last_name
FROM employees
INNER JOIN service_done_by
ON service_done_by.employee_id = employees.employee_id
ORDER BY service_id;

-- Gets the first/last name of employees who worked on each service and what they did
SELECT employees.first_name, employees.last_name, service_tickets.vin_num, service_tickets.service_done
FROM employees
INNER JOIN service_done_by
ON service_done_by.employee_id = employees.employee_id
INNER JOIN service_tickets
ON service_tickets.service_id = service_done_by.service_id

-- Gets the first/last name of employees who worked on each service and what they did, and the car make/model
SELECT employees.first_name, employees.last_name, service_tickets.vin_num, service_tickets.service_done, cars.make, cars.model, cars.year
FROM employees
INNER JOIN service_done_by
ON service_done_by.employee_id = employees.employee_id
INNER JOIN service_tickets
ON service_tickets.service_id = service_done_by.service_id
INNER JOIN cars
ON service_tickets.vin_num = cars.vin_num

-- Gets the cars sold and who they were sold to
SELECT cars.vin_num, cars.make, cars.model, cars.year, customers.first_name, customers.last_name
FROM invoices
INNER JOIN cars
ON cars.vin_num = invoices.vin_num
INNER JOIN customers
ON customers.customer_id = invoices.customer_id
WHERE invoices.car_sale = true;