CREATE OR REPLACE PACKAGE pkg_airline AS
    PROCEDURE route_add (
        departuretime routes.departuretime%TYPE,
        durationmin   routes.durationoftravelinminutes%TYPE,
        inputftid     routes.flighttype_flighttypeid%TYPE,
        src           routes.sourceairport%TYPE,
        dest          routes.destinationairport%TYPE
    );

    PROCEDURE add_flight_seat_availability (
        input_noofseats               flight_seat_availability.noofseats%TYPE,
        input_flighttype_flighttypeid flight_seat_availability.flighttype_flighttypeid%TYPE,
        input_seat_type_seattypeid    flight_seat_availability.seat_type_seattypeid%TYPE
    );
    
    PROCEDURE add_status (
    inp_status status.status%TYPE
    );

    invalid_data EXCEPTION;
    record_exists EXCEPTION;
END pkg_airline;
/

CREATE OR REPLACE PACKAGE BODY pkg_airline AS

    PROCEDURE route_add (
        departuretime routes.departuretime%TYPE,
        durationmin   routes.durationoftravelinminutes%TYPE,
        inputftid     routes.flighttype_flighttypeid%TYPE,
        src           routes.sourceairport%TYPE,
        dest          routes.destinationairport%TYPE
    ) IS
        cntflighttype NUMBER;
        routeno       VARCHAR(3);
    BEGIN
        SELECT
            COUNT(*)
        INTO cntflighttype
        FROM
            flight_type
        WHERE
            flighttypeid = inputftid;

        IF cntflighttype = 0 THEN
            RAISE invalid_data;
        ELSIF departuretime IS NULL OR length(departuretime) = 0 THEN
            RAISE invalid_data;
        ELSIF durationmin IS NULL OR durationmin = 0 THEN
            RAISE invalid_data;
        ELSIF src = dest THEN
            RAISE invalid_data;
        ELSE
            routeno := dbms_random.string('U', 3);
            INSERT INTO routes (
                routeid,
                routeno,
                departuretime,
                durationoftravelinminutes,
                flighttype_flighttypeid,
                sourceairport,
                destinationairport
            ) VALUES (
                seq_route.NEXTVAL,
                routeno,
                departuretime,
                durationmin,
                inputftid,
                src,
                dest
            );

            COMMIT;
            dbms_output.put_line('ROUTE ADDED SUCCCESSFULLY');
        END IF;

    EXCEPTION
        WHEN invalid_data THEN
            dbms_output.put_line('INVALID DATA ENTERED');
        WHEN OTHERS THEN
            dbms_output.put_line(sqlerrm);
    END;

    PROCEDURE add_flight_seat_availability (
        input_noofseats               flight_seat_availability.noofseats%TYPE,
        input_flighttype_flighttypeid flight_seat_availability.flighttype_flighttypeid%TYPE,
        input_seat_type_seattypeid    flight_seat_availability.seat_type_seattypeid%TYPE
    ) AS

        total_seats           NUMBER;
        actual_total_seats    NUMBER;
        invalid_data EXCEPTION;
        cntseattypeid         NUMBER;
        cntflighttype         NUMBER;
        cntfsa                NUMBER;
        cntseattypeflighttype NUMBER;
    BEGIN
        SELECT
            COUNT(*)
        INTO cntseattypeid
        FROM
            seat_type
        WHERE
            seattypeid = input_seat_type_seattypeid;

        SELECT
            COUNT(*)
        INTO cntflighttype
        FROM
            flight_type
        WHERE
            flighttypeid = input_flighttype_flighttypeid;

        SELECT
            COUNT(*)
        INTO cntseattypeflighttype
        FROM
            flight_seat_availability
        WHERE
                flighttype_flighttypeid = input_flighttype_flighttypeid
            AND seat_type_seattypeid = input_seat_type_seattypeid;

        SELECT
            COUNT(*)
        INTO cntfsa
        FROM
            flight_seat_availability
        WHERE
            flighttype_flighttypeid = input_flighttype_flighttypeid;

        IF cntseattypeid = 0 THEN
            RAISE invalid_data;
        ELSIF cntflighttype = 0 THEN
            RAISE invalid_data;
        ELSIF input_noofseats IS NULL THEN
            RAISE invalid_data;
        ELSIF input_flighttype_flighttypeid IS NULL THEN
            RAISE invalid_data;
        ELSIF input_seat_type_seattypeid IS NULL THEN
            RAISE invalid_data;
        ELSIF cntseattypeflighttype > 0 THEN
            RAISE record_exists;
        ELSE
            IF cntfsa = 0 THEN
                total_seats := input_noofseats;
            ELSE
                SELECT
                    SUM(noofseats) + input_noofseats
                INTO total_seats
                FROM
                    flight_seat_availability
                GROUP BY
                    flighttype_flighttypeid
                HAVING
                    flighttype_flighttypeid = input_flighttype_flighttypeid;

            END IF;

            SELECT
                totalnoofseats
            INTO actual_total_seats
            FROM
                flight_type
            WHERE
                flighttypeid = input_flighttype_flighttypeid;

            IF total_seats > actual_total_seats THEN
                RAISE invalid_data;
            ELSE
                INSERT INTO flight_seat_availability (
                    flightseatavailabilityid,
                    noofseats,
                    flighttype_flighttypeid,
                    seat_type_seattypeid
                ) VALUES (
                    seq_flight_seat_availability.NEXTVAL,
                    input_noofseats,
                    input_flighttype_flighttypeid,
                    input_seat_type_seattypeid
                );

                COMMIT;
                dbms_output.put_line('Flight Seat Availability ADDED SUCCCESSFULLY');
            END IF;

        END IF;

    EXCEPTION
        WHEN invalid_data THEN
            dbms_output.put_line('INVALID DATA ENTERED');
        WHEN record_exists THEN
            dbms_output.put_line('SEAT AVAILABILITY ALREADY EXISTS');
        WHEN OTHERS THEN
            dbms_output.put_line(sqlerrm);
    END;

    PROCEDURE add_status (
    inp_status status.status%TYPE
) AS
    invalid_data EXCEPTION;
    count_status NUMBER;
BEGIN
    IF inp_status IS NULL OR inp_status = '' THEN
        RAISE invalid_data;
    ELSE
        INSERT INTO status (
            statusid,
            status
        ) VALUES (
            seq_status.NEXTVAL,
            inp_status
        );

        COMMIT;
        dbms_output.put_line('STATUS ADDED SUCCCESSFULLY');
    END IF;
EXCEPTION
    WHEN invalid_data THEN
        dbms_output.put_line('INVALID DATA ENTERED');
    WHEN OTHERS THEN
        dbms_output.put_line(sqlerrm);
END;
 
END pkg_airline;
/
