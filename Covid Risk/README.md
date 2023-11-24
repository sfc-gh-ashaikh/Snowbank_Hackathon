# COVID Credit Risk
Snowbank is offering credit products to clients in US & Canada. They are able to get KPIs for their lending activity around their outstanding balance & commit balances.

However, most financial institutions have a more holistic approach for credit risk and want to integrate global factors such as climate risk and the Covid-19 pandemics. As a result we are going to bring into Covid-19 data from the marketplace to demonstrate the ease of adding additional data sources within the Snowbank environment, and join the bank's data with the marketplace data in order to run a risk assessment of the Covid-19 pandemics to the bank's business and put a dollar figure estimate around the risk.

## Bringing in Covid-19 data
We will be using the COVID-19 Epidemiological Data by Starschema from the marketplace. The first thing you will need to do is bring that data in from the marketplace as shown in the image below. For the sake of subsequent scripts running without errors ensure you name the database ```STARSCHEMA_COVID19``` and grant it ```PUBLIC``` access. 

![STARSCHEMA_COVID19](/images/covid.png)

## Create Covid-19 Risk Views
Once you have installed the Covid dataset within your account. Create a new worksheet and run the following [script](/COVID%20Credit%20RIsk/snowbank_covid_credit_risk.sqlsnowbank_covid)

This script will create the following views:
- ```COVID19_INCVACCINE_US_VW```: a Covid-19 vaccination view as of the most recent date across the US
- ```STATE_CREDIT_COVID_RISK_VW```: a combination of Covid-19 casualty, vaccination and credit data.
- ```STATE_CREDIT_RISK_COVID```: a Covid-19 credit risk view broken down by states in the USA. 

We will be using these views as the basis of any further analytics we create in the next part.

## Covid-19 Credit Risk Questions

Using the views created above along with another tables you see fit you will need to create views that answer the following questions:
1. Total number of confirmed cases
2. Total number of deaths
3. Total oustanding balance *hint: use ```CREDIT_ACCOUNTS```*
4. Total oustanding amount loans at risk ($) *hint: this is using the ```OUSTANDING_BALANCE_COVID_RISK``` column where ```est_casualty > 0```
5. % of Oustanding balance at risk
6. Oustanding balance by state and product
7. Confirmed covid cases and deaths per state
8. Vaccination campaign per state (incl ```doses_admin_total```,```doses_shipped_total```,```total_population```)

[Answers:](https://github.com/snowflakecorp/frostbytes/blob/main/Industry%20-%20Financial%20Services/Snowbank/Snowbank%20Holistic%20Credit%20Risk%20Analysis/40%20-%20analytics/2%20-%20Snowbank%20Covid-19%20Credit%20Risk/README.md) Only Snowflake employees have access to this. Rely on your SE if you get stuck anywhere. 

## Creating a Streamlist App


