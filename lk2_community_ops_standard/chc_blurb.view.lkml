# most active contributor jbabra@snapchat.com
view: chc_blurb {

  sql_table_name: `businesshelpcenteranalytics.123256751.snapcommunitysupportblurbs` ;;

  dimension: blurb_id {}

  dimension: description {}

  dimension: blurb_link {
    link: {
      url: "{{ value }}"
      label: "Link"
    }
  }
  }
