CREATE OR REPLACE PACKAGE pkg_booking AS
    PROCEDURE booking_add (
        input_customerid  booking.customer_id%TYPE,
        input_promotionid booking.promotion_promotionid%TYPE,
        input_stid        booking.seat_type_seattypeid%TYPE,
        input_fsid        booking.flight_schedules_flight_schedule_id%TYPE
    );

    PROCEDURE passenger_add (
        input_fn        passenger.firstname%TYPE,
        input_ln        passenger.lastname%TYPE,
        input_email     passenger.email%TYPE,
        input_phoneno   passenger.phoneno%TYPE,
        input_age       passenger.age%TYPE,
        input_gender    passenger.gender%TYPE,
        input_bookingid passenger.booking_bookingid%TYPE,
        input_statusid  passenger.status_statusid%TYPE
    );

    invalid_data EXCEPTION;
END pkg_booking;
/

CREATE OR REPLACE PACKAGE BODY pkg_booking AS

    PROCEDURE booking_add (
        input_customerid  booking.customer_id%TYPE,
        input_promotionid booking.promotion_promotionid%TYPE,
        input_stid        booking.seat_type_seattypeid%TYPE,
        input_fsid        booking.flight_schedules_flight_schedule_id%TYPE
    ) AS

        cntcustomer NUMBER;
        cntfs       NUMBER;
        cntpromo    NUMBER;
        cntst       NUMBER;
        pnr         VARCHAR(6);
        fs_date     DATE;
        fs_rec      flight_schedules%rowtype;
        invalid_dateoftravel EXCEPTION;
        insufficient_seats EXCEPTION;
    BEGIN
        SELECT
            COUNT(*)
        INTO cntcustomer
        FROM
            customer
        WHERE
            customerid = input_customerid;

        SELECT
            COUNT(*)
        INTO cntfs
        FROM
            flight_schedules
        WHERE
            flight_schedule_id = input_fsid;

        SELECT
            COUNT(*)
        INTO cntpromo
        FROM
            promotion
        WHERE
                promotionid = input_promotionid
            AND active = 'Y';

        SELECT
            COUNT(*)
        INTO cntst
        FROM
            seat_type
        WHERE
            seattypeid = input_stid;

        SELECT
            *
        INTO fs_rec
        FROM
            flight_schedules
        WHERE
            flight_schedule_id = input_fsid;

        IF fs_rec.seatsavailable = 0 THEN
            RAISE insufficient_seats;
        ELSIF cntcustomer = 0 THEN
            RAISE invalid_data;
        ELSIF cntfs = 0 THEN
            RAISE invalid_data;
        ELSIF cntpromo = 0 THEN
            RAISE invalid_data;
        ELSIF cntst = 0 THEN
            RAISE invalid_data;
        ELSE
            pnr := dbms_random.string('U', 6);
            SELECT
                dateoftravel
            INTO fs_date
            FROM
                flight_schedules
            WHERE
                flight_schedule_id = input_fsid;

            IF fs_date < sysdate THEN
                RAISE invalid_dateoftravel;
            END IF;
            INSERT INTO booking (
                bookingid,
                pnr,
                dateofbooking,
                customer_id,
                promotion_promotionid,
                seat_type_seattypeid,
                flight_schedules_flight_schedule_id
            ) VALUES (
                seq_booking.NEXTVAL,
                pnr,
                sysdate,
                input_customerid,
                input_promotionid,
                input_stid,
                input_fsid
            );

            COMMIT;
            dbms_output.put_line('BOOKING ADDED SUCCCESSFULLY WITH PNR ' || pnr);
        END IF;

    EXCEPTION
        WHEN invalid_data THEN
            dbms_output.put_line('INVALID DATA ENTERED');
        WHEN invalid_dateoftravel THEN
            dbms_output.put_line('INVALID Date of Travel ENTERED');
        WHEN insufficient_seats THEN
            dbms_output.put_line('NO SEATS LEFT');
        WHEN OTHERS THEN
            dbms_output.put_line(sqlerrm);
    END;

    PROCEDURE passenger_add (
        input_fn        passenger.firstname%TYPE,
        input_ln        passenger.lastname%TYPE,
        input_email     passenger.email%TYPE,
        input_phoneno   passenger.phoneno%TYPE,
        input_age       passenger.age%TYPE,
        input_gender    passenger.gender%TYPE,
        input_bookingid passenger.booking_bookingid%TYPE,
        input_statusid  passenger.status_statusid%TYPE
    ) AS

        cntbooking      NUMBER;
        cntstatus       NUMBER;
        seq_passengerid NUMBER;
        booking_rec     booking%rowtype;
        fs_rec          flight_schedules%rowtype;
        insufficient_seats EXCEPTION;
    BEGIN
        SELECT
            COUNT(*)
        INTO cntbooking
        FROM
            booking
        WHERE
            bookingid = input_bookingid;

        SELECT
            COUNT(*)
        INTO cntstatus
        FROM
            status
        WHERE
            statusid = input_statusid;

        IF cntbooking = 0 THEN
            RAISE invalid_data;
        ELSIF cntstatus = 0 THEN
            RAISE invalid_data;
        ELSIF input_fn IS NULL OR length(input_fn) = 0 THEN
            RAISE invalid_data;
        ELSIF input_ln IS NULL OR length(input_ln) = 0 THEN
            RAISE invalid_data;
        ELSIF input_email IS NULL OR length(input_email) = 0 THEN
            RAISE invalid_data;
        ELSIF input_phoneno IS NULL OR length(input_phoneno) = 0 THEN
            RAISE invalid_data;
        ELSIF input_age IS NULL OR input_age < 0 THEN
            RAISE invalid_data;
        ELSIF input_gender IS NULL OR length(input_gender) = 0 THEN
            RAISE invalid_data;
        ELSE
            -- verify seats exist
            -- get booking rec
            SELECT
                *
            INTO booking_rec
            FROM
                booking
            WHERE
                bookingid = input_bookingid;
                
-- get flight schedule rec
            SELECT
                *
            INTO fs_rec
            FROM
                flight_schedules
            WHERE
                flight_schedule_id = booking_rec.flight_schedules_flight_schedule_id;

            IF fs_rec.seatsavailable = 0 THEN
                RAISE insufficient_seats;
            ELSE
                seq_passengerid := seq_passenger.nextval;
                INSERT INTO passenger (
                    passengerid,
                    firstname,
                    lastname,
                    email,
                    phoneno,
                    age,
                    gender,
                    booking_bookingid,
                    status_statusid
                ) VALUES (
                    seq_passengerid,
                    input_fn,
                    input_ln,
                    input_email,
                    input_phoneno,
                    input_age,
                    input_gender,
                    input_bookingid,
                    input_statusid
                );

                UPDATE flight_schedules
                SET
                    seatsavailable = seatsavailable - 1
                WHERE
                    flight_schedule_id = booking_rec.flight_schedules_flight_schedule_id;

                COMMIT;
                dbms_output.put_line('PASSENGER ADDED SUCCCESSFULLY WITH ID ' || seq_passengerid);
            END IF;

        END IF;

    EXCEPTION
        WHEN invalid_data THEN
            dbms_output.put_line('INVALID DATA ENTERED');
        WHEN insufficient_seats THEN
            dbms_output.put_line('NO SEATS LEFT');
        WHEN OTHERS THEN
            dbms_output.put_line(sqlerrm);
    END;

END;
/