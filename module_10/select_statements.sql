SELECT * FROM  employee;
SELECT * FROM  employee_job;
SELECT * FROM  job_responsibility;

SELECT * FROM  customer;

SELECT * FROM  visa;
SELECT * FROM  employee_visa;
SELECT * FROM  customer_visa;

SELECT * FROM  inoculation;
SELECT * FROM  employee_inoculation;
SELECT * FROM  customer_inoculation;

SELECT * FROM  destination;
SELECT * FROM  destination_inoculation;
SELECT * FROM  destination_visa;

SELECT * FROM  trip;
SELECT * FROM  trip_excursion;
SELECT * FROM  excursion;

SELECT * FROM  employee_trip;
SELECT * FROM  customer_trip;

SELECT * FROM  item_type;
SELECT * FROM  item;
SELECT * FROM  trip_item;



select employee.first_name, employee.last_name, employee.nick_name, employee.job_title, 
job_responsibility.job_responsibility_id, job_responsibility.responsibility, job_responsibility.description 
from employee
left outer join employee_job on employee.employee_id = employee_job.employee_id
left outer join job_responsibility on employee_job.job_responsibility_id = job_responsibility.job_responsibility_id;

select *
from trip
left outer join trip_excursion on trip_excursion.trip_id = trip.trip_id
left outer join excursion on excursion.excursion_id = trip_excursion.excursion_id
order by begin_date, date;


select * from employee
left outer join employee_visa on employee.employee_id = employee_visa.employee_id
left outer join visa on employee_visa.visa_id = visa.visa_id
order by employee.employee_id, visa.visa_id;


select * from customer
left outer join customer_visa on customer.customer_id = customer_visa.customer_id
left outer join visa on customer_visa.visa_id = visa.visa_id
where customer.customer_id = 1
order by customer.customer_id, visa.visa_id;


select * from customer
left outer join customer_trip on customer.customer_id = customer_trip.customer_id
left outer join trip on customer_trip.trip_id = trip.trip_id
left outer join destination on destination.destination_id = trip.destination_id
where customer.customer_id = 8
order by trip.destination_id;


select * from item
left outer join item_type on item.item_type_id = item_type.item_type_id
order by item.item_id;