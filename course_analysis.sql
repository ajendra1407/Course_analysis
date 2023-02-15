
select * from s_id;
# Tracks have several courses in it  
select track, count(c_id)
from s_data 
group by track
; 

# 1 course only in 1 track 
select c_id, count(track)
from s_data
group by c_id; 

# student and track mapping - 1 student having multiple tracks 
select s_id, count(track)
from s_data
group by s_id 
having count(track)>1;

#student and course mapping - 1 student multiple course 
select s_id, count(c_id)
from s_data 
group by s_id
having count(c_id)>1 ;




# Are there differences in study progress (points earned) between study programmes?
select c_id, sum(points) as Progress
from s_points 
group by c_id
order by sum(points) DESC;

# - Which age group has the best study progression? -> 20-30 group has best study progression 
with cte as 
(select d.s_id, p.points, 
 case when age between 20 and 30 then '20-30'
      when age between 30 and 40 then '30-40'
      when age between 40 and 50 then '40-50'
      else '50+' 
      end as Age_group 
from s_data d
join s_points p 
on d.s_id = p.s_id)
select Age_group, sum(points)
from cte
group by Age_group 
order by Age_group; 

#- Are women more likely to quit than men? -> Female more likely then Men 
# calculate their total and average points
select d.sex, sum(p.points), avg(p.points), count(p.points)
from s_points p
left join s_data d on p.s_id=d.s_id
group by d.sex ;

select d.sex, sum(p.points), avg(p.points), count(p.points)
from s_points p
left join s_data d on p.c_id=d.c_id
group by d.sex ;

# All courses are distinct 
select count(distinct c_id)
from s_data; 

#- Do emails have an influence on cancellations? -> More mail count led to more Points by a student 
select i.s_id, sum(i.mail_count), sum(p.points)
from s_data d
left join s_id i on d.s_id = i.s_id
left join s_points p on d.s_id=p.s_id
group by i.s_id;


























