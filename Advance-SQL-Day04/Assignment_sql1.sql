-- 1: Calculate Simple Interest
DECLARE
    -- 1. Declare three variables [cite: 34]
    p_principal NUMBER := 5000;  -- Principal amount
    r_rate      NUMBER := 8.5;   -- Rate of interest
    t_time      NUMBER := 2;     -- Time in years
    v_interest  NUMBER;

BEGIN
    -- 2. Compute Simple Interest using the formula [cite: 34]
    v_interest := (p_principal * r_rate * t_time) / 100;

    -- 3. Display the result [cite: 34]
    DBMS_OUTPUT.PUT_LINE('Principal Amount: ' || p_principal);
    DBMS_OUTPUT.PUT_LINE('Rate of Interest: ' || r_rate || '%');
    DBMS_OUTPUT.PUT_LINE('Time (in years): ' || t_time);
    DBMS_OUTPUT.PUT_LINE('Calculated Simple Interest is: ' || v_interest);
END;
/

-- 2: Employee Bonus Calculation
DECLARE
    -- 1. Declare variables [cite: 36]
    emp_name VARCHAR2(50);
    salary   NUMBER;
    bonus    NUMBER;

BEGIN
    -- 2. Assign values to emp_name and salary [cite: 36]
    emp_name := 'John Doe';
    salary   := 65000;

    -- 3. Use an IF condition to calculate the bonus [cite: 37]
    IF salary > 50000 THEN
        bonus := 0.10 * salary; -- 10% bonus for salary > 50000
    ELSE
        bonus := 0.15 * salary; -- 15% bonus otherwise
    END IF;

    -- 4. Display the results [cite: 37]
    DBMS_OUTPUT.PUT_LINE('Employee Name: ' || emp_name);
    DBMS_OUTPUT.PUT_LINE('Salary: ' || salary);
    DBMS_OUTPUT.PUT_LINE('Calculated Bonus: ' || bonus);
END;
/

-- 3: Retrieve and Display Department Details
DECLARE
    -- 1. Declare a variable of type DEPARTMENTS%ROWTYPE [cite: 38]
    v_dept DEPARTMENTS%ROWTYPE;
    
    -- 2. Take a sample department ID [cite: 39]
    v_dept_id DEPARTMENTS.DEPARTMENT_ID%TYPE := 60; -- Using 'IT' department as an example

BEGIN
    -- 3. Fetch the corresponding record into v_dept [cite: 39]
    SELECT * INTO v_dept FROM DEPARTMENTS WHERE department_id = v_dept_id;

    -- 4. Display department name and location ID [cite: 40]
    DBMS_OUTPUT.PUT_LINE('Department Details for ID: ' || v_dept_id);
    DBMS_OUTPUT.PUT_LINE('-----------------------------');
    DBMS_OUTPUT.PUT_LINE('Department Name: ' || v_dept.department_name);
    DBMS_OUTPUT.PUT_LINE('Location ID: ' || v_dept.location_id);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Department with ID ' || v_dept_id || ' does not exist.');
END;
/

-- 4: Student Marks Management
DECLARE
    -- 1. Use an associative array where Key is Name and Value is Marks [cite: 41]
    TYPE t_marks_table IS TABLE OF NUMBER INDEX BY VARCHAR2(50);
    v_student_marks t_marks_table;

    v_student_name  VARCHAR2(50);
    v_total_marks   NUMBER := 0;
    v_avg_marks     NUMBER;
    v_student_count NUMBER := 0;

BEGIN
    -- 2. Insert marks for at least 5 students [cite: 41]
    v_student_marks('Alice')   := 88;
    v_student_marks('Bob')     := 92;
    v_student_marks('Charlie') := 75;
    v_student_marks('David')   := 95;
    v_student_marks('Eve')     := 81;

    -- 3. Display all student names with their marks [cite: 42]
    DBMS_OUTPUT.PUT_LINE('--- Student Marks ---');
    v_student_name := v_student_marks.FIRST; -- Get the first key

    WHILE v_student_name IS NOT NULL LOOP
        DBMS_OUTPUT.PUT_LINE(v_student_name || ': ' || v_student_marks(v_student_name));
        
        -- Calculate total and count for average
        v_total_marks := v_total_marks + v_student_marks(v_student_name);
        v_student_count := v_student_count + 1;
        
        v_student_name := v_student_marks.NEXT(v_student_name); -- Move to the next key
    END LOOP;

    -- 4. Calculate and print Total and Average marks [cite: 42]
    IF v_student_count > 0 THEN
        v_avg_marks := v_total_marks / v_student_count;
        DBMS_OUTPUT.PUT_LINE('---------------------');
        DBMS_OUTPUT.PUT_LINE('Total Marks: ' || v_total_marks);
        DBMS_OUTPUT.PUT_LINE('Average Marks: ' || ROUND(v_avg_marks, 2));
    END IF;
END;
/

-- 5: Country-Capital Lookup
DECLARE
    -- 1. Declare an associative array for Country-Capital pairs [cite: 44]
    TYPE t_capital_lookup IS TABLE OF VARCHAR2(100) INDEX BY VARCHAR2(100);
    v_capitals t_capital_lookup;

    -- 3. Set a country name to find (instead of user input) [cite: 45]
    v_country_to_find VARCHAR2(100) := 'Japan';

BEGIN
    -- 2. Insert at least 6 country-capital pairs [cite: 44]
    v_capitals('USA')     := 'Washington, D.C.';
    v_capitals('India')   := 'New Delhi';
    v_capitals('UK')      := 'London';
    v_capitals('Japan')   := 'Tokyo';
    v_capitals('Germany') := 'Berlin';
    v_capitals('France')  := 'Paris';

    -- 4. Check if the country exists and display the appropriate message 
    -- Hint: Use EXISTS(key) 
    IF v_capitals.EXISTS(v_country_to_find) THEN
        DBMS_OUTPUT.PUT_LINE('The capital of ' || v_country_to_find || ' is ' || v_capitals(v_country_to_find) || '.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Country not found: ' || v_country_to_find || '.');
    END IF;
END;
/