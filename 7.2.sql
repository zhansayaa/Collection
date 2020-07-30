DECLARE 
CURSOR STUDENT_GRADE IS SELECT s.student_id, s.First_name, g.numeric_grade
FROM student s JOIN grade g ON s.student_id = g.student_id;
rec STUDENT_GRADE%rowtype;
TYPE student_type IS TABLE OF STUDENT_GRADE%ROWTYPE INDEX BY BINARY_INTEGER;
student_tab student_type;
v NUMBER :=1;
BEGIN
OPEN STUDENT_GRADE;
    LOOP
        FETCH STUDENT_GRADE into rec;
        EXIT when STUDENT_GRADE%notfound;
        student_tab(v).student_id :=rec.student_id;
        student_tab(v).First_name :=rec.First_name;
        student_tab(v).numeric_grade :=rec.numeric_grade;   
        v := v + 1;
        END LOOP;
    CLOSE STUDENT_GRADE;
        DBMS_OUTPUT.PUT_LINE('ID: '||student_tab(student_tab.FIRST).student_id || ' Student`s name: '||student_tab(student_tab.FIRST).First_name || ' Grade is:  '  || student_tab(student_tab.FIRST).numeric_grade);
        DBMS_OUTPUT.PUT_LINE('ID: '||student_tab(student_tab.LAST).student_id || ' Student`s name: '||student_tab(student_tab.LAST).First_name || '  Grade is:  '  || student_tab(student_tab.LAST).numeric_grade);
END;
