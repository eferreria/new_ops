- dashboard: community_support_score_card
  title: Community Support Score Card
  layout: newspaper
  preferred_viewer: dashboards-next
  elements:
  - title: P90 First Resolution Time hrs (SLA)
    name: P90 First Resolution Time hrs (SLA)
    model: lk2_community_ops_legacy
    explore: zendesk_ticket
    type: looker_grid
    fields: [zendesk_ticket_agent_turnaround_time.turnaround_time_calendar_min_p90,
      zendesk_ticket.created_week]
    fill_fields: [zendesk_ticket.created_week]
    filters:
      zendesk_ticket.excluding_snapstreaks: 'Yes'
      zendesk_ticket.created_week: 104 weeks ago for 104 weeks
      zendesk_ticket.is_tickets_automated: 'No'
      zendesk_ticket.is_general_support: 'Yes'
    sorts: [zendesk_ticket.created_week desc]
    limit: 5000
    column_limit: 5000
    row_total: right
    dynamic_fields: [{table_calculation: p90_first_resolution_time_hrs, label: P90
          First Resolution Time (Hrs), expression: "${zendesk_ticket_agent_turnaround_time.turnaround_time_calendar_min_p90}/60",
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: prior_wk, label: Prior Wk, expression: 'offset(${p90_first_resolution_time_hrs},1)',
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: py, label: PY, expression: 'offset(${p90_first_resolution_time_hrs},52)',
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: wow, label: WoW %, expression: "(${p90_first_resolution_time_hrs}-${prior_wk})/${prior_wk}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: yoy, label: YoY %, expression: "(${p90_first_resolution_time_hrs}-${py})/${py}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: gray
    limit_displayed_rows: true
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '15'
    rows_font_size: '20'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a
      palette_id: 93f8aeb4-3f4a-4cd7-8fee-88c3417516a1
      options:
        steps: 5
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      zendesk_ticket.count_tickets: Current Wk
      first_resolution_time_hrs: Current Wk
      p90_first_resolution_time_hrs: P90 last week (hrs)
      prior_wk: WoW
      py: YoY
    series_text_format:
      yoy:
        align: left
      wow:
        align: left
      p90_first_resolution_time_hrs:
        align: left
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '1'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#FCCF41",
        font_color: !!null '', color_application: {collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a,
          palette_id: 39798c77-0126-4f2f-a920-8d7ce381fa5a, options: {steps: 5, reverse: true,
            stepped: true, mirror: false, constraints: {min: {type: number, value: -1},
              max: {type: number, value: 1}, mid: {type: number, value: 0}}}}, bold: false,
        italic: false, strikethrough: false, fields: [wow, yoy]}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    y_axes: [{label: P90 First Resolution Time (hrs), orientation: left, series: [
          {axisId: p90_first_resolution_time_hrs, id: p90_first_resolution_time_hrs,
            name: Current Wk}, {axisId: prior_wk, id: prior_wk, name: Prior Wk}, {
            axisId: py, id: py, name: PY}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 38, type: linear}]
    x_axis_label: ''
    hidden_series: [3 - Business Support L2 (FTE) - zendesk_ticket.count_tickets,
      2 - Business Support VL2 (Accenture) - zendesk_ticket.count_tickets]
    series_types: {}
    series_colors:
      Row Total - zendesk_ticket.count_tickets: "#ffffff"
      1- Business Support L1 (Accenture) - zendesk_ticket.count_tickets: "#1ea8df"
      3 - Business Support L2 (FTE) - zendesk_ticket.count_tickets: "#e31a1c"
      2 - Business Support VL2 (Accenture) - zendesk_ticket.count_tickets: "#635189"
      4 - Ad Product Quality - zendesk_ticket.count_tickets: "#33a02c"
      5- Pixel Support (Accenture) - zendesk_ticket.count_tickets: "#ff7f00"
      yoy_change_2019: "#e31a1c"
      2018 - zendesk_ticket.count_tickets: "#1ea8df"
      2020 - zendesk_ticket.count_tickets: "#A2BF39"
      yoy_change_2020: "#33a02c"
      sales_volume: "#33a02c"
      total_contacts: "#d0d0d0"
      twitter_outbound_volume: "#33a02c"
      general_support_volume: "#e31a1c"
      feedback_volume: "#1f78b4"
      public_user_volume: "#ff7f00"
      tokens_volume: "#6a3d9a"
      zendesk_ticket.count_tickets: "#000000"
      prior_wk: "#e31a1c"
      py: "#6a3d9a"
      first_resolution_time_hrs: "#000000"
      goal: "#33a02c"
      p90_first_resolution_time_hrs: "#000000"
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: left, color: "#33a02c",
        line_value: '24', label: Goal (24 hr)}]
    trend_lines: []
    discontinuous_nulls: true
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [calculation_7, zendesk_ticket_agent_turnaround_time.turnaround_time_calendar_min_p90,
      prior_wk, py]
    defaults_version: 1
    listen: {}
    row: 2
    col: 7
    width: 17
    height: 3
  - title: Agent Addressable Volume
    name: Agent Addressable Volume
    model: lk2_community_ops_legacy
    explore: zendesk_ticket
    type: looker_grid
    fields: [zendesk_ticket.created_week, zendesk_ticket.count_tickets]
    fill_fields: [zendesk_ticket.created_week]
    filters:
      zendesk_ticket.excluding_snapstreaks: 'Yes'
      zendesk_ticket.created_week: 104 weeks ago for 104 weeks
      zendesk_ticket.is_tickets_automated: 'No'
      zendesk_ticket.adbl_general_support_volume: 'Yes'
    sorts: [zendesk_ticket.created_week desc]
    limit: 5000
    column_limit: 5000
    row_total: right
    dynamic_fields: [{table_calculation: prior_wk, label: Prior Wk, expression: 'offset(${zendesk_ticket.count_tickets},1)',
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: py, label: PY, expression: 'offset(${zendesk_ticket.count_tickets},52)',
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: wow, label: WoW %, expression: "(${zendesk_ticket.count_tickets}-${prior_wk})/${prior_wk}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: yoy, label: YoY %, expression: "(${zendesk_ticket.count_tickets}-${py})/${py}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: gray
    limit_displayed_rows: true
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '15'
    rows_font_size: '20'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a
      palette_id: 93f8aeb4-3f4a-4cd7-8fee-88c3417516a1
      options:
        steps: 5
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      zendesk_ticket.count_tickets: Tickets last week
      first_resolution_time_hrs: Current Wk
      p90_first_resolution_time_hrs: P90 last week (hrs)
      prior_wk: WoW
      py: YoY
    series_cell_visualizations:
      zendesk_ticket.count_tickets:
        is_active: false
      wow:
        is_active: false
    series_text_format:
      zendesk_ticket.count_tickets:
        align: left
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '1'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#FCCF41",
        font_color: !!null '', color_application: {collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a,
          palette_id: 39798c77-0126-4f2f-a920-8d7ce381fa5a, options: {steps: 5, reverse: true,
            stepped: true, mirror: false, constraints: {min: {type: number, value: -1},
              max: {type: number, value: 1}, mid: {type: number, value: 0}}}}, bold: false,
        italic: false, strikethrough: false, fields: [wow, yoy]}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    y_axes: [{label: P90 First Resolution Time (hrs), orientation: left, series: [
          {axisId: p90_first_resolution_time_hrs, id: p90_first_resolution_time_hrs,
            name: Current Wk}, {axisId: prior_wk, id: prior_wk, name: Prior Wk}, {
            axisId: py, id: py, name: PY}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 38, type: linear}]
    x_axis_label: ''
    hidden_series: [3 - Business Support L2 (FTE) - zendesk_ticket.count_tickets,
      2 - Business Support VL2 (Accenture) - zendesk_ticket.count_tickets]
    series_types: {}
    series_colors:
      Row Total - zendesk_ticket.count_tickets: "#ffffff"
      1- Business Support L1 (Accenture) - zendesk_ticket.count_tickets: "#1ea8df"
      3 - Business Support L2 (FTE) - zendesk_ticket.count_tickets: "#e31a1c"
      2 - Business Support VL2 (Accenture) - zendesk_ticket.count_tickets: "#635189"
      4 - Ad Product Quality - zendesk_ticket.count_tickets: "#33a02c"
      5- Pixel Support (Accenture) - zendesk_ticket.count_tickets: "#ff7f00"
      yoy_change_2019: "#e31a1c"
      2018 - zendesk_ticket.count_tickets: "#1ea8df"
      2020 - zendesk_ticket.count_tickets: "#A2BF39"
      yoy_change_2020: "#33a02c"
      sales_volume: "#33a02c"
      total_contacts: "#d0d0d0"
      twitter_outbound_volume: "#33a02c"
      general_support_volume: "#e31a1c"
      feedback_volume: "#1f78b4"
      public_user_volume: "#ff7f00"
      tokens_volume: "#6a3d9a"
      zendesk_ticket.count_tickets: "#000000"
      prior_wk: "#e31a1c"
      py: "#6a3d9a"
      first_resolution_time_hrs: "#000000"
      goal: "#33a02c"
      p90_first_resolution_time_hrs: "#000000"
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: left, color: "#33a02c",
        line_value: '24', label: Goal (24 hr)}]
    trend_lines: []
    discontinuous_nulls: true
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [calculation_7, prior_wk, py]
    defaults_version: 1
    listen: {}
    row: 5
    col: 7
    width: 17
    height: 3
  - name: General Support
    type: text
    title_text: General Support
    subtitle_text: ''
    body_text: ''
    row: 0
    col: 0
    width: 24
    height: 2
  - name: Agent Addressable Volume (2)
    type: text
    title_text: Agent Addressable Volume
    subtitle_text: ''
    body_text: ''
    row: 5
    col: 0
    width: 7
    height: 3
  - name: P90 First Resolution Time hrs (SLA) (2)
    type: text
    title_text: P90 First Resolution Time hrs (SLA)
    subtitle_text: ''
    body_text: ''
    row: 2
    col: 0
    width: 7
    height: 3
  - name: "% Within SLA"
    type: text
    title_text: "% Within SLA"
    subtitle_text: First Resolution time <24 hrs
    body_text: ''
    row: 8
    col: 0
    width: 7
    height: 3
  - title: "% Within SLA"
    name: "% Within SLA (2)"
    model: lk2_community_ops_legacy
    explore: zendesk_ticket
    type: looker_grid
    fields: [zendesk_ticket.created_week, zendesk_ticket_metric_sets.percent_tickets_first_resolution_time_within_24hr]
    fill_fields: [zendesk_ticket.created_week]
    filters:
      zendesk_ticket.excluding_snapstreaks: 'Yes'
      zendesk_ticket.created_week: 104 weeks ago for 104 weeks
      zendesk_ticket.is_tickets_automated: 'No'
      zendesk_ticket.adbl_general_support_volume: 'Yes'
    sorts: [zendesk_ticket.created_week desc]
    limit: 5000
    column_limit: 5000
    row_total: right
    dynamic_fields: [{table_calculation: prior_wk, label: Prior Wk, expression: 'offset(${zendesk_ticket_metric_sets.percent_tickets_first_resolution_time_within_24hr},1)',
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: py, label: PY, expression: 'offset(${zendesk_ticket_metric_sets.percent_tickets_first_resolution_time_within_24hr},52)',
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: wow, label: WoW %, expression: "(${zendesk_ticket_metric_sets.percent_tickets_first_resolution_time_within_24hr}-${prior_wk})/${prior_wk}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: yoy, label: YoY %, expression: "(${zendesk_ticket_metric_sets.percent_tickets_first_resolution_time_within_24hr}-${py})/${py}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: gray
    limit_displayed_rows: true
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '15'
    rows_font_size: '20'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a
      palette_id: 93f8aeb4-3f4a-4cd7-8fee-88c3417516a1
      options:
        steps: 5
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      zendesk_ticket.count_tickets: Tickets last week
      first_resolution_time_hrs: Current Wk
      p90_first_resolution_time_hrs: P90 last week (hrs)
      prior_wk: WoW
      py: YoY
      zendesk_ticket_metric_sets.percent_tickets_first_resolution_time_within_24hr: "%\
        \ within SLA"
    series_cell_visualizations:
      zendesk_ticket.count_tickets:
        is_active: false
      wow:
        is_active: false
    series_text_format:
      zendesk_ticket_metric_sets.percent_tickets_first_resolution_time_within_24hr:
        align: left
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '1'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#FCCF41",
        font_color: !!null '', color_application: {collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a,
          palette_id: 39798c77-0126-4f2f-a920-8d7ce381fa5a, options: {steps: 5, reverse: true,
            stepped: true, mirror: false, constraints: {min: {type: number, value: -1},
              max: {type: number, value: 1}, mid: {type: number, value: 0}}}}, bold: false,
        italic: false, strikethrough: false, fields: [wow, yoy]}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    y_axes: [{label: P90 First Resolution Time (hrs), orientation: left, series: [
          {axisId: p90_first_resolution_time_hrs, id: p90_first_resolution_time_hrs,
            name: Current Wk}, {axisId: prior_wk, id: prior_wk, name: Prior Wk}, {
            axisId: py, id: py, name: PY}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 38, type: linear}]
    x_axis_label: ''
    hidden_series: [3 - Business Support L2 (FTE) - zendesk_ticket.count_tickets,
      2 - Business Support VL2 (Accenture) - zendesk_ticket.count_tickets]
    series_types: {}
    series_colors:
      Row Total - zendesk_ticket.count_tickets: "#ffffff"
      1- Business Support L1 (Accenture) - zendesk_ticket.count_tickets: "#1ea8df"
      3 - Business Support L2 (FTE) - zendesk_ticket.count_tickets: "#e31a1c"
      2 - Business Support VL2 (Accenture) - zendesk_ticket.count_tickets: "#635189"
      4 - Ad Product Quality - zendesk_ticket.count_tickets: "#33a02c"
      5- Pixel Support (Accenture) - zendesk_ticket.count_tickets: "#ff7f00"
      yoy_change_2019: "#e31a1c"
      2018 - zendesk_ticket.count_tickets: "#1ea8df"
      2020 - zendesk_ticket.count_tickets: "#A2BF39"
      yoy_change_2020: "#33a02c"
      sales_volume: "#33a02c"
      total_contacts: "#d0d0d0"
      twitter_outbound_volume: "#33a02c"
      general_support_volume: "#e31a1c"
      feedback_volume: "#1f78b4"
      public_user_volume: "#ff7f00"
      tokens_volume: "#6a3d9a"
      zendesk_ticket.count_tickets: "#000000"
      prior_wk: "#e31a1c"
      py: "#6a3d9a"
      first_resolution_time_hrs: "#000000"
      goal: "#33a02c"
      p90_first_resolution_time_hrs: "#000000"
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: left, color: "#33a02c",
        line_value: '24', label: Goal (24 hr)}]
    trend_lines: []
    discontinuous_nulls: true
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [calculation_7, prior_wk, py]
    defaults_version: 1
    listen: {}
    row: 8
    col: 7
    width: 17
    height: 3
  - name: P50 First Response Time hrs (SLA)
    type: text
    title_text: P50 First Response Time hrs (SLA)
    subtitle_text: ''
    body_text: ''
    row: 11
    col: 0
    width: 7
    height: 3
  - title: P50 First Response Time hrs (SLA)
    name: P50 First Response Time hrs (SLA) (2)
    model: lk2_community_ops_legacy
    explore: zendesk_ticket
    type: looker_grid
    fields: [zendesk_ticket.created_week, zendesk_ticket_metric_sets.reply_time_in_minutes_calendar_median]
    fill_fields: [zendesk_ticket.created_week]
    filters:
      zendesk_ticket.excluding_snapstreaks: 'Yes'
      zendesk_ticket.created_week: 104 weeks ago for 104 weeks
      zendesk_ticket.is_tickets_automated: 'No'
      zendesk_ticket.adbl_general_support_volume: 'Yes'
    sorts: [zendesk_ticket.created_week desc]
    limit: 5000
    column_limit: 5000
    row_total: right
    dynamic_fields: [{table_calculation: first_reply_time_p50_hrs, label: First reply
          time P50 hrs, expression: "${zendesk_ticket_metric_sets.reply_time_in_minutes_calendar_median}/60",
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: prior_wk, label: Prior Wk, expression: 'offset(${first_reply_time_p50_hrs},1)',
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: py, label: PY, expression: 'offset(${first_reply_time_p50_hrs},52)',
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: wow, label: WoW %, expression: "(${first_reply_time_p50_hrs}-${prior_wk})/${prior_wk}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: yoy, label: YoY %, expression: "(${first_reply_time_p50_hrs}-${py})/${py}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: gray
    limit_displayed_rows: true
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '15'
    rows_font_size: '20'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a
      palette_id: 93f8aeb4-3f4a-4cd7-8fee-88c3417516a1
      options:
        steps: 5
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      zendesk_ticket.count_tickets: Tickets last week
      first_resolution_time_hrs: Current Wk
      p90_first_resolution_time_hrs: P90 last week (hrs)
      prior_wk: WoW
      py: YoY
      zendesk_ticket_metric_sets.percent_tickets_first_resolution_time_within_24hr: "%\
        \ within SLA"
      first_reply_time_p50_hrs: P50 First Response time
    series_cell_visualizations:
      zendesk_ticket.count_tickets:
        is_active: false
      wow:
        is_active: false
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '1'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#FCCF41",
        font_color: !!null '', color_application: {collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a,
          palette_id: 39798c77-0126-4f2f-a920-8d7ce381fa5a, options: {steps: 5, reverse: true,
            stepped: true, mirror: false, constraints: {min: {type: number, value: -1},
              max: {type: number, value: 1}, mid: {type: number, value: 0}}}}, bold: false,
        italic: false, strikethrough: false, fields: [wow, yoy]}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    y_axes: [{label: P90 First Resolution Time (hrs), orientation: left, series: [
          {axisId: p90_first_resolution_time_hrs, id: p90_first_resolution_time_hrs,
            name: Current Wk}, {axisId: prior_wk, id: prior_wk, name: Prior Wk}, {
            axisId: py, id: py, name: PY}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 38, type: linear}]
    x_axis_label: ''
    hidden_series: [3 - Business Support L2 (FTE) - zendesk_ticket.count_tickets,
      2 - Business Support VL2 (Accenture) - zendesk_ticket.count_tickets]
    series_types: {}
    series_colors:
      Row Total - zendesk_ticket.count_tickets: "#ffffff"
      1- Business Support L1 (Accenture) - zendesk_ticket.count_tickets: "#1ea8df"
      3 - Business Support L2 (FTE) - zendesk_ticket.count_tickets: "#e31a1c"
      2 - Business Support VL2 (Accenture) - zendesk_ticket.count_tickets: "#635189"
      4 - Ad Product Quality - zendesk_ticket.count_tickets: "#33a02c"
      5- Pixel Support (Accenture) - zendesk_ticket.count_tickets: "#ff7f00"
      yoy_change_2019: "#e31a1c"
      2018 - zendesk_ticket.count_tickets: "#1ea8df"
      2020 - zendesk_ticket.count_tickets: "#A2BF39"
      yoy_change_2020: "#33a02c"
      sales_volume: "#33a02c"
      total_contacts: "#d0d0d0"
      twitter_outbound_volume: "#33a02c"
      general_support_volume: "#e31a1c"
      feedback_volume: "#1f78b4"
      public_user_volume: "#ff7f00"
      tokens_volume: "#6a3d9a"
      zendesk_ticket.count_tickets: "#000000"
      prior_wk: "#e31a1c"
      py: "#6a3d9a"
      first_resolution_time_hrs: "#000000"
      goal: "#33a02c"
      p90_first_resolution_time_hrs: "#000000"
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: left, color: "#33a02c",
        line_value: '24', label: Goal (24 hr)}]
    trend_lines: []
    discontinuous_nulls: true
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [calculation_7, prior_wk, py, zendesk_ticket_metric_sets.reply_time_in_minutes_calendar_median]
    defaults_version: 1
    listen: {}
    row: 11
    col: 7
    width: 17
    height: 3
  - name: P90 Full Resolution Time hrs
    type: text
    title_text: P90 Full Resolution Time hrs
    subtitle_text: ''
    body_text: ''
    row: 14
    col: 0
    width: 7
    height: 3
  - title: P90 Full Resolution Time hrs
    name: P90 Full Resolution Time hrs (2)
    model: lk2_community_ops_legacy
    explore: zendesk_ticket
    type: looker_grid
    fields: [zendesk_ticket.created_week, zendesk_ticket_metric_sets.full_resolution_time_in_minutes_calendar_p90]
    fill_fields: [zendesk_ticket.created_week]
    filters:
      zendesk_ticket.excluding_snapstreaks: 'Yes'
      zendesk_ticket.created_week: 104 weeks ago for 104 weeks
      zendesk_ticket.is_tickets_automated: 'No'
      zendesk_ticket.adbl_general_support_volume: 'Yes'
    sorts: [zendesk_ticket.created_week desc]
    limit: 5000
    column_limit: 5000
    row_total: right
    dynamic_fields: [{table_calculation: p90_full_resolution_time_hrs, label: P90
          Full Resolution Time hrs, expression: "${zendesk_ticket_metric_sets.full_resolution_time_in_minutes_calendar_p90}/60",
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: prior_wk, label: Prior Wk, expression: 'offset(${p90_full_resolution_time_hrs},1)',
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: py, label: PY, expression: 'offset(${p90_full_resolution_time_hrs},52)',
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: wow, label: WoW %, expression: "(${p90_full_resolution_time_hrs}-${prior_wk})/${prior_wk}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: yoy, label: YoY %, expression: "(${p90_full_resolution_time_hrs}-${py})/${py}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: gray
    limit_displayed_rows: true
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '15'
    rows_font_size: '20'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a
      palette_id: 93f8aeb4-3f4a-4cd7-8fee-88c3417516a1
      options:
        steps: 5
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      zendesk_ticket.count_tickets: Tickets last week
      first_resolution_time_hrs: Current Wk
      p90_first_resolution_time_hrs: P90 last week (hrs)
      prior_wk: WoW
      py: YoY
      zendesk_ticket_metric_sets.percent_tickets_first_resolution_time_within_24hr: "%\
        \ within SLA"
      first_reply_time_p50_hrs: P50 First Response time
    series_cell_visualizations:
      zendesk_ticket.count_tickets:
        is_active: false
      wow:
        is_active: false
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '1'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#FCCF41",
        font_color: !!null '', color_application: {collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a,
          palette_id: 39798c77-0126-4f2f-a920-8d7ce381fa5a, options: {steps: 5, reverse: true,
            stepped: true, mirror: false, constraints: {min: {type: number, value: -1},
              max: {type: number, value: 1}, mid: {type: number, value: 0}}}}, bold: false,
        italic: false, strikethrough: false, fields: [wow, yoy]}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    y_axes: [{label: P90 First Resolution Time (hrs), orientation: left, series: [
          {axisId: p90_first_resolution_time_hrs, id: p90_first_resolution_time_hrs,
            name: Current Wk}, {axisId: prior_wk, id: prior_wk, name: Prior Wk}, {
            axisId: py, id: py, name: PY}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 38, type: linear}]
    x_axis_label: ''
    hidden_series: [3 - Business Support L2 (FTE) - zendesk_ticket.count_tickets,
      2 - Business Support VL2 (Accenture) - zendesk_ticket.count_tickets]
    series_types: {}
    series_colors:
      Row Total - zendesk_ticket.count_tickets: "#ffffff"
      1- Business Support L1 (Accenture) - zendesk_ticket.count_tickets: "#1ea8df"
      3 - Business Support L2 (FTE) - zendesk_ticket.count_tickets: "#e31a1c"
      2 - Business Support VL2 (Accenture) - zendesk_ticket.count_tickets: "#635189"
      4 - Ad Product Quality - zendesk_ticket.count_tickets: "#33a02c"
      5- Pixel Support (Accenture) - zendesk_ticket.count_tickets: "#ff7f00"
      yoy_change_2019: "#e31a1c"
      2018 - zendesk_ticket.count_tickets: "#1ea8df"
      2020 - zendesk_ticket.count_tickets: "#A2BF39"
      yoy_change_2020: "#33a02c"
      sales_volume: "#33a02c"
      total_contacts: "#d0d0d0"
      twitter_outbound_volume: "#33a02c"
      general_support_volume: "#e31a1c"
      feedback_volume: "#1f78b4"
      public_user_volume: "#ff7f00"
      tokens_volume: "#6a3d9a"
      zendesk_ticket.count_tickets: "#000000"
      prior_wk: "#e31a1c"
      py: "#6a3d9a"
      first_resolution_time_hrs: "#000000"
      goal: "#33a02c"
      p90_first_resolution_time_hrs: "#000000"
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: left, color: "#33a02c",
        line_value: '24', label: Goal (24 hr)}]
    trend_lines: []
    discontinuous_nulls: true
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [calculation_7, prior_wk, py, zendesk_ticket_metric_sets.full_resolution_time_in_minutes_calendar_p90]
    defaults_version: 1
    listen: {}
    row: 14
    col: 7
    width: 17
    height: 3
  - name: P50 Full Resolution Time
    type: text
    title_text: P50 Full Resolution Time
    subtitle_text: ''
    body_text: ''
    row: 17
    col: 0
    width: 7
    height: 3
  - title: P50 Full Resolution Time hrs
    name: P50 Full Resolution Time hrs
    model: lk2_community_ops_legacy
    explore: zendesk_ticket
    type: looker_grid
    fields: [zendesk_ticket.created_week, zendesk_ticket_metric_sets.full_resolution_time_in_minutes_calendar_median]
    fill_fields: [zendesk_ticket.created_week]
    filters:
      zendesk_ticket.excluding_snapstreaks: 'Yes'
      zendesk_ticket.created_week: 104 weeks ago for 104 weeks
      zendesk_ticket.is_tickets_automated: 'No'
      zendesk_ticket.adbl_general_support_volume: 'Yes'
    sorts: [zendesk_ticket.created_week desc]
    limit: 5000
    column_limit: 5000
    row_total: right
    dynamic_fields: [{table_calculation: p50_full_resolution_time_hrs, label: P50
          Full Resolution Time hrs, expression: "${zendesk_ticket_metric_sets.full_resolution_time_in_minutes_calendar_median}/60",
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: prior_wk, label: Prior Wk, expression: 'offset(${p50_full_resolution_time_hrs},1)',
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: py, label: PY, expression: 'offset(${p50_full_resolution_time_hrs},52)',
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: wow, label: WoW %, expression: "(${p50_full_resolution_time_hrs}-${prior_wk})/${prior_wk}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: yoy, label: YoY %, expression: "(${p50_full_resolution_time_hrs}-${py})/${py}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: gray
    limit_displayed_rows: true
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '15'
    rows_font_size: '20'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a
      palette_id: 93f8aeb4-3f4a-4cd7-8fee-88c3417516a1
      options:
        steps: 5
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      zendesk_ticket.count_tickets: Tickets last week
      first_resolution_time_hrs: Current Wk
      p90_first_resolution_time_hrs: P90 last week (hrs)
      prior_wk: WoW
      py: YoY
      zendesk_ticket_metric_sets.percent_tickets_first_resolution_time_within_24hr: "%\
        \ within SLA"
      first_reply_time_p50_hrs: P50 First Response time
    series_cell_visualizations:
      zendesk_ticket.count_tickets:
        is_active: false
      wow:
        is_active: false
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '1'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#FCCF41",
        font_color: !!null '', color_application: {collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a,
          palette_id: 39798c77-0126-4f2f-a920-8d7ce381fa5a, options: {steps: 5, reverse: true,
            stepped: true, mirror: false, constraints: {min: {type: number, value: -1},
              max: {type: number, value: 1}, mid: {type: number, value: 0}}}}, bold: false,
        italic: false, strikethrough: false, fields: [wow, yoy]}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    y_axes: [{label: P90 First Resolution Time (hrs), orientation: left, series: [
          {axisId: p90_first_resolution_time_hrs, id: p90_first_resolution_time_hrs,
            name: Current Wk}, {axisId: prior_wk, id: prior_wk, name: Prior Wk}, {
            axisId: py, id: py, name: PY}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 38, type: linear}]
    x_axis_label: ''
    hidden_series: [3 - Business Support L2 (FTE) - zendesk_ticket.count_tickets,
      2 - Business Support VL2 (Accenture) - zendesk_ticket.count_tickets]
    series_types: {}
    series_colors:
      Row Total - zendesk_ticket.count_tickets: "#ffffff"
      1- Business Support L1 (Accenture) - zendesk_ticket.count_tickets: "#1ea8df"
      3 - Business Support L2 (FTE) - zendesk_ticket.count_tickets: "#e31a1c"
      2 - Business Support VL2 (Accenture) - zendesk_ticket.count_tickets: "#635189"
      4 - Ad Product Quality - zendesk_ticket.count_tickets: "#33a02c"
      5- Pixel Support (Accenture) - zendesk_ticket.count_tickets: "#ff7f00"
      yoy_change_2019: "#e31a1c"
      2018 - zendesk_ticket.count_tickets: "#1ea8df"
      2020 - zendesk_ticket.count_tickets: "#A2BF39"
      yoy_change_2020: "#33a02c"
      sales_volume: "#33a02c"
      total_contacts: "#d0d0d0"
      twitter_outbound_volume: "#33a02c"
      general_support_volume: "#e31a1c"
      feedback_volume: "#1f78b4"
      public_user_volume: "#ff7f00"
      tokens_volume: "#6a3d9a"
      zendesk_ticket.count_tickets: "#000000"
      prior_wk: "#e31a1c"
      py: "#6a3d9a"
      first_resolution_time_hrs: "#000000"
      goal: "#33a02c"
      p90_first_resolution_time_hrs: "#000000"
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: left, color: "#33a02c",
        line_value: '24', label: Goal (24 hr)}]
    trend_lines: []
    discontinuous_nulls: true
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [calculation_7, prior_wk, py, zendesk_ticket_metric_sets.full_resolution_time_in_minutes_calendar_median]
    defaults_version: 1
    listen: {}
    row: 17
    col: 7
    width: 17
    height: 3
  - name: Productivity per Shift
    type: text
    title_text: Productivity per Shift
    subtitle_text: ''
    body_text: ''
    row: 20
    col: 0
    width: 12
    height: 3
  - name: Average Agent Utilization
    type: text
    title_text: Average Agent Utilization
    subtitle_text: ''
    body_text: ''
    row: 23
    col: 0
    width: 7
    height: 3
  - name: First Contact Resolution
    type: text
    title_text: First Contact Resolution
    subtitle_text: ''
    body_text: ''
    row: 26
    col: 0
    width: 7
    height: 3
  - title: First Contact Resolution %
    name: First Contact Resolution %
    model: lk2_community_ops_legacy
    explore: zendesk_ticket
    type: looker_grid
    fields: [zendesk_ticket.created_week, zendesk_ticket_metric_sets.first_contact_resolution_tickets_percent,
      zendesk_ticket_metric_sets.first_contact_resolution_tickets_count]
    fill_fields: [zendesk_ticket.created_week]
    filters:
      zendesk_ticket.excluding_snapstreaks: 'Yes'
      zendesk_ticket.created_week: 104 weeks ago for 104 weeks
      zendesk_ticket.is_tickets_automated: 'No'
      zendesk_ticket.adbl_general_support_volume: 'Yes'
    sorts: [zendesk_ticket.created_week desc]
    limit: 5000
    column_limit: 5000
    row_total: right
    dynamic_fields: [{table_calculation: prior_wk, label: Prior Wk, expression: 'offset(${zendesk_ticket_metric_sets.first_contact_resolution_tickets_percent},1)',
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: py, label: PY, expression: 'offset(${zendesk_ticket_metric_sets.first_contact_resolution_tickets_percent},52)',
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: wow, label: WoW %, expression: "(${zendesk_ticket_metric_sets.first_contact_resolution_tickets_percent}-${prior_wk})/${prior_wk}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: yoy, label: YoY %, expression: "(${zendesk_ticket_metric_sets.first_contact_resolution_tickets_percent}-${py})/${py}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: gray
    limit_displayed_rows: true
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '15'
    rows_font_size: '20'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a
      palette_id: 93f8aeb4-3f4a-4cd7-8fee-88c3417516a1
      options:
        steps: 5
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      zendesk_ticket.count_tickets: Tickets last week
      first_resolution_time_hrs: Current Wk
      p90_first_resolution_time_hrs: P90 last week (hrs)
      prior_wk: WoW
      py: YoY
      zendesk_ticket_metric_sets.percent_tickets_first_resolution_time_within_24hr: "%\
        \ within SLA"
      first_reply_time_p50_hrs: P50 First Response time
    series_cell_visualizations:
      zendesk_ticket.count_tickets:
        is_active: false
      wow:
        is_active: false
    series_text_format:
      zendesk_ticket_metric_sets.first_contact_resolution_tickets_percent:
        align: left
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '1'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#FCCF41",
        font_color: !!null '', color_application: {collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a,
          palette_id: 39798c77-0126-4f2f-a920-8d7ce381fa5a, options: {steps: 5, reverse: true,
            stepped: true, mirror: false, constraints: {min: {type: number, value: -1},
              max: {type: number, value: 1}, mid: {type: number, value: 0}}}}, bold: false,
        italic: false, strikethrough: false, fields: [wow, yoy]}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    y_axes: [{label: P90 First Resolution Time (hrs), orientation: left, series: [
          {axisId: p90_first_resolution_time_hrs, id: p90_first_resolution_time_hrs,
            name: Current Wk}, {axisId: prior_wk, id: prior_wk, name: Prior Wk}, {
            axisId: py, id: py, name: PY}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 38, type: linear}]
    x_axis_label: ''
    hidden_series: [3 - Business Support L2 (FTE) - zendesk_ticket.count_tickets,
      2 - Business Support VL2 (Accenture) - zendesk_ticket.count_tickets]
    series_types: {}
    series_colors:
      Row Total - zendesk_ticket.count_tickets: "#ffffff"
      1- Business Support L1 (Accenture) - zendesk_ticket.count_tickets: "#1ea8df"
      3 - Business Support L2 (FTE) - zendesk_ticket.count_tickets: "#e31a1c"
      2 - Business Support VL2 (Accenture) - zendesk_ticket.count_tickets: "#635189"
      4 - Ad Product Quality - zendesk_ticket.count_tickets: "#33a02c"
      5- Pixel Support (Accenture) - zendesk_ticket.count_tickets: "#ff7f00"
      yoy_change_2019: "#e31a1c"
      2018 - zendesk_ticket.count_tickets: "#1ea8df"
      2020 - zendesk_ticket.count_tickets: "#A2BF39"
      yoy_change_2020: "#33a02c"
      sales_volume: "#33a02c"
      total_contacts: "#d0d0d0"
      twitter_outbound_volume: "#33a02c"
      general_support_volume: "#e31a1c"
      feedback_volume: "#1f78b4"
      public_user_volume: "#ff7f00"
      tokens_volume: "#6a3d9a"
      zendesk_ticket.count_tickets: "#000000"
      prior_wk: "#e31a1c"
      py: "#6a3d9a"
      first_resolution_time_hrs: "#000000"
      goal: "#33a02c"
      p90_first_resolution_time_hrs: "#000000"
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: left, color: "#33a02c",
        line_value: '24', label: Goal (24 hr)}]
    trend_lines: []
    discontinuous_nulls: true
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [calculation_7, prior_wk, py, zendesk_ticket_metric_sets.first_contact_resolution_tickets_count]
    defaults_version: 1
    listen: {}
    row: 26
    col: 7
    width: 17
    height: 3
  - name: Replies per solved ticket
    type: text
    title_text: Replies per solved ticket
    subtitle_text: ''
    body_text: ''
    row: 29
    col: 0
    width: 7
    height: 3
  - title: Replies per solved ticket
    name: Replies per solved ticket (2)
    model: lk2_community_ops_legacy
    explore: zendesk_ticket
    type: looker_grid
    fields: [zendesk_ticket.created_week, zendesk_ticket_metric_sets.replies_sum,
      zendesk_ticket.count_tickets]
    fill_fields: [zendesk_ticket.created_week]
    filters:
      zendesk_ticket.excluding_snapstreaks: 'Yes'
      zendesk_ticket.created_week: 104 weeks ago for 104 weeks
      zendesk_ticket.is_tickets_automated: 'No'
      zendesk_ticket.adbl_general_support_volume: 'Yes'
      zendesk_ticket.status: closed,solved
    sorts: [zendesk_ticket.created_week desc]
    limit: 5000
    column_limit: 5000
    row_total: right
    dynamic_fields: [{table_calculation: replies_per_solved, label: Replies per solved,
        expression: "${zendesk_ticket_metric_sets.replies_sum}/${zendesk_ticket.count_tickets}",
        value_format: !!null '', value_format_name: decimal_1, _kind_hint: measure,
        _type_hint: number}, {table_calculation: prior_wk, label: Prior Wk, expression: 'offset(${replies_per_solved},1)',
        value_format: !!null '', value_format_name: decimal_1, _kind_hint: measure,
        _type_hint: number}, {table_calculation: py, label: PY, expression: 'offset(${replies_per_solved},52)',
        value_format: !!null '', value_format_name: decimal_1, _kind_hint: measure,
        _type_hint: number}, {table_calculation: wow, label: WoW %, expression: "(${replies_per_solved}-${prior_wk})/${prior_wk}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: yoy, label: YoY %, expression: "(${replies_per_solved}-${py})/${py}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: gray
    limit_displayed_rows: true
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '15'
    rows_font_size: '20'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a
      palette_id: 93f8aeb4-3f4a-4cd7-8fee-88c3417516a1
      options:
        steps: 5
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      zendesk_ticket.count_tickets: Tickets last week
      first_resolution_time_hrs: Current Wk
      p90_first_resolution_time_hrs: P90 last week (hrs)
      prior_wk: WoW
      py: YoY
      zendesk_ticket_metric_sets.percent_tickets_first_resolution_time_within_24hr: "%\
        \ within SLA"
      first_reply_time_p50_hrs: P50 First Response time
    series_cell_visualizations:
      zendesk_ticket.count_tickets:
        is_active: false
      wow:
        is_active: false
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '1'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#FCCF41",
        font_color: !!null '', color_application: {collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a,
          palette_id: 39798c77-0126-4f2f-a920-8d7ce381fa5a, options: {steps: 5, reverse: true,
            stepped: true, mirror: false, constraints: {min: {type: number, value: -1},
              max: {type: number, value: 1}, mid: {type: number, value: 0}}}}, bold: false,
        italic: false, strikethrough: false, fields: [wow, yoy]}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    y_axes: [{label: P90 First Resolution Time (hrs), orientation: left, series: [
          {axisId: p90_first_resolution_time_hrs, id: p90_first_resolution_time_hrs,
            name: Current Wk}, {axisId: prior_wk, id: prior_wk, name: Prior Wk}, {
            axisId: py, id: py, name: PY}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 38, type: linear}]
    x_axis_label: ''
    hidden_series: [3 - Business Support L2 (FTE) - zendesk_ticket.count_tickets,
      2 - Business Support VL2 (Accenture) - zendesk_ticket.count_tickets]
    series_types: {}
    series_colors:
      Row Total - zendesk_ticket.count_tickets: "#ffffff"
      1- Business Support L1 (Accenture) - zendesk_ticket.count_tickets: "#1ea8df"
      3 - Business Support L2 (FTE) - zendesk_ticket.count_tickets: "#e31a1c"
      2 - Business Support VL2 (Accenture) - zendesk_ticket.count_tickets: "#635189"
      4 - Ad Product Quality - zendesk_ticket.count_tickets: "#33a02c"
      5- Pixel Support (Accenture) - zendesk_ticket.count_tickets: "#ff7f00"
      yoy_change_2019: "#e31a1c"
      2018 - zendesk_ticket.count_tickets: "#1ea8df"
      2020 - zendesk_ticket.count_tickets: "#A2BF39"
      yoy_change_2020: "#33a02c"
      sales_volume: "#33a02c"
      total_contacts: "#d0d0d0"
      twitter_outbound_volume: "#33a02c"
      general_support_volume: "#e31a1c"
      feedback_volume: "#1f78b4"
      public_user_volume: "#ff7f00"
      tokens_volume: "#6a3d9a"
      zendesk_ticket.count_tickets: "#000000"
      prior_wk: "#e31a1c"
      py: "#6a3d9a"
      first_resolution_time_hrs: "#000000"
      goal: "#33a02c"
      p90_first_resolution_time_hrs: "#000000"
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: left, color: "#33a02c",
        line_value: '24', label: Goal (24 hr)}]
    trend_lines: []
    discontinuous_nulls: true
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [calculation_7, prior_wk, py, zendesk_ticket_metric_sets.replies_sum,
      zendesk_ticket.count_tickets]
    defaults_version: 1
    listen: {}
    row: 29
    col: 7
    width: 17
    height: 3
  - name: Total Ticket Volume
    type: text
    title_text: Total Ticket Volume
    subtitle_text: ''
    body_text: ''
    row: 32
    col: 0
    width: 7
    height: 3
  - title: Total Ticket Volume
    name: Total Ticket Volume (2)
    model: lk2_community_ops_legacy
    explore: zendesk_ticket
    type: looker_grid
    fields: [zendesk_ticket.created_week, zendesk_ticket.count_tickets]
    fill_fields: [zendesk_ticket.created_week]
    filters:
      zendesk_ticket.excluding_snapstreaks: 'Yes'
      zendesk_ticket.created_week: 104 weeks ago for 104 weeks
      zendesk_ticket.adbl_general_support_volume: 'Yes'
    sorts: [zendesk_ticket.created_week desc]
    limit: 5000
    column_limit: 5000
    row_total: right
    dynamic_fields: [{table_calculation: prior_wk, label: Prior Wk, expression: 'offset(${zendesk_ticket.count_tickets},1)',
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: py, label: PY, expression: 'offset(${zendesk_ticket.count_tickets},52)',
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: wow, label: WoW %, expression: "(${zendesk_ticket.count_tickets}-${prior_wk})/${prior_wk}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: yoy, label: YoY %, expression: "(${zendesk_ticket.count_tickets}-${py})/${py}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: gray
    limit_displayed_rows: true
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '15'
    rows_font_size: '20'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a
      palette_id: 93f8aeb4-3f4a-4cd7-8fee-88c3417516a1
      options:
        steps: 5
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      zendesk_ticket.count_tickets: Tickets last week
      first_resolution_time_hrs: Current Wk
      p90_first_resolution_time_hrs: P90 last week (hrs)
      prior_wk: WoW
      py: YoY
      zendesk_ticket_metric_sets.percent_tickets_first_resolution_time_within_24hr: "%\
        \ within SLA"
      first_reply_time_p50_hrs: P50 First Response time
    series_cell_visualizations:
      zendesk_ticket.count_tickets:
        is_active: false
      wow:
        is_active: false
    series_text_format:
      zendesk_ticket.created_week: {}
      zendesk_ticket_metric_sets.replies_sum:
        align: left
      zendesk_ticket.count_tickets:
        align: left
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '1'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#FCCF41",
        font_color: !!null '', color_application: {collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a,
          palette_id: 39798c77-0126-4f2f-a920-8d7ce381fa5a, options: {steps: 5, reverse: true,
            stepped: true, mirror: false, constraints: {min: {type: number, value: -1},
              max: {type: number, value: 1}, mid: {type: number, value: 0}}}}, bold: false,
        italic: false, strikethrough: false, fields: [wow, yoy]}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    y_axes: [{label: P90 First Resolution Time (hrs), orientation: left, series: [
          {axisId: p90_first_resolution_time_hrs, id: p90_first_resolution_time_hrs,
            name: Current Wk}, {axisId: prior_wk, id: prior_wk, name: Prior Wk}, {
            axisId: py, id: py, name: PY}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 38, type: linear}]
    x_axis_label: ''
    hidden_series: [3 - Business Support L2 (FTE) - zendesk_ticket.count_tickets,
      2 - Business Support VL2 (Accenture) - zendesk_ticket.count_tickets]
    series_types: {}
    series_colors:
      Row Total - zendesk_ticket.count_tickets: "#ffffff"
      1- Business Support L1 (Accenture) - zendesk_ticket.count_tickets: "#1ea8df"
      3 - Business Support L2 (FTE) - zendesk_ticket.count_tickets: "#e31a1c"
      2 - Business Support VL2 (Accenture) - zendesk_ticket.count_tickets: "#635189"
      4 - Ad Product Quality - zendesk_ticket.count_tickets: "#33a02c"
      5- Pixel Support (Accenture) - zendesk_ticket.count_tickets: "#ff7f00"
      yoy_change_2019: "#e31a1c"
      2018 - zendesk_ticket.count_tickets: "#1ea8df"
      2020 - zendesk_ticket.count_tickets: "#A2BF39"
      yoy_change_2020: "#33a02c"
      sales_volume: "#33a02c"
      total_contacts: "#d0d0d0"
      twitter_outbound_volume: "#33a02c"
      general_support_volume: "#e31a1c"
      feedback_volume: "#1f78b4"
      public_user_volume: "#ff7f00"
      tokens_volume: "#6a3d9a"
      zendesk_ticket.count_tickets: "#000000"
      prior_wk: "#e31a1c"
      py: "#6a3d9a"
      first_resolution_time_hrs: "#000000"
      goal: "#33a02c"
      p90_first_resolution_time_hrs: "#000000"
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: left, color: "#33a02c",
        line_value: '24', label: Goal (24 hr)}]
    trend_lines: []
    discontinuous_nulls: true
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [calculation_7, prior_wk, py]
    defaults_version: 1
    listen: {}
    row: 32
    col: 7
    width: 17
    height: 3
  - name: "% Automated"
    type: text
    title_text: "% Automated"
    subtitle_text: ''
    body_text: ''
    row: 35
    col: 0
    width: 7
    height: 3
  - title: "% Automated"
    name: "% Automated (2)"
    model: lk2_community_ops_legacy
    explore: zendesk_ticket
    type: looker_grid
    fields: [zendesk_ticket.created_week, zendesk_ticket.tickets__fully_automated_percent,
      zendesk_ticket.tickets_fully_automated]
    fill_fields: [zendesk_ticket.created_week]
    filters:
      zendesk_ticket.excluding_snapstreaks: 'Yes'
      zendesk_ticket.created_week: 104 weeks ago for 104 weeks
      zendesk_ticket.adbl_general_support_volume: 'Yes'
    sorts: [zendesk_ticket.created_week desc]
    limit: 5000
    column_limit: 5000
    row_total: right
    dynamic_fields: [{table_calculation: prior_wk, label: Prior Wk, expression: 'offset(${zendesk_ticket.tickets__fully_automated_percent},1)',
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: py, label: PY, expression: 'offset(${zendesk_ticket.tickets__fully_automated_percent},52)',
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: wow, label: WoW %, expression: "(${zendesk_ticket.tickets__fully_automated_percent}-${prior_wk})/${prior_wk}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: yoy, label: YoY %, expression: "(${zendesk_ticket.tickets__fully_automated_percent}-${py})/${py}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: gray
    limit_displayed_rows: true
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '15'
    rows_font_size: '20'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a
      palette_id: 93f8aeb4-3f4a-4cd7-8fee-88c3417516a1
      options:
        steps: 5
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      zendesk_ticket.count_tickets: Tickets last week
      first_resolution_time_hrs: Current Wk
      p90_first_resolution_time_hrs: P90 last week (hrs)
      prior_wk: WoW
      py: YoY
      zendesk_ticket_metric_sets.percent_tickets_first_resolution_time_within_24hr: "%\
        \ within SLA"
      first_reply_time_p50_hrs: P50 First Response time
    series_cell_visualizations:
      zendesk_ticket.count_tickets:
        is_active: false
      wow:
        is_active: false
    series_text_format:
      zendesk_ticket.created_week: {}
      zendesk_ticket_metric_sets.replies_sum:
        align: left
      zendesk_ticket.count_tickets:
        align: left
      zendesk_ticket.tickets__fully_automated_percent:
        align: left
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '1'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#FCCF41",
        font_color: !!null '', color_application: {collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a,
          palette_id: 39798c77-0126-4f2f-a920-8d7ce381fa5a, options: {steps: 5, reverse: true,
            stepped: true, mirror: false, constraints: {min: {type: number, value: -1},
              max: {type: number, value: 1}, mid: {type: number, value: 0}}}}, bold: false,
        italic: false, strikethrough: false, fields: [wow, yoy]}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    y_axes: [{label: P90 First Resolution Time (hrs), orientation: left, series: [
          {axisId: p90_first_resolution_time_hrs, id: p90_first_resolution_time_hrs,
            name: Current Wk}, {axisId: prior_wk, id: prior_wk, name: Prior Wk}, {
            axisId: py, id: py, name: PY}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 38, type: linear}]
    x_axis_label: ''
    hidden_series: [3 - Business Support L2 (FTE) - zendesk_ticket.count_tickets,
      2 - Business Support VL2 (Accenture) - zendesk_ticket.count_tickets]
    series_types: {}
    series_colors:
      Row Total - zendesk_ticket.count_tickets: "#ffffff"
      1- Business Support L1 (Accenture) - zendesk_ticket.count_tickets: "#1ea8df"
      3 - Business Support L2 (FTE) - zendesk_ticket.count_tickets: "#e31a1c"
      2 - Business Support VL2 (Accenture) - zendesk_ticket.count_tickets: "#635189"
      4 - Ad Product Quality - zendesk_ticket.count_tickets: "#33a02c"
      5- Pixel Support (Accenture) - zendesk_ticket.count_tickets: "#ff7f00"
      yoy_change_2019: "#e31a1c"
      2018 - zendesk_ticket.count_tickets: "#1ea8df"
      2020 - zendesk_ticket.count_tickets: "#A2BF39"
      yoy_change_2020: "#33a02c"
      sales_volume: "#33a02c"
      total_contacts: "#d0d0d0"
      twitter_outbound_volume: "#33a02c"
      general_support_volume: "#e31a1c"
      feedback_volume: "#1f78b4"
      public_user_volume: "#ff7f00"
      tokens_volume: "#6a3d9a"
      zendesk_ticket.count_tickets: "#000000"
      prior_wk: "#e31a1c"
      py: "#6a3d9a"
      first_resolution_time_hrs: "#000000"
      goal: "#33a02c"
      p90_first_resolution_time_hrs: "#000000"
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: left, color: "#33a02c",
        line_value: '24', label: Goal (24 hr)}]
    trend_lines: []
    discontinuous_nulls: true
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [calculation_7, prior_wk, py, zendesk_ticket.tickets_fully_automated]
    defaults_version: 1
    listen: {}
    row: 35
    col: 7
    width: 17
    height: 3
  - name: Backlog Volume
    type: text
    title_text: Backlog Volume
    subtitle_text: ''
    body_text: ''
    row: 38
    col: 0
    width: 7
    height: 3
  - title: Backlog Volume
    name: Backlog Volume (2)
    model: lk2_community_ops_legacy
    explore: zendesk_ticket
    type: looker_grid
    fields: [zendesk_ticket.created_week, zendesk_ticket.count_tickets]
    fill_fields: [zendesk_ticket.created_week]
    filters:
      zendesk_ticket.excluding_snapstreaks: 'Yes'
      zendesk_ticket.created_week: 104 weeks ago for 104 weeks
      zendesk_ticket.status: hold,new,open,pending
      zendesk_ticket.is_tickets_automated: 'No'
      zendesk_ticket.is_general_support: 'Yes'
    sorts: [zendesk_ticket.created_week desc]
    limit: 5000
    column_limit: 5000
    row_total: right
    dynamic_fields: [{table_calculation: prior_wk, label: Prior Wk, expression: 'offset(${zendesk_ticket.count_tickets},1)',
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: py, label: PY, expression: 'offset(${zendesk_ticket.count_tickets},52)',
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: wow, label: WoW %, expression: "(${zendesk_ticket.count_tickets}-${prior_wk})/${prior_wk}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: yoy, label: YoY %, expression: "(${zendesk_ticket.count_tickets}-${py})/${py}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: gray
    limit_displayed_rows: true
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '15'
    rows_font_size: '20'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a
      palette_id: 93f8aeb4-3f4a-4cd7-8fee-88c3417516a1
      options:
        steps: 5
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      zendesk_ticket.count_tickets: Tickets backlog
      first_resolution_time_hrs: Current Wk
      p90_first_resolution_time_hrs: P90 last week (hrs)
      prior_wk: WoW
      py: YoY
      zendesk_ticket_metric_sets.percent_tickets_first_resolution_time_within_24hr: "%\
        \ within SLA"
      first_reply_time_p50_hrs: P50 First Response time
    series_cell_visualizations:
      zendesk_ticket.count_tickets:
        is_active: false
      wow:
        is_active: false
    series_text_format:
      zendesk_ticket.created_week: {}
      zendesk_ticket_metric_sets.replies_sum:
        align: left
      zendesk_ticket.count_tickets:
        align: left
      zendesk_ticket.tickets__fully_automated_percent:
        align: left
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '1'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#FCCF41",
        font_color: !!null '', color_application: {collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a,
          palette_id: 39798c77-0126-4f2f-a920-8d7ce381fa5a, options: {steps: 5, reverse: true,
            stepped: true, mirror: false, constraints: {min: {type: number, value: -1},
              max: {type: number, value: 1}, mid: {type: number, value: 0}}}}, bold: false,
        italic: false, strikethrough: false, fields: [wow, yoy]}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    y_axes: [{label: P90 First Resolution Time (hrs), orientation: left, series: [
          {axisId: p90_first_resolution_time_hrs, id: p90_first_resolution_time_hrs,
            name: Current Wk}, {axisId: prior_wk, id: prior_wk, name: Prior Wk}, {
            axisId: py, id: py, name: PY}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 38, type: linear}]
    x_axis_label: ''
    hidden_series: [3 - Business Support L2 (FTE) - zendesk_ticket.count_tickets,
      2 - Business Support VL2 (Accenture) - zendesk_ticket.count_tickets]
    series_types: {}
    series_colors:
      Row Total - zendesk_ticket.count_tickets: "#ffffff"
      1- Business Support L1 (Accenture) - zendesk_ticket.count_tickets: "#1ea8df"
      3 - Business Support L2 (FTE) - zendesk_ticket.count_tickets: "#e31a1c"
      2 - Business Support VL2 (Accenture) - zendesk_ticket.count_tickets: "#635189"
      4 - Ad Product Quality - zendesk_ticket.count_tickets: "#33a02c"
      5- Pixel Support (Accenture) - zendesk_ticket.count_tickets: "#ff7f00"
      yoy_change_2019: "#e31a1c"
      2018 - zendesk_ticket.count_tickets: "#1ea8df"
      2020 - zendesk_ticket.count_tickets: "#A2BF39"
      yoy_change_2020: "#33a02c"
      sales_volume: "#33a02c"
      total_contacts: "#d0d0d0"
      twitter_outbound_volume: "#33a02c"
      general_support_volume: "#e31a1c"
      feedback_volume: "#1f78b4"
      public_user_volume: "#ff7f00"
      tokens_volume: "#6a3d9a"
      zendesk_ticket.count_tickets: "#000000"
      prior_wk: "#e31a1c"
      py: "#6a3d9a"
      first_resolution_time_hrs: "#000000"
      goal: "#33a02c"
      p90_first_resolution_time_hrs: "#000000"
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: left, color: "#33a02c",
        line_value: '24', label: Goal (24 hr)}]
    trend_lines: []
    discontinuous_nulls: true
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [calculation_7, prior_wk, py]
    defaults_version: 1
    listen: {}
    row: 38
    col: 7
    width: 17
    height: 3
  - name: Average Agent Utilization (2)
    title: Average Agent Utilization
    merged_queries:
    - model: lk2_community_ops_legacy
      explore: zendesk_ticket_events
      type: looker_line
      fields: [zendesk_ticket_events.updated_at_pst_week, zendesk_ticket_events.count_ticket,
        zendesk_ticket.total_time_spent_sum, custops_fte_vendor_users.subteam_primary,
        zendesk_ticket_metric_sets.assignee_stations_sum]
      filters:
        zendesk_ticket_events.partition_filter: 2 weeks ago for 2 weeks
        custops_fte_vendor_users.fte_or_vendor: Vendor
        zendesk_ticket.excluding_snapstreaks: 'Yes'
        zendesk_ticket_events.updated_at_pst_week: 2 weeks ago for 2 weeks
        custops_fte_vendor_users.team: "%Community Operations%"
        custops_fte_vendor_users.subteam_primary: Community Support (L1)
      sorts: [zendesk_ticket_events.updated_at_pst_week desc]
      limit: 500
      row_total: right
      filter_expression: "${zendesk_group.name}=\"General Support L1\" OR \n${zendesk_group.name}=\"\
        General Support L2\" OR \n${zendesk_group.name}=\"General Support L3\" OR\
        \ \n${zendesk_group.name}=\"Support@support.snapchat\" OR \n${zendesk_group.name}=\"\
        Snap Tokens\" OR\n${zendesk_group.name}=\"Feedback\" OR \n\n${zendesk_ticket_initials.initial_group}=\"\
        General Support L1\" OR ${zendesk_ticket_initials.initial_group}=\"General\
        \ Support L2\" OR ${zendesk_ticket_initials.initial_group}=\"General Support\
        \ L3\" OR ${zendesk_ticket_initials.initial_group}=\"Support@support.snapchat\"\
        \ OR ${zendesk_ticket_initials.initial_group}=\"Snap Tokens\" OR ${zendesk_ticket_initials.initial_group}=\"\
        Feedback\""
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      y_axis_scale_mode: linear
      x_axis_reversed: false
      y_axis_reversed: false
      plot_size_by_field: false
      trellis: ''
      stacking: ''
      limit_displayed_rows: false
      legend_position: center
      point_style: none
      show_value_labels: false
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      show_null_points: true
      interpolation: linear
      defaults_version: 1
      hidden_fields: []
    - model: lk2_community_ops_legacy
      explore: zendesk_ticket
      type: table
      fields: [zendesk_ticket.created_week, custops_fte_vendor_users.subteam_primary,
        zendesk_agent.count_agents]
      filters:
        custops_fte_vendor_users.fte_or_vendor: Vendor
        custops_fte_vendor_users.position: "%Agent%,%agent%"
        custops_fte_vendor_users.subteam_primary: Community Support (L1)
        custops_fte_vendor_users.team: "%Community Operations%"
        zendesk_ticket.created_week: 2 weeks ago for 2 weeks
        zendesk_ticket.excluding_snapstreaks: 'Yes'
      sorts: [zendesk_ticket.created_week desc]
      limit: 500
      filter_expression: "${zendesk_group.name}=\"General Support L1\" OR \n${zendesk_group.name}=\"\
        General Support L2\" OR \n${zendesk_group.name}=\"General Support L3\" OR\
        \ \n${zendesk_group.name}=\"Support@support.snapchat\" OR \n${zendesk_group.name}=\"\
        Snap Tokens\" OR\n${zendesk_group.name}=\"Feedback\" OR \n\n${zendesk_ticket_initials.initial_group}=\"\
        General Support L1\" OR ${zendesk_ticket_initials.initial_group}=\"General\
        \ Support L2\" OR ${zendesk_ticket_initials.initial_group}=\"General Support\
        \ L3\" OR ${zendesk_ticket_initials.initial_group}=\"Support@support.snapchat\"\
        \ OR ${zendesk_ticket_initials.initial_group}=\"Snap Tokens\" OR ${zendesk_ticket_initials.initial_group}=\"\
        Feedback\""
      join_fields:
      - field_name: custops_fte_vendor_users.subteam_primary
        source_field_name: custops_fte_vendor_users.subteam_primary
      - field_name: zendesk_ticket.created_week
        source_field_name: zendesk_ticket_events.updated_at_pst_week
    color_application:
      collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a
      palette_id: 93f8aeb4-3f4a-4cd7-8fee-88c3417516a1
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    size_to_fit: true
    series_column_widths:
      zendesk_ticket_events.updated_at_pst_week: 470
    table_theme: gray
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '1'
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '15'
    rows_font_size: '20'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axes: [{label: '', orientation: left, series: [{axisId: average_utilization,
            id: Public User Support - average_utilization, name: Public User Support},
          {axisId: average_utilization, id: Community Support (L1) - average_utilization,
            name: Community Support (L1)}], showLabels: true, showValues: true, maxValue: 1,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    series_colors:
      average_utilization_all_teams: "#000000"
      Public User Support - average_utilization: "#ff7f00"
      Community Support (L1) - average_utilization: "#1f78b4"
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: left, color: "#000000",
        line_value: '0.8125', label: 32.5h/w (target)}]
    show_null_points: true
    interpolation: linear
    hidden_fields: [zendesk_ticket_events.count_ticket, zendesk_ticket.total_time_spent_sum,
      zendesk_agent.count_agents, total_hours_occupied, total_capacity_hours, zendesk_ticket_metric_sets.assignee_stations_sum,
      custops_fte_vendor_users.subteam_primary, prior_wk]
    type: looker_grid
    series_types: {}
    dynamic_fields: [{table_calculation: total_hours_occupied, label: Total Hours
          Occupied, expression: "((${zendesk_ticket.total_time_spent_sum}/${zendesk_ticket_metric_sets.assignee_stations_sum})\n\
          *\n${zendesk_ticket_events.count_ticket})\n/60/60", value_format: !!null '',
        value_format_name: decimal_0, _kind_hint: measure, _type_hint: number}, {
        table_calculation: total_capacity_hours, label: Total Capacity Hours, expression: "${zendesk_agent.count_agents}*40",
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: average_utilization, label: Average
          Utilization, expression: "${total_hours_occupied}/${total_capacity_hours}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: prior_wk, label: Prior Wk, expression: 'offset(${average_utilization},1)',
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: wow, label: WoW %, expression: "(${average_utilization}-${prior_wk})/${prior_wk}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    row: 23
    col: 7
    width: 17
    height: 3
