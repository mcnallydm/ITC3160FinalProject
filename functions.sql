create or replace function calc_age (
    DOB customers.dob%type
)
return char as
age int;
begin
    SELECT round(months_between(sysdate , DOB) /12)
    into age
    FROM dual;
    if age>21 then
        return 'f';
    else
        return 't';
    end if;
end;

----------------------------------------------------------------------

create or replace function calc_months (
    sd rentals.start_date%type,
    rd rentals.return_date%type
)
return int as
duration int;
begin
    SELECT months_between(rd , sd)
    into duration
    FROM dual;
    return duration;
end;

----------------------------------------------------------------------

create or replace function calc_days (
    sd rentals.start_date%type,
    rd rentals.return_date%type
)
return int as
duration int;
begin
    SELECT trunc(rd) - sd into duration FROM DUAL;
    return duration;
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