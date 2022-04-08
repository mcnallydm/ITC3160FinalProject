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

create or replace function calc_total_cost (
    rid rentals.id%type
)
return number as
total rentals.cost%type;
rcost rentals.cost%type;
rinsurance rentals.insurance%type;
rage rentals.age_fees%type;
rdamages rentals.damages%type;
begin
    select nvl(cost, 0), nvl(insurance, 0), nvl(age_fees, 0), nvl(damages, 0) into rcost, rinsurance, rage, rdamages from rentals where (id=rid);
    SELECT round(rcost+rinsurance+rage+rdamages, 2) into total FROM DUAL;
    return total;
end;