/*PROBLEM*/
Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. The output column headers should be Doctor, Professor, Singer, and Actor, respectively.

Note: Print NULL when there are no more names corresponding to an occupation.

Input Format

The OCCUPATIONS table is described as follows:



Occupation will only contain one of the following values: Doctor, Professor, Singer or Actor.

Sample Input



Sample Output

Jenny    Ashley     Meera  Jane
Samantha Christeen  Priya  Julia
NULL     Ketty      NULL   Maria
Explanation

The first column is an alphabetically ordered list of Doctor names.
The second column is an alphabetically ordered list of Professor names.
The third column is an alphabetically ordered list of Singer names.
The fourth column is an alphabetically ordered list of Actor names.
The empty cell data for columns with less than the maximum number of names per occupation (in this case, the Professor and Actor columns) are filled with NULL values.

/* SOLUTION */


with 

a as  (select  name as aa, ROW_NUMBER() OVER (order by name) as rowy from occupations where occupation = "doctor" order by name ), 
b as  (select  name as bb, ROW_NUMBER() OVER (order by name) as rowy from occupations where occupation = "Professor" order by name), 
c as (select  name as cc, ROW_NUMBER() OVER (order by name) as rowy from occupations where occupation = "Singer" order by name),
d as (select  name as dd, ROW_NUMBER() OVER (order by name) as rowy from occupations where occupation = "Actor" order by name),



a2 as (select aa,bb, a.rowy as rowy
        from a
           left join b
        on a.rowy = b.rowy
union
select aa,bb, b.rowy as rowy
        from a
           right join b
        on a.rowy = b.rowy
),

a3 as (
select aa,bb,cc, a2.rowy as rowy
        from a2 
           left join c
        on a.rowy = c.rowy
union
select aa,bb,cc, c.rowy as rowy
        from a2
           right join c
        on a.rowy = c.rowy)


select aa,bb,cc,dd
        from a3
           left join d
        on a3.rowy = d.rowy
union
select aa,bb, cc ,dd
        from a3
           right join d
        on a3.rowy = d.rowy