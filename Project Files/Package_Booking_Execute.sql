set serveroutput on
DECLARE
    b1            app_admin.booking%rowtype;
    passengers_b1 app_admin.pkg_booking.passenger_array;
BEGIN
    dbms_output.put_line('RESERVING A BOOKING FOR FLIGHT 44');
    dbms_output.put_line('SEAT AVAILABLE COUNT FOR FLIGHT 44 ' || app_admin.get_flight_Seat_availability(44));
    b1.customer_id := 15;
    b1.promotion_promotionid := 1;
    b1.seat_type_seattypeid := 1;
    b1.flight_schedules_flight_schedule_id := 44;
    passengers_b1(1).firstname := 'Beulah';
    passengers_b1(1).lastname := 'Cruickshank';
    passengers_b1(1).email := 'Beulah6@hotmail.com';
    passengers_b1(1).phoneno := '1450149332';
    passengers_b1(1).age := 30;
    passengers_b1(1).gender := 'F';
    passengers_b1(2).firstname := 'James';
    passengers_b1(2).lastname := 'Cruickshank';
    passengers_b1(2).email := 'james@yahoo.com';
    passengers_b1(2).phoneno := '9874561230';
    passengers_b1(2).age := 32;
    passengers_b1(2).gender := 'M';
    app_admin.pkg_booking.booking_with_passengers(b1, passengers_b1);
    dbms_output.put_line('SEAT AVAILABLE COUNT ' || app_admin.get_flight_Seat_availability(44));
    dbms_output.put_line(NULL);
    
    dbms_output.put_line('CANCELLING PASSENGER WITH ID 374 IN FLIGHT 44');
    app_admin.pkg_booking.passenger_cancel(374,true);
    dbms_output.put_line('SEAT AVAILABLE COUNT ' || app_admin.get_flight_Seat_availability(44));
    dbms_output.put_line(NULL);
    
    
    dbms_output.put_line('CANCELLING BOOKING WITH ID 247 IN FLIGHT 44');
    app_admin.pkg_booking.booking_cancel(247);
    dbms_output.put_line('SEAT AVAILABLE COUNT ' || app_admin.get_flight_Seat_availability(44));
    dbms_output.put_line(NULL);
    
    
    dbms_output.put_line('RESERVING A BOOKING FOR FLIGHT 40');
    dbms_output.put_line('SEAT AVAILABLE COUNT ' || app_admin.get_flight_Seat_availability(40));
    b1.customer_id := 9;
    b1.promotion_promotionid := 1;
    b1.seat_type_seattypeid := 2;
    b1.flight_schedules_flight_schedule_id := 40;
    passengers_b1(1).firstname := 'Ruben';
    passengers_b1(1).lastname := 'Okuneva';
    passengers_b1(1).email := 'Ruben.Okuneva34@hotmail.com';
    passengers_b1(1).phoneno := '6849079568';
    passengers_b1(1).age := 60;
    passengers_b1(1).gender := 'M';
    passengers_b1(2).firstname := 'Jason';
    passengers_b1(2).lastname := 'Paul';
    passengers_b1(2).email := 'jason@yahoo.com';
    passengers_b1(2).phoneno := '9874561230';
    passengers_b1(2).age := 63;
    passengers_b1(2).gender := 'M';
    app_admin.pkg_booking.booking_with_passengers(b1, passengers_b1);
    dbms_output.put_line('SEAT AVAILABLE COUNT ' || app_admin.get_flight_Seat_availability(40));
    dbms_output.put_line(NULL);
      
END;
/
