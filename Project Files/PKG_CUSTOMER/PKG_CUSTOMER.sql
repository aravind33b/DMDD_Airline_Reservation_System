CREATE OR REPLACE PACKAGE pkg_customer AS
    PROCEDURE customer_signup (
        firstname  customer.firstname%TYPE,
        lastname   customer.lastname%TYPE,
        inputemail customer.email%TYPE,
        mobileno   customer.mobileno%TYPE
    );

    invalid_data EXCEPTION;
    already_exists EXCEPTION;
END pkg_customer;
/

CREATE OR REPLACE PACKAGE BODY pkg_customer AS

    PROCEDURE customer_signup (
        firstname  customer.firstname%TYPE,
        lastname   customer.lastname%TYPE,
        inputemail customer.email%TYPE,
        mobileno   customer.mobileno%TYPE
    ) IS
        cntuser NUMBER;
        customer_id NUMBER;
    BEGIN
        SELECT
            COUNT(*)
        INTO cntuser
        FROM
            customer
        WHERE
            email = inputemail;

        IF cntuser >= 1 THEN
            RAISE already_exists;
        ELSIF firstname IS NULL OR length(firstname) = 0 THEN
            RAISE invalid_data;
        ELSIF lastname IS NULL OR length(lastname) = 0 THEN
            RAISE invalid_data;
        ELSIF inputemail IS NULL OR length(inputemail) = 0 THEN
            RAISE invalid_data;
        ELSIF mobileno IS NULL OR length(mobileno) = 0 OR length(mobileno) < 10 THEN
            RAISE invalid_data;
        ELSIF regexp_count(mobileno, '^[0-9]+$') <> 1 THEN
            RAISE invalid_data;
        ELSE
        customer_id := seq_customer.NEXTVAL;
            INSERT INTO customer (
                customerid,
                firstname,
                lastname,
                email,
                mobileno
            ) VALUES (
                customer_id,
                firstname,
                lastname,
                inputemail,
                mobileno
            );

            COMMIT;
            dbms_output.put_line('CUSTOMER ADDED SUCCCESSFULLY WITH ID ' || customer_id);
        END IF;

    EXCEPTION
        WHEN invalid_data THEN
            dbms_output.put_line('INVALID DATA ENTERED');
        WHEN already_exists THEN
            dbms_output.put_line('ACCOUNT ALREADY EXISTS');
        WHEN OTHERS THEN
            dbms_output.put_line(sqlerrm);
    END;

END pkg_customer;
/