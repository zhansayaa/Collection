DECLARE 
CURSOR STUDENT_GRADE IS SELECT s.student_id, s.First_name, g.numeric_grade
FROM student s JOIN grade g ON s.student_id = g.student_id;
rec STUDENT_GRADE%rowtype;
TYPE student_type IS TABLE OF STUDENT_GRADE%ROWTYPE;
student_tab student_type :=student_type();
v_cnt NUMBER :=1;
div NUMBER :=0;
temp Number :=0;
BEGIN
    OPEN STUDENT_GRADE;
    LOOP
        FETCH STUDENT_GRADE into rec;
        EXIT when STUDENT_GRADE%notfound;
        student_tab.EXTEND;
        student_tab(v_cnt).student_id :=rec.student_id;
        student_tab(v_cnt).First_name :=rec.First_name;
        student_tab(v_cnt).numeric_grade :=rec.numeric_grade;  
         v_cnt := v_cnt + 1;
        END LOOP;
    CLOSE STUDENT_GRADE;
    
    FOR i in 1 .. student_tab.COUNT LOOP
      IF(student_tab(i).student_id = student_tab(i+1).student_id) THEN
        temp := temp + student_tab(i).numeric_grade;
        div := div + 1;
      ELSE 
        DBMS_OUTPUT.PUT_LINE('ID  '||student_tab(i).student_id || ' Student name: '  || student_tab(i).First_name || ', GRADE: '|| temp/div);
        temp := 0;
        div := 0;
      end if;
    END LOOP;
END;

