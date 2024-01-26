/******************** Table 1 : CovidDeaths ********************/

-- Casting varchar columns into float
ALTER TABLE CovidDeaths
ALTER COLUMN total_cases float

ALTER TABLE CovidDeaths
ALTER COLUMN total_deaths float

ALTER TABLE CovidDeaths
ALTER COLUMN new_cases float

ALTER TABLE CovidDeaths
ALTER COLUMN new_deaths float

-- Selcet data that we are going to be using
SELECT 
	location, 
	date, 
	total_cases, 
	new_cases, 
	total_deaths, 
	population 
FROM CovidDeaths
ORDER BY 1,2

-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contact covid in your country
SELECT 
	location, 
	date, 
	total_cases, 
	total_deaths,
	ROUND((total_deaths/total_cases) * 100, 2) AS DeathPercentage
FROM CovidDeaths
WHERE 
	(total_deaths/total_cases) IS NOT NULL
	AND location LIKE '%states%'
ORDER BY 1,2

-- Looking at Total Cases vs Population
-- Shows what percentage of population got Covid
SELECT 
	location, 
	date, 
	total_cases, 
	population,
	ROUND((total_cases/population) * 100, 4) AS DeathPoulation
FROM CovidDeaths
WHERE 
	(total_cases/population) IS NOT NULL
	--AND location LIKE '%states%'
ORDER BY 1,2

-- Looking at countries with highest infection rate comared to population
SELECT 
	location, 
	population,
	MAX(total_cases) AS InfectionCount,
	ROUND((total_cases/population) * 100, 4) AS PoulationInfectedPercent
FROM CovidDeaths
WHERE ROUND((total_cases/population) * 100, 4) IS NOT NULL
GROUP BY location, population, total_cases
ORDER BY population DESC, PoulationInfectedPercent DESC

-- Show continent with highest death count 
SELECT 
	continent, 
	MAX(total_deaths) AS TotalDeathsCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathsCount DESC

-- Show total new cases and deaths around the world
SELECT  
	SUM(new_cases) AS TotalCases, 
	SUM(new_deaths) AS TotalDeaths,
	(SUM(new_deaths) / SUM(new_cases)) * 100 AS DeathsPercentage
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2

-- Show total new cases and deaths around the world by date
SELECT  
	date, 
	SUM(new_cases) AS TotalCases, 
	SUM(new_deaths) AS TotalDeaths,
	(SUM(new_deaths) / SUM(new_cases)) * 100 AS DeathsPercentage
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2


/******************** Table 2 : CovidVaccinations ********************/

-- Casting varchar columns into int
ALTER TABLE CovidVaccinations
ALTER COLUMN new_vaccinations int

-- Selcet data that we are going to be using
SELECT 
	*
FROM CovidDeaths dea
JOIN CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date

-- Looking at total Population Vaccinations using CTE
WITH PopvsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
AS
(
	SELECT 
		dea.continent,
		dea.location,
		dea.date,
		dea.population,
		vac.new_vaccinations,
		SUM(CAST(vac.new_vaccinations AS BIGINT))
		OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
	FROM CovidDeaths dea
	JOIN CovidVaccinations vac
		ON dea.location = vac.location
		AND dea.date = vac.date
	WHERE dea.continent IS NOT NULL
)
SELECT 
	*, 
	(RollingPeopleVaccinated/population) * 100
FROM PopvsVac

-- Looking at total Population Vaccinations using temp table
DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
	continent nvarchar(255),
	location nvarchar(255),
	date datetime,
	population numeric,
	new_vaccinations numeric,
	RollingPeopleVaccinated numeric
)
INSERT INTO #PercentPopulationVaccinated
SELECT 
	dea.continent,
	dea.location,
	dea.date,
	dea.population,
	vac.new_vaccinations,
	SUM(CAST(vac.new_vaccinations AS BIGINT))
	OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL

SELECT 
	*, 
	(RollingPeopleVaccinated/population) * 100
FROM #PercentPopulationVaccinated

-- Create a view to store date for later visualzation
DROP VIEW IF EXISTS PercentPopulationVaccinated
GO
CREATE VIEW PercentPopulationVaccinated AS
SELECT 
	dea.continent,
	dea.location,
	dea.date,
	dea.population,
	vac.new_vaccinations,
	SUM(CAST(vac.new_vaccinations AS BIGINT))
	OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
GO

SELECT * FROM PercentPopulationVaccinated