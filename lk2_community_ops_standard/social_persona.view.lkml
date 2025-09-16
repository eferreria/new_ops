# most active contributor abenharosh@snapchat.com
view: social_persona {
  view_label: "Social Persona (SF Only)"
  derived_table: {

    sql:  SELECT * FROM
           `sc-analytics.prod_metadata_crm_co.social_persona_*`
          WHERE _TABLE_SUFFIX = FORMAT_DATE('%Y%m%d', CURRENT_DATE("America/Los_Angeles"))     ;;
  }

  dimension: are_we_following {
    type: yesno
    sql: CASE WHEN ${TABLE}.are_we_following = "False" THEN FALSE
              WHEN ${TABLE}.are_we_following = "True" THEN TRUE
              ELSE FALSE END;;
              description: "Specifies whether a Salesforce social account is following the social persona or not."
  }

  dimension: author_labels {
    hidden: yes
    description: "Comma-separated list of author type tags."
  }

  dimension:  created_by_id {
    hidden: yes
  }

  dimension_group: created_date {
    type: time
    label: "Created PST"
    sql: TIMESTAMP_ADD(CAST(${TABLE}.created_date AS TIMESTAMP), INTERVAL -7 HOUR);;
    timeframes: [date, time, hour_of_day, week, day_of_week, month]
    convert_tz: no
    hidden: yes
  }

  dimension: followers {
    type: number
    description: "Number of followers that the social persona has."
    sql: CAST(${TABLE}.followers AS FLOAT64) ;;
  }

  dimension: followers_range {
    type: tier
    description: "Range of followers that the social persona has."
    tiers: [0,100,500,1000,10000,50000,100000,500000,1000000]
    style: integer
    sql: ${followers} ;;
  }

  dimension: num_following {
    type: number
    description: "Number of people that the social persona is following."
    label: "Following"
  }

  dimension: id {
    type: string
    primary_key: yes
    hidden: yes
  }

  dimension: influencer_score {
    type: number
    description: "Score describing the influence of the social persona"
  }

  dimension:  is_blocklisted {
    description: "Specifies whether the social persona is blacklisted or not."
    type: yesno
    sql: CASE WHEN ${TABLE}.is_blocklisted = "False" THEN FALSE
              WHEN ${TABLE}.is_blocklisted = "True" THEN TRUE
              ELSE FALSE END;;
  }

  dimension: is_default {
    description: "Specifies whether the social persona supplies the default avatar image that’s displayed on the contact or account"
    type: yesno
    sql: CASE WHEN ${TABLE}.is_default = "False" THEN FALSE
              WHEN ${TABLE}.is_default = "True" THEN TRUE
              ELSE FALSE END;;
  }

  dimension: is_deleted {
    sql: CASE WHEN ${TABLE}.is_deleted = "False" THEN FALSE
    WHEN ${TABLE}.is_deleted = "True" THEN TRUE
    ELSE FALSE END;;
    type: yesno
  }

  dimension: is_following_us {
    description: "Specifies whether the social persona is following a our social account or not."
    type: yesno
    sql: CASE WHEN ${TABLE}.is_following_us = "False" THEN FALSE
              WHEN ${TABLE}.is_following_us = "True" THEN TRUE
              ELSE FALSE END;;
  }

  dimension: is_verified {
    description: "Specifies whether the social persona is verified or not."
    type: yesno
    sql: CASE WHEN ${TABLE}.is_verified = "False" THEN FALSE
              WHEN ${TABLE}.is_verified = "True" THEN TRUE
              ELSE FALSE END;;
  }

  dimension: last_modified_by_id {
    hidden: yes
  }

  dimension_group: last_modified_date {}

  dimension: last_referenced_date {
    description: "Date and time when the social persona was last referenced."
    hidden: yes
  }

  dimension: last_viewed_date {
    description: "Date and time when the social persona was last viewed."
    hidden: yes
  }

  dimension: listed_count {
    hidden: yes
  }

  dimension: media_provider {
    description: "Social network of the social persona. Twitter or DM"
    label: "Tweet Type"
    sql: CASE WHEN ${TABLE}.media_provider = "TWITTER" THEN "Public Tweet"
              WHEN ${TABLE}.media_provider = "Twitter Received DM" THEN "DM"
              ELSE ${TABLE}.media_provider END
              ;;
  }

  dimension: media_type {
    description: "Social network type of the social persona"
    hidden: yes
  }

  dimension: parent_id {}

  dimension: profile_type {
    description: "Type of profile. Values are: Person,  Page"
  }

  dimension: provider {
    hidden: yes
    description: "Social network, such as Facebook or Twitter, of the social persona."
  }

 dimension:  source_app {
   description: "Salesforce product that created the social persona."
  hidden: yes
 }

  measure: count_personas {
    type: count
  }

  measure: count_verified_users {
    type: count
    filters: [is_verified: "yes"]
  }

  # measure: count_dm {
  #   type: count
  #   label: "Count DMs"
  #   filters: [media_provider: "DM"]
  # }

  # measure: count_public_tweets {
  #   type: count
  #   filters: [media_provider: "Public Tweet"]
  # }





}
