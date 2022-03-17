
# Covid-19 Data Extraction & Exploration in SQL (using SSMS)

In this project, our main goal is extracting and exploring the complete COVID-19 dataset maintained by [Our World in Data](https://github.com/owid/covid-19-data/tree/master/public/data).

### DATA

The dataset is a .csv file with 67 columns and 163,574 rows (as of 02/21/2022). I have divided the main dataset into two separate tables, namely covid_deaths and covid_vaccination. 

### REQUIREMENT

Build a database and perform some EDA using SQL.

Major questions that we'll be answering here are:


    1.	What does the Total Cases vs Total Deaths look like?


    2.	What percentage of the total population is infected with Covid-19?
    
    
    3.	Which are the countries/ continents with highest number of death due to Covid-19?


    4.      What does the vaccination status look like per population? 
### Project Pipeline

    1.	Build a Database – Here we’ll be using Microsoft SQL Server Management Studio.
    
    2.	Develop the SQL Query for data exploration.

### What we did
    1. Downloaded the Covid-19 complete dataset .csv file from [here]('https://covid.ourworldindata.org/data/owid-covid-data.csv') which consists of 21 columns.
    
    2. Rearranged the population column and then split the whole worksheet into two separate tables <br> (covid_deaths and covid_vaccincation, with 'iso_code', 'continent', 'location' and 'date' columns remaining the same) and <br> saved them as .xlsx files (could have downloaded xlsx format directly from the source).
    
    3. Created a database in SSMS and imported the two tables into it and queried them for analysis purpose.

### Skills used 
**Joins, CTE, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types**

### What do we know now / Lessons Learned

* SSMS is easy and user-friendly. We can import tables directly from Excel files.
* There are only 195 countries in the world. However, in this dataset, 225 locations are shown. Hmmm...
* Income groups and other groups (such as continents, world, EU, etc.) are present in the Country (location) column and there are corresponding NULL values in the continent column. Those were taken care of while querying.


## Thank you!!


