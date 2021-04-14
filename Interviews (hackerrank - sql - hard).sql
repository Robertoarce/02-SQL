/*The PROBLEM*/

Samantha interviews many candidates from different colleges using coding challenges and contests. Write a query to print the contest_id, hacker_id, name, and the sums of total_submissions, total_accepted_submissions, total_views, and total_unique_views for each contest sorted by contest_id. Exclude the contest from the result if all four sums are .

Note: A specific contest can be used to screen candidates at more than one college, but each college only holds  screening contest.

Input Format

The following tables hold interview data:

Contests: The contest_id is the id of the contest, hacker_id is the id of the hacker who created the contest, and name is the name of the hacker. 
    column       |   type
    __________________________
    contest_id   |  integer
    hacker_id    |  integer
    name         |  string


Colleges: The college_id is the id of the college, and contest_id is the id of the contest that Samantha used to screen the candidates. 
    column       |   type
    __________________________
    college_id   |  integer
    contest_id   |  integer
    
Challenges: The challenge_id is the id of the challenge that belongs to one of the contests whose contest_id Samantha forgot, and college_id is the id of the college where the challenge was given to candidates. 
    column          |   type
    __________________________
    challenge_id    |  integer
    college_id      |  integer

View_Stats: The challenge_id is the id of the challenge, total_views is the number of times the challenge was viewed by candidates, and total_unique_views is the number of times the challenge was viewed by unique candidates. 
    column                  |   type
    __________________________________
    challenge_id            |  integer
    total_views             |  integer
    total_unique_views      |  integer

Submission_Stats: The challenge_id is the id of the challenge, total_submissions is the number of submissions for the challenge, and total_accepted_submission is the number of submissions that achieved full scores. 
    column                     |   type
    ______________________________________
    challenge_id               |  integer
    total_submissions          |  integer
    total_accepted_submission  |  string
 
Sample Output

66406 17973 Rose 111 39 156 56
66556 79153 Angela 0 0 11 10
94828 80275 Frank 150 38 41 15
Explanation

The contest 66406  is used in the college 11219 . In this college  11219, challenges 18765  and  47127 are asked, so from the view and submission stats:

Sum of total submissions = 27 +56 +28 = 111

Sum of total accepted submissions 10 + 18 + 11 = 39

Sum of total views 43 + 72 +26 +15 = 156

Sum of total unique views 10 + 13 + 19 + 14 =56

Similarly, we can find the sums for contests 66556 and 94828.


/*Solution*/

with

total_sub as (select challenge_id, sum(total_submissions) as total_subs, sum(total_accepted_submissions) as total_ac_subs from Submission_Stats
group by challenge_id),

total_views as (select challenge_id, sum(total_views) as sum_total_views, sum(total_unique_views) as sum_total_unique_subs from View_Stats
group by challenge_id),

colleges as (select contest_id, a.college_id, challenge_id from colleges as a left join challenges as b on a.college_id = b.college_id group by contest_id, a.college_id, challenge_id),

mix_subs_views as (select a.challenge_id, sum(total_subs) as total_subs, sum(total_ac_subs) as total_ac_subs, sum(total_views) as total_views,
 sum(total_unique_views) as total_unique_views from total_sub as a left join total_views as b on a.challenge_id = b.challenge_id group by a.challenge_id
 
 union

 select b.challenge_id, sum(total_subs) as total_subs, sum(total_ac_subs) as total_ac_subs, sum(total_views) as total_views,
 sum(total_unique_views) as total_unique_views from total_sub as a right join total_views as b on a.challenge_id = b.challenge_id group by b.challenge_id
 )

select 
    a.contest_id, 
    b.hacker_id, 
    b.name, 
sum(a.total_subs), 
sum(a.total_ac_subs), 
sum(total_views), 
sum(total_unique_views) 
from 
    a.mix_subs_views 
right join 
    b.Contests
on 
    a.contest_id = b.contest_id
group by
    a.contest_id, 
    b.hacker_id, 
    b.name





with

total_sub as (select challenge_id, sum(total_submissions) as total_subs, sum(total_accepted_submissions) as total_ac_subs from Submission_Stats
group by challenge_id),

total_views as (select challenge_id, sum(total_views) as sum_total_views, sum(total_unique_views) as sum_total_unique_subs from View_Stats
group by challenge_id),

colleges as (select contest_id, a.college_id, challenge_id from colleges as a left join challenges as b on a.college_id = b.college_id group by contest_id, a.college_id, challenge_id),

mix_subs_views as (select a.challenge_id, sum(total_subs) as total_subs, sum(total_ac_subs) as total_ac_subs, sum(total_views) as total_views,
 sum(total_unique_views) as total_unique_views from (select challenge_id, sum(total_submissions) as total_subs, sum(total_accepted_submissions) as total_ac_subs from Submission_Stats
group by challenge_id) as a left join total_views as b on a.challenge_id = b.challenge_id group by a.challenge_id
 
 union

 select b.challenge_id, sum(total_subs) as total_subs, sum(total_ac_subs) as total_ac_subs, sum(total_views) as total_views,
 sum(total_unique_views) as total_unique_views from (select challenge_id, sum(total_submissions) as total_subs, sum(total_accepted_submissions) as total_ac_subs from Submission_Stats
group by challenge_id) as a right join total_views as b on a.challenge_id = b.challenge_id group by b.challenge_id
 )

select 
    a.contest_id, 
    b.hacker_id, 
    b.name, 
sum(a.total_subs), 
sum(a.total_ac_subs), 
sum(total_views), 
sum(total_unique_views) 
from 
    (select a.challenge_id, sum(total_subs) as total_subs, sum(total_ac_subs) as total_ac_subs, sum(total_views) as total_views,
 sum(total_unique_views) as total_unique_views from (select challenge_id, sum(total_submissions) as total_subs, sum(total_accepted_submissions) as total_ac_subs from Submission_Stats
group by challenge_id) as a left join total_views as b on a.challenge_id = b.challenge_id group by a.challenge_id
 
 union

 select b.challenge_id, sum(total_subs) as total_subs, sum(total_ac_subs) as total_ac_subs, sum(total_views) as total_views,
 sum(total_unique_views) as total_unique_views from (select challenge_id, sum(total_submissions) as total_subs, sum(total_accepted_submissions) as total_ac_subs from Submission_Stats
group by challenge_id) as a right join total_views as b on a.challenge_id = b.challenge_id group by b.challenge_id
 ) as a
right join 
    b.Contests
on 
    a.contest_id = b.contest_id
group by
    a.contest_id, 
    b.hacker_id, 
    b.name
