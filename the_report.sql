
You are given two tables: Students and Grades. Students contains three columns ID, Name and Marks.


/*PROBLEM*/
/*Grades contains the following data:

Ketty gives Eve a task to generate a report containing three columns:
 Name, Grade and Mark.
  Ketty doesn't want the NAMES of those students who received a grade lower than 8. 
  The report must be in descending order by grade -- i.e. higher grades are entered first.
   If there is more than one student with the same grade (8-10) assigned to them, 
   order those particular students by their name alphabetically.
   Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. 
   If there is more than one student with the same grade (1-7) assigned to them,
    order those particular students by their marks in ascending order.
Print "NULL"  as the name if the grade is less than 8.

Sample Output

Maria 10 99
Jane 9 81
Julia 9 88 
Scarlet 8 78
NULL 7 63
NULL 7 68

*/
/*SOLUTION */

select 

    case when note >7 then Name else "NULL" end as name,
    note,
    marks
from
        (select 
            Id,
            Name,
            case  
                when marks >89 then  10
                when marks >79 then  9
                when marks >69 then  8
                when marks >59 then  7
                when marks >49 then  6
                when marks >39 then  5
                when marks >29 then  4
                when marks >19 then  3
                when marks >9  then  2 
                else                 1
                end as note,
            marks
        from 
            students
        ) as a
order by 
    note desc,
    Name asc,
    marks asc