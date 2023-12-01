# Import python packages
import streamlit as st
import snowflake.snowpark.functions as F
from snowflake.snowpark.context import get_active_session

# Write directly to the app
st.title("Covid Credit Risk :truck:")
st.write("Covid Credit Risk broken down by State:")

# Get the current credentials
session = get_active_session()

#state names
city_names_df = session.table("snowbank_hackathon.public.na_states").select("state","country").distinct().sort("state")
city_names_df = city_names_df.filter(F.col("country") == 'US')
queried_data = city_names_df.to_pandas()

# Choose a city
state = st.selectbox("State:",queried_data)

def get_cases_death(state):

    cases_deaths_df = session.table(
        "snowbank.analytics.STATE_CREDIT_COVID_RISK_VW"
    ).filter(F.col("state") == state).select("deaths_cases","confirmed_cases")

    return cases_deaths_df.to_pandas()
    
def get_oustanding_balance_risk(state):

     ##return a dataframe that returns the oustanding balance at covid risk for a given state

     return 
def get_product_balance_risk(state):
 
    ##return a dataframe that returns the oustanding balance at covid risk grouped by product description for a given state
    return

if st.button("Generate Report"):
    # Get predictions
    with st.spinner("Getting risk analytics..."):
        cases_deaths = get_cases_death(state)
        #risk_balance = get_oustanding_balance_risk(state)
        #product_risk_balance = get_product_balance_risk(state)

        # uncomment the above statements once the functions are defined
        
        col1, col2, col3 = st.columns(3)
        col1.metric("Confirmed Cases", cases_deaths.get("CONFIRMED_CASES"))
        col2.metric("Confirmed Deaths", cases_deaths.get("DEATHS_CASES"))
        #col3.metric("Oustanding Balance at Risk", risk_balance.get("<NAME_OF_COLUMN>")

        # create a bar chart with the product_risk_balance dataframe
    

        
        