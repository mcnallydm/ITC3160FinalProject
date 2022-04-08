create or replace view rental_history as
    -- Shows the rental history for each vehicle that has been rented before
    select vehicles.id, agencies_id, customers_id_num as "customer id", vehicles.classes_class as "vehicle class", start_date, end_date, return_date
    from vehicles join rentals on (vehicles.id = rentals.vehicles_id)
    order by 1;
    
select * from rental_history;

----------------------------------------------------------------------

create or replace view full_rental_history as
    -- Shows rental history for ALL vehicles (including ones that have never been rented before)
    select vehicles.id, agencies_id, customers_id_num as "customer id", vehicles.classes_class as "vehicle class", start_date, end_date, return_date
    from vehicles left outer join rentals on (vehicles.id = rentals.vehicles_id)
    order by 1;
    
select * from full_rental_history;

----------------------------------------------------------------------

create or replace view longrates as
    -- Shows the rates of the long-term leases for each class
    select upper(classes_class) as "class",  '$ '||max(rate)||'/month' as "long-lease rates"
    from class_lease
    group by classes_class;
    
select * from longrates;

----------------------------------------------------------------------

create or replace view most_profitable as
    -- Shows which long lease rates are worth the most
    select upper(classes_class) as "class",  '$ '||max(rate)||'/month' as "long-lease rates"
    from class_lease
    group by classes_class
    having max(rate)>5500;
    
select * from most_profitable;

----------------------------------------------------------------------

create or replace view return_price as
    -- Shows the details and price for all vehicles that have been rented and returned
    select vehicles.id as "vehicle id", upper(classes_class) as "vehicle class", first_name||' '||last_name as "name", '$ '||calc_total_cost(rentals.id) as "total", to_char(return_date, 'dd Month yyyy') as "returned"
    from vehicles join rentals ON (rentals.vehicles_id=vehicles.id) join customers on (customers.id_num = rentals.customers_id_num)
    where (return_date is not null);

select * from return_price;

----------------------------------------------------------------------

create or replace view longest_lease as
    -- Shows the details of the lease that will last/has lasted the longest
    select id as "rental id", to_char(start_date, 'dd/mm/yyyy') as "start", to_char(end_date, 'dd/mm/yyyy') as "end", calc_days(start_date, end_date)||' days' as "length", first_name||' '||last_name as renter
    from rentals join customers on (customers.id_num = rentals.customers_id_num)
    where (calc_days(start_date, end_date) = (select max(calc_days(start_date, end_date)) from rentals));
    
select * from longest_lease;