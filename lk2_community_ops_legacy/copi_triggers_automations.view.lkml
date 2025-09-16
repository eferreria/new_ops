view: copi_triggers_automations {
  sql_table_name: [sc-analytics:report_customer_ops.copi_triggers_automations] ;;


  dimension: added_tags {
    type: string
    primary_key: yes
  }

  dimension: Rule_URL {
    type: string
  }

  dimension: Rule_Name {
    type: string
  }

  dimension: Rule_Status_Action {
    type: string
  }

  dimension: Rule_Notification_Action {
    type: yesno
  }

  dimension: Rule_Assigned_GroupID {
    type: string
  }

  dimension: Rule_Assigned_Group_Name {
    type: string
  }

  dimension: Rule_Resolution_type {
    type: string
  }

  dimension: Rule_Type {
    type: string
  }

  dimension: Rule_Team_Owner {
    type: string
  }

  dimension: Rule_Agent_Owner {
    type: string
  }

  dimension: Rule_Customer_Visibility {
    type: string
  }

#Sheet https://docs.google.com/spreadsheets/d/1SQVcuKoiK4DgmmmY4LJ6pe8J5N6w4MnPZOSGMZWgMZE/edit#gid=118140653

}
