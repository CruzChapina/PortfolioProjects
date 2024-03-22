-- Retrieve all rows from the dataset.
Select * 
From Crime

--Retrieve the count of incidents reported in each area.
SELECT AREA, AREA_NAME, COUNT(*) AS Incident_Count
FROM Crime
GROUP BY AREA, AREA_NAME
Order by Incident_Count desc
--From our highest incident count the area is unknown but central 
--is the most known area with the highest count. 


--Retrieve the total count of incidents reported for each crime code description.
Select Crm_cd, count(*) as Crime_Code
from Crime
Group by Crm_Cd
Order by Crime_Code desc

--Retrieve incidents where the crime code is '480' (BIKE - STOLEN).
select * 
from Crime 
where Crm_Cd = 480 

--Retrieve incidents where the crime code description contains 'THEFT'.
select * 
from Crime 
where Crm_Cd_Desc Like '%THEFT%'

--Retrieve incidents where the victim's age is between 18 and 30 years old.
Select * 
From Crime 
Where Vict_Age Between 18 and 30

--Retrieve incidents where the crime occurred at a specific location (e.g., " S FLOWER ST").
Select * 
From Crime
Where LOCATION like '%S Main%'

--Retrieve incidents reported in a specific month and year.
Select * 
From Crime	
Where Date_Rptd like  '%05-03%'

--Retrieve incidents where the status is marked as 'Invest Cont' (Investigation Continued).
Select * 
From Crime
Where Status_Desc = 'Invest Cont'

--Retrieve incidents where the victim's sex is female (F).

Select * 
From Crime
Where Vict_Sex = 'F'

--Retrieve the top 5 known areas with the highest number of incidents reported.
Select Top 5 AREA, AREA_NAME, count(*) AS Incident_Count
From Crime
GROUP BY AREA_NAME, AREA
ORDER BY Incident_Count Desc

--Retrieve the crime codes and their corresponding descriptions for incidents where the victim's age is less than 18 or greater than 65.
Select Crm_Cd, Crm_Cd_Desc
from Crime
Where Vict_Age < 18 OR Vict_Age > 65

--Retrieve the average latitude and longitude of incidents reported in each area.
Select AREA_NAME, AREA, Avg(LAT) as AvgLAT, Avg(LON) as AvgLON
From Crime
Group By AREA_NAME, AREA

--Retrieve incidents where the crime occurred between 6:00 PM and 12:00 AM (evening hours).
SELECT *
FROM Crime
WHERE TIME_OCC >= '1800' AND TIME_OCC <= '2359'

--Retrieve incidents where the location is either a bus stop or a clothing store.
SELECT *
FROM Crime
WHERE Premis_Desc LIKE '%BUS Stop%'
   OR Premis_Desc LIKE '%CLOTHING STORE%'

--Retrieve the most common crime descriptions and their occurrence count.
Select count(*) as description_count, Crm_Cd_Desc
from Crime
Group by Crm_Cd_Desc
--Retrieve incidents reported in the past year.
Select * 
From Crime 
Where Date_Rptd > '12-31-23' 
--Retrieve the average age of victims for each crime code and the desription.
Select Crm_Cd, Crm_Cd_Desc, avg(Vict_Age) as Avg_Age_For_Code
From Crime 
Group By Crm_Cd, Crm_Cd_Desc
Order By Avg_Age_For_Code 

--Retrieve the top 5 areas with the highest average age of victims.
Select Top(5) AREA, AREA_NAME, avg(Vict_Age) as avg_age
From Crime
group by Area, AREA_NAME
order By avg_age DESC

--Retrieve incidents where the crime occurred on weekends (Saturday or Sunday).
Select * 
From Crime 
Where DATENAME(dw, Date_occ) in ('Saturday', 'Sunday')

--Retrieve incidents where the victim's age is an outlier (e.g., more than 3 standard deviations from the mean age).
SELECT *
FROM Crime
WHERE Vict_Age > (
    SELECT AVG(Vict_Age) + 3 * STDEV(Vict_Age)
    FROM Crime
)
OR Vict_Age < (
    SELECT AVG(Vict_Age) - 3 * STDEV(Vict_Age)
    FROM Crime
);


