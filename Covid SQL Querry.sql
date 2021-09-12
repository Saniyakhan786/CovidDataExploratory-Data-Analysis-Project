
Select *
From [Data Analysis]..['covid- deaths']
Order by 3,4


-- Select *
-- From [Data Analysis]..['covid- vaccines']
-- Order by 3,4

-- Select data that we are going to be using
Select location, date, total_cases, new_cases, total_deaths, population 
From [Data Analysis]..['covid- deaths']
Order by 1,2

-- Looking at Total Cases vs Total Deaths
Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From [Data Analysis]..['covid- deaths']
Order by 1,2

-- Looking at Total Cases vs Total Deaths for States
Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From [Data Analysis]..['covid- deaths']
Where location like '%states%'
Order by 1,2

-- Looking at Total Cases vs Total Deaths for India
Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From [Data Analysis]..['covid- deaths']
Where location like '%India%'
Order by 1,2

-- Looking at Total Cases vs Population for States
Select location, date, total_cases, population, (total_cases/population)*100 as PopulationPercentage
From [Data Analysis]..['covid- deaths']
Where location like '%states%'
Order by 1,2

-- Looking at Total Cases vs Population for India
Select location, date, total_cases, population, (total_cases/population)*100 as PopulationPercentage
From [Data Analysis]..['covid- deaths']
Where location like '%India%'
Order by 1,2

-- Looking at Total Cases vs Population
Select location, date, total_cases, population, (total_cases/population)*100 as PopulationPercentage
From [Data Analysis]..['covid- deaths']
--Where location like '%India%'
Order by 1,2

-- Looking at contries with highest Infection rate compared to Population
Select location, population, MAX (total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as InfectionPercentage
From [Data Analysis]..['covid- deaths']
--Where location like '%India%'
Group by location, population
Order by 1,2

-- Looking at contries with highest Infection rate compared to Population
Select location, population, MAX (total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as InfectionPercentage
From [Data Analysis]..['covid- deaths']
--Where location like '%States%'
Group by location, population
Order by 1,2

-- Looking at contries with highest Infection rate compared to Population in Descending Order
Select location, population, MAX (total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as InfectionPercentage
From [Data Analysis]..['covid- deaths']
--Where location like '%India%'
Group by location, population
Order by InfectionPercentage desc

-- Looking at contries with highest Infection rate compared to Population in Ascendong Order
Select location, population, MAX (total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as InfectionPercentage
From [Data Analysis]..['covid- deaths']
--Where location like '%India%'
Group by location, population
Order by InfectionPercentage asc

-- Showing Countries with Highest Death Count per Population in Ascending Order
Select location, MAX (total_deaths) as TotalDeathCount
From [Data Analysis]..['covid- deaths']
--Where location like '%India%'
Group by location
Order by TotalDeathCount asc

-- Showing Countries with Highest Death Count per Population in Decending  Order
Select location, MAX (total_deaths) as TotalDeathCount
From [Data Analysis]..['covid- deaths']
--Where location like '%India%'
Group by location
Order by TotalDeathCount desc
--here the data type is not integer hence we need to caste the column into int datatype to give us an numeric values
Select location, MAX (cast(total_deaths as int)) as TotalDeathCount
From [Data Analysis]..['covid- deaths']
--Where location like '%India%'
Group by location
Order by TotalDeathCount desc

-- In the dataset we have column where the countinent is null and therefore it gives us different location to get it more 
-- precise we can add a line which will consider it as not null 
Select *
From [Data Analysis]..['covid- deaths']
Where continent is not null
Order by 3,4
-- Now we dont have any not null continent also we can add this line to all the other code to get it more precise

Select location, MAX (cast(total_deaths as int)) as TotalDeathCount
From [Data Analysis]..['covid- deaths']
--Where location like '%India%'
Where continent is not null
Group by location
Order by TotalDeathCount desc

-- here we are doing it using IS NULL
Select location, MAX (cast(total_deaths as int)) as TotalDeathCount
From [Data Analysis]..['covid- deaths']
--Where location like '%India%'
Where continent is null
Group by location
Order by TotalDeathCount desc

-- Lets break down by continents

Select continent, MAX (cast(total_deaths as int)) as TotalDeathCount
From [Data Analysis]..['covid- deaths']
--Where location like '%India%'
Where continent is not null
Group by continent
Order by TotalDeathCount desc

Select continent, MAX (cast(total_deaths as int)) as TotalDeathCount
From [Data Analysis]..['covid- deaths']
--Where location like '%India%'
Where continent is null
Group by continent
Order by TotalDeathCount desc

-- Showing Continent with Highest Death Count per Population in Decending  Order
Select continent, MAX (cast(total_deaths as int)) as TotalDeathCount
From [Data Analysis]..['covid- deaths']
--Where location like '%India%'
Where continent is not null
Group by continent
Order by TotalDeathCount desc

-- Showing Global Numbers

Select date, SUM(new_cases) -- total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From [Data Analysis]..['covid- deaths']
-- Where location like '%states%'
Where continent is not null
Group by date
Order by 1,2
-- for death we need to caste it to ineger as it is varchar in the dataset
Select date, SUM(new_cases), SUM(cast (new_deaths as int )) 
From [Data Analysis]..['covid- deaths']
-- Where location like '%states%'
Where continent is not null
Group by date
Order by 1,2

Select date, SUM(new_cases), SUM(cast (new_deaths as int )) as TotalDeaths, SUM(cast (new_deaths as int ))/SUM(new_cases) *100 as DeathPercentaage
From [Data Analysis]..['covid- deaths']
-- Where location like '%states%'
Where continent is not null
Group by date
Order by 1,2

Select SUM(new_cases) as NewCases, SUM(cast (new_deaths as int )) as TotalDeaths, SUM(cast (new_deaths as int ))/SUM(new_cases) *100 as DeathPercentaage
From [Data Analysis]..['covid- deaths']
-- Where location like '%states%'
Where continent is not null
--Group by date
Order by 1,2

--Vaccine Dataset

Select *
From [Data Analysis]..['covid- vaccines']
Order by 3,4

-- Joining both the datasets

Select *
From [Data Analysis]..['covid- vaccines'] vac
Join [Data Analysis]..['covid- deaths'] dea
      On dea.location = vac.location
	  and dea.date = vac.date

-- Looking at Total Vaccinaton vs Total Population
Select dea.continent, dea.date, dea.location, dea.population , vac.new_vaccinations
From [Data Analysis]..['covid- vaccines'] vac
Join [Data Analysis]..['covid- deaths'] dea
      On dea.location = vac.location
	  and dea.date = vac.date
Where dea.continent is not null
Order by 1,2,3

Select dea.continent, dea.date, dea.location, dea.population , vac.new_vaccinations, 
SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date)
From [Data Analysis]..['covid- vaccines'] vac
Join [Data Analysis]..['covid- deaths'] dea
      On dea.location = vac.location
	  and dea.date = vac.date
Where dea.continent is not null
Order by 1,2,3

Select dea.continent, dea.date, dea.location, dea.population , vac.new_vaccinations, 
SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date as RollongPeopleVaccinated)
From [Data Analysis]..['covid- vaccines'] vac
Join [Data Analysis]..['covid- deaths'] dea
      On dea.location = vac.location
	  and dea.date = vac.date
Where dea.continent is not null
Order by 1,2,3

-- Use CTE
With PopvsVac (Continent, Location, Date, Population, New_vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.date, dea.location, dea.population , vac.new_vaccinations, 
SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
From [Data Analysis]..['covid- vaccines'] vac
Join [Data Analysis]..['covid- deaths'] dea
      On dea.location = vac.location
	  and dea.date = vac.date
Where dea.continent is not null
--Order by 1,2,3
)
Select*, (RollingPeopleVaccinated/Population)*100
From PopvsVac

-- USE TEMP TABLE
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
Select dea.continent, dea.date, dea.location, dea.population , vac.new_vaccinations, 
SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
From [Data Analysis]..['covid- vaccines'] vac
Join [Data Analysis]..['covid- deaths'] dea
      On dea.location = vac.location
	  and dea.date = vac.date
--Where dea.continent is not null
--Order by 1,2,3

Select*, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated

Select *
From PercentPopulationVaccinated

-- Creating View for storing our data

Create View  DeathPercentage as
Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From [Data Analysis]..['covid- deaths']
--Order by 1,2


Create View  PopulationPer
as
Select location, date, total_cases, population, (total_cases/population)*100 as PopulationPercentage
From [Data Analysis]..['covid- deaths']
Where location like '%India%'
--Order by 1,2















