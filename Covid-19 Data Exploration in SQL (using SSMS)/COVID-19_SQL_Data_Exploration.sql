/*
Covid 19 Data Exploration 
Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types
*/


Select *
FROM Covid_Project..covid_deaths
WHERE continent is not null
order by 3,4;


-- Selecting the data that we are going to be using

select Location, date, total_cases, new_cases, total_deaths, population
FROM Covid_Project..covid_deaths
WHERE continent is not null
order by 1,2;

-- Looking at Total Cases vs Total Deaths
-- Shows the likelihood of dying if you contract covid in your country
select Location, date, total_cases, total_deaths, ROUND((total_deaths/total_cases)*100,2) as DeathPercentage
FROM Covid_Project..covid_deaths
WHERE continent is not null
order by 1,2;


-- Looking at the Total Cases vs the Population which shows us what percentage of population is infected with Covid

select Location, date, total_cases, Population, ROUND((total_cases/population)*100,2) as CasesPerPopulation
FROM Covid_Project..covid_deaths
WHERE continent is not null
--AND location like '%india%'
order by 1,2;

-- Looking at Countries with Highest Infection Rate compared to Population

SELECT Location,  Population, MAX(total_cases) as HighestInfectionCount, MAX(ROUND((total_cases/population)*100,2)) as HighestInfectionRate
FROM Covid_Project..covid_deaths
WHERE continent is not null
GROUP BY Location, Population
ORDER BY HighestInfectionRate desc;



-- Showing Countries with highest Death Count per Population

SELECT Location, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM Covid_Project..covid_deaths
WHERE continent is not null
GROUP BY Location
ORDER BY TotalDeathCount desc;


-- Let's break things down by continent

-- showing continents with the highest death count per population

SELECT continent, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM Covid_Project..covid_deaths
WHERE continent is not null
GROUP BY continent
ORDER BY TotalDeathCount desc;

--We can see that the continent's death count is erroneously shown (just a country's details)
-- We shall rectify that in a later stage


-- GLOBAL NUMBERS

SELECT date, SUM(new_cases) as Total_Cases, SUM(cast(new_deaths as int)) as Total_Deaths, ROUND(SUM(cast(new_deaths as int))/SUM(new_cases)*100,2) as Death_Percentage
FROM Covid_Project..covid_deaths
WHERE continent is not null
GROUP BY date
ORDER BY 1,2;

--Total deaths all over the world so far
SELECT SUM(new_cases) as Total_Cases, SUM(cast(new_deaths as int)) as Total_Deaths, ROUND(SUM(cast(new_deaths as int))/SUM(new_cases)*100,2) as Death_Percentage
FROM Covid_Project..covid_deaths
WHERE continent is not null
--GROUP BY date
ORDER BY 1,2;

--NOW LET US JOIN THE TWO TABLES

-- Looking at Total Population vs Vaccinations


SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM Covid_Project..covid_deaths dea
JOIN Covid_Project..covid_vaccination vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3;


-- Shows Percentage of Population that has recieved at least one Covid Vaccine


SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated 
--, ROUND((RollingPeopleVaccinated/dea.population)*100,2) AS [Rolling%]
FROM Covid_Project..covid_deaths dea
JOIN Covid_Project..covid_vaccination vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3;

-- Using CTE or a TEMP TABLE to perform Calculation on Partition By in previous query (IF YOU DON'T WANNA GET AN ERROR WHILE CALLING RollingPeopleVaccinated)

-- So, let us copy that here and try again with CTE!!

WITH PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
AS
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated 
--, ROUND((RollingPeopleVaccinated/dea.population)*100,2) AS [Rolling%]
FROM Covid_Project..covid_deaths dea
JOIN Covid_Project..covid_vaccination vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3
)
Select *, ROUND((RollingPeopleVaccinated/Population)*100,2) AS [Rolling%]
FROM PopvsVac;


-- Now the same thing with TEMP TABLE

DROP TABLE IF EXISTS #PercentPopulationVaccinated;
CREATE TABLE #PercentPopulationVaccinated
(
Continent nvarchar(255), 
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vaccinations numeric,
RollingPeopleVaccinated numeric
)

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated 
--, ROUND((RollingPeopleVaccinated/dea.population)*100,2) AS [Rolling%]
FROM Covid_Project..covid_deaths dea
JOIN Covid_Project..covid_vaccination vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3

Select *, ROUND((RollingPeopleVaccinated/Population)*100,2) AS [Rolling%]
FROM #PercentPopulationVaccinated;




-- Creating VIEW to store data for later visualization


CREATE VIEW PercentPopulationVaccinated AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated 
--, ROUND((RollingPeopleVaccinated/dea.population)*100,2) AS [Rolling%]
FROM Covid_Project..covid_deaths dea
JOIN Covid_Project..covid_vaccination vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3

select *
from PercentPopulationVaccinated
