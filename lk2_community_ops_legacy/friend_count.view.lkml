# most active contributor jbabra@snapchat.com
view: friend_count {

  derived_table: {
    sql: SELECT
          (friendCount + pendingCount + followingCount + lockedCount +blockedCount) as outGoingFriendCount,
          friendCount,
          pendingCount,
          followingCount,
          lockedCount,
          blockedCount,
          userid

          FROM [feelinsonice-hrd:user_identity.friend_data_20200705] ;;
  }

  filter: userid_filter {
    sql: ${TABLE}.userid ;;
    type: string
  }

  dimension: friendCount {
    type: string
  }

  dimension: pendingCount {
    type: string
  }

  dimension: followingCount {
    type: string
  }

  dimension: lockedCount {
    type: string
  }

  dimension: blockedCount {
    type: string
  }

  dimension: outGoingFriendCount {
    type: string
  }

  dimension: userid {
    type: string
  }



}
