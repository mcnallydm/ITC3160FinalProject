insert into agencies (address, city, country)
values ('16 Broadway Blvd.', 'New York City', 'United States');
insert into agencies (address, city, country)
values ('6 Gravias St.', 'Athens', 'Greece');
insert into agencies (address, city, country)
values ('1016-Rt. 601', 'Skillman', 'United States');
insert into agencies (address, city, country)
values ('25 Mithril St.', 'London', 'England');

insert into customers
values ('4489782', 'Dara', 'McNally', '17-MAY-2000', null, null);
insert into customers
values ('866758', 'George', 'Horas', '11-JUN-2002', null, '888-458-9006');
insert into customers
values ('3478556', 'Beatrice', 'Lopez', '09-APR-1986', 'b.lops668@hotmail.com', '680-345-5637');
insert into customers
values ('3767569', 'Alex', 'Schmetz', '23-DEC-2000', 'alschmeztiscool@yahoo.com', null);

insert into leases
values ('s');
insert into leases
values ('l');

insert into classes
values ('SUV');
insert into classes
values ('sedan');
insert into classes
values ('coup');
insert into classes
values ('minivan');

insert into class_lease
values ('SUV', 's', 200.00);
insert into class_lease
values ('SUV', 'l', 5500.00);
insert into class_lease
values ('sedan', 's', 150.00);
insert into class_lease
values ('sedan', 'l', 4200.00);
insert into class_lease
values ('coup', 's', 250.00);
insert into class_lease
values ('coup', 'l', 6400.00);
insert into class_lease
values ('minivan', 's', 225.00);
insert into class_lease
values ('minivan', 'l', 5750.00);

insert into vehicles
values (null, '2135-4675', 8, 'Chevrolet', 'Tahoe', 'SUV');
insert into vehicles
values (null, '4678-8907', 8, 'Chrysler', 'Sebring', 'coup');
insert into vehicles
values (null, '6587-2985', 9, 'Toyota', 'Corola', 'sedan');
insert into vehicles
values (null, '8537-9355', 9, 'Honda', 'MV', 'minivan');
insert into vehicles
values (null, '5782-4566', 10, 'Chevrolet', 'Trailblazer', 'SUV');
insert into vehicles
values (null, '4822-7877', 10, 'Mercedes', 'Cozy', 'sedan');
insert into vehicles
values (null, '4556-9376', 11, 'Honda', 'CRV', 'sedan');
insert into vehicles
values (null, '9851-6739', 11, 'Honda', 'MV', 'minivan');

insert into rentals
values (null, sysdate, '01-JUN-2022', null, 4500.50, null, null, null, 's', 11, 9, '866758');
insert into rentals
values (null, '01-JUN-2022', '15-DEC-2045', null, 2500, null, null, null, 'l', 14, 11, '3767569');
insert into rentals
values (null, '23-MAY-2022', '19-APR-2023', null, 2500, null, null, null, 'l', 8, 8, '4489782');
insert into rentals
values (null, '06-JUN-2022', '15-JUL-2022', null, 2500, null, null, null, 's', 13, 10, '3478556');
insert into rentals
values (null, '01-Jan-2022', '31-DEC-2022', null, 2500, null, null, null, 'l', 10, 9, '3767569');
insert into rentals
values (null, '01-MAR-2022', '01-APR-2022', null, 140, null, null, null, 's', 13, 10, '866758');


update rentals
    set return_date = '01-JUN-2022'
    where id=2;