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

    ##return a dataframe that returns the number of confirmed cases and number of deaths for a given state
    cases_deaths_df = #insert code


    return cases_deaths_df.to_pandas()
    
def get_oustanding_balance_risk(state):

     ##return a dataframe that returns the oustanding balance at covid risk for a given state

    get_balance_df = #insert code

    return get_balance_df.to_pandas()
    
def get_product_balance_risk(state):
    
    ##return a dataframe that returns the oustanding balance at covid risk grouped by product description for a given state

    product_balance_df = #insert code

    return product_balance_df.to_pandas()

if st.button("Generate Report"):
    # Get predictions
    with st.spinner("Getting risk analytics..."):
        cases_deaths = get_cases_death(state)
        risk_balance = get_oustanding_balance_risk(state)
        product_risk_balance = get_product_balance_risk(state) 
        
        col1, col2, col3 = st.columns(3)
        col1.metric("Confirmed Cases", cases_deaths.get("CONFIRMED_CASES"))
        col2.metric("Confirmed Deaths", cases_deaths.get("DEATHS_CASES"))
        col3.metric("Oustanding Balance at Risk", risk_balance.get("SUM_BALANCE_RISK"))

        # create a bar chart with the product_risk_balance dataframe
    

        
        