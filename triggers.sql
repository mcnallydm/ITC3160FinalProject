create or replace trigger AGENCY_IDS  
   before insert on "MCNALLY"."AGENCIES" 
   for each row 
begin  
   if inserting then 
      if :NEW."ID" is null then 
         select AGENCY_PKS.nextval into :NEW."ID" from dual; 
      end if; 
   end if; 
end;

----------------------------------------------------------------------

create or replace trigger RENTAL_IDS  
   before insert on "MCNALLY"."RENTALS" 
   for each row 
begin  
   if inserting then 
      if :NEW."ID" is null then 
         select RENTAL_PK_IDS.nextval into :NEW."ID" from dual; 
      end if; 
   end if; 
end;

----------------------------------------------------------------------

create or replace trigger VEHICLE_IDS  
   before insert on "MCNALLY"."VEHICLES" 
   for each row 
begin  
   if inserting then 
      if :NEW."ID" is null then 
         select VEHICLE_PK_IDS.nextval into :NEW."ID" from dual; 
      end if; 
   end if; 
end;

----------------------------------------------------------------------

create or replace trigger calc_cost_age_fees
    before insert or update on "MCNALLY"."RENTALS"
    for each row
declare
cust_dob customers.dob%type;
young char(1);
lease_rate class_lease.rate%type;
v_class vehicles.classes_class%type;
dur int;
begin
    if :new.return_date is not null then
        select dob into cust_dob from customers where id_num=:new.customers_id_num;
        select calc_age(cust_dob) into young from dual;
        select classes_class into v_class from vehicles where (id=:new.vehicles_id and agencies_id=:new.vehicles_agencies_id);
        select rate into lease_rate from class_lease where (classes_class=v_class and leases_type=:new.leases_type);
        if :new.leases_type='s' then
            select calc_days(:new.start_date, :new.return_date) into dur from dual;
        else
            select calc_months(:new.start_date, :new.return_date) into dur from dual;
        end if;
        select dur*lease_rate into :new.cost from dual;
        if young='t' then
            select round(:new.cost/10, 2) into :new.age_fees from dual;
        end if;
    end if;
end;