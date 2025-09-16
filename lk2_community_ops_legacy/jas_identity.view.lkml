# most active contributor jbabra@snapchat.com
view: jas_identity {
  derived_table: {
    sql: SELECT
        userID AS userID,
        lastEngagementTime AS lastEngagementTime,
         deviceType AS deviceType,
         version AS version,
         creationTime AS creationTime,
         ghost_user_id AS ghost_user_id,
         isPhoneVerified AS isPhoneVerified,
         isEmailVerified as isEmailVerified,
         lastCity as lastCity,
         lastCountry as lastCountry,
         sentCount as sentCount,
         receivedCount as receivedCount,
         storyCount as storyCount,
         hasBitmoji as hasBitmoji,
         bestFriendIDs as bestFriendIDs,
         isTestUser as isTestUser,
         hasProfilePicture as hasProfilePicture,
         hasDisplayName as hasDisplayName,
         friendCount as friendCount,
         snapPrivacy as snapPrivacy,
         storyPrivacy as storyPrivacy,
        age as age
                   FROM TABLE_QUERY([sc-analytics:report_user],
                  "table_id IN (SELECT table_id FROM [sc-analytics:report_user.__TABLES__]
                  WHERE REGEXP_MATCH(table_id, r'^identity_[0-9]{8}$')
                  ORDER BY table_id
                  DESC LIMIT 1)")
;;
  }

#Dimensions

  dimension: userid {
    type: string
    primary_key: yes
    sql: ${TABLE}.userID ;;
  }

  dimension: ghost_user_id {
    type: string
    sql: ${TABLE}.ghost_user_id ;;
  }

  dimension_group: account_creation_time {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.creationTime ;;
  }

  dimension_group: last_engagement_time {
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.lastEngagementTime ;;
  }


  dimension: device_type {
    type: string
    label: "ios or android"
    sql: ${TABLE}.deviceType ;;
  }

#   dimension: device_model {
#     type: string
#     sql: ${TABLE}.device_model ;;
#   }

  dimension: snap_version {
    type: string
    sql: ${TABLE}.version ;;
  }

  dimension: last_country {
    type: string
    label: "Last country of user"
    sql: ${TABLE}.lastCountry ;;
  }

  dimension: churn_days {
    label: "Days since last active"
    description: "difference between today's date and last engagement date in UTC"
    type: number
    sql: DATEDIFF( CURRENT_DATE(), ${last_engagement_time_date}) ;;

  }

#New dims

dimension: isPhoneVerified {
  type: yesno
}


dimension:  isEmailVerified {
  type: yesno
}

dimension:  lastCity {
  type: string
}

dimension: lastCountry {
  type: string
  map_layer_name: countries
}

measure: sentCount {
  type: number
}

measure: receivedCount {
  type: number
}

measure: storyCount {
  type: number
}

  dimension: hasBitmoji {
    type: yesno
  }

  dimension: bestFriendIDs {
    type: string
    sql: CASE WHEN  bestFriendIDs is NOT NULL THEN "Has best friends"
    ELSE "no best friends"
    END;;
  }

  dimension: isTestUser {
    type: yesno
  }

  dimension: hasProfilePicture {
    type: yesno
  }

  dimension: hasDisplayName {
    type: yesno
  }


  dimension: friendCount {
    type: number
  }

dimension: friend_range {
  type: tier
  tiers: [0, 10, 20, 50, 100, 300]
  style: integer
  sql: ${TABLE}.friendCount
  ;;
}


  dimension: snapPrivacy {
    type: string
  }

  dimension: storyPrivacy {
    type:  string
  }

  dimension: age {
    type: number
  }


dimension: age_range {
  type: tier
  tiers: [0,10,20,30,40,50,60,70,80]
  style: integer
  sql: ${TABLE}.age ;;

}

# Measures

  measure: count {
    type: count
    label: "Count of unique userIDs"
    # sql: ${userid} ;;
    drill_fields: [churn_days, last_engagement_time_date]

  }







}
