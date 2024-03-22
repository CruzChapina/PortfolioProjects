select * 
from [dbo].[FoodPreference]



 ---Finding the Total Number of applicants

 Select count(*) as TotalApplicants
 From FoodPreference; 

  Select count(distinct(Participant_ID)) as TotalApplicants
 From FoodPreference;

 ---Calculate the average age of participants 

 select AVG(Age) as AverageAge
 From FoodPreference 

 --- List the unique Nationalities of all Participants

 Select Distinct Nationality 
 From FoodPreference 

 --Notcice that we have multiple names for mutliple nationalities therefore to clean the data we must update in our spreadsheet to have one unique Nationality

 --- Identify the most commonly selected food 

 Select top(1) Food, Count(*) as TotalFood 
 From FoodPreference
 Group By Food
 Order BY TotalFood Desc


 --Count the number of participants who are both female and between the age of 25 and 35 years old

 select count(*) as TotalFemaleAdults
 from FoodPreference 
 Where Age Between 25 and 35 
	   And Gender = 'Female'


--Retrieve the time stamp of the and participant Id of the youngest participant in the table 

select Top(1) Timestamp, Participant_ID,
from FoodPreference 
Order By Age 

-- To find the age of the youngest participant all we have to do is add Age to the select command


-- Count the number of participants who are from the same nationality as the oldest participant 


Select Count(*) AS SameNatCount
from FoodPreference
where Nationality =	(
	select top 1 Nationality
	from FoodPreference
	order by Age Desc
)
	
--- Calculate the total number of participants who from the top three nationalities on the table 

--recieves the top three nationalities 
Select top(3) Nationality, count(*) as ParticipantCount
from FoodPreference 
Group BY Nationality 
Order BY ParticipantCount desc
---reminder that I have not updated the table for the repeated or similar Nationalities so this could affect our result.



--- Calcultate the total number of participants for each unique combination of gender and nationality

select Gender, Nationality, Count(*) as ParticipantCount
from FoodPreference 
where Gender IS NOT NUll
Group by Gender, Nationality

