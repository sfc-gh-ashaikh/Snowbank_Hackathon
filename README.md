# Lloyds Snowbank Hackathon

## Snowbank Overview
The Snowbank Financial Services Demonstration is built around a fictitious bank Snowbank which offers retail banking products to its 50M strong customer base in the US & Canada. Its business spans banking products (Chequing accounts, Saving accounts, Registered accounts) and also had a lending business to personal and commercial customers with a range of credit products (Credit Cards, Line of Credits, Mortgages).

#### The Snowbank Data model is the following:
![Snowbank_Data_Model](images/Snowbank_data_model.png)

The base data model is quite solid, and can be expanded to support additional use cases (Customer 360), but also regionalized by changing data in tables according to the scenario you want to customize it for.

**There are currently 2 demonstrations available:**
  1. The [Snowbank Retail Banking Demo](https://github.com/snowflakecorp/frostbytes/tree/main/Industry%20-%20Financial%20Services/Snowbank/Snowbank%20Retail%20Banking) is a demo like Citibike for a banking audience. It has 4 different vignettes which takes the audience through loading data from scratch, demonstrating DevOps & Simple Administration to the audience. The last vignette demonstrates near-real time ingestion within Snowflake implementing snowpipe and streams & tasks.
  2. The [Snowbank Holistic Credit Risk Analysis Demo](https://github.com/snowflakecorp/frostbytes/tree/main/Industry%20-%20Financial%20Services/Snowbank/Snowbank%20Holistic%20Credit%20Risk%20Analysis) demonstrates the power of the Snowflake Data Marketplace to get quick actionable insights about the Covid-19 credit risk by joining live shared data with the bank's own data.

Depending on the customer interest, both these demos can be shown to a prospect, or a combination of both. If demonstrating to a technical audience, the Snowbank Retail Banking may be more suitable. If demonstrating to a business audience, the Snowbank Holistic Credit Risk Analysis may be more suitable as it is a Snowsight dashboard based demo and focuses on actionable insights.
