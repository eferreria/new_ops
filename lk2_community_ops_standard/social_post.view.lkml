# most active contributor abenharosh@snapchat.com
view: social_post {
  view_label: "Social Post"
  derived_table: {

    sql:  SELECT
          id as id,
          cast(is_outbound as string) as is_outbound,
          created_date as created_date,
          parent_id as parent_id,
          Null as inbound_total,
          null as outbound_total,
          "Salesforce" as platform

    FROM
           `sc-analytics.prod_metadata_crm_co.social_post_20240221`  -- 2024-02-21 was the last day of operation in SF Social Studio before Sprinklr migration
          WHERE CAST(created_date AS TIMESTAMP) <= CAST('2024-02-22' AS TIMESTAMP)

          UNION ALL

          SELECT
          CASE_ID_0 as id,
          NULL as is_outbound,
          CAST(TIMESTAMP_MILLIS(CAST(DATE_TYPE_CASE_CREATION_TIME_2 AS INT64)) AS STRING) as created_date,
          CASE_ID_0 as parent_id,
          M_INBOUND_CASE_ASSOCIATED_FAN_MESSAGE_COUNT_0 as inbound_total,
          M_INBOUND_CASE_ASSOCIATED_BRAND_MESSAGE_COUNT_1 as outbound_total,
          "Sprinklr" as platform

          FROM
          `sc-sprinklr.prod_metadata_sprinklr.cases`
           WHERE CAST(TIMESTAMP_MILLIS(CAST(DATE_TYPE_CASE_CREATION_TIME_2 AS INT64)) AS TIMESTAMP) >= CAST('2024-02-22' AS TIMESTAMP)


          ;;
  }

  dimension: id {
    type: string
    primary_key: yes
    hidden: yes
  }

  dimension: content {
    label: "Message body"
    description: "Body of the social post"
    hidden: yes
  }

  dimension: platform {
    label: "Platform"
    description: "Salesforce or Sprinklr"
    hidden: no
  }

  dimension: created_by_id {
    hidden: yes
  }

  dimension: created_date {
    hidden: yes
    sql: CAST(${TABLE}.created_date AS TIMESTAMP) ;;
  }

  dimension_group: created_utc {
    type: time
    label: "Created UTC"
    sql: CAST(${TABLE}.created_date AS TIMESTAMP) ;;
    timeframes: [date, time, hour, hour_of_day, week, day_of_week, month, year, quarter]
    hidden: no
  }

  dimension_group: created_date_pst {
    type: time
    label: "Created PST"
    sql: TIMESTAMP_ADD(CAST(${TABLE}.created_date AS TIMESTAMP), INTERVAL -7 HOUR);;
    timeframes: [date, time, hour, hour_of_day, week, day_of_week, month, year, quarter]
  }

  dimension: engagement_level {
    type: string
    description: "Engagement level of the social post, such as reviewed or resolved"
    hidden: yes
  }

  dimension: is_deleted {
    description: "Specifies whether the post is deleted or not"
    type: yesno
    sql: CASE WHEN ${TABLE}.is_deleted = "False" THEN FALSE
              WHEN ${TABLE}.is_deleted = "True" THEN TRUE
              ELSE FALSE END;;
    hidden: yes
  }

  dimension: is_outbound {
    description: "Specifies whether the post is outbound or not; SF ONLY"
    hidden: yes
    type: string
    sql: CASE WHEN ${TABLE}.is_outbound = "True" THEN "1" ELSE "0" END
              ;;

  }

  dimension: last_modified_by_id {
    hidden: yes
  }

  dimension: last_modified_date {
    hidden: yes
    sql: CAST(${TABLE}.last_modified_date AS TIMESTAMP) ;;
  }

  dimension: media_provider {
    description: "Social network of the social persona. Twitter or DM"
    label: "Tweet Type"
    sql: CASE WHEN ${TABLE}.media_provider = "TWITTER" THEN "Public Tweet"
              WHEN ${TABLE}.media_provider = "Twitter Received DM" THEN "DM"
              ELSE ${TABLE}.media_provider END
              ;;
    hidden: yes
  }


  dimension: media_type {
    description: "Social network type of the social persona"
    hidden: yes
  }

  dimension: message_type {
    type: string
    description: "Type of message. Values are:
    Direct—Twitter direct message
    Reply—Twitter reply
    Retweet—Twitter retweet
    Tweet—Twitter tweet"
    hidden: yes
  }

  dimension: name {
    type: string
    hidden: yes
    description: "Name of the social post"
  }

  dimension: notes {
    type: string
    hidden: yes
    description: "Notes added by Social Hub actions for the social post"
  }

  dimension: language {
    type: string
    description: "Language of the social post"
    hidden: yes
  }

  dimension: parent_id {
    type: string
    description: "ID of the parent record of the social post, for example, the ID of a case"
    hidden: no
  }

  dimension: owner_id {
    type: string
    hidden: yes
    description: "ID of the owner of the social post"
  }

  dimension: persona_id {
    type: string
    description: "ID of the social persona who made the post
    This is a relationship field"
    hidden: yes
  }

  dimension: posted {
    hidden: yes
    sql: TIMESTAMP_SUB(CAST(${TABLE}.posted AS TIMESTAMP), INTERVAL 7 HOUR ) ;;
    description: "Date and time when the social post was made"
    label: "Message PST"
  }

  dimension: post_tags {
    type: string
    description: "List of tags on the social post"
    hidden: yes
  }

  dimension: post_priority {
    type: string
    description: "Priority of the social post set in Social Studio"
    hidden: yes
  }

  dimension: post_url {
    type: string
    hidden: yes
  }

  dimension: recipient_type {
    type: string
    description: "Type of the recipient of the social post, such as a person"
    hidden: yes
  }

  dimension: sentiment {
    type: string
    description: "Sentiment of the social post. Values are:
    Negative
    Neutral
    Positive
    SomewhatNegative
    SomewhatPositive"
    hidden: yes
  }

  dimension: spam_rating {
    type: string
    description: "Spam rating of the social post. Values are:
    NotSpam
    Spam"
    hidden: yes
  }


  dimension: topic_profile_name {
    type: string
    hidden: yes
  }

  dimension: topic_type {
    type: string
    description: "Type of topic. Values are:
    Keyword
    Managed"
    hidden: yes
  }

  dimension: status {
    type: string
    description: "Status of the social post. Values are:
    DELETED
    FAILED
    HIDDEN
    PENDING
    PENDING_APPROVAL
    RECALL_APPROVAL
    REJECTED_APPROVAL
    REPLIED
    SENT
    UNKNOWN"
    hidden: yes
  }

  dimension: status_message {
    type: string
    description: "Status message for the social post"
    hidden: yes
  }

  dimension: unique_commentors {
    description: "Number of unique people who commented on the social post"
    hidden: yes
  }

  dimension: view_count {
    description: "Number of times the social post was viewed"
    hidden: yes
  }


  # MEASURES




  measure: count_DM {
    type: count
    filters: [is_outbound: "0", media_provider: "DM"]
    description: "Count of incoming direct message"
    drill_fields: [drill*]
    hidden: yes
  }

  measure: count_public_tweet{
    type: count
    filters: [is_outbound: "0", media_provider: "Public Tweet"]
    description: "Count of incoming public tweet"
    drill_fields: [drill*]
    hidden: yes
  }

  measure: count_outbound_message {
    type: sum
    sql:
    CASE
    WHEN (${platform}="Salesforce" and ${is_outbound}="1") THEN 1
    WHEN ${platform}="Sprinklr" THEN ${TABLE}.outbound_total
    ELSE null END
    ;;
    description: "Count of outgoing message by agent"
  }

  measure: count_inbound_message {
    type: sum
    sql:
    CASE
    WHEN (${platform}="Salesforce" and ${is_outbound}="0") THEN 1
    WHEN ${platform}="Sprinklr" THEN ${TABLE}.inbound_total
    ELSE null END
    ;;
    description: "Count of all incoming message by external users"

  }

  measure: count {
    type: count
    label: "Count incoming + outgoing"
    hidden: yes
  }

  set: drill {
    fields: [id,
      created_date,
      content,
      media_provider,
      message_type,
      spam_rating]

  }



# https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_objects_socialpost.htm






}
