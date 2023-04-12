CREATE OR REPLACE PACKAGE pkg_booking AS
    PROCEDURE booking_add (
        input_customerid  booking.customer_id%TYPE,
        input_promotionid booking.promotion_promotionid%TYPE,
        input_stid        booking.seat_type_seattypeid%TYPE,
        input_fsid        booking.flight_schedules_flight_schedule_id%TYPE
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
        pnr         VARCHAR(6);
        fs_date     DATE;
        invalid_dateoftravel EXCEPTION;
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
            promotionid = input_promotionid;

        IF cntcustomer = 0 THEN
            RAISE invalid_data;
        ELSIF cntfs = 0 THEN
            RAISE invalid_data;
        ELSIF cntpromo = 0 THEN
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
        WHEN OTHERS THEN
            dbms_output.put_line(sqlerrm);
    END;

END;
/