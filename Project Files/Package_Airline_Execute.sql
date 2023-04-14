-- CREATE SEQUENCE seq_fs start with 45 increment by 1;
set serveroutput on

EXECUTE PKG_AIRLINE.add_promotion( 'Santander-Summer-10', '10% off for Santander customers', 'N');
EXECUTE PKG_AIRLINE.add_promotion( 'NUStudent', '100% off for  Northeastern Huskies', 'Y');
EXECUTE PKG_AIRLINE.add_promotion( 'Huskies', 'Promotion to NU students', 'Y');
EXECUTE PKG_AIRLINE.add_promotion( 'Chase -Loyality', '60% off for Chase loyal customers', 'Y');

execute PKG_AIRLINE.add_flight_type('Boeing','110'); 
execute PKG_AIRLINE.add_flight_type('Buoyant','120');
execute PKG_AIRLINE.add_flight_type('Ballistic','90'); 
execute PKG_AIRLINE.add_flight_type('Aerodynamic','30'); 

execute pkg_airline.add_status('onHold');
execute pkg_airline.add_status('Refunded');
execute pkg_airline.add_status('Pending');

execute pkg_airline.route_add('06:30',75,2,58,44);
execute pkg_airline.route_add('21:10',30,5,58,44);
execute pkg_airline.route_add('09:45',120,3,60,32);
execute pkg_airline.route_add('10:05',90,4,38,60);

execute pkg_airline.add_flight_seat_availability(50,4,2);
execute pkg_airline.add_flight_seat_availability(10,6,1);
execute pkg_airline.add_flight_seat_availability(100,1,2);
execute pkg_airline.add_flight_seat_availability(30,2,1);
execute pkg_airline.add_flight_seat_availability(80,3,2);

execute pkg_airline.add_flight_schedule(4,to_date('30-APR-23','DD-MON-RR'));
execute pkg_airline.add_flight_schedule(4,to_date('14-FEB-24','DD-MON-RR'));
execute pkg_airline.add_flight_schedule(4,to_date('29-JUN-24','DD-MON-RR'));
execute pkg_airline.add_flight_schedule(4,to_date('29-APR-25','DD-MON-RR'));
execute pkg_airline.add_flight_schedule(4,to_date('21-APR-23','DD-MON-RR'));


