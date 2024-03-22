---Count the total number of records in the dataset.

select Count(*) 
from exams

---Calculate the average scores in math, reading, and writing for each gender.

select gender, avg(reading_score) as AvgReading, avg(math_score) as AvgMath, avg(writing_score)  as AvgWrite
from exams
group by gender

--- Compute the average scores by race/ethnicity.

select race_ethnicity, avg(reading_score) as AvgReading, avg(math_score) as AvgMath, avg(writing_score)  as AvgWrite
from exams
Group By race_ethnicity 
order by race_ethnicity

---Find the average scores based on different levels of parental education.

select [parental_level_of_education], avg(reading_score) as AvgReading, avg(math_score) as AvgMath, avg(writing_score)  as AvgWrite
from exams
group by parental_level_of_education

---Calculate the percentage of students who completed the test preparation course, grouped by gender. 

SELECT gender, COUNT(CASE WHEN test_preparation_course = 'completed' THEN 1 END) * 100.0 / COUNT(*) AS percentage_completed
FROM exams
GROUP BY gender

---Determine the average scores for students who had standard lunch versus free/reduced lunch.

select [lunch], avg(reading_score) as AvgReading, avg(math_score) as AvgMath, avg(writing_score)  as AvgWrite
from exams
group by lunch

---Find the average scores for students who completed the test preparation course versus those who didn't, grouped by race/ethnicity.

select [test_preparation_course], avg(reading_score) as AvgReading, avg(math_score) as AvgMath, avg(writing_score)  as AvgWrite
from exams
group by test_preparation_course 

--- Retrieve the average math score for students in each age group from the second table.

select age, avg(math_score) as AvgMath 
From students
group by age

---Find the number of students in each race/ethnicity category in the first table.

select race_ethnicity, count(*) as TotalStudents
from exams 
group by race_ethnicity 
order by race_ethnicity 

--- Calculate the percentage of students who completed the test preparation course, grouped by race/ethnicity, in the first table.

select race_ethnicity, COUNT(CASE WHEN test_preparation_course = 'completed' THEN 1 END) * 100.0 / COUNT(*) AS percentage_completed
FROM exams
GROUP BY race_ethnicity




