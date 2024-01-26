<!-- PROJECT TITLE -->
<h1 align="center">SQL Data Exploration Using SQL Server</h1>

<!-- HEADER -->
<p align="center">
  <img src="Images/Header.png"/>
</p>

<!-- PROJECT OVERVIEW -->
## <br>**➲ Project overview**
This project focuses on exploring and analyzing COVID-19 related data using SQL Server. The primary datasets used are sourced from Our World in Data, specifically the COVID-19 deaths dataset (link to dataset). The dataset is split into two tables: CovidDeaths and CovidVaccinations. The analysis aims to provide insights into COVID-19 cases, deaths, and vaccinations, helping users understand various aspects of the pandemic.

<!-- PREREQUISTIES -->
## <br>**➲ Prerequisites**
This is list of required tools for the project to be installed :
* <a href="https://www.microsoft.com/en-us/sql-server/sql-server-downloads" target="_blank">SQL Server</a>
* <a href="https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16" target="_blank">SQL Server Management Studio (SSMS)</a>


<!-- THE DATASET -->
## <br>**➲ The Dataset**
Download the <a href="https://ourworldindata.org/covid-deaths" target="_blank">COVID-19 deaths dataset</a> from Our World in Data and save it as a CSV file.<br>

<!-- THE DATABASE -->
## <br>**➲ The Database**
1. Download the Dataset
    * Download the COVID-19 deaths dataset from the provided link.
2. Split the Dataset:
    * Divide the dataset into two separate datasets: CovidDeaths and CovidVaccinations as given in Dataset folder.
3. Database Creation:
    * Use SQL Server to create a database named Covid.
4. Table Creation:
    * Import the respective datasets into their corresponding tables.

<!-- DATA ANALYSIS -->
## <br>**➲ SQL Queries and Analysis**
In this part we created multiple queries for analyze the two table from the database and all queries can be founded in Queries folder in Data_Exploration.sql:
<br>

- Table 1 | CovidDeaths :<br>
  * Total Cases vs Total Deaths:
  Query to show the likelihood of dying if you contract COVID-19 in your country.
  
  * Total Cases vs Population:
  Query to display the percentage of the population that contracted COVID-19.

  * Highest Infection Rates:
  Identify countries with the highest infection rates compared to their population.

  * Continent with Highest Death Count:
  Query to determine the continent with the highest death count.

  * Worldwide Statistics:
  Retrieve total new cases and deaths globally.

  * Worldwide Statistics by Date:
  Query to show total new cases and deaths around the world by date.

- Table 2 | CovidVaccinations :<br>
  * Total Population Vaccinations using CTE:
  Use a Common Table Expression (CTE) to analyze the total population vaccinations.

  * Total Population Vaccinations using Temp Table:
  Utilize a temporary table for analyzing total population vaccinations.

<!-- CONTACT -->
## <br>**➲ Contact**
- E-mail   : [omaarelsherif@gmail.com](mailto:omaarelsherif@gmail.com)
- LinkedIn : https://www.linkedin.com/in/omaarelsherif/
- Facebook : https://www.facebook.com/omaarelshereif
