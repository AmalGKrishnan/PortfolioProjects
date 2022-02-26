/*
Queries used for Tableau Project
*/



-- 1. 

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From Covid_Project..covid_deaths
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2

-- Just a double check based off the data provided
-- numbers are extremely close so we will keep them - The Second includes "International"  Location


--Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
--From Covid_Project..covid_deaths
----Where location like '%states%'
--where location = 'World'
----Group By date
--order by 1,2


-- 2. 

-- We take these out as they are not inluded in the above queries and want to stay consistent
-- European Union is part of Europe

Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From Covid_Project..covid_deaths
--Where location like '%states%'
Where continent is null 
and location not in ('World', 'European Union', 'International')
and location not like '%income%'
Group by location
order by TotalDeathCount desc

--select DISTINCT location From Covid_Project..covid_deaths where location like '%income%'
-- we are getting location with 'income' names too, so we are removing them too in our
-- 3.

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From Covid_Project..covid_deaths
Where continent is not null
--and location not in ('World', 'European Union', 'International')
--and location not like '%income%'
Group by Location, Population
order by PercentPopulationInfected desc

-- Here we have NULL values which need to be converted in MS Excel.
-- 4.


Select Location, continent, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From Covid_Project..covid_deaths
Where continent is not null
--Where location like '%states%'
Group by continent, Location, Population, date
order by PercentPopulationInfected desc

