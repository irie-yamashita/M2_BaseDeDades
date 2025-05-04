/*01*/
CREATE OR REPLACE FUNCTION func_restriccions_emp()
   RETURNS TRIGGER
AS $$
BEGIN
    IF TG_OP = 'INSERT' &&  NEW.salary < 0 THEN
        RAISE 'El salari no pot ser negatiu!';
    ELSIF TG_OP = 'UPDATE' AND NEW.salary < OLD.salary THEN
        RAISE 'El salari nou no pot ser inferior al salari antic.';
    ELSIF TG_OP = 'UPDATE' AND OLD.commission_pct IS NULL THEN
        RAISE 'El employee a modificar no pot tenir comission_pct NULL';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trig_restriccions_emp BEFORE INSERT OR UPDATE
ON employees
FOR EACH ROW
EXECUTE PROCEDURE func_restriccions_emp();

INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (444, 'Pep', 'López', 'pep@itb.cat', '123.456.7890',  '2025-04-29', 'IT_PROG', -1000, 0.1, 100, 90);