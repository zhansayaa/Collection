DECLARE 
CURSOR STUDENT_GRADE IS SELECT s.student_id, s.First_name, g.numeric_grade
FROM student s JOIN grade g ON s.student_id = g.student_id;
rec STUDENT_GRADE%rowtype;
TYPE student_type IS TABLE OF STUDENT_GRADE%ROWTYPE INDEX BY BINARY_INTEGER;
student_tab student_type;
v_cnt NUMBER :=1;
BEGIN
OPEN STUDENT_GRADE;
    LOOP
        FETCH STUDENT_GRADE into rec;
        EXIT when STUDENT_GRADE%notfound;
        student_tab(v_cnt).student_id :=rec.student_id;
        student_tab(v_cnt).First_name :=rec.First_name;
        student_tab(v_cnt).numeric_grade :=rec.numeric_grade;  
        v_cnt := v_cnt + 1;
        END LOOP;
    CLOSE STUDENT_GRADE;
    DBMS_OUTPUT.PUT_LINE('Total number is  ' || student_tab.COUNT);
   -- student_tab.DELETE(student_tab.LAST);
    --DBMS_OUTPUT.PUT_LINE('Now ' || student_tab.COUNT);
    --FOR i in 1 .. student_tab.COUNT LOOP
     --   DBMS_OUTPUT.PUT_LINE('ID ' || student_tab(i).student_id || ' Name: '|| student_tab(i).first_name);
    --END LOOP;
END;
