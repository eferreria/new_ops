view: communityops_forecast_20211_2022 {
label: "CO Forecast 21-22"
  sql_table_name: [sc-analytics:report_customer_ops.communityops_forecast_20211_2022] ;;

  dimension: month_s {
    sql: ${TABLE}.month ;;
    type: string
    label: "Month first date"
  }

  dimension_group: date {
    type: time
    sql: TIMESTAMP(${month_s}) ;;
    description: "Month first date available as a date dimension"
    timeframes: [date, month, month_name, month_num, quarter, quarter_of_year,week, week_of_year, year]
  }

  dimension: Team {
    type: string
    description: "Team - Social, GS or PU"
  }

  dimension: type {
    type: string
    description: "ACTUALS, FORECAST, PLAN"
  }

  dimension: DAUs_millions {
    type: number
    description: "DAUs actuals and forecasted"
  }

  dimension: Tickets_percent_of_DAU {
    type: number
    sql: ${TABLE}.Tickets_percent_of_DAU  ;;
    value_format_name: percent_4
  }

  dimension: Total_tickets {
    type: number
    description: "Total of all tickets in all workflows"
  }

  dimension: Contingency_percent {
    type: number
    sql: CAST(REPLACE(${TABLE}.Contingency_percent,'%','') AS FLOAT)/100 ;;
    value_format_name: percent_1
  }

  dimension: Total_tickets_add_contingency_percent {
    type: number
  }

  dimension: Percent_of_Addressable_Tickets {
    type: number
    sql: ${TABLE}.Percent_of_Addressable_Tickets ;;
    value_format_name: percent_2
  }

  dimension: Tickets {
    type: number
  }

  dimension: percent_Automation {
    type: number
    sql: ${TABLE}.percent_Automation  ;;
    value_format_name: percent_2
  }

  dimension: Remaining_Addressable_Tickets_ {
    type: number
  }

  dimension: P90_percent_Addressable_Tickets {
    type: number
    sql: CAST (REPLACE(${TABLE}.P90_percent_Addressable_Tickets,'%','') AS FLOAT)/100 ;;
    value_format_name: percent_2
  }

  dimension: p90_sla_addressable {
    type: number
    sql: CAST (REPLACE(${TABLE}.p90_sla_addressable,',','') AS INTEGER) ;;
  }

  dimension: aht {
    type: number
    label: "Average Handle Time mins"
  }

  dimension: Full_Resolution_time_monthly_minutes {
    type: number
    sql: CAST (REPLACE(${TABLE}.Full_Resolution_time_monthly_minutes,',','') AS INTEGER) ;;
    description: "General & PU support only"
  }

  dimension: Full_Resolution_time_monthly_hours {
    type: number
    sql: CAST (REPLACE(${TABLE}.Full_Resolution_time_monthly_hours,',','') AS INTEGER) ;;
    description: "General & PU support only"
  }

  dimension: First_Touch_Response_Time_Monthly_Minutes {
    type: number
    sql: CAST (REPLACE(${TABLE}.First_Touch_Response_Time_Monthly_Minutes,',','') AS INTEGER) ;;
    label: "Social First Touch Response Time Monthly min"
    description: "Social support only"
  }

  dimension: First_Touch_Response_Time_Monthly_hours {
    type: number
    sql: CAST (REPLACE(${TABLE}.First_Touch_Response_Time_Monthly_hours,',','') AS INTEGER) ;;
    label: "Social First Touch Response Time Monthly hrs"
    description: "Social support only"
  }

  dimension: CW_Productivity_Per_Shift_Daily_hrs {
    type: number
    sql: CAST (REPLACE(${TABLE}.CW_Productivity_Per_Shift_Daily_hrs,'%','') AS FLOAT) ;;
  }

  dimension: CW_Working_Days_Per_week {
    type: number
    sql: CAST (REPLACE(${TABLE}.CW_Working_Days_Per_week,'%','') AS FLOAT) ;;
  }

  dimension: Days_per_Month {
    type: number
  }

  dimension: Required_Agents_Monthly {
    type: number
    sql: CAST (REPLACE(${TABLE}.Required_Agents_Monthly,'%','') AS FLOAT) ;;
  }

  dimension: Actual_Agents_Monthly {
    type: number
  }

  dimension: CW_Variance {
    type: number
    sql: CAST (REPLACE(${TABLE}.CW_Variance,'%','') AS FLOAT) ;;
  }

  dimension: Overhead_Ratio {
    type: number
    sql: CAST (REPLACE(${TABLE}.Overhead_Ratio,'%','') AS FLOAT) ;;
  }

  dimension: Overhead_qa_add_tl {
    type: number
    sql: CAST (REPLACE(${TABLE}.Overhead_qa_add_tl,'%','') AS FLOAT) ;;
  }

  dimension: Total_Forecaste__Agents {
    type: number
    sql: CAST (REPLACE(${TABLE}.Total_Forecaste__Agents,'%','') AS FLOAT) ;;
    label: "Total Forecasted Agents"
  }

  dimension: QA_plus_tl {
    type: number
    sql: CAST (REPLACE(${TABLE}.QA_plus_tl,'%','') AS FLOAT) ;;
  }

  dimension: Managers {
    type: number
    sql: CAST (REPLACE(${TABLE}.Managers,'%','') AS FLOAT) ;;
  }

  dimension: Total_Forecasted_CWs_to_Meet_SLA_Forecast {
    type: number
    sql: CAST (REPLACE(${TABLE}.Total_Forecasted_CWs_to_Meet_SLA_Forecast,'%','') AS FLOAT) ;;
  }

  dimension: Actual {
    type: number
  }

  dimension: Variance {
    type: number
    sql: CAST (REPLACE(${TABLE}.Variance,'%','') AS FLOAT) ;;
  }

  dimension: Average_Agent_Cost {
    type: number
    value_format_name: usd
  }

  dimension: Average_Overhead_Cost {
    type: number
    value_format_name: usd
  }

  dimension: Total_Agent_Cost {
    type: number
    value_format_name: usd
  }

  dimension: Total_Overhead_Cost {
    type: number
    value_format_name: usd
  }

  dimension: Total_Manager_Cost {
    type: number
    value_format_name: usd
  }

  dimension: Total_Cost {
    type: number
    value_format_name: usd
  }

  dimension: CPT {
    type: number
    value_format_name: usd
  }

  dimension: CP_1k_DAU {
    type: number
    value_format_name: usd
  }

  #MEASURES

  measure: tickets {
    type: sum
    sql: ${Tickets} ;;
  }

  measure: p_Automation {
    type: sum
    sql: ${percent_Automation}  ;;
    value_format_name: percent_2
    label: "Percent Automation"
  }

  measure: dau_millions {
    type: sum
    description: "DAUs actuals and forecasted"
    sql: ${DAUs_millions} ;;
  }

  measure: Full_Resolution_time_monthly_hrs {
    type: sum
    sql: ${Full_Resolution_time_monthly_hours} ;;
    description: "General & PU support only"
  }

  measure: First_Touch_Response_Time_Monthly_hrs {
    type: sum
    sql: ${First_Touch_Response_Time_Monthly_hours} ;;
    label: "Social First Touch Response Time Monthly hrs"
    description: "Social support only"
  }

  measure: Tickets_as_percent_of_DAU {
    type: sum
    sql:  ${Tickets_percent_of_DAU}  ;;
    value_format_name: percent_4
  }

  measure: aht_min {
    type: sum
    sql:  ${aht}  ;;
    label: "Average Handle Time mins"
  }


# Sheet https://docs.google.com/spreadsheets/d/1VGuiilm2lBgHJsIlBzoNY15S9Z0E6csR-0RlTh1rV0E/edit#gid=899598599

  }
