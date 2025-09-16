view: le_contacts_info {
  view_label: "LE Contact Info"
  derived_table: {
    sql: SELECT * FROM [sc-analytics:report_zendesk.le_contacts_info] WHERE profile_tags LIKE '%le-check%' OR profile_tags LIKE '%le-phone%' OR profile_tags LIKE '%le-req%';;
  }
  dimension: requester_id {
    type: number
    primary_key: yes
    link: {
      label: "Zendesk User Profile"
      url: "https://snapchat.zendesk.com/agent/users/{{value}}"
      icon_url: "https://cdn4.iconfinder.com/data/icons/logos-brands-5/24/zendesk-1024.png"
    }
  }

  dimension: email {
    type: string
  }

  dimension: details {
    label: "Agency Name"
    type: string
  }

  dimension: notes {
    label: "Agency Address"
    type: string
  }

  dimension: profile_tags {
    label: "Tags"
    sql: CASE
          WHEN ${has_leo_less_safelist_tag} IS true THEN CONCAT(${TABLE}.profile_tags,",",'leo-less-safelist')
          ELSE ${TABLE}.profile_tags
        END ;;
  }

  dimension: has_leo_less_safelist_tag {
    label: "LESS Safelisted?"
    type: yesno
  }

  dimension: domain {
    label: "Email Domain"
    type: string
    sql: REGEXP_EXTRACT(${email},"([^@]+)$") ;;
  }

  #dimension_group: first_submitted_ticket {
  #  type: time
  #  sql: MIN(${zendesk_ticket.created_utc_date}) ;;
  #}

}
