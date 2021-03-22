/* PROBLEM */

/*Julia conducted a  days of learning SQL contest.
The start date of the contest was March 01, 2016 and the end date was March 15, 2016.
Write a query to print total number of unique hackers who made at least  submission each day (starting on the first day of the contest),
and find the hacker_id and name of the hacker who made maximum number of submissions each day. 
If more than one such hacker has a maximum number of submissions, print the lowest hacker_id. 
The query should print this information for each day of the contest, sorted by the date.

/* site = https://www.hackerrank.com/challenges/15-days-of-learning-sql/problem */

/* SOLUTION */

with 

--hackers that submited everyday

a as ( select 
        hacker_id,
        submission_date,
        count(distinct submission_id) as count_submissions,
        day(submission_date ) as daysy,
        row_number() over (partition by hacker_id order by submission_date asc) as row_rank

    from submissions
    group by hacker_id,submission_date) 
    
,valid_hackers as (   
    select hacker_id,
        submission_date,
         count_submissions from a
    where daysy <=row_rank  
)

--count valid hackers per day
,count_hackers_byday as (
    select 
        a.submission_date,
        count(distinct a.hacker_id) count_valid_hackers
    from submissions as a
     -- only hackers that submited everyday 
    inner join valid_hackers as b 
        on a.hacker_id=b.hacker_id
        and a.submission_date=b.submission_date

    group by 
        a.submission_date
) 

--submissions per day of valid hackers
,submissions_perday as (
 
    select 
        a.hacker_id, 
        a.submission_date,
    -- Calculations
        count(distinct submission_id) total_submissions  
    from submissions  a
      
       group by
        a.hacker_id, a.submission_date
)

--ranking valid hackers per day by submissions
,ranking_hackers as (

    select
        hacker_id,
        submission_date,
        row_number() over (partition by submission_date order by total_submissions desc, hacker_id asc ) ranking
    from submissions_perday
)

select
    a.submission_date,
    c.count_valid_hackers,
    a.hacker_id,
    b.name 
 
from ranking_hackers a

Left join hackers b
    on a.hacker_id = b.hacker_id

left join count_hackers_byday c 
    on a.submission_date = c.submission_date

where a.ranking=1

order by  a.submission_date;

