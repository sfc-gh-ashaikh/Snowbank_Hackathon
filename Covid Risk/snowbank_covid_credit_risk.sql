

------------------------------------
-- Set context
------------------------------------
USE ROLE BANK_ENGINEER_ROLE;
USE SCHEMA SNOWBANK.ANALYTICS;
USE WAREHOUSE SNOWBANK_ANALYTICS_WH;

------------------------------------
-- COVID19 VACCINATION VIEW 
------------------------------------

CREATE OR REPLACE SECURE VIEW COVID19_INCVACCINE_US_VW AS
with daily_cases as (
                      select country_region,
                      ISO3166_2 as state,
                      date,
                      sum( case when case_type = 'Deaths' then cases else 0 end) as Deaths_Cases ,
                      sum( case when case_type = 'Active' then cases else 0 end) as Active_Cases ,
                      sum( case when case_type = 'Confirmed' then cases else 0 end) as Confirmed_Cases ,
                      sum( case when case_type = 'Recovered' then cases else 0 end) as Recovered_Cases
                      from starschema_covid19.public.jhu_covid_19 c
        where country_region='United States'
        and date > dateadd(day,-7, '2023-03-09')
        group by country_region, state, date
)
, demographics as (
    select ISO3166_2 as state, sum(total_population) total_population from starschema_covid19.public.demographics where iso3166_1 = 'US' group by 1
)
select c.*,d.total_population, doses_alloc_total, doses_shipped_total, doses_admin_total, people_total, people_total_2nd_dose,
    (confirmed_cases/total_population) as confirmed_pct,
       (deaths_cases/total_population) as death_pct,
       (DOSES_ADMIN_TOTAL/total_population) as vaccine_pct,
       (PEOPLE_TOTAL_2ND_DOSE/total_population) as fully_vaccine_pct,
             (DOSES_ADMIN_TOTAL/DOSES_SHIPPED_TOTAL) as vaccine_usage_pct,
       case when doses_shipped_total is null then NULL else rank() over ( order by vaccine_usage_pct desc) end as Vaccine_ulitization_rank,
       rank() over ( order by fully_vaccine_pct desc) as total_population_vaccinated_rank
from daily_cases c
inner join demographics d on c.state = d.state
inner join starschema_covid19.public.JHU_VACCINES v
        --on c.date = v.date
       on c.state = v.STABBR
where c.date = (select max(date) from daily_cases)
and v.date = (select max(date) from starschema_covid19.public.JHU_VACCINES);

------------------------------------
--- STATE_CREDIT_COVID_RISK_VW view
------------------------------------

CREATE OR REPLACE SECURE VIEW STATE_CREDIT_COVID_RISK_VW AS
with credit_by_state as (

    select d.state, sum(c.outstanding_balance) as total_outstanding_balance, sum(c.commit_balance) as total_commit_balance
    from snowbank_hackathon.public.credit_accounts c
      inner join snowbank_hackathon.public.depositors d
          on  c.depositor_id=d.depositor_id
     group by d.state

)
   select cov.*,total_outstanding_balance, total_commit_balance,
              rank() over ( order by TOTAL_OUTSTANDING_BALANCE desc) as TOTAL_OUTSTANDING_BALANCE_rank



   from
    credit_by_state s inner join COVID19_incVaccine_US_VW cov
    on s.state = cov.state
    ;
------------------------------------
-- credit secure view loan_at_risk
------------------------------------

create or replace secure view state_credit_risk_covid as
WITH X as
(
select d.state,st.state_name, pc.category, pc.description, count(*) as depositor_count,round(sum(outstanding_balance)) as sum_outstanding_balance, sum(commit_balance) as sum_commit_balance,
round(avg(outstanding_balance)) as avg_outstanding_balance, round(avg(commit_balance)) as avg_commit_balance
from snowbank_hackathon.public.credit_accounts ca, snowbank_hackathon.public.product_code pc, snowbank_hackathon.public.depositors d, snowbank_hackathon.public.na_states st
where ca.product_code=pc.product_code
and d.state=st.state
and d.depositor_id=ca.depositor_id
group by d.state,st.state_name, pc.category, pc.description
)
select X.*, cov.deaths_cases, cov.total_population, ((cov.deaths_cases/cov.total_population)*depositor_count) as est_casualty, round(avg_outstanding_balance*est_casualty) as outstanding_balance_covid_risk
from X, STATE_CREDIT_COVID_RISK_VW cov
where X.state=cov.state;


------------------------------------
-- Query one view
------------------------------------
select * from state_credit_risk_covid;