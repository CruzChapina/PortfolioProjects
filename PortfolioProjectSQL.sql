Select *
From CovidDeaths
order by 3, 4

--Select *
--From CovidVaccinations
--order by 3, 4


Select Location , Date, total_cases, new_cases, total_deaths, population
From CovidDeaths
order by 1, 2

-- Looking at the Total Cases vs Total Deaths 
-- Shows the likelihood of dying if you contract covid in the USA
Select Location , Date, total_cases, total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
From CovidDeaths
Where location like '%states%'
order by 1, 2

--Looking at the Total Casees vs Population
--Shows what percentage of the population got covid

Select Location , Date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
From CovidDeaths
--Where location like '%states%'
order by 1, 2

--Looking at the highest infection rate compared to the population

Select Location , population, Max(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentPopulationInfected
From CovidDeaths
--Where location like '%states%'
Group By Location, Population
order by PercentPopulationInfected desc


--Showing Countries with the Highest Death count per population

Select Location , Max(cast(Total_deaths as int)) as TotalDeathCount
From CovidDeaths
--Where location like '%states%'
where continent is not null
Group By Location
order by TotalDeathCount desc

-- Lets break things down by continent



--THis is showing the continents with the highest death count

Select continent , Max(cast(Total_deaths as int)) as TotalDeathCount
From CovidDeaths
--Where location like '%states%'
where continent is not null
Group By continent
order by TotalDeathCount desc


-- Global Numbers

Select Sum(new_cases) as total_cases, Sum(cast(new_deaths as int)) as total_deaths, 
	Sum(cast(new_deaths as int))/Sum(new_cases)*100 as DeathPercentage
From CovidDeaths
--Where location like '%states%'
where continent is not null
--group by date
order by 1, 2


--Looking at Total Population vs Vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
	,Sum(cast(vac.new_vaccinations as int)) over (Partition by dea.location order by dea.location, dea.date) 
	,as RollingPeopleVaccinated
	From CovidDeaths dea
Join CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3


--Use CTE

With PopvsVac (COntinent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as 
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
	,Sum(cast(vac.new_vaccinations as int)) over (Partition by dea.location order by dea.location, dea.date) 
	--,as RollingPeopleVaccinated
	From CovidDeaths dea
Join CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3
)

Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac


-- TEMP Table

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null 
--order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated


--Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From CovidDeaths dea
Join CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 

Select * 
From PercentPopulationVaccinated