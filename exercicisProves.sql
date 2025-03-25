CREATE OR REPLACE PROCEDURE proc_emp_info2 (par_id EMPLOYEES.EMPLOYEE_ID%TYPE) AS
$$
    DECLARE
        var_empl EMPLOYEES%ROWTYPE;
        var_job_title JOBS.JOB_TITLE%TYPE;
    BEGIN
        SELECT e.employee_id, e.first_name, j.job_title
        INTO var_empl.employee_id, var_empl.first_name, var_job_title
        FROM employees e JOIN jobs j USING(job_id)
        WHERE employee_id = par_id;

        RAISE NOTICE '% % %', var_empl.employee_id, var_empl.first_name, var_job_title;
    END;
$$ LANGUAGE plpgsql;




DO
$$
    DECLARE
        var_id employees.EMPLOYEE_ID%TYPE= :v_id;
    BEGIN
        CALL proc_emp_info2(var_id);
    END;
$$;