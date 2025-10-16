CREATE TABLE DEPTS(
deptno NUMBER PRIMARY KEY,
dname VARCHAR2(20) NOT NULL,
location VARCHAR2(20) NOT NULL
);

CREATE TABLE EMPS(
empno NUMBER PRIMARY KEY ,
ename VARCHAR2(200) NOT NULL,
job VARCHAR2(200) NOT NULL,
salary NUMBER NOT NULL,
dep_no NUMBER REFERENCES DEPTS(deptno)
);

INSERT ALL
INTO DEPTS (deptno, dname, location) values (10, 'IT','Bangalore')
INTO DEPTS (deptno, dname, location) values (20, 'HR','Hyderabad')
INTO DEPTS (deptno, dname, location) values (30, 'Operations', 'Delhi')
SELECT * FROM dual;

COMMIT;

INSERT ALL
INTO EMPS (empno, ename, job, salary, dep_no) VALUES (1, 'Aarav' , 'Software Engineer' , 30000000, 10)
INTO EMPS (empno, ename, job, salary, dep_no) VALUES (2, 'Meera' , 'Software Engineer' , 50000000, 20)
INTO EMPS (empno, ename, job, salary, dep_no) VALUES (3, 'Ben' , 'Human Resources' , 80000000, 30)
SELECT * FROM dual;

COMMIT;

-------------------------------------------------

EMPLOYEE NAMES ALONG WITH THEIR DEPARTMENT NAMES.
SELECT e.ename, d.dname
FROM EMPS e
JOIN DEPTS d ON e.dep_no = d.deptno; 

ALL EMPLOYEES WITH THEIR JOB TITLES AND THE LOCATION OF THEIR DEPARTMENT.
SELECT e.ename, e.job, d.location
FROM EMPS e
JOIN DEPTS d ON e.dep_no = d.deptno; 

EMPLOYEES WHO WORK IN THE SALES DEPARTMENT.
SELECT e.ename, e.job, e.salary
FROM EMPS e
JOIN DEPTS d ON e.dep_no = d.deptno
WHERE UPPER(d.dname) = 'SALES'; 

EMPLOYEES ALONG WITH THEIR DEPARTMENT NAME AND LOCATION,
-- INCLUDING DEPARTMENTS THAT HAVE NO EMPLOYEES.
SELECT e.ename, e.job, d.dname, d.location
FROM DEPTS d
LEFT JOIN EMPS e ON e.dep_no = d.deptno; 

ALL DEPARTMENTS AND EMPLOYEES,
-- EVEN IF SOME EMPLOYEES ARE NOT ASSIGNED TO ANY DEPARTMENT.
SELECT e.ename, e.job, d.dname, d.location
FROM EMPS e
FULL OUTER JOIN DEPTS d ON e.dep_no = d.deptno; 

EACH DEPARTMENT NAME AND TOTAL SALARY PAID TO ITS EMPLOYEES.
SELECT d.dname, SUM(e.salary) AS total_salary
FROM DEPTS d
LEFT JOIN EMPS e ON e.dep_no = d.deptno
GROUP BY d.dname; 

DEPARTMENTS THAT HAVE MORE THAN 3 EMPLOYEES.
-- Display dname and number of employees.
SELECT d.dname, COUNT(e.empno) AS num_employees
FROM DEPTS d
JOIN EMPS e ON e.dep_no = d.deptno
GROUP BY d.dname
HAVING COUNT(e.empno) > 3; 

EMPLOYEES WHO WORK IN THE SAME LOCATION AS THE ACCOUNTING DEPARTMENT.
SELECT e.ename, e.job, d.location
FROM EMPS e
JOIN DEPTS d ON e.dep_no = d.deptno
WHERE d.location = (
SELECT location
FROM DEPTS
WHERE UPPER(dname) = 'ACCOUNTING'
); 

EACH DEPARTMENT, DISPLAY THE EMPLOYEE WHO HAS THE HIGHEST SALARY.
SELECT e.ename, e.salary, d.dname
FROM EMPS e
JOIN DEPTS d ON e.dep_no = d.deptno
WHERE e.salary = (
SELECT MAX(e2.salary)
FROM EMPS e2
WHERE e2.dep_no = e.dep_no
); 

EMPLOYEES WHOSE SALARY IS GREATER THAN
-- THE AVERAGE SALARY OF THEIR DEPARTMENT.
SELECT e.ename, e.salary, d.dname
FROM EMPS e
JOIN DEPTS d ON e.dep_no = d.deptno
WHERE e.salary > (
SELECT AVG(e2.salary)
FROM EMPS e2
WHERE e2.dep_no = e.dep_no

); 
