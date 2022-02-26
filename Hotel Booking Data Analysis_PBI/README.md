
# HOTEL BOOKING DATA ANALYSIS & VISUALIZATION WITH PowerBI

The main goal of this project is to develop a database to analyze & visualize the Hotel Booking Data.

### DATA

The dataset is an excel file with 5 worksheets in it (2018-2020 data respectively, meal cost, and market segment). The yearly data accumulates to 141,917 rows.

### REQUIREMENT

Build a visual data story or dashboard using PowerBI to present to the stakeholders (with white and blue theme).

Major questions to be answered here are:


    1.	Is our hotel revenue growing by year?


    2.	Should we increase our parking lot size?
    
    
    3.	What trends can we see in the data?
## Project Pipeline

    1.	Build a Database – Here we’ll be using PostgreSQL’s PGAdmin.
    2.	Develop the SQL Query
    3.	Connect PowerBI to the Database
    4.	Visualize
    5.	Summarize findings.



## Lessons Learned

* PostgreSQL does not have a direct IMPORT option from .xlsx files. Instead, we have to convert the excel sheet to .csv format (which means each worksheet will be a new file), create each table’s exact data structure (schema) in PGAdmin and then only import these .csv files to the database. WOW!!!

* While importing the dataset, automatic typecasting happens in PostgreSQL, which will lead to some error if NULL values are present in integer type columns. Maybe change it to TEXT and later convert it back.



## What do we know now?

Let us try to answer the questions we were asked:

**Q. Is the hotel revenue growing by year?**

Ans. We can see that the 2020 data might possibly be incomplete (which we need to check further). However, 2019 has seen more sales than 2018 where CITY HOTEL overtook RESORT HOTEL in 2019 and still leads.

**Q. Should we increase our parking lot size?**

Ans. From the dashboard, we can see that there are no evidences suggesting for an increase in the parking lot size as it is mostly same for both the hotels throughout the years.

![alt text](https://github.com/AmalGKrishnan/PortfolioProjects/blob/main/Hotel%20Booking%20Data%20Analysis_PBI/Dashboard.png)


**Q. What trends can we see in the data?**

Ans. The trends can be seen by sliding the Bar Slicer (to the desired dates window) and also by selecting specific hotel/ country. 


## Final Output
![alt text](https://github.com/AmalGKrishnan/PortfolioProjects/blob/main/Hotel%20Booking%20Data%20Analysis_PBI/Dashboard_Final.PNG)

![alt text](https://github.com/AmalGKrishnan/PortfolioProjects/blob/main/Hotel%20Booking%20Data%20Analysis_PBI/Dashboard_Final_Mobile_1.PNG)



# Thank You!!
