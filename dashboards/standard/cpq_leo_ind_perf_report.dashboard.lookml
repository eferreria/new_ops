---
- dashboard: cpq_leo_individual_performance_report
  title: "[CPQ] LEO Individual Performance Report"
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: zNzxXmNW4aholOqCGyzgCX
  elements:
  - title: SW/CO (Proactive QA)
    name: SW/CO (Proactive QA)
    model: lk2_platform_integrity_standard
    explore: pi_leo_fte_zd_qa_scores
    type: looker_line
    fields: [pi_leo_fte_zd_qa_scores.action_date_week, pi_leo_fte_zd_qa_scores._score,
      pi_leo_fte_zd_qa_scores.qa_count]
    fill_fields: [pi_leo_fte_zd_qa_scores.action_date_week]
    filters:
      pi_leo_fte_zd_qa_scores.lp_type: CO,sw,SW
      pi_leo_fte_zd_qa_scores.action_date_date: 13 weeks
      pi_leo_fte_zd_qa_scores.certified_qa_recipient: 'No'
    sorts: [pi_leo_fte_zd_qa_scores.action_date_week desc]
    limit: 500
    column_limit: 50
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
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    color_application:
      collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
      palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
      options:
        steps: 5
        reverse: false
    y_axes: [{label: '', orientation: left, series: [{axisId: pi_leo_fte_zd_qa_scores._score,
            id: pi_leo_fte_zd_qa_scores._score, name: " Score"}], showLabels: true,
        showValues: true, maxValue: 1, unpinAxis: true, tickDensity: default, type: linear},
      {label: '', orientation: right, series: [{axisId: pi_leo_fte_zd_qa_scores.qa_count,
            id: pi_leo_fte_zd_qa_scores.qa_count, name: QA Count}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: linear}]
    series_types:
      International - pi_leo_fte_zd_qa_scores.qa_count: column
      Production - pi_leo_fte_zd_qa_scores.qa_count: column
      pi_leo_fte_zd_qa_scores.qa_count: column
    series_colors:
      International - pi_leo_fte_zd_qa_scores.qa_count: "#4276BE"
      Production - pi_leo_fte_zd_qa_scores.qa_count: "#E57947"
      Production - pi_leo_fte_zd_qa_scores._score: "#E57947"
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: center, color: "#000000",
        line_value: ".98", label: Goal (98%)}]
    discontinuous_nulls: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      Agent Email: pi_leo_fte_zd_qa_scores.qa_recipient
    row: 150
    col: 0
    width: 12
    height: 9
  - name: Individual's Quality Score Trends
    type: text
    title_text: Individual's Quality Score Trends
    subtitle_text: L13 Weeks
    body_text: ''
    row: 130
    col: 0
    width: 24
    height: 2
  - name: Productivity
    type: text
    title_text: Productivity
    subtitle_text: ''
    body_text: ''
    row: 0
    col: 0
    width: 24
    height: 2
  - name: Notes
    type: text
    title_text: Notes
    subtitle_text: ''
    body_text: "Individual's Quality Score Trends\n\n- QA score and count where the\
      \ agent was QA'd as a Recipient. This will only populate if the agent has placed\
      \ a ticket in the QA sheets within the past 12 complete weeks.\n- For SW/CO\
      \ tile: QA Process Type = Production; LP Type = SW, CO\n- For Sub tile: QA Process\
      \ Type = Production; LP Type = Subpoena\n- For non-US tile: QA Process Type\
      \ = International\n- For PRTT/WT tile: QA Process Type = PRTT & WT\n- For PRs\
      \ tile: QA Process Type = Preservation\n- For Triaging/Classification tile:\
      \ QA Process Type = Triaging & Classification\n- For UN tile: QA Process Type\
      \ = UN\n- Over the last 12 complete weeks (will not include the current week)\n\
      \nIndividual's Unsolved Counts\n\n- Count of tickets assigned to agent that\
      \ are currently not Solved, Closed, or Deleted per workflow\n\nCount of Solved\
      \ Tickets + QA'd Tickets (Individual)\n\n- Agent's weekly volume of solved tickets\
      \ PLUS volume of QA'd tickets as reviewer\n- Over the past 12 complete weeks\
      \ (will not include the current week)\n\nCount of Solved Tickets + QA'd Tickets\
      \ (Level)\n\n- Avg. per specialist weekly volume of solved tickets alongside\
      \ avg. per specialist volume of QA'd tickets as reviewer\n- The averages are\
      \ reached by dividing the total number of tickets QA'd or solved by specialists\
      \ in a given week BY the number of ACTIVE specialists in the queues or QA sheets\
      \ for a given week (will change based on OOO, certification status, etc.). Active\
      \ agents in Queues will not equal active agents QAing.\n- Over the past 12 complete\
      \ weeks (will not include the current week)\n\nCount Tickets QA'd as Reviewer\
      \ (Individual)\n\n- Total tickets the agent has QA'd as reviewer from all QA\
      \ sheets\n- Broken down by process type \n- Over the past 12 complete weeks\
      \ (will not include the current week)\n\nCount Tickets QA'd as Reviewer (Comparison\
      \ to Level)\n\n- Avg. per ACTIVE specialist count of tickets QA'd as reviewer\
      \ from all QA sheets\n- The average is reached by dividing the total number\
      \ tickets QA'd by specialists in a given week by number of ACTIVE specialists\
      \ in the QA sheets for a given week (will change based on OOO, certification\
      \ status, etc.)\n- Over the past 12 complete weeks (will not include the current\
      \ week)\n- Please note that this comparison should not be treated as a true\
      \ gauge of productivity, as it treats PRs and SWs as equivalent. Please reference\
      \ the individual graph for additional details regarding ticket breakdown.\n\n\
      Count of Solved Tickets (Individual)\n\n- Total tickets the agent has solved\n\
      - Broken down by contact reason grouped\n- Over the past 12 complete weeks (will\
      \ not include the current week)\n\nCount of Solved Tickets (Comparison to Level)\n\
      \n- Avg. per ACTIVE specialist count of tickets solved\n- The average is reached\
      \ by dividing the total number tickets solved by specialists in a given week\
      \ by number of ACTIVE specialists in the queues for a given week (will change\
      \ based on OOO, certification status, etc.)\n- Over the past 12 complete weeks\
      \ (will not include the current week)\n- Please note that this comparison should\
      \ not be treated as a true gauge of productivity, as it treats PRs and SWs as\
      \ equivalent. Please reference the individual graph for additional details regarding\
      \ ticket breakdown."
    row: 224
    col: 0
    width: 24
    height: 19
  - title: Solved Tickets (Individual) [L13 Weeks]
    name: Solved Tickets (Individual) [L13 Weeks]
    model: lk2_community_ops_legacy
    explore: zendesk_ticket
    type: looker_column
    fields: [zendesk_ticket.leo_contact_reason_grouped, zendesk_ticket.count_tickets,
      zendesk_ticket_metric_sets.solved_at_utc_week]
    pivots: [zendesk_ticket.leo_contact_reason_grouped]
    fill_fields: [zendesk_ticket_metric_sets.solved_at_utc_week]
    filters:
      zendesk_ticket.tag: "-%ncmec-receipts%"
      zendesk_ticket_metric_sets.solved_at_utc_date: 13 weeks
    sorts: [zendesk_ticket.leo_contact_reason_grouped, zendesk_ticket_metric_sets.solved_at_utc_week
        desc]
    limit: 500
    column_limit: 50
    filter_expression: if(NOT(${zendesk_ticket.leo_contact_reason}="Imminent Customer
      Threat Escalation") AND contains(${zendesk_ticket.tag},"snap-internal"),no,yes)
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
      palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
      options:
        steps: 5
        reverse: false
    x_axis_label: Solved at Week
    series_colors: {}
    defaults_version: 1
    hidden_fields:
    listen:
      Productivity Solved Contact Reason: zendesk_ticket.leo_contact_reason_grouped
      Date Filter: zendesk_ticket_metric_sets.solved_at_date
      Agent Email: zendesk_agent.email
    row: 24
    col: 0
    width: 12
    height: 11
  - title: Subpoena/Summons (Proactive QA)
    name: Subpoena/Summons (Proactive QA)
    model: lk2_platform_integrity_standard
    explore: pi_leo_fte_zd_qa_scores
    type: looker_line
    fields: [pi_leo_fte_zd_qa_scores.action_date_week, pi_leo_fte_zd_qa_scores._score,
      pi_leo_fte_zd_qa_scores.qa_count]
    fill_fields: [pi_leo_fte_zd_qa_scores.action_date_week]
    filters:
      pi_leo_fte_zd_qa_scores.lp_type: subpoena,Subpoena
      pi_leo_fte_zd_qa_scores.action_date_date: 13 weeks
      pi_leo_fte_zd_qa_scores.certified_qa_recipient: 'No'
    sorts: [pi_leo_fte_zd_qa_scores.action_date_week desc]
    limit: 500
    column_limit: 50
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
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    color_application:
      collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
      palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
      options:
        steps: 5
        reverse: false
    y_axes: [{label: '', orientation: left, series: [{axisId: pi_leo_fte_zd_qa_scores._score,
            id: pi_leo_fte_zd_qa_scores._score, name: " Score"}], showLabels: true,
        showValues: true, maxValue: 1, unpinAxis: true, tickDensity: default, type: linear},
      {label: '', orientation: right, series: [{axisId: pi_leo_fte_zd_qa_scores.qa_count,
            id: pi_leo_fte_zd_qa_scores.qa_count, name: QA Count}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: linear}]
    series_types:
      International - pi_leo_fte_zd_qa_scores.qa_count: column
      Production - pi_leo_fte_zd_qa_scores.qa_count: column
      pi_leo_fte_zd_qa_scores.qa_count: column
    series_colors:
      International - pi_leo_fte_zd_qa_scores.qa_count: "#4276BE"
      Production - pi_leo_fte_zd_qa_scores.qa_count: "#E57947"
      Production - pi_leo_fte_zd_qa_scores._score: "#E57947"
    reference_lines: [{reference_type: line, line_value: ".98", range_start: max,
        range_end: min, margin_top: deviation, margin_value: mean, margin_bottom: deviation,
        label_position: center, color: "#000000", label: Goal (98%)}]
    discontinuous_nulls: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      Agent Email: pi_leo_fte_zd_qa_scores.qa_recipient
    row: 159
    col: 0
    width: 12
    height: 9
  - title: International (Proactive QA)
    name: International (Proactive QA)
    model: lk2_platform_integrity_standard
    explore: pi_leo_fte_zd_qa_scores
    type: looker_line
    fields: [pi_leo_fte_zd_qa_scores.action_date_week, pi_leo_fte_zd_qa_scores._score,
      pi_leo_fte_zd_qa_scores.qa_count]
    fill_fields: [pi_leo_fte_zd_qa_scores.action_date_week]
    filters:
      pi_leo_fte_zd_qa_scores.qa_process_type: International
      pi_leo_fte_zd_qa_scores.action_date_date: 13 weeks
      pi_leo_fte_zd_qa_scores.certified_qa_recipient: 'No'
    sorts: [pi_leo_fte_zd_qa_scores.action_date_week desc]
    limit: 500
    column_limit: 50
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
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    color_application:
      collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
      palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
      options:
        steps: 5
        reverse: false
    y_axes: [{label: '', orientation: left, series: [{axisId: pi_leo_fte_zd_qa_scores._score,
            id: pi_leo_fte_zd_qa_scores._score, name: " Score"}], showLabels: true,
        showValues: true, maxValue: 1, unpinAxis: true, tickDensity: default, type: linear},
      {label: '', orientation: right, series: [{axisId: pi_leo_fte_zd_qa_scores.qa_count,
            id: pi_leo_fte_zd_qa_scores.qa_count, name: QA Count}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: linear}]
    series_types:
      International - pi_leo_fte_zd_qa_scores.qa_count: column
      Production - pi_leo_fte_zd_qa_scores.qa_count: column
      pi_leo_fte_zd_qa_scores.qa_count: column
    series_colors:
      International - pi_leo_fte_zd_qa_scores.qa_count: "#4276BE"
      Production - pi_leo_fte_zd_qa_scores.qa_count: "#E57947"
      Production - pi_leo_fte_zd_qa_scores._score: "#E57947"
    reference_lines: [{reference_type: line, line_value: ".98", range_start: max,
        range_end: min, margin_top: deviation, margin_value: mean, margin_bottom: deviation,
        label_position: center, color: "#000000", label: Goal (98%)}]
    discontinuous_nulls: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      Agent Email: pi_leo_fte_zd_qa_scores.qa_recipient
    row: 141
    col: 0
    width: 12
    height: 9
  - title: Preservations (Proactive QA)
    name: Preservations (Proactive QA)
    model: lk2_platform_integrity_standard
    explore: pi_leo_fte_zd_qa_scores
    type: looker_line
    fields: [pi_leo_fte_zd_qa_scores.action_date_week, pi_leo_fte_zd_qa_scores._score,
      pi_leo_fte_zd_qa_scores.qa_count]
    fill_fields: [pi_leo_fte_zd_qa_scores.action_date_week]
    filters:
      pi_leo_fte_zd_qa_scores.qa_process_type: Preservation
      pi_leo_fte_zd_qa_scores.action_date_date: 13 weeks
    sorts: [pi_leo_fte_zd_qa_scores.action_date_week desc]
    limit: 500
    column_limit: 50
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
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    color_application:
      collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
      palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
      options:
        steps: 5
        reverse: false
    y_axes: [{label: '', orientation: left, series: [{axisId: pi_leo_fte_zd_qa_scores._score,
            id: pi_leo_fte_zd_qa_scores._score, name: " Score"}], showLabels: true,
        showValues: true, maxValue: 1, unpinAxis: true, tickDensity: default, type: linear},
      {label: '', orientation: right, series: [{axisId: pi_leo_fte_zd_qa_scores.qa_count,
            id: pi_leo_fte_zd_qa_scores.qa_count, name: QA Count}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: linear}]
    series_types:
      International - pi_leo_fte_zd_qa_scores.qa_count: column
      Production - pi_leo_fte_zd_qa_scores.qa_count: column
      pi_leo_fte_zd_qa_scores.qa_count: column
    series_colors:
      International - pi_leo_fte_zd_qa_scores.qa_count: "#4276BE"
      Production - pi_leo_fte_zd_qa_scores.qa_count: "#E57947"
      Production - pi_leo_fte_zd_qa_scores._score: "#E57947"
    reference_lines: [{reference_type: line, line_value: ".98", range_start: max,
        range_end: min, margin_top: deviation, margin_value: mean, margin_bottom: deviation,
        label_position: center, color: "#000000", label: Goal (98%)}]
    discontinuous_nulls: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      Agent Email: pi_leo_fte_zd_qa_scores.qa_recipient
    row: 132
    col: 0
    width: 12
    height: 9
  - title: Triaging/Classification
    name: Triaging/Classification
    model: lk2_platform_integrity_standard
    explore: pi_leo_fte_zd_qa_scores
    type: looker_line
    fields: [pi_leo_fte_zd_qa_scores.action_date_week, pi_leo_fte_zd_qa_scores._score,
      pi_leo_fte_zd_qa_scores.qa_count]
    fill_fields: [pi_leo_fte_zd_qa_scores.action_date_week]
    filters:
      pi_leo_fte_zd_qa_scores.qa_process_type: Triaging & Classification
      pi_leo_fte_zd_qa_scores.action_date_date: 13 weeks
    sorts: [pi_leo_fte_zd_qa_scores.action_date_week desc]
    limit: 500
    column_limit: 50
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
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    color_application:
      collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
      palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
      options:
        steps: 5
        reverse: false
    y_axes: [{label: '', orientation: left, series: [{axisId: pi_leo_fte_zd_qa_scores._score,
            id: pi_leo_fte_zd_qa_scores._score, name: " Score"}], showLabels: true,
        showValues: true, maxValue: 1, unpinAxis: true, tickDensity: default, type: linear},
      {label: '', orientation: right, series: [{axisId: pi_leo_fte_zd_qa_scores.qa_count,
            id: pi_leo_fte_zd_qa_scores.qa_count, name: QA Count}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: linear}]
    series_types:
      International - pi_leo_fte_zd_qa_scores.qa_count: column
      Production - pi_leo_fte_zd_qa_scores.qa_count: column
      pi_leo_fte_zd_qa_scores.qa_count: column
    series_colors:
      International - pi_leo_fte_zd_qa_scores.qa_count: "#4276BE"
      Production - pi_leo_fte_zd_qa_scores.qa_count: "#E57947"
      Production - pi_leo_fte_zd_qa_scores._score: "#E57947"
    reference_lines: [{reference_type: line, line_value: ".98", range_start: max,
        range_end: min, margin_top: deviation, margin_value: mean, margin_bottom: deviation,
        label_position: center, color: "#000000", label: Goal (98%)}]
    discontinuous_nulls: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      Agent Email: pi_leo_fte_zd_qa_scores.qa_recipient
    row: 177
    col: 0
    width: 12
    height: 9
  - title: User Notice (Proactive QA)
    name: User Notice (Proactive QA)
    model: lk2_platform_integrity_standard
    explore: pi_leo_fte_zd_qa_scores
    type: looker_line
    fields: [pi_leo_fte_zd_qa_scores.action_date_week, pi_leo_fte_zd_qa_scores._score,
      pi_leo_fte_zd_qa_scores.qa_count]
    fill_fields: [pi_leo_fte_zd_qa_scores.action_date_week]
    filters:
      pi_leo_fte_zd_qa_scores.qa_process_type: UN
      pi_leo_fte_zd_qa_scores.action_date_date: 13 weeks
      pi_leo_fte_zd_qa_scores.certified_qa_recipient: 'No'
    sorts: [pi_leo_fte_zd_qa_scores.action_date_week desc]
    limit: 500
    column_limit: 50
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
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    color_application:
      collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
      palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
      options:
        steps: 5
        reverse: false
    y_axes: [{label: '', orientation: left, series: [{axisId: pi_leo_fte_zd_qa_scores._score,
            id: pi_leo_fte_zd_qa_scores._score, name: " Score"}], showLabels: true,
        showValues: true, maxValue: 1, unpinAxis: true, tickDensity: default, type: linear},
      {label: '', orientation: right, series: [{axisId: pi_leo_fte_zd_qa_scores.qa_count,
            id: pi_leo_fte_zd_qa_scores.qa_count, name: QA Count}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: linear}]
    series_types:
      International - pi_leo_fte_zd_qa_scores.qa_count: column
      Production - pi_leo_fte_zd_qa_scores.qa_count: column
      pi_leo_fte_zd_qa_scores.qa_count: column
    series_colors:
      International - pi_leo_fte_zd_qa_scores.qa_count: "#4276BE"
      Production - pi_leo_fte_zd_qa_scores.qa_count: "#E57947"
      Production - pi_leo_fte_zd_qa_scores._score: "#E57947"
    reference_lines: [{reference_type: line, line_value: ".98", range_start: max,
        range_end: min, margin_top: deviation, margin_value: mean, margin_bottom: deviation,
        label_position: center, color: "#000000", label: Goal (98%)}]
    discontinuous_nulls: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      Agent Email: pi_leo_fte_zd_qa_scores.qa_recipient
    row: 168
    col: 0
    width: 12
    height: 9
  - title: PRTT/WT
    name: PRTT/WT
    model: lk2_platform_integrity_standard
    explore: pi_leo_fte_zd_qa_scores
    type: looker_line
    fields: [pi_leo_fte_zd_qa_scores.action_date_week, pi_leo_fte_zd_qa_scores._score,
      pi_leo_fte_zd_qa_scores.qa_count]
    fill_fields: [pi_leo_fte_zd_qa_scores.action_date_week]
    filters:
      pi_leo_fte_zd_qa_scores.qa_process_type: PRTT & WT
      pi_leo_fte_zd_qa_scores.action_date_date: 13 weeks
    sorts: [pi_leo_fte_zd_qa_scores.action_date_week desc]
    limit: 500
    column_limit: 50
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
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    color_application:
      collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
      palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
      options:
        steps: 5
        reverse: false
    y_axes: [{label: '', orientation: left, series: [{axisId: pi_leo_fte_zd_qa_scores._score,
            id: pi_leo_fte_zd_qa_scores._score, name: " Score"}], showLabels: true,
        showValues: true, maxValue: 1, unpinAxis: true, tickDensity: default, type: linear},
      {label: '', orientation: right, series: [{axisId: pi_leo_fte_zd_qa_scores.qa_count,
            id: pi_leo_fte_zd_qa_scores.qa_count, name: QA Count}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: linear}]
    series_types:
      International - pi_leo_fte_zd_qa_scores.qa_count: column
      Production - pi_leo_fte_zd_qa_scores.qa_count: column
      pi_leo_fte_zd_qa_scores.qa_count: column
    series_colors:
      International - pi_leo_fte_zd_qa_scores.qa_count: "#4276BE"
      Production - pi_leo_fte_zd_qa_scores.qa_count: "#E57947"
      Production - pi_leo_fte_zd_qa_scores._score: "#E57947"
    reference_lines: [{reference_type: line, line_value: ".98", range_start: max,
        range_end: min, margin_top: deviation, margin_value: mean, margin_bottom: deviation,
        label_position: center, color: "#000000", label: Goal (98%)}]
    discontinuous_nulls: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      Agent Email: pi_leo_fte_zd_qa_scores.qa_recipient
    row: 177
    col: 12
    width: 12
    height: 9
  - title: Unsolved Tickets per Workflow
    name: Unsolved Tickets per Workflow
    model: lk2_community_ops_legacy
    explore: zendesk_ticket
    type: looker_grid
    fields: [zendesk_ticket.count_tickets, zendesk_ticket.status, zendesk_ticket.leo_contact_reason_grouped]
    pivots: [zendesk_ticket.status]
    filters:
      zendesk_ticket.status: "-solved,-closed,-deleted"
      zendesk_ticket.leo_contact_reason_grouped: "-EMPTY,-NULL"
    sorts: [zendesk_ticket.count_tickets desc 0, zendesk_ticket.status]
    limit: 500
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: true
    color_application:
      collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
      palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_cell_visualizations:
      zendesk_ticket.count_tickets:
        is_active: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#4276BE",
        font_color: !!null '', color_application: {collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b,
          palette_id: 0fb6d761-0476-4a6d-987f-15f890984d47, options: {steps: 5}},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
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
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    listen:
      Agent Email: zendesk_agent.email
    row: 123
    col: 6
    width: 12
    height: 7
  - name: Total Complexity Weighted Productivity (Comparison to Level) [L13 Weeks]
    title: Total Complexity Weighted Productivity (Comparison to Level) [L13 Weeks]
    merged_queries:
    - model: lk2_community_ops_legacy
      explore: zendesk_ticket
      type: looker_column
      fields: [zendesk_ticket.count_tickets, zendesk_ticket_metric_sets.solved_at_utc_week,
        zendesk_ticket.leo_contact_reason_weighted_prod, zendesk_ticket.leo_identifiers_weighted_prod,
        zendesk_ticket.leo_legal_process_weighted_prod]
      fill_fields: [zendesk_ticket_metric_sets.solved_at_utc_week]
      filters:
        zendesk_ticket.leo_contact_reason: "-EMPTY,-NULL"
        zendesk_ticket_metric_sets.solved_at_utc_date: 13 weeks
        zendesk_ticket.tag: "-%le^_summit^_invitation%"
      sorts: [zendesk_ticket_metric_sets.solved_at_utc_week desc]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: "${zendesk_ticket.leo_contact_reason_weighted_prod}+${zendesk_ticket.leo_identifiers_weighted_prod}+${zendesk_ticket.leo_legal_process_weighted_prod}"
        label: Total Complexity Productivity
        value_format:
        value_format_name: decimal_2
        _kind_hint: measure
        table_calculation: total_complexity_productivity
        _type_hint: number
      filter_expression: if(NOT(${zendesk_ticket.leo_contact_reason_grouped}="Imminent
        Customer Threat Escalation") AND contains(${zendesk_ticket.tag},"snap-internal"),no,yes)
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
      show_value_labels: true
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      color_application:
        collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
        palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
        options:
          steps: 5
      limit_displayed_rows_values:
        show_hide: hide
        first_last: last
        num_rows: '3'
      label_color: ["#173589", transparent]
      show_null_points: true
      interpolation: linear
      defaults_version: 1
      hidden_fields: [zendesk_ticket.count_tickets]
    - model: lk2_platform_integrity_standard
      explore: pi_leo_fte_zd_qa_scores
      type: table
      fields: [pi_leo_fte_zd_qa_scores.qa_date_week, pi_leo_fte_zd_qa_scores.qa_count,
        pi_leo_fte_zd_qa_scores.qa_weighted_prod]
      fill_fields: [pi_leo_fte_zd_qa_scores.qa_date_week]
      filters:
        pi_leo_fte_zd_qa_scores.zendesk_agent_tags_qa_reviewer: "-%enablement%,-%-nb%"
        pi_leo_fte_zd_qa_scores.qa_date_week: 13 weeks
        pi_leo_fte_zd_qa_scores.qa_process_type: "-NULL"
        pi_leo_fte_zd_qa_scores.qa_reviewer: "-%naomi%"
      sorts: [pi_leo_fte_zd_qa_scores.qa_date_week desc]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: pi_leo_fte_zd_qa_scores.qa_date_week
        source_field_name: zendesk_ticket_metric_sets.solved_at_utc_week
    - model: lk2_community_ops_legacy
      explore: zendesk_ticket
      type: table
      fields: [zendesk_ticket_metric_sets.solved_at_utc_week, zendesk_ticket.count_tickets,
        zendesk_agent.count_agents, zendesk_ticket.leo_contact_reason_weighted_prod,
        zendesk_ticket.leo_identifiers_weighted_prod, zendesk_ticket.leo_legal_process_weighted_prod]
      fill_fields: [zendesk_ticket_metric_sets.solved_at_utc_week]
      filters:
        zendesk_ticket.leo_contact_reason: "-EMPTY,-NULL"
        zendesk_ticket_metric_sets.solved_at_utc_date: 13 weeks
        zendesk_ticket.tag: "-%le^_summit^_invitation%"
      sorts: [zendesk_ticket_metric_sets.solved_at_utc_week desc]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: "${zendesk_ticket.count_tickets}/${zendesk_agent.count_agents}"
        label: Avg. Tickets Solved per Agent
        value_format:
        value_format_name: decimal_1
        _kind_hint: measure
        table_calculation: avg_tickets_solved_per_agent
        _type_hint: number
      - category: table_calculation
        expression: "(${zendesk_ticket.leo_contact_reason_weighted_prod}+${zendesk_ticket.leo_identifiers_weighted_prod}+${zendesk_ticket.leo_legal_process_weighted_prod})/${zendesk_agent.count_agents}"
        label: Avg. Complexity per Agent
        value_format:
        value_format_name: decimal_1
        _kind_hint: measure
        table_calculation: avg_complexity_per_agent
        _type_hint: number
      filter_expression: if(NOT(${zendesk_ticket.leo_contact_reason_grouped}="Imminent
        Customer Threat Escalation") AND contains(${zendesk_ticket.tag},"snap-internal"),no,yes)
      join_fields:
      - field_name: zendesk_ticket_metric_sets.solved_at_utc_week
        source_field_name: zendesk_ticket_metric_sets.solved_at_utc_week
    - model: lk2_platform_integrity_standard
      explore: pi_leo_fte_zd_qa_scores
      type: table
      fields: [pi_leo_fte_zd_qa_scores.qa_date_week, pi_leo_fte_zd_qa_scores.qa_count,
        pi_leo_fte_zd_qa_scores.count_unique_qa_reviewer, pi_leo_fte_zd_qa_scores.qa_weighted_prod]
      fill_fields: [pi_leo_fte_zd_qa_scores.qa_date_week]
      filters:
        pi_leo_fte_zd_qa_scores.qa_process_type: "-EMPTY,-NULL"
        pi_leo_fte_zd_qa_scores.qa_date_date: 13 weeks
        pi_leo_fte_zd_qa_scores.qa_reviewer: "-%naomi%"
        pi_leo_fte_zd_qa_scores.zendesk_agent_tags_qa_reviewer: "-%enablement%,-%-nb%"
      sorts: [pi_leo_fte_zd_qa_scores.qa_date_week desc]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: "${pi_leo_fte_zd_qa_scores.qa_count}/${pi_leo_fte_zd_qa_scores.count_unique_qa_reviewer}"
        label: Avg. QA'd Tickets per Agent
        value_format:
        value_format_name: decimal_1
        _kind_hint: measure
        table_calculation: avg_qad_tickets_per_agent
        _type_hint: number
      - category: table_calculation
        expression: "${pi_leo_fte_zd_qa_scores.qa_weighted_prod}/${pi_leo_fte_zd_qa_scores.count_unique_qa_reviewer}"
        label: Avg. QA Complexity per Agent
        value_format:
        value_format_name: decimal_1
        _kind_hint: measure
        table_calculation: avg_qa_complexity_per_agent
        _type_hint: number
      join_fields:
      - field_name: pi_leo_fte_zd_qa_scores.qa_date_week
        source_field_name: zendesk_ticket_metric_sets.solved_at_utc_week
    color_application:
      collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
      palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
      options:
        steps: 5
        reverse: false
      collection_default: false
      collection_label: Lighthouse
      palette_label: Categorical
      palette_type: Categorical
      palette_colors:
      - "#4276BE"
      - "#3FB0D5"
      - "#E57947"
      - "#FFD95F"
      - "#B42F37"
      - "#6A013A"
      - "#7363A9"
      - "#44759A"
      - "#FBB556"
      - "#D5C679"
      - "#9ED7D7"
      - "#D59E79"
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Solved at Week
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    font_size: ''
    series_types: {}
    point_style: none
    series_colors:
      avg_qad_tickets_per_agent: "#E57947"
      avg_tickets_solved_per_agent: "#3FB0D5"
      zendesk_ticket.count_tickets: "#3FB0D5"
      pi_leo_fte_zd_qa_scores.qa_count: "#E57947"
      avg_solved_qad_tickets: "#3FB0D5"
      agent_complexity_productivity: "#E57947"
      avg_complexity_productivity_per_agent: "#FBB556"
    series_labels:
      zendesk_ticket.count_tickets: Solved Tickets
      pi_leo_fte_zd_qa_scores.qa_count: QA'd Tickets
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    x_axis_datetime_label: "%b %d"
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#4276BE"
    hidden_fields: [q2_zendesk_ticket.count_tickets, zendesk_agent.count_agents, avg_tickets_solved_per_agent,
      q3_pi_leo_fte_zd_qa_scores.qa_count, pi_leo_fte_zd_qa_scores.count_unique_qa_reviewer,
      avg_qad_tickets_per_agent, zendesk_ticket.count_tickets, pi_leo_fte_zd_qa_scores.qa_count,
      zendesk_ticket.leo_contact_reason_weighted_prod, zendesk_ticket.leo_identifiers_weighted_prod,
      zendesk_ticket.leo_legal_process_weighted_prod, avg_complexity_per_agent, pi_leo_fte_zd_qa_scores.qa_weighted_prod,
      avg_qa_complexity_per_agent, q2_zendesk_ticket.leo_contact_reason_weighted_prod,
      q2_zendesk_ticket.leo_identifiers_weighted_prod, q2_zendesk_ticket.leo_legal_process_weighted_prod,
      q3_pi_leo_fte_zd_qa_scores.qa_weighted_prod, total_complexity_productivity]
    type: looker_line
    sorts: [zendesk_ticket_metric_sets.solved_at_utc_week]
    dynamic_fields:
    - category: table_calculation
      expression: coalesce(${zendesk_ticket.count_tickets},0)+coalesce(${pi_leo_fte_zd_qa_scores.qa_count},0)
      label: Agent Solved + QA'd Tickets
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: agent_solved_qad_tickets
      _type_hint: number
    - category: table_calculation
      expression: coalesce(${avg_tickets_solved_per_agent},0)+coalesce(${avg_qad_tickets_per_agent},0)
      label: Avg. Solved + QA'd Tickets
      value_format:
      value_format_name: decimal_1
      _kind_hint: measure
      table_calculation: avg_solved_qad_tickets
      _type_hint: number
    - category: table_calculation
      expression: coalesce(${zendesk_ticket.leo_contact_reason_weighted_prod},0)+coalesce(${zendesk_ticket.leo_identifiers_weighted_prod},0)+coalesce(${zendesk_ticket.leo_legal_process_weighted_prod},0)+coalesce(${pi_leo_fte_zd_qa_scores.qa_weighted_prod},0)
      label: Agent Complexity Productivity
      value_format:
      value_format_name: decimal_1
      _kind_hint: measure
      table_calculation: agent_complexity_productivity
      _type_hint: number
    - category: table_calculation
      expression: coalesce(${avg_complexity_per_agent},0)+coalesce(${avg_qa_complexity_per_agent},0)
      label: Avg. Complexity Productivity per Agent
      value_format:
      value_format_name: decimal_1
      _kind_hint: measure
      table_calculation: avg_complexity_productivity_per_agent
      _type_hint: number
    listen:
    - Productivity Solved Contact Reason: zendesk_ticket.leo_contact_reason_grouped
      Date Filter: zendesk_ticket_metric_sets.solved_at_date
      Agent Email: zendesk_agent.email
    - Date Filter: pi_leo_fte_zd_qa_scores.qa_date_date
      Productivity QA LP Type: pi_leo_fte_zd_qa_scores.lp_type
      Productivity QA Contact Reason: pi_leo_fte_zd_qa_scores.qa_process_type
      Agent Email: pi_leo_fte_zd_qa_scores.qa_reviewer
    - Productivity Solved Contact Reason: zendesk_ticket.leo_contact_reason_grouped
      Date Filter: zendesk_ticket_metric_sets.solved_at_date
      Agent Tags: zendesk_agent.tags
      LEO Level: zendesk_agent.leo_level
    - Date Filter: pi_leo_fte_zd_qa_scores.qa_date_date
      Agent Tags: pi_leo_fte_zd_qa_scores.zendesk_agent_tags_qa_reviewer
      LEO Level: pi_leo_fte_zd_qa_scores.zendesk_agent_leo_level_reviewer
      Productivity QA LP Type: pi_leo_fte_zd_qa_scores.lp_type
      Productivity QA Contact Reason: pi_leo_fte_zd_qa_scores.qa_process_type
    row: 2
    col: 12
    width: 12
    height: 11
  - name: Individual's Unsolved Counts
    type: text
    title_text: Individual's Unsolved Counts
    subtitle_text: ''
    body_text: ''
    row: 121
    col: 6
    width: 12
    height: 2
  - name: Solved + QA'd Tickets (Individual) [Last Complete Week]
    title: Solved + QA'd Tickets (Individual) [Last Complete Week]
    merged_queries:
    - model: lk2_community_ops_legacy
      explore: zendesk_ticket
      type: looker_column
      fields: [zendesk_ticket.count_tickets, zendesk_ticket.leo_contact_reason_grouped]
      filters:
        zendesk_ticket.leo_contact_reason: "-EMPTY,-NULL"
        zendesk_ticket_metric_sets.solved_at_utc_date: 1 weeks ago for 1 weeks
      sorts: [zendesk_ticket.count_tickets desc]
      limit: 500
      column_limit: 50
      total: true
      filter_expression: if(NOT(${zendesk_ticket.leo_contact_reason_grouped})="Imminent
        Customer Threat Escalation" AND contains(${zendesk_ticket.tag},"snap-internal"),no,yes)
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
      show_value_labels: true
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      color_application:
        collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
        palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
        options:
          steps: 5
      limit_displayed_rows_values:
        show_hide: hide
        first_last: last
        num_rows: '3'
      label_color: ["#173589", transparent]
      show_null_points: true
      interpolation: linear
      defaults_version: 1
      hidden_fields:
    - model: lk2_platform_integrity_standard
      explore: pi_leo_fte_zd_qa_scores
      type: table
      fields: [pi_leo_fte_zd_qa_scores.qa_count, qa_contact_reason_grouped]
      filters:
        pi_leo_fte_zd_qa_scores.zendesk_agent_tags_qa_reviewer: "-%enablement%,-%-nb%"
        pi_leo_fte_zd_qa_scores.qa_date_week: 1 weeks ago for 1 weeks
        pi_leo_fte_zd_qa_scores.qa_process_type: "-NULL"
        pi_leo_fte_zd_qa_scores.qa_reviewer: "-%naomi%"
      sorts: [pi_leo_fte_zd_qa_scores.qa_count desc]
      limit: 500
      total: true
      dynamic_fields:
      - category: dimension
        expression: if(${pi_leo_fte_zd_qa_scores.qa_process_type}="Production",${pi_leo_fte_zd_qa_scores.lp_type},${pi_leo_fte_zd_qa_scores.qa_process_type})
        label: QA Workflow
        value_format:
        value_format_name:
        dimension: qa_workflow
        _kind_hint: dimension
        _type_hint: string
      - category: dimension
        expression: if(${qa_workflow}="SW" OR ${qa_workflow}="CO","SW/CO",if(${qa_workflow}="Subpoena","Subpoena
          / Summons",if(${qa_workflow}="UN","User Notice",if(${qa_workflow}="PRTT
          & WT","PRTT / WT",${qa_workflow}))))
        label: QA Contact Reason Grouped
        value_format:
        value_format_name:
        dimension: qa_contact_reason_grouped
        _kind_hint: dimension
        _type_hint: string
      join_fields:
      - field_name: qa_contact_reason_grouped
        source_field_name: zendesk_ticket.leo_contact_reason_grouped
    color_application:
      collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
      palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
      options:
        steps: 5
        reverse: false
      collection_default: false
      collection_label: Lighthouse
      palette_label: Categorical
      palette_type: Categorical
      palette_colors:
      - "#4276BE"
      - "#3FB0D5"
      - "#E57947"
      - "#FFD95F"
      - "#B42F37"
      - "#6A013A"
      - "#7363A9"
      - "#44759A"
      - "#FBB556"
      - "#D5C679"
      - "#9ED7D7"
      - "#D59E79"
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    size_to_fit: true
    series_labels:
      zendesk_ticket.count_tickets: Solved Tickets
      pi_leo_fte_zd_qa_scores.qa_count: QA'd Tickets
    series_cell_visualizations:
      zendesk_ticket.count_tickets:
        is_active: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b,
          palette_id: 0fb6d761-0476-4a6d-987f-15f890984d47, options: {steps: 5}},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Solved at Week
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    legend_position: center
    font_size: 85%
    series_types: {}
    point_style: none
    series_colors:
      avg_qad_tickets_per_agent: "#E57947"
      avg_tickets_solved_per_agent: "#3FB0D5"
      pi_leo_fte_zd_qa_scores.qa_count: "#E57947"
      zendesk_ticket.count_tickets: "#3FB0D5"
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields:
    type: looker_grid
    sorts: [zendesk_ticket.leo_contact_reason_grouped]
    total: true
    listen:
    - Productivity Solved Contact Reason: zendesk_ticket.leo_contact_reason_grouped
      Date Filter: zendesk_ticket_metric_sets.solved_at_date
      Agent Email: zendesk_agent.email
    - Date Filter: pi_leo_fte_zd_qa_scores.qa_date_date
      Productivity QA LP Type: pi_leo_fte_zd_qa_scores.lp_type
      Productivity QA Contact Reason: pi_leo_fte_zd_qa_scores.qa_process_type
      Agent Email: pi_leo_fte_zd_qa_scores.qa_reviewer
    row: 46
    col: 0
    width: 12
    height: 9
  - name: Solved + QA'd Tickets (Individual) [Last Complete Month]
    title: Solved + QA'd Tickets (Individual) [Last Complete Month]
    merged_queries:
    - model: lk2_community_ops_legacy
      explore: zendesk_ticket
      type: looker_column
      fields: [zendesk_ticket.count_tickets, zendesk_ticket.leo_contact_reason_grouped]
      filters:
        zendesk_ticket.leo_contact_reason: "-EMPTY,-NULL"
        zendesk_ticket_metric_sets.solved_at_utc_date: 1 months ago for 1 months
      sorts: [zendesk_ticket.count_tickets desc]
      limit: 500
      column_limit: 50
      total: true
      filter_expression: if(NOT(${zendesk_ticket.leo_contact_reason_grouped})="Imminent
        Customer Thread Escalation" AND contains(${zendesk_ticket.tag},"snap-internal"),no,yes)
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
      show_value_labels: true
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      color_application:
        collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
        palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
        options:
          steps: 5
      limit_displayed_rows_values:
        show_hide: hide
        first_last: last
        num_rows: '3'
      label_color: ["#173589", transparent]
      show_null_points: true
      interpolation: linear
      defaults_version: 1
      hidden_fields:
    - model: lk2_platform_integrity_standard
      explore: pi_leo_fte_zd_qa_scores
      type: table
      fields: [pi_leo_fte_zd_qa_scores.qa_count, qa_contact_reason_grouped]
      filters:
        pi_leo_fte_zd_qa_scores.qa_date_week: 1 months ago for 1 months
        pi_leo_fte_zd_qa_scores.qa_process_type: "-NULL"
        pi_leo_fte_zd_qa_scores.qa_reviewer: "-%naomi%"
      sorts: [pi_leo_fte_zd_qa_scores.qa_count desc]
      limit: 500
      total: true
      dynamic_fields:
      - category: dimension
        expression: if(${pi_leo_fte_zd_qa_scores.qa_process_type}="Production",${pi_leo_fte_zd_qa_scores.lp_type},${pi_leo_fte_zd_qa_scores.qa_process_type})
        label: QA Workflow
        value_format:
        value_format_name:
        dimension: qa_workflow
        _kind_hint: dimension
        _type_hint: string
      - category: dimension
        expression: if(${qa_workflow}="SW" OR ${qa_workflow}="CO","SW/CO",if(${qa_workflow}="Subpoena","Subpoena
          / Summons",if(${qa_workflow}="UN","User Notice",if(${qa_workflow}="PRTT
          & WT","PRTT / WT",${qa_workflow}))))
        label: QA Contact Reason Grouped
        value_format:
        value_format_name:
        dimension: qa_contact_reason_grouped
        _kind_hint: dimension
        _type_hint: string
      join_fields:
      - field_name: qa_contact_reason_grouped
        source_field_name: zendesk_ticket.leo_contact_reason_grouped
    color_application:
      collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
      palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
      options:
        steps: 5
        reverse: false
      collection_default: false
      collection_label: Lighthouse
      palette_label: Categorical
      palette_type: Categorical
      palette_colors:
      - "#4276BE"
      - "#3FB0D5"
      - "#E57947"
      - "#FFD95F"
      - "#B42F37"
      - "#6A013A"
      - "#7363A9"
      - "#44759A"
      - "#FBB556"
      - "#D5C679"
      - "#9ED7D7"
      - "#D59E79"
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    series_labels:
      zendesk_ticket.count_tickets: Solved Tickets
      pi_leo_fte_zd_qa_scores.qa_count: QA'd Tickets
    series_cell_visualizations:
      zendesk_ticket.count_tickets:
        is_active: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b,
          palette_id: 0fb6d761-0476-4a6d-987f-15f890984d47, options: {steps: 5}},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Solved at Week
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    legend_position: center
    font_size: 85%
    series_types: {}
    point_style: none
    series_colors:
      avg_qad_tickets_per_agent: "#E57947"
      avg_tickets_solved_per_agent: "#3FB0D5"
      pi_leo_fte_zd_qa_scores.qa_count: "#E57947"
      zendesk_ticket.count_tickets: "#3FB0D5"
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields:
    type: looker_grid
    sorts: [zendesk_ticket.leo_contact_reason_grouped]
    total: true
    listen:
    - Productivity Solved Contact Reason: zendesk_ticket.leo_contact_reason_grouped
      Date Filter: zendesk_ticket_metric_sets.solved_at_date
      Agent Email: zendesk_agent.email
    - Date Filter: pi_leo_fte_zd_qa_scores.qa_date_date
      Productivity QA LP Type: pi_leo_fte_zd_qa_scores.lp_type
      Productivity QA Contact Reason: pi_leo_fte_zd_qa_scores.qa_process_type
      Agent Email: pi_leo_fte_zd_qa_scores.qa_reviewer
    row: 57
    col: 12
    width: 12
    height: 9
  - name: Actioned + QA'd Tickets (Individual) [L13 Months]
    title: Actioned + QA'd Tickets (Individual) [L13 Months]
    merged_queries:
    - model: lk2_community_ops_legacy
      explore: zendesk_ticket
      type: looker_column
      fields: [zendesk_ticket.count_tickets, zendesk_ticket_metric_sets.solved_at_utc_month]
      fill_fields: [zendesk_ticket_metric_sets.solved_at_utc_month]
      filters:
        zendesk_ticket.leo_contact_reason: "-EMPTY,-NULL"
        zendesk_ticket_metric_sets.solved_at_utc_date: 13 months
      sorts: [zendesk_ticket_metric_sets.solved_at_utc_month desc]
      limit: 500
      column_limit: 50
      filter_expression: if(NOT(${zendesk_ticket.leo_contact_reason_grouped}="Imminent
        Customer Threat Escalation") AND contains(${zendesk_ticket.tag},"snap-internal"),no,yes)
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
      show_value_labels: true
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      color_application:
        collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
        palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
        options:
          steps: 5
      limit_displayed_rows_values:
        show_hide: hide
        first_last: last
        num_rows: '3'
      label_color: ["#173589", transparent]
      show_null_points: true
      interpolation: linear
      defaults_version: 1
      hidden_fields:
    - model: lk2_platform_integrity_standard
      explore: pi_leo_fte_zd_qa_scores
      type: table
      fields: [pi_leo_fte_zd_qa_scores.qa_count, pi_leo_fte_zd_qa_scores.qa_date_month]
      fill_fields: [pi_leo_fte_zd_qa_scores.qa_date_month]
      filters:
        pi_leo_fte_zd_qa_scores.zendesk_agent_tags_qa_reviewer: "-%enablement%,-%-nb%"
        pi_leo_fte_zd_qa_scores.qa_date_week: 13 months
        pi_leo_fte_zd_qa_scores.qa_process_type: "-NULL"
        pi_leo_fte_zd_qa_scores.qa_reviewer: "-%naomi%"
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: pi_leo_fte_zd_qa_scores.qa_date_month
        source_field_name: zendesk_ticket_metric_sets.solved_at_utc_month
    - model: lk2_platform_integrity_legacy
      explore: maestroqa_rubric_answers
      type: table
      fields: [maestroqa_answers.created_month, maestroqa_answers.count]
      fill_fields: [maestroqa_answers.created_month]
      filters:
        maestroqa_templates.name: "%Preservation%,%Reporting%,%SW/CO%,%Subpoena%,%International%,%User\
          \ Notice%,%UN%,%EDR%"
        maestroqa_answers.created_date: 13 months
      sorts: [maestroqa_answers.created_month desc]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: maestroqa_answers.created_month
        source_field_name: zendesk_ticket_metric_sets.solved_at_utc_month
    - model: lk2_community_ops_legacy
      explore: zendesk_ticket_events
      type: table
      fields: [zendesk_ticket_events.updated_at_month, classification_actions, triaging_actions]
      fill_fields: [zendesk_ticket_events.updated_at_month]
      filters:
        zendesk_ticket_events.partition_filter: 13 months
        zendesk_ticket.leo_contact_reason_grouped: "-EMPTY,-NULL"
        zendesk_ticket.tag: "-%snap-internal%"
      sorts: [zendesk_ticket_events.updated_at_month desc]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: measure
        expression:
        label: Classification Actions
        value_format:
        value_format_name:
        based_on: zendesk_ticket_events.count_ticket
        _kind_hint: measure
        measure: classification_actions
        type: count_distinct
        _type_hint: number
        filters:
          zendesk_ticket_events.added_tags: "%leo-case-status-classified%,%leo-case-status-bc-classified%"
      - category: measure
        expression:
        label: Triaging Actions
        value_format:
        value_format_name:
        based_on: zendesk_ticket_events.count_ticket
        _kind_hint: measure
        measure: triaging_actions
        type: count_distinct
        _type_hint: number
        filters:
          zendesk_ticket_events.added_tags: "%leo-case-status-triaged%,%leo-case-status-ba-triaged%"
      join_fields:
      - field_name: zendesk_ticket_events.updated_at_month
        source_field_name: zendesk_ticket_metric_sets.solved_at_utc_month
    color_application:
      collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
      palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
      options:
        steps: 5
        reverse: false
      collection_default: false
      collection_label: Lighthouse
      palette_label: Categorical
      palette_type: Categorical
      palette_colors:
      - "#4276BE"
      - "#3FB0D5"
      - "#E57947"
      - "#FFD95F"
      - "#B42F37"
      - "#6A013A"
      - "#7363A9"
      - "#44759A"
      - "#FBB556"
      - "#D5C679"
      - "#9ED7D7"
      - "#D59E79"
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Solved at Month
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    x_axis_zoom: true
    y_axis_zoom: true
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    font_size: 85%
    series_types:
      3_week_rolling_average: line
      3_month_rolling_average: line
    point_style: none
    series_colors:
      avg_qad_tickets_per_agent: "#E57947"
      avg_tickets_solved_per_agent: "#3FB0D5"
      pi_leo_fte_zd_qa_scores.qa_count: "#E57947"
      zendesk_ticket.count_tickets: "#3FB0D5"
      3_week_rolling_average: "#B42F37"
      3_month_rolling_average: "#B42F37"
      qa_count: "#E57947"
      classification_actions: "#FFD95F"
      triaging_actions: "#FBB556"
      classification_triaging_count: "#FFD95F"
    series_labels:
      zendesk_ticket.count_tickets: Solved Tickets
      pi_leo_fte_zd_qa_scores.qa_count: QA'd Tickets
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [total_solved_qa_count, pi_leo_fte_zd_qa_scores.qa_count, maestroqa_answers.count,
      total_actioned_qa_count, classification_actions, triaging_actions]
    type: looker_column
    dynamic_fields:
    - category: table_calculation
      expression: coalesce(${maestroqa_answers.count},0)+coalesce(${pi_leo_fte_zd_qa_scores.qa_count},0)
      label: QA Count
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: qa_count
      _type_hint: number
    - category: table_calculation
      expression: coalesce(${classification_actions},0)+coalesce(${triaging_actions},0)
      label: Classification + Triaging Count
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: classification_triaging_count
      _type_hint: number
    - category: table_calculation
      expression: coalesce(${zendesk_ticket.count_tickets},0)+coalesce(${pi_leo_fte_zd_qa_scores.qa_count},0)+coalesce(${maestroqa_answers.count},0)+coalesce(${classification_actions},0)+coalesce(${triaging_actions},0)
      label: Total Actioned + QA Count
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: total_actioned_qa_count
      _type_hint: number
    - category: table_calculation
      expression: mean(offset_list(${total_actioned_qa_count},0,3))
      label: 3-month Rolling Average
      value_format:
      value_format_name: decimal_1
      _kind_hint: measure
      table_calculation: 3_month_rolling_average
      _type_hint: number
    listen:
    - Productivity Solved Contact Reason: zendesk_ticket.leo_contact_reason_grouped
      Date Filter: zendesk_ticket_metric_sets.solved_at_date
      Agent Email: zendesk_agent.email
    - Date Filter: pi_leo_fte_zd_qa_scores.qa_date_date
      Productivity QA LP Type: pi_leo_fte_zd_qa_scores.lp_type
      Productivity QA Contact Reason: pi_leo_fte_zd_qa_scores.qa_process_type
      Agent Email: pi_leo_fte_zd_qa_scores.qa_reviewer
    - Agent Email: maestroqa_answers.qa_reviewer
    - Agent Email: zendesk_agent.email
    row: 13
    col: 0
    width: 12
    height: 11
  - name: Total Complexity Weighted Productivity (Comparison to Level) [L13 Months]
    title: Total Complexity Weighted Productivity (Comparison to Level) [L13 Months]
    merged_queries:
    - model: lk2_community_ops_legacy
      explore: zendesk_ticket
      type: looker_column
      fields: [zendesk_ticket.count_tickets, zendesk_ticket.leo_contact_reason_weighted_prod,
        zendesk_ticket.leo_identifiers_weighted_prod, zendesk_ticket.leo_legal_process_weighted_prod,
        zendesk_ticket_metric_sets.solved_at_utc_month]
      fill_fields: [zendesk_ticket_metric_sets.solved_at_utc_month]
      filters:
        zendesk_ticket.leo_contact_reason: "-EMPTY,-NULL"
        zendesk_ticket_metric_sets.solved_at_utc_date: 13 months
        zendesk_ticket.tag: "-%le^_summit^_invitation%"
      sorts: [zendesk_ticket_metric_sets.solved_at_utc_month desc]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: "${zendesk_ticket.leo_contact_reason_weighted_prod}+${zendesk_ticket.leo_identifiers_weighted_prod}+${zendesk_ticket.leo_legal_process_weighted_prod}"
        label: Total Complexity Productivity
        value_format:
        value_format_name: decimal_2
        _kind_hint: measure
        table_calculation: total_complexity_productivity
        _type_hint: number
      filter_expression: if(NOT(${zendesk_ticket.leo_contact_reason_grouped}="Imminent
        Customer Threat Escalation") AND contains(${zendesk_ticket.tag},"snap-internal"),no,yes)
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
      show_value_labels: true
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      color_application:
        collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
        palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
        options:
          steps: 5
      limit_displayed_rows_values:
        show_hide: hide
        first_last: last
        num_rows: '3'
      label_color: ["#173589", transparent]
      show_null_points: true
      interpolation: linear
      defaults_version: 1
      hidden_fields: [zendesk_ticket.count_tickets]
    - model: lk2_platform_integrity_standard
      explore: pi_leo_fte_zd_qa_scores
      type: table
      fields: [pi_leo_fte_zd_qa_scores.qa_count, pi_leo_fte_zd_qa_scores.qa_weighted_prod,
        pi_leo_fte_zd_qa_scores.qa_date_month]
      fill_fields: [pi_leo_fte_zd_qa_scores.qa_date_month]
      filters:
        pi_leo_fte_zd_qa_scores.qa_process_type: "-NULL"
        pi_leo_fte_zd_qa_scores.qa_reviewer: "-%naomi%"
        pi_leo_fte_zd_qa_scores.qa_date_date: 13 months
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: pi_leo_fte_zd_qa_scores.qa_date_month
        source_field_name: zendesk_ticket_metric_sets.solved_at_utc_month
    - model: lk2_community_ops_legacy
      explore: zendesk_ticket
      type: table
      fields: [zendesk_ticket.count_tickets, zendesk_agent.count_agents, zendesk_ticket.leo_contact_reason_weighted_prod,
        zendesk_ticket.leo_identifiers_weighted_prod, zendesk_ticket.leo_legal_process_weighted_prod,
        zendesk_ticket_metric_sets.solved_at_utc_month]
      fill_fields: [zendesk_ticket_metric_sets.solved_at_utc_month]
      filters:
        zendesk_ticket.leo_contact_reason: "-EMPTY,-NULL"
        zendesk_ticket_metric_sets.solved_at_utc_date: 13 months
        zendesk_ticket.tag: "-%le^_summit^_invitation%"
      sorts: [zendesk_ticket_metric_sets.solved_at_utc_month desc]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: "${zendesk_ticket.count_tickets}/${zendesk_agent.count_agents}"
        label: Avg. Tickets Solved per Agent
        value_format:
        value_format_name: decimal_1
        _kind_hint: measure
        table_calculation: avg_tickets_solved_per_agent
        _type_hint: number
      - category: table_calculation
        expression: "(${zendesk_ticket.leo_contact_reason_weighted_prod}+${zendesk_ticket.leo_identifiers_weighted_prod}+${zendesk_ticket.leo_legal_process_weighted_prod})/${zendesk_agent.count_agents}"
        label: Avg. Complexity per Agent
        value_format:
        value_format_name: decimal_1
        _kind_hint: measure
        table_calculation: avg_complexity_per_agent
        _type_hint: number
      filter_expression: if(NOT(${zendesk_ticket.leo_contact_reason_grouped}="Imminent
        Customer Threat Escalation") AND contains(${zendesk_ticket.tag},"snap-internal"),no,yes)
      join_fields:
      - field_name: zendesk_ticket_metric_sets.solved_at_utc_month
        source_field_name: zendesk_ticket_metric_sets.solved_at_utc_month
    - model: lk2_platform_integrity_standard
      explore: pi_leo_fte_zd_qa_scores
      type: table
      fields: [pi_leo_fte_zd_qa_scores.qa_count, pi_leo_fte_zd_qa_scores.count_unique_qa_reviewer,
        pi_leo_fte_zd_qa_scores.qa_weighted_prod, pi_leo_fte_zd_qa_scores.qa_date_month]
      fill_fields: [pi_leo_fte_zd_qa_scores.qa_date_month]
      filters:
        pi_leo_fte_zd_qa_scores.qa_process_type: "-EMPTY,-NULL"
        pi_leo_fte_zd_qa_scores.qa_date_date: 13 months
        pi_leo_fte_zd_qa_scores.qa_reviewer: "-%naomi%"
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: "${pi_leo_fte_zd_qa_scores.qa_count}/${pi_leo_fte_zd_qa_scores.count_unique_qa_reviewer}"
        label: Avg. QA'd Tickets per Agent
        value_format:
        value_format_name: decimal_1
        _kind_hint: measure
        table_calculation: avg_qad_tickets_per_agent
        _type_hint: number
      - category: table_calculation
        expression: "${pi_leo_fte_zd_qa_scores.qa_weighted_prod}/${pi_leo_fte_zd_qa_scores.count_unique_qa_reviewer}"
        label: Avg. QA Complexity per Agent
        value_format:
        value_format_name: decimal_1
        _kind_hint: measure
        table_calculation: avg_qa_complexity_per_agent
        _type_hint: number
      join_fields:
      - field_name: pi_leo_fte_zd_qa_scores.qa_date_month
        source_field_name: zendesk_ticket_metric_sets.solved_at_utc_month
    color_application:
      collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
      palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
      options:
        steps: 5
        reverse: false
      collection_default: false
      collection_label: Lighthouse
      palette_label: Categorical
      palette_type: Categorical
      palette_colors:
      - "#4276BE"
      - "#3FB0D5"
      - "#E57947"
      - "#FFD95F"
      - "#B42F37"
      - "#6A013A"
      - "#7363A9"
      - "#44759A"
      - "#FBB556"
      - "#D5C679"
      - "#9ED7D7"
      - "#D59E79"
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Solved at Month
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    font_size: ''
    series_types: {}
    point_style: none
    series_colors:
      avg_qad_tickets_per_agent: "#E57947"
      avg_tickets_solved_per_agent: "#3FB0D5"
      zendesk_ticket.count_tickets: "#3FB0D5"
      pi_leo_fte_zd_qa_scores.qa_count: "#E57947"
      avg_solved_qad_tickets: "#3FB0D5"
      agent_complexity_productivity: "#E57947"
      avg_complexity_productivity_per_agent: "#FBB556"
    series_labels:
      zendesk_ticket.count_tickets: Solved Tickets
      pi_leo_fte_zd_qa_scores.qa_count: QA'd Tickets
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    x_axis_datetime_label: ''
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#4276BE"
    hidden_fields: [q2_zendesk_ticket.count_tickets, zendesk_agent.count_agents, avg_tickets_solved_per_agent,
      q3_pi_leo_fte_zd_qa_scores.qa_count, pi_leo_fte_zd_qa_scores.count_unique_qa_reviewer,
      avg_qad_tickets_per_agent, zendesk_ticket.count_tickets, pi_leo_fte_zd_qa_scores.qa_count,
      zendesk_ticket.leo_contact_reason_weighted_prod, zendesk_ticket.leo_identifiers_weighted_prod,
      zendesk_ticket.leo_legal_process_weighted_prod, avg_complexity_per_agent, pi_leo_fte_zd_qa_scores.qa_weighted_prod,
      avg_qa_complexity_per_agent, q2_zendesk_ticket.leo_contact_reason_weighted_prod,
      q2_zendesk_ticket.leo_identifiers_weighted_prod, q2_zendesk_ticket.leo_legal_process_weighted_prod,
      q3_pi_leo_fte_zd_qa_scores.qa_weighted_prod, total_complexity_productivity]
    type: looker_line
    dynamic_fields:
    - category: table_calculation
      expression: coalesce(${zendesk_ticket.count_tickets},0)+coalesce(${pi_leo_fte_zd_qa_scores.qa_count},0)
      label: Agent Solved + QA'd Tickets
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: agent_solved_qad_tickets
      _type_hint: number
    - category: table_calculation
      expression: coalesce(${avg_tickets_solved_per_agent},0)+coalesce(${avg_qad_tickets_per_agent},0)
      label: Avg. Solved + QA'd Tickets
      value_format:
      value_format_name: decimal_1
      _kind_hint: measure
      table_calculation: avg_solved_qad_tickets
      _type_hint: number
    - category: table_calculation
      expression: coalesce(${total_complexity_productivity},0)+coalesce(${pi_leo_fte_zd_qa_scores.qa_weighted_prod},0)
      label: Agent Complexity Productivity
      value_format:
      value_format_name: decimal_1
      _kind_hint: measure
      table_calculation: agent_complexity_productivity
      _type_hint: number
    - category: table_calculation
      expression: coalesce(${avg_complexity_per_agent},0)+coalesce(${avg_qa_complexity_per_agent},0)
      label: Avg. Complexity Productivity per Agent
      value_format:
      value_format_name: decimal_1
      _kind_hint: measure
      table_calculation: avg_complexity_productivity_per_agent
      _type_hint: number
    listen:
    - Productivity Solved Contact Reason: zendesk_ticket.leo_contact_reason_grouped
      Date Filter: zendesk_ticket_metric_sets.solved_at_date
      Agent Email: zendesk_agent.email
    - Date Filter: pi_leo_fte_zd_qa_scores.qa_date_date
      Productivity QA LP Type: pi_leo_fte_zd_qa_scores.lp_type
      Productivity QA Contact Reason: pi_leo_fte_zd_qa_scores.qa_process_type
      Agent Email: pi_leo_fte_zd_qa_scores.qa_reviewer
    - Productivity Solved Contact Reason: zendesk_ticket.leo_contact_reason_grouped
      Date Filter: zendesk_ticket_metric_sets.solved_at_date
      Agent Tags: zendesk_agent.tags
      LEO Level: zendesk_agent.leo_level
    - Date Filter: pi_leo_fte_zd_qa_scores.qa_date_date
      Agent Tags: pi_leo_fte_zd_qa_scores.zendesk_agent_tags_qa_reviewer
      LEO Level: pi_leo_fte_zd_qa_scores.zendesk_agent_leo_level_reviewer
      Productivity QA LP Type: pi_leo_fte_zd_qa_scores.lp_type
      Productivity QA Contact Reason: pi_leo_fte_zd_qa_scores.qa_process_type
    row: 13
    col: 12
    width: 12
    height: 11
  - title: Solved Tickets (Individual) [L13 Months]
    name: Solved Tickets (Individual) [L13 Months]
    model: lk2_community_ops_legacy
    explore: zendesk_ticket
    type: looker_column
    fields: [zendesk_ticket.leo_contact_reason_grouped, zendesk_ticket.count_tickets,
      zendesk_ticket_metric_sets.solved_at_utc_month]
    pivots: [zendesk_ticket.leo_contact_reason_grouped]
    fill_fields: [zendesk_ticket_metric_sets.solved_at_utc_month]
    filters:
      zendesk_ticket.tag: "-%ncmec-receipts%"
      zendesk_ticket_metric_sets.solved_at_utc_date: 13 months
    sorts: [zendesk_ticket.leo_contact_reason_grouped, zendesk_ticket_metric_sets.solved_at_utc_month
        desc]
    limit: 500
    column_limit: 50
    filter_expression: if(NOT(${zendesk_ticket.leo_contact_reason}="Imminent Customer
      Threat Escalation") AND contains(${zendesk_ticket.tag},"snap-internal"),no,yes)
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
      palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
      options:
        steps: 5
        reverse: false
    x_axis_label: Solved at Month
    series_colors: {}
    defaults_version: 1
    hidden_fields:
    listen:
      Productivity Solved Contact Reason: zendesk_ticket.leo_contact_reason_grouped
      Date Filter: zendesk_ticket_metric_sets.solved_at_date
      Agent Email: zendesk_agent.email
    row: 35
    col: 0
    width: 12
    height: 11
  - title: Tickets QA'd as Reviewer (Individual) [L13 Months]
    name: Tickets QA'd as Reviewer (Individual) [L13 Months]
    model: lk2_platform_integrity_standard
    explore: pi_leo_fte_zd_qa_scores
    type: looker_column
    fields: [pi_leo_fte_zd_qa_scores.qa_count, qa_contact_reason_grouped, pi_leo_fte_zd_qa_scores.qa_date_month]
    pivots: [qa_contact_reason_grouped]
    fill_fields: [pi_leo_fte_zd_qa_scores.qa_date_month]
    filters: {}
    sorts: [qa_contact_reason_grouped, pi_leo_fte_zd_qa_scores.qa_date_month desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: dimension
      expression: if(${pi_leo_fte_zd_qa_scores.qa_process_type}="Production",${pi_leo_fte_zd_qa_scores.lp_type},${pi_leo_fte_zd_qa_scores.qa_process_type})
      label: QA Workflow
      value_format:
      value_format_name:
      dimension: qa_workflow
      _kind_hint: dimension
      _type_hint: string
    - category: dimension
      expression: if(${qa_workflow}="SW" OR ${qa_workflow}="CO","SW/CO",if(${qa_workflow}="Subpoena","Subpoena
        / Summons",if(${qa_workflow}="UN","User Notice",if(${qa_workflow}="PRTT &
        WT","PRTT / WT",${qa_workflow}))))
      label: QA Contact Reason Grouped
      value_format:
      value_format_name:
      dimension: qa_contact_reason_grouped
      _kind_hint: measure
      _type_hint: string
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
      palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
      options:
        steps: 5
        reverse: false
    series_colors:
      PRTT / WT - pi_leo_fte_zd_qa_scores.qa_count: "#B42F37"
      Subpoena / Summons - pi_leo_fte_zd_qa_scores.qa_count: "#D5C679"
      SW/CO - pi_leo_fte_zd_qa_scores.qa_count: "#FFD95F"
      User Notice - pi_leo_fte_zd_qa_scores.qa_count: "#9ED7D7"
      qa_contact_reason_grouped___null - pi_leo_fte_zd_qa_scores.qa_count: "#B42F37"
    defaults_version: 1
    listen:
      Date Filter: pi_leo_fte_zd_qa_scores.qa_date_date
      Productivity QA LP Type: pi_leo_fte_zd_qa_scores.lp_type
      Productivity QA Contact Reason: pi_leo_fte_zd_qa_scores.qa_process_type
      Agent Email: pi_leo_fte_zd_qa_scores.qa_reviewer
    row: 46
    col: 12
    width: 12
    height: 11
  - name: Individual's Average Handling Time Trends
    type: text
    title_text: Individual's Average Handling Time Trends
    subtitle_text: Unlike above tiles, a lower AHT is better for this section.
    body_text: ''
    row: 66
    col: 3
    width: 18
    height: 2
  - name: Average Handling Time (Preservations) [L13 Weeks]
    title: Average Handling Time (Preservations) [L13 Weeks]
    merged_queries:
    - model: lk2_community_ops_legacy
      explore: zendesk_ticket
      type: looker_line
      fields: [zendesk_ticket.total_time_spent_min_avg, zendesk_ticket_metric_sets.first_reply_at_week]
      fill_fields: [zendesk_ticket_metric_sets.first_reply_at_week]
      filters:
        zendesk_ticket.leo_contact_reason_grouped: Preservation
        zendesk_ticket.tag: "-%snap-internal%"
        zendesk_ticket_metric_sets.first_reply_at_date: 13 weeks
        zendesk_agent.tags: "-%enablement%,-%leo-lead%,-%-mgr%"
      sorts: [zendesk_ticket_metric_sets.first_reply_at_week desc]
      limit: 500
      column_limit: 150
      row_total: right
      dynamic_fields:
      - category: measure
        expression:
        label: AHT (FTE Average)
        value_format:
        value_format_name:
        based_on: zendesk_ticket.total_time_spent_min_avg
        _kind_hint: measure
        measure: aht_fte_average
        type: average
        _type_hint: average
        filters:
          zendesk_agent.email: "%@snapchat.com%"
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
      show_value_labels: true
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      show_null_points: true
      interpolation: linear
      defaults_version: 1
    - model: lk2_community_ops_legacy
      explore: zendesk_ticket
      type: table
      fields: [zendesk_ticket.total_time_spent_min_avg, zendesk_ticket_metric_sets.first_reply_at_week]
      fill_fields: [zendesk_ticket_metric_sets.first_reply_at_week]
      filters:
        zendesk_ticket_metric_sets.first_reply_at_date: 13 weeks
        zendesk_agent.fte_or_vendor: FTE
        zendesk_ticket.leo_contact_reason_grouped: Preservation
        zendesk_agent.tags: "-%enablement%,-%leo-lead%,-%-mgr%"
        zendesk_ticket.tag: "-%snap-internal%"
      sorts: [zendesk_ticket_metric_sets.first_reply_at_week desc]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: zendesk_ticket_metric_sets.first_reply_at_week
        source_field_name: zendesk_ticket_metric_sets.first_reply_at_week
    - model: lk2_community_ops_legacy
      explore: zendesk_ticket
      type: table
      fields: [zendesk_ticket_metric_sets.first_reply_at_week, zendesk_ticket.total_time_spent_min_avg]
      fill_fields: [zendesk_ticket_metric_sets.first_reply_at_week]
      filters:
        zendesk_ticket_metric_sets.first_reply_at_date: 13 weeks
        zendesk_ticket.leo_contact_reason_grouped: Preservation
        zendesk_agent.tags: "-%enablement%,-%leo-leads%,-%-mgr%"
        zendesk_ticket.tag: "-%snap-internal%"
        zendesk_agent.fte_or_vendor: Vendor
      sorts: [zendesk_ticket_metric_sets.first_reply_at_week desc]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: zendesk_ticket_metric_sets.first_reply_at_week
        source_field_name: zendesk_ticket_metric_sets.first_reply_at_week
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
    series_labels:
      zendesk_ticket.total_time_spent_min_avg: Individual AHT
      q1_zendesk_ticket.total_time_spent_min_avg: FTE Average AHT
      q2_zendesk_ticket.total_time_spent_min_avg: Vendor Average AHT
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    type: looker_line
    listen:
    - Agent Email: zendesk_agent.email
    -
    -
    row: 68
    col: 0
    width: 12
    height: 11
  - name: Average Handling Time (PRTT/WT) [L13 Weeks]
    title: Average Handling Time (PRTT/WT) [L13 Weeks]
    merged_queries:
    - model: lk2_community_ops_legacy
      explore: zendesk_ticket
      type: looker_line
      fields: [zendesk_ticket.total_time_spent_min_avg, zendesk_ticket_metric_sets.first_reply_at_week]
      fill_fields: [zendesk_ticket_metric_sets.first_reply_at_week]
      filters:
        zendesk_ticket.leo_contact_reason_grouped: PRTT / WT
        zendesk_ticket.tag: "-%snap-internal%"
        zendesk_ticket_metric_sets.first_reply_at_date: 13 weeks
        zendesk_agent.tags: "-%enablement%,-%leo-lead%,-%-mgr%"
      sorts: [zendesk_ticket_metric_sets.first_reply_at_week desc]
      limit: 500
      column_limit: 150
      row_total: right
      dynamic_fields:
      - category: measure
        expression:
        label: AHT (FTE Average)
        value_format:
        value_format_name:
        based_on: zendesk_ticket.total_time_spent_min_avg
        _kind_hint: measure
        measure: aht_fte_average
        type: average
        _type_hint: average
        filters:
          zendesk_agent.email: "%@snapchat.com%"
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
      show_value_labels: true
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      show_null_points: true
      interpolation: linear
      defaults_version: 1
    - model: lk2_community_ops_legacy
      explore: zendesk_ticket
      type: table
      fields: [zendesk_ticket.total_time_spent_min_avg, zendesk_ticket_metric_sets.first_reply_at_week]
      fill_fields: [zendesk_ticket_metric_sets.first_reply_at_week]
      filters:
        zendesk_ticket_metric_sets.first_reply_at_date: 13 weeks
        zendesk_agent.fte_or_vendor: FTE
        zendesk_ticket.leo_contact_reason_grouped: PRTT / WT
        zendesk_agent.tags: "-%enablement%,-%leo-lead%,-%-mgr%"
        zendesk_ticket.tag: "-%snap-internal%"
      sorts: [zendesk_ticket_metric_sets.first_reply_at_week desc]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: zendesk_ticket_metric_sets.first_reply_at_week
        source_field_name: zendesk_ticket_metric_sets.first_reply_at_week
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
    series_labels:
      zendesk_ticket.total_time_spent_min_avg: Individual AHT
      q1_zendesk_ticket.total_time_spent_min_avg: FTE Average AHT
      q2_zendesk_ticket.total_time_spent_min_avg: Vendor Average AHT
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    type: looker_line
    listen:
    - Agent Email: zendesk_agent.email
    -
    row: 90
    col: 6
    width: 12
    height: 11
  - name: Average Handling Time (Subpoena/Summons) [L13 Weeks]
    title: Average Handling Time (Subpoena/Summons) [L13 Weeks]
    merged_queries:
    - model: lk2_community_ops_legacy
      explore: zendesk_ticket
      type: looker_line
      fields: [zendesk_ticket.total_time_spent_min_avg, zendesk_ticket_metric_sets.first_reply_at_week]
      fill_fields: [zendesk_ticket_metric_sets.first_reply_at_week]
      filters:
        zendesk_ticket.leo_contact_reason_grouped: Subpoena / Summons
        zendesk_ticket.tag: "-%snap-internal%"
        zendesk_ticket_metric_sets.first_reply_at_date: 13 weeks
        zendesk_agent.tags: "-%enablement%,-%leo-lead%,-%-mgr%"
      sorts: [zendesk_ticket_metric_sets.first_reply_at_week desc]
      limit: 500
      column_limit: 150
      row_total: right
      dynamic_fields:
      - category: measure
        expression:
        label: AHT (FTE Average)
        value_format:
        value_format_name:
        based_on: zendesk_ticket.total_time_spent_min_avg
        _kind_hint: measure
        measure: aht_fte_average
        type: average
        _type_hint: average
        filters:
          zendesk_agent.email: "%@snapchat.com%"
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
      show_value_labels: true
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      show_null_points: true
      interpolation: linear
      defaults_version: 1
    - model: lk2_community_ops_legacy
      explore: zendesk_ticket
      type: table
      fields: [zendesk_ticket.total_time_spent_min_avg, zendesk_ticket_metric_sets.first_reply_at_week]
      fill_fields: [zendesk_ticket_metric_sets.first_reply_at_week]
      filters:
        zendesk_ticket_metric_sets.first_reply_at_date: 12 weeks ago for 12 weeks
        zendesk_agent.fte_or_vendor: FTE
        zendesk_ticket.leo_contact_reason_grouped: Subpoena / Summons
        zendesk_agent.tags: "-%enablement%,-%leo-lead%,-%-mgr%"
        zendesk_ticket.tag: "-%snap-internal%"
      sorts: [zendesk_ticket_metric_sets.first_reply_at_week desc]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: zendesk_ticket_metric_sets.first_reply_at_week
        source_field_name: zendesk_ticket_metric_sets.first_reply_at_week
    - model: lk2_community_ops_legacy
      explore: zendesk_ticket
      type: table
      fields: [zendesk_ticket_metric_sets.first_reply_at_week, zendesk_ticket.total_time_spent_min_avg]
      fill_fields: [zendesk_ticket_metric_sets.first_reply_at_week]
      filters:
        zendesk_ticket_metric_sets.first_reply_at_date: 13 weeks
        zendesk_ticket.leo_contact_reason_grouped: Subpoena / Summons
        zendesk_agent.tags: "-%enablement%,-%leo-leads%,-%-mgr%"
        zendesk_ticket.tag: "-%snap-internal%"
        zendesk_agent.fte_or_vendor: Vendor
      sorts: [zendesk_ticket_metric_sets.first_reply_at_week desc]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: zendesk_ticket_metric_sets.first_reply_at_week
        source_field_name: zendesk_ticket_metric_sets.first_reply_at_week
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
    series_labels:
      zendesk_ticket.total_time_spent_min_avg: Individual AHT
      q1_zendesk_ticket.total_time_spent_min_avg: FTE Average AHT
      q2_zendesk_ticket.total_time_spent_min_avg: Vendor Average AHT
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    type: looker_line
    listen:
    - Agent Email: zendesk_agent.email
    -
    -
    row: 79
    col: 12
    width: 12
    height: 11
  - name: Average Handling Time (SW/CO) [L13 Weeks]
    title: Average Handling Time (SW/CO) [L13 Weeks]
    merged_queries:
    - model: lk2_community_ops_legacy
      explore: zendesk_ticket
      type: looker_line
      fields: [zendesk_ticket.total_time_spent_min_avg, zendesk_ticket_metric_sets.first_reply_at_week]
      fill_fields: [zendesk_ticket_metric_sets.first_reply_at_week]
      filters:
        zendesk_ticket.leo_contact_reason_grouped: SW/CO
        zendesk_ticket.tag: "-%snap-internal%"
        zendesk_ticket_metric_sets.first_reply_at_date: 13 weeks
        zendesk_agent.tags: "-%enablement%,-%leo-lead%,-%-mgr%"
      sorts: [zendesk_ticket_metric_sets.first_reply_at_week desc]
      limit: 500
      column_limit: 150
      row_total: right
      dynamic_fields:
      - category: measure
        expression:
        label: AHT (FTE Average)
        value_format:
        value_format_name:
        based_on: zendesk_ticket.total_time_spent_min_avg
        _kind_hint: measure
        measure: aht_fte_average
        type: average
        _type_hint: average
        filters:
          zendesk_agent.email: "%@snapchat.com%"
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
      show_value_labels: true
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      show_null_points: true
      interpolation: linear
      defaults_version: 1
    - model: lk2_community_ops_legacy
      explore: zendesk_ticket
      type: table
      fields: [zendesk_ticket.total_time_spent_min_avg, zendesk_ticket_metric_sets.first_reply_at_week]
      fill_fields: [zendesk_ticket_metric_sets.first_reply_at_week]
      filters:
        zendesk_ticket_metric_sets.first_reply_at_date: 13 weeks
        zendesk_agent.fte_or_vendor: FTE
        zendesk_ticket.leo_contact_reason_grouped: SW/CO
        zendesk_agent.tags: "-%enablement%,-%leo-lead%,-%-mgr%"
        zendesk_ticket.tag: "-%snap-internal%"
      sorts: [zendesk_ticket_metric_sets.first_reply_at_week desc]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: zendesk_ticket_metric_sets.first_reply_at_week
        source_field_name: zendesk_ticket_metric_sets.first_reply_at_week
    - model: lk2_community_ops_legacy
      explore: zendesk_ticket
      type: table
      fields: [zendesk_ticket_metric_sets.first_reply_at_week, zendesk_ticket.total_time_spent_min_avg]
      fill_fields: [zendesk_ticket_metric_sets.first_reply_at_week]
      filters:
        zendesk_ticket_metric_sets.first_reply_at_date: 13 weeks
        zendesk_ticket.leo_contact_reason_grouped: SW/CO
        zendesk_agent.tags: "-%enablement%,-%leo-leads%,-%-mgr%"
        zendesk_ticket.tag: "-%snap-internal%"
        zendesk_agent.fte_or_vendor: Vendor
      sorts: [zendesk_ticket_metric_sets.first_reply_at_week desc]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: zendesk_ticket_metric_sets.first_reply_at_week
        source_field_name: zendesk_ticket_metric_sets.first_reply_at_week
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
    series_labels:
      zendesk_ticket.total_time_spent_min_avg: Individual AHT
      q1_zendesk_ticket.total_time_spent_min_avg: FTE Average AHT
      q2_zendesk_ticket.total_time_spent_min_avg: Vendor Average AHT
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    type: looker_line
    listen:
    - Agent Email: zendesk_agent.email
    -
    -
    row: 79
    col: 0
    width: 12
    height: 11
  - name: Average Handling Time (International) [L13 Weeks]
    title: Average Handling Time (International) [L13 Weeks]
    merged_queries:
    - model: lk2_community_ops_legacy
      explore: zendesk_ticket
      type: looker_line
      fields: [zendesk_ticket.total_time_spent_min_avg, zendesk_ticket_metric_sets.first_reply_at_week]
      fill_fields: [zendesk_ticket_metric_sets.first_reply_at_week]
      filters:
        zendesk_ticket.leo_contact_reason_grouped: International
        zendesk_ticket.tag: "-%snap-internal%"
        zendesk_ticket_metric_sets.first_reply_at_date: 13 weeks
        zendesk_agent.tags: "-%enablement%,-%leo-lead%,-%-mgr%"
      sorts: [zendesk_ticket_metric_sets.first_reply_at_week desc]
      limit: 500
      column_limit: 150
      row_total: right
      dynamic_fields:
      - category: measure
        expression:
        label: AHT (FTE Average)
        value_format:
        value_format_name:
        based_on: zendesk_ticket.total_time_spent_min_avg
        _kind_hint: measure
        measure: aht_fte_average
        type: average
        _type_hint: average
        filters:
          zendesk_agent.email: "%@snapchat.com%"
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
      show_value_labels: true
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      show_null_points: true
      interpolation: linear
      defaults_version: 1
    - model: lk2_community_ops_legacy
      explore: zendesk_ticket
      type: table
      fields: [zendesk_ticket.total_time_spent_min_avg, zendesk_ticket_metric_sets.first_reply_at_week]
      fill_fields: [zendesk_ticket_metric_sets.first_reply_at_week]
      filters:
        zendesk_ticket_metric_sets.first_reply_at_date: 13 weeks
        zendesk_agent.fte_or_vendor: FTE
        zendesk_ticket.leo_contact_reason_grouped: International
        zendesk_agent.tags: "-%enablement%,-%leo-lead%,-%-mgr%"
        zendesk_ticket.tag: "-%snap-internal%"
      sorts: [zendesk_ticket_metric_sets.first_reply_at_week desc]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: zendesk_ticket_metric_sets.first_reply_at_week
        source_field_name: zendesk_ticket_metric_sets.first_reply_at_week
    - model: lk2_community_ops_legacy
      explore: zendesk_ticket
      type: table
      fields: [zendesk_ticket_metric_sets.first_reply_at_week, zendesk_ticket.total_time_spent_min_avg]
      fill_fields: [zendesk_ticket_metric_sets.first_reply_at_week]
      filters:
        zendesk_ticket_metric_sets.first_reply_at_date: 13 weeks
        zendesk_ticket.leo_contact_reason_grouped: International
        zendesk_agent.tags: "-%enablement%,-%leo-leads%,-%-mgr%"
        zendesk_ticket.tag: "-%snap-internal%"
        zendesk_agent.fte_or_vendor: Vendor
      sorts: [zendesk_ticket_metric_sets.first_reply_at_week desc]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: zendesk_ticket_metric_sets.first_reply_at_week
        source_field_name: zendesk_ticket_metric_sets.first_reply_at_week
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
    series_labels:
      zendesk_ticket.total_time_spent_min_avg: Individual AHT
      q1_zendesk_ticket.total_time_spent_min_avg: FTE Average AHT
      q2_zendesk_ticket.total_time_spent_min_avg: Vendor Average AHT
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    type: looker_line
    listen:
    - Agent Email: zendesk_agent.email
    -
    -
    row: 68
    col: 12
    width: 12
    height: 11
  - name: Actioned + QA'd Tickets (Individual) [L13 Weeks]
    title: Actioned + QA'd Tickets (Individual) [L13 Weeks]
    merged_queries:
    - model: lk2_community_ops_legacy
      explore: zendesk_ticket
      type: looker_column
      fields: [zendesk_ticket.count_tickets, zendesk_ticket_metric_sets.solved_at_utc_week]
      fill_fields: [zendesk_ticket_metric_sets.solved_at_utc_week]
      filters:
        zendesk_ticket.leo_contact_reason: "-EMPTY,-NULL"
        zendesk_ticket_metric_sets.solved_at_utc_date: 13 weeks
      sorts: [zendesk_ticket_metric_sets.solved_at_utc_week desc]
      limit: 500
      column_limit: 50
      filter_expression: if(NOT(${zendesk_ticket.leo_contact_reason_grouped}="Imminent
        Customer Threat Escalation") AND contains(${zendesk_ticket.tag},"snap-internal"),no,yes)
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
      show_value_labels: true
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      color_application:
        collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
        palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
        options:
          steps: 5
      limit_displayed_rows_values:
        show_hide: hide
        first_last: last
        num_rows: '3'
      label_color: ["#173589", transparent]
      show_null_points: true
      interpolation: linear
      defaults_version: 1
      hidden_fields:
    - model: lk2_platform_integrity_standard
      explore: pi_leo_fte_zd_qa_scores
      type: table
      fields: [pi_leo_fte_zd_qa_scores.qa_count, pi_leo_fte_zd_qa_scores.qa_date_week]
      fill_fields: [pi_leo_fte_zd_qa_scores.qa_date_week]
      filters:
        pi_leo_fte_zd_qa_scores.zendesk_agent_tags_qa_reviewer: "-%enablement%,-%-nb%"
        pi_leo_fte_zd_qa_scores.qa_date_week: 13 weeks
        pi_leo_fte_zd_qa_scores.qa_process_type: "-NULL"
      sorts: [pi_leo_fte_zd_qa_scores.qa_date_week desc]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: pi_leo_fte_zd_qa_scores.qa_date_week
        source_field_name: zendesk_ticket_metric_sets.solved_at_utc_week
    - model: lk2_platform_integrity_legacy
      explore: maestroqa_rubric_answers
      type: table
      fields: [maestroqa_answers.created_week, maestroqa_answers.count]
      fill_fields: [maestroqa_answers.created_week]
      filters:
        maestroqa_templates.name: "%International%,%Preservation%,%Reporting%,%SW/CO%,%Production%,%Subpoena%,%EDR%"
        maestroqa_answers.created_date: 14 weeks
      sorts: [maestroqa_answers.created_week desc]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: maestroqa_answers.created_week
        source_field_name: zendesk_ticket_metric_sets.solved_at_utc_week
    - model: lk2_community_ops_legacy
      explore: zendesk_ticket_events
      type: table
      fields: [classification_actions, triaging_actions, zendesk_ticket_events.updated_at_week]
      fill_fields: [zendesk_ticket_events.updated_at_week]
      filters:
        zendesk_ticket_events.partition_filter: 13 weeks
        zendesk_ticket.leo_contact_reason_grouped: "-EMPTY,-NULL"
        zendesk_ticket.tag: "-%snap-internal%"
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: measure
        expression:
        label: Classification Actions
        value_format:
        value_format_name:
        based_on: zendesk_ticket_events.count_ticket
        _kind_hint: measure
        measure: classification_actions
        type: count_distinct
        _type_hint: number
        filters:
          zendesk_ticket_events.added_tags: "%leo-case-status-classified%,%leo-case-status-bc-classified%"
      - category: measure
        expression:
        label: Triaging Actions
        value_format:
        value_format_name:
        based_on: zendesk_ticket_events.count_ticket
        _kind_hint: measure
        measure: triaging_actions
        type: count_distinct
        _type_hint: number
        filters:
          zendesk_ticket_events.added_tags: "%leo-case-status-triaged%,%leo-case-status-ba-triaged%"
      join_fields:
      - field_name: zendesk_ticket_events.updated_at_week
        source_field_name: zendesk_ticket_metric_sets.solved_at_utc_week
    color_application:
      collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
      palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
      options:
        steps: 5
        reverse: false
      collection_default: false
      collection_label: Lighthouse
      palette_label: Categorical
      palette_type: Categorical
      palette_colors:
      - "#4276BE"
      - "#3FB0D5"
      - "#E57947"
      - "#FFD95F"
      - "#B42F37"
      - "#6A013A"
      - "#7363A9"
      - "#44759A"
      - "#FBB556"
      - "#D5C679"
      - "#9ED7D7"
      - "#D59E79"
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Solved at Month
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    x_axis_zoom: true
    y_axis_zoom: true
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    font_size: 85%
    series_types:
      3_week_rolling_average: line
    point_style: none
    series_colors:
      avg_qad_tickets_per_agent: "#E57947"
      avg_tickets_solved_per_agent: "#3FB0D5"
      pi_leo_fte_zd_qa_scores.qa_count: "#E57947"
      zendesk_ticket.count_tickets: "#3FB0D5"
      3_week_rolling_average: "#B42F37"
      solved_count: "#3FB0D5"
      qa_count: "#E57947"
      classification_triaging_count: "#FFD95F"
    series_labels:
      zendesk_ticket.count_tickets: Solved Tickets
      pi_leo_fte_zd_qa_scores.qa_count: QA'd Tickets
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [total_solved_qa_count, zendesk_ticket_events.count_ticket, pi_leo_fte_zd_qa_scores.qa_count,
      maestroqa_answers.count, classification_actions, triaging_actions, total_actioned_qa_count]
    type: looker_column
    hidden_pivots: {}
    dynamic_fields:
    - category: table_calculation
      expression: coalesce(${zendesk_ticket.count_tickets},0)+coalesce(${pi_leo_fte_zd_qa_scores.qa_count},0)+coalesce(${maestroqa_answers.count},0)+coalesce(${classification_actions},0)+coalesce(${triaging_actions},0)
      label: Total Actioned + QA Count
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: total_actioned_qa_count
      _type_hint: number
    - category: table_calculation
      expression: coalesce(${pi_leo_fte_zd_qa_scores.qa_count},0)+coalesce(${maestroqa_answers.count},0)
      label: QA Count
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: qa_count
      _type_hint: number
    - category: table_calculation
      expression: coalesce(${classification_actions},0)+coalesce(${triaging_actions},0)
      label: Classification + Triaging Count
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: classification_triaging_count
      _type_hint: number
    - category: table_calculation
      expression: mean(offset_list(${total_actioned_qa_count},0,3))
      label: 3-week Rolling Average
      value_format:
      value_format_name: decimal_1
      _kind_hint: measure
      table_calculation: 3_week_rolling_average
      _type_hint: number
    listen:
    - Productivity Solved Contact Reason: zendesk_ticket.leo_contact_reason_grouped
      Date Filter: zendesk_ticket_metric_sets.solved_at_date
      Agent Email: zendesk_agent.email
    - Date Filter: pi_leo_fte_zd_qa_scores.qa_date_date
      Productivity QA LP Type: pi_leo_fte_zd_qa_scores.lp_type
      Productivity QA Contact Reason: pi_leo_fte_zd_qa_scores.qa_process_type
      Agent Email: pi_leo_fte_zd_qa_scores.qa_reviewer
    - Agent Email: maestroqa_answers.qa_reviewer
    - Agent Email: zendesk_agent.email
    row: 2
    col: 0
    width: 12
    height: 11
  - title: Preservations (Reactive QA)
    name: Preservations (Reactive QA)
    model: lk2_platform_integrity_legacy
    explore: maestroqa_rubric_answers
    type: looker_line
    fields: [maestroqa_answers.score, maestroqa_answers.first_saved_week, maestroqa_answers.count]
    fill_fields: [maestroqa_answers.first_saved_week]
    filters:
      maestroqa_answers.first_saved_date: 13 weeks
      maestroqa_templates.name: Preservation Rubric
    sorts: [maestroqa_answers.first_saved_week desc]
    limit: 500
    column_limit: 50
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
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    color_application:
      collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
      palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: maestroqa_answers.score,
            id: maestroqa_answers.score, name: Score}], showLabels: true, showValues: true,
        maxValue: 1, unpinAxis: true, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: !!null '', orientation: right, series: [{axisId: maestroqa_answers.count,
            id: maestroqa_answers.count, name: QA Count}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      maestroqa_answers.count: column
    series_labels:
      maestroqa_answers.count: QA Count
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: center, color: "#000000",
        line_value: '0.98', label: Goal (98%)}]
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Agent Email: maestroqa_helpdesk_id_email.email
    row: 132
    col: 12
    width: 12
    height: 9
  - title: Subpoena/Summons (Reactive QA)
    name: Subpoena/Summons (Reactive QA)
    model: lk2_platform_integrity_legacy
    explore: maestroqa_rubric_answers
    type: looker_line
    fields: [maestroqa_answers.score, maestroqa_answers.first_saved_week, maestroqa_answers.count]
    fill_fields: [maestroqa_answers.first_saved_week]
    filters:
      maestroqa_answers.first_saved_date: 13 weeks
      maestroqa_templates.name: "%Subpoena%"
    sorts: [maestroqa_answers.first_saved_week desc]
    limit: 500
    column_limit: 50
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
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    color_application:
      collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
      palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: maestroqa_answers.score,
            id: maestroqa_answers.score, name: Score}], showLabels: true, showValues: true,
        maxValue: 1, unpinAxis: true, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: !!null '', orientation: right, series: [{axisId: maestroqa_answers.count,
            id: maestroqa_answers.count, name: QA Count}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      maestroqa_answers.count: column
    series_labels:
      maestroqa_answers.count: QA Count
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: center, color: "#000000",
        line_value: '0.98', label: Goal (98%)}]
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Agent Email: maestroqa_helpdesk_id_email.email
    row: 159
    col: 12
    width: 12
    height: 9
  - title: SW/CO (Reactive QA)
    name: SW/CO (Reactive QA)
    model: lk2_platform_integrity_legacy
    explore: maestroqa_rubric_answers
    type: looker_line
    fields: [maestroqa_answers.score, maestroqa_answers.first_saved_week, maestroqa_answers.count]
    fill_fields: [maestroqa_answers.first_saved_week]
    filters:
      maestroqa_answers.first_saved_date: 13 weeks
      maestroqa_templates.name: "%SW/CO%"
    sorts: [maestroqa_answers.first_saved_week desc]
    limit: 500
    column_limit: 50
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
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    color_application:
      collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
      palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: maestroqa_answers.score,
            id: maestroqa_answers.score, name: Score}], showLabels: true, showValues: true,
        maxValue: 1, unpinAxis: true, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: !!null '', orientation: right, series: [{axisId: maestroqa_answers.count,
            id: maestroqa_answers.count, name: QA Count}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      maestroqa_answers.count: column
    series_labels:
      maestroqa_answers.count: QA Count
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: center, color: "#000000",
        line_value: '0.98', label: Goal (98%)}]
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Agent Email: maestroqa_helpdesk_id_email.email
    row: 150
    col: 12
    width: 12
    height: 9
  - title: International (Reactive QA)
    name: International (Reactive QA)
    model: lk2_platform_integrity_standard
    explore: pi_leo_fte_zd_qa_scores
    type: looker_line
    fields: [pi_leo_fte_zd_qa_scores.action_date_week, pi_leo_fte_zd_qa_scores._score,
      pi_leo_fte_zd_qa_scores.qa_count]
    fill_fields: [pi_leo_fte_zd_qa_scores.action_date_week]
    filters:
      pi_leo_fte_zd_qa_scores.qa_process_type: International
      pi_leo_fte_zd_qa_scores.action_date_date: 13 weeks
      pi_leo_fte_zd_qa_scores.certified_qa_recipient: 'Yes'
    sorts: [pi_leo_fte_zd_qa_scores.action_date_week desc]
    limit: 500
    column_limit: 50
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
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    color_application:
      collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
      palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
      options:
        steps: 5
        reverse: false
    y_axes: [{label: '', orientation: left, series: [{axisId: pi_leo_fte_zd_qa_scores._score,
            id: pi_leo_fte_zd_qa_scores._score, name: " Score"}], showLabels: true,
        showValues: true, maxValue: 1, unpinAxis: true, tickDensity: default, type: linear},
      {label: '', orientation: right, series: [{axisId: pi_leo_fte_zd_qa_scores.qa_count,
            id: pi_leo_fte_zd_qa_scores.qa_count, name: QA Count}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: linear}]
    series_types:
      International - pi_leo_fte_zd_qa_scores.qa_count: column
      Production - pi_leo_fte_zd_qa_scores.qa_count: column
      pi_leo_fte_zd_qa_scores.qa_count: column
    series_colors:
      International - pi_leo_fte_zd_qa_scores.qa_count: "#4276BE"
      Production - pi_leo_fte_zd_qa_scores.qa_count: "#E57947"
      Production - pi_leo_fte_zd_qa_scores._score: "#E57947"
    reference_lines: [{reference_type: line, line_value: ".98", range_start: max,
        range_end: min, margin_top: deviation, margin_value: mean, margin_bottom: deviation,
        label_position: center, color: "#000000", label: Goal (98%)}]
    discontinuous_nulls: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      Agent Email: pi_leo_fte_zd_qa_scores.qa_recipient
    row: 141
    col: 12
    width: 12
    height: 9
  - title: User Notice (Reactive QA)
    name: User Notice (Reactive QA)
    model: lk2_platform_integrity_legacy
    explore: maestroqa_rubric_answers
    type: looker_line
    fields: [maestroqa_answers.score, maestroqa_answers.first_saved_week, maestroqa_answers.count]
    fill_fields: [maestroqa_answers.first_saved_week]
    filters:
      maestroqa_answers.first_saved_date: 13 weeks
      maestroqa_templates.name: "%User Notice%,%UN%"
    sorts: [maestroqa_answers.first_saved_week desc]
    limit: 500
    column_limit: 50
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
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    color_application:
      collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
      palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: maestroqa_answers.score,
            id: maestroqa_answers.score, name: Score}], showLabels: true, showValues: true,
        maxValue: 1, unpinAxis: true, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: !!null '', orientation: right, series: [{axisId: maestroqa_answers.count,
            id: maestroqa_answers.count, name: QA Count}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      maestroqa_answers.count: column
    series_labels:
      maestroqa_answers.count: QA Count
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: center, color: "#000000",
        line_value: '0.98', label: Goal (98%)}]
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Agent Email: maestroqa_helpdesk_id_email.email
    row: 168
    col: 12
    width: 12
    height: 9
  - title: Top Error Category (Reactive QA Preservations)
    name: Top Error Category (Reactive QA Preservations)
    model: lk2_platform_integrity_legacy
    explore: maestroqa_rubric_answers
    type: looker_grid
    fields: [maestroqa_questions.question, maestroqa_question_scores.count]
    filters:
      maestroqa_answers.first_saved_date: 30 days
      maestroqa_templates.name: "%Preservation%"
      maestroqa_question_scores.score: '0'
    sorts: [maestroqa_question_scores.count desc]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      maestroqa_question_scores.count: Error Count
    series_cell_visualizations:
      maestroqa_question_scores.count:
        is_active: true
        palette:
          palette_id: 16f7550d-b0b6-c550-3630-b720be91f870
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
          custom_colors:
          - "#ff8386"
          - "#e60b0b"
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
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Agent Email: maestroqa_helpdesk_id_email.email
    row: 188
    col: 12
    width: 12
    height: 7
  - title: Top Error Category (Proactive QA Preservations)
    name: Top Error Category (Proactive QA Preservations)
    model: lk2_platform_integrity_standard
    explore: pi_leo_fte_zd_qa_scores
    type: looker_grid
    fields: [pi_leo_fte_zd_qa_questions_scores.questions_incorrect, pi_leo_fte_zd_qa_questions_scores.question_text]
    filters:
      pi_leo_fte_zd_qa_scores.action_date_date: 30 days
      pi_leo_fte_zd_qa_scores.qa_process_type: Preservation
    sorts: [pi_leo_fte_zd_qa_questions_scores.questions_incorrect desc]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      pi_leo_fte_zd_qa_questions_scores.questions_incorrect:
        is_active: true
        palette:
          palette_id: 4c080e10-d785-555e-8d52-282db01abdd5
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
          custom_colors:
          - "#ff7c7c"
          - "#e60606"
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
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    listen:
      Agent Email: pi_leo_fte_zd_qa_scores.qa_recipient
    row: 188
    col: 0
    width: 12
    height: 7
  - name: Individual's Quality Common Errors
    type: text
    title_text: Individual's Quality Common Errors
    subtitle_text: L30 Days
    body_text: ''
    row: 186
    col: 0
    width: 24
    height: 2
  - title: Top Error Category (MaestroQA Subpoena)
    name: Top Error Category (MaestroQA Subpoena)
    model: lk2_platform_integrity_legacy
    explore: maestroqa_rubric_answers
    type: looker_grid
    fields: [maestroqa_questions.question, maestroqa_question_scores.count]
    filters:
      maestroqa_answers.first_saved_date: 30 days
      maestroqa_templates.name: "%Subpoena%"
      maestroqa_question_scores.score: '0'
    sorts: [maestroqa_question_scores.count desc]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      maestroqa_question_scores.count: Error Count
    series_cell_visualizations:
      maestroqa_question_scores.count:
        is_active: true
        palette:
          palette_id: 16f7550d-b0b6-c550-3630-b720be91f870
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
          custom_colors:
          - "#ff8386"
          - "#e60b0b"
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
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Agent Email: maestroqa_helpdesk_id_email.email
    row: 202
    col: 12
    width: 12
    height: 7
  - title: Top Error Category (Proactive QA SW/CO)
    name: Top Error Category (Proactive QA SW/CO)
    model: lk2_platform_integrity_standard
    explore: pi_leo_fte_zd_qa_scores
    type: looker_grid
    fields: [pi_leo_fte_zd_qa_questions_scores.questions_incorrect, pi_leo_fte_zd_qa_questions_scores.question_text]
    filters:
      pi_leo_fte_zd_qa_scores.action_date_date: 30 days
      pi_leo_fte_zd_qa_scores.qa_process_type: Production
      pi_leo_fte_zd_qa_scores.lp_type: SW,CO,sw
    sorts: [pi_leo_fte_zd_qa_questions_scores.questions_incorrect desc]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      pi_leo_fte_zd_qa_questions_scores.questions_incorrect:
        is_active: true
        palette:
          palette_id: 4c080e10-d785-555e-8d52-282db01abdd5
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
          custom_colors:
          - "#ff7c7c"
          - "#e60606"
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
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    listen:
      Agent Email: pi_leo_fte_zd_qa_scores.qa_recipient
    row: 195
    col: 0
    width: 12
    height: 7
  - title: Top Error Category (Proactive QA Subpoena)
    name: Top Error Category (Proactive QA Subpoena)
    model: lk2_platform_integrity_standard
    explore: pi_leo_fte_zd_qa_scores
    type: looker_grid
    fields: [pi_leo_fte_zd_qa_questions_scores.questions_incorrect, pi_leo_fte_zd_qa_questions_scores.question_text]
    filters:
      pi_leo_fte_zd_qa_scores.action_date_date: 30 days
      pi_leo_fte_zd_qa_scores.qa_process_type: Production
      pi_leo_fte_zd_qa_scores.lp_type: Subpoena,subpoena
    sorts: [pi_leo_fte_zd_qa_questions_scores.questions_incorrect desc]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      pi_leo_fte_zd_qa_questions_scores.questions_incorrect:
        is_active: true
        palette:
          palette_id: 4c080e10-d785-555e-8d52-282db01abdd5
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
          custom_colors:
          - "#ff7c7c"
          - "#e60606"
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
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    listen:
      Agent Email: pi_leo_fte_zd_qa_scores.qa_recipient
    row: 202
    col: 0
    width: 12
    height: 7
  - title: Top Error Category (MaestroQA SW/CO)
    name: Top Error Category (MaestroQA SW/CO)
    model: lk2_platform_integrity_legacy
    explore: maestroqa_rubric_answers
    type: looker_grid
    fields: [maestroqa_questions.question, maestroqa_question_scores.count]
    filters:
      maestroqa_answers.first_saved_date: 30 days
      maestroqa_templates.name: "%SW/CO%"
      maestroqa_question_scores.score: '0'
    sorts: [maestroqa_question_scores.count desc]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      maestroqa_question_scores.count: Error Count
    series_cell_visualizations:
      maestroqa_question_scores.count:
        is_active: true
        palette:
          palette_id: 16f7550d-b0b6-c550-3630-b720be91f870
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
          custom_colors:
          - "#ff8386"
          - "#e60b0b"
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
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Agent Email: maestroqa_helpdesk_id_email.email
    row: 195
    col: 12
    width: 12
    height: 7
  - name: Preservation MaestroQA AHT (As Grader) [L13 Weeks]
    title: Preservation MaestroQA AHT (As Grader) [L13 Weeks]
    merged_queries:
    - model: lk2_platform_integrity_legacy
      explore: maestroqa_rubric_answers
      type: looker_line
      fields: [maestroqa_answers.avg_grading_time_min, maestroqa_answers.qa_date_week]
      fill_fields: [maestroqa_answers.qa_date_week]
      filters:
        maestroqa_templates.name: Preservation Rubric
        maestroqa_answers.qa_date_date: 13 weeks
      sorts: [maestroqa_answers.qa_date_week desc]
      limit: 500
      column_limit: 50
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
      show_value_labels: true
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      show_null_points: true
      interpolation: linear
      x_axis_zoom: true
      y_axis_zoom: true
      defaults_version: 1
    - model: lk2_platform_integrity_legacy
      explore: maestroqa_rubric_answers
      type: table
      fields: [maestroqa_answers.qa_date_week, maestroqa_answers.avg_grading_time_min]
      fill_fields: [maestroqa_answers.qa_date_week]
      filters:
        maestroqa_answers.qa_date_date: 13 weeks
        zendesk_agent.fte_or_vendor: FTE
        maestroqa_templates.name: Preservation Rubric
      limit: 500
      join_fields:
      - field_name: maestroqa_answers.qa_date_week
        source_field_name: maestroqa_answers.qa_date_week
    - model: lk2_platform_integrity_legacy
      explore: maestroqa_rubric_answers
      type: table
      fields: [maestroqa_answers.qa_date_week, maestroqa_answers.avg_grading_time_min]
      fill_fields: [maestroqa_answers.qa_date_week]
      filters:
        maestroqa_templates.name: Preservation Rubric
        maestroqa_answers.qa_date_date: 13 weeks
        zendesk_agent.fte_or_vendor: Vendor
      limit: 500
      join_fields:
      - field_name: maestroqa_answers.qa_date_week
        source_field_name: maestroqa_answers.qa_date_week
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
    x_axis_zoom: true
    y_axis_zoom: true
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    series_labels:
      maestroqa_answers.avg_grading_time_min: Individual AHT
      q1_maestroqa_answers.avg_grading_time_min: FTE Average AHT
      q2_maestroqa_answers.avg_grading_time_min: Vendor Average AHT
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    type: looker_line
    listen:
    - Agent Email: maestroqa_answers.qa_reviewer
    -
    -
    row: 101
    col: 0
    width: 12
    height: 10
  - name: SW/CO MaestroQA AHT (As Grader) [L13 Weeks]
    title: SW/CO MaestroQA AHT (As Grader) [L13 Weeks]
    merged_queries:
    - model: lk2_platform_integrity_legacy
      explore: maestroqa_rubric_answers
      type: looker_line
      fields: [maestroqa_answers.avg_grading_time_min, maestroqa_answers.qa_date_week]
      fill_fields: [maestroqa_answers.qa_date_week]
      filters:
        maestroqa_templates.name: SW/CO Rubric
        maestroqa_answers.qa_date_date: 13 weeks
      sorts: [maestroqa_answers.qa_date_week desc]
      limit: 500
      column_limit: 50
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
      show_value_labels: true
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      show_null_points: true
      interpolation: linear
      x_axis_zoom: true
      y_axis_zoom: true
      defaults_version: 1
    - model: lk2_platform_integrity_legacy
      explore: maestroqa_rubric_answers
      type: table
      fields: [maestroqa_answers.qa_date_week, maestroqa_answers.avg_grading_time_min]
      fill_fields: [maestroqa_answers.qa_date_week]
      filters:
        maestroqa_answers.qa_date_date: 13 weeks
        zendesk_agent.fte_or_vendor: FTE
        maestroqa_templates.name: SW/CO Rubric
      sorts: [maestroqa_answers.qa_date_week desc]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: maestroqa_answers.qa_date_week
        source_field_name: maestroqa_answers.qa_date_week
    - model: lk2_platform_integrity_legacy
      explore: maestroqa_rubric_answers
      type: table
      fields: [maestroqa_answers.qa_date_week, maestroqa_answers.avg_grading_time_min]
      fill_fields: [maestroqa_answers.qa_date_week]
      filters:
        maestroqa_templates.name: SW/CO Rubric
        maestroqa_answers.qa_date_date: 13 weeks
        zendesk_agent.fte_or_vendor: Vendor
      sorts: [maestroqa_answers.qa_date_week desc]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: maestroqa_answers.qa_date_week
        source_field_name: maestroqa_answers.qa_date_week
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
    x_axis_zoom: true
    y_axis_zoom: true
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    series_labels:
      maestroqa_answers.avg_grading_time_min: Individual AHT
      q1_maestroqa_answers.avg_grading_time_min: FTE Average AHT
      q2_maestroqa_answers.avg_grading_time_min: Vendor Average AHT
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    type: looker_line
    listen:
    - Agent Email: maestroqa_answers.qa_reviewer
    -
    -
    row: 101
    col: 12
    width: 12
    height: 10
  - name: Subpoena MaestroQA AHT (As Grader) [L13 Weeks]
    title: Subpoena MaestroQA AHT (As Grader) [L13 Weeks]
    merged_queries:
    - model: lk2_platform_integrity_legacy
      explore: maestroqa_rubric_answers
      type: looker_line
      fields: [maestroqa_answers.avg_grading_time_min, maestroqa_answers.qa_date_week]
      fill_fields: [maestroqa_answers.qa_date_week]
      filters:
        maestroqa_templates.name: Subpoena Rubric
        maestroqa_answers.qa_date_date: 13 weeks
      sorts: [maestroqa_answers.qa_date_week desc]
      limit: 500
      column_limit: 50
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
      show_value_labels: true
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      show_null_points: true
      interpolation: linear
      x_axis_zoom: true
      y_axis_zoom: true
      defaults_version: 1
    - model: lk2_platform_integrity_legacy
      explore: maestroqa_rubric_answers
      type: table
      fields: [maestroqa_answers.qa_date_week, maestroqa_answers.avg_grading_time_min]
      fill_fields: [maestroqa_answers.qa_date_week]
      filters:
        maestroqa_answers.qa_date_date: 13 weeks
        zendesk_agent.fte_or_vendor: FTE
        maestroqa_templates.name: Subpoena Rubric
      sorts: [maestroqa_answers.qa_date_week desc]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: maestroqa_answers.qa_date_week
        source_field_name: maestroqa_answers.qa_date_week
    - model: lk2_platform_integrity_legacy
      explore: maestroqa_rubric_answers
      type: table
      fields: [maestroqa_answers.qa_date_week, maestroqa_answers.avg_grading_time_min]
      fill_fields: [maestroqa_answers.qa_date_week]
      filters:
        maestroqa_templates.name: Subpoena Rubric
        maestroqa_answers.qa_date_date: 13 weeks
        zendesk_agent.fte_or_vendor: Vendor
      sorts: [maestroqa_answers.qa_date_week desc]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: maestroqa_answers.qa_date_week
        source_field_name: maestroqa_answers.qa_date_week
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
    x_axis_zoom: true
    y_axis_zoom: true
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    series_labels:
      maestroqa_answers.avg_grading_time_min: Individual AHT
      q1_maestroqa_answers.avg_grading_time_min: FTE Average AHT
      q2_maestroqa_answers.avg_grading_time_min: Vendor Average AHT
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    type: looker_line
    listen:
    - Agent Email: maestroqa_answers.qa_reviewer
    -
    -
    row: 111
    col: 0
    width: 12
    height: 10
  - name: EDR MaestroQA AHT (As Grader) [L13 Weeks]
    title: EDR MaestroQA AHT (As Grader) [L13 Weeks]
    merged_queries:
    - model: lk2_platform_integrity_legacy
      explore: maestroqa_rubric_answers
      type: looker_line
      fields: [maestroqa_answers.avg_grading_time_min, maestroqa_answers.qa_date_week]
      fill_fields: [maestroqa_answers.qa_date_week]
      filters:
        maestroqa_templates.name: "%EDR Rubric%"
        maestroqa_answers.qa_date_date: 13 weeks
      sorts: [maestroqa_answers.qa_date_week desc]
      limit: 500
      column_limit: 50
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
      show_value_labels: true
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      show_null_points: true
      interpolation: linear
      x_axis_zoom: true
      y_axis_zoom: true
      defaults_version: 1
    - model: lk2_platform_integrity_legacy
      explore: maestroqa_rubric_answers
      type: table
      fields: [maestroqa_answers.qa_date_week, maestroqa_answers.avg_grading_time_min]
      fill_fields: [maestroqa_answers.qa_date_week]
      filters:
        maestroqa_answers.qa_date_date: 13 weeks
        zendesk_agent.fte_or_vendor: FTE
        maestroqa_templates.name: "%EDR Rubric%"
      sorts: [maestroqa_answers.qa_date_week desc]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: maestroqa_answers.qa_date_week
        source_field_name: maestroqa_answers.qa_date_week
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
    x_axis_zoom: true
    y_axis_zoom: true
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    series_labels:
      maestroqa_answers.avg_grading_time_min: Individual AHT
      q1_maestroqa_answers.avg_grading_time_min: FTE Average AHT
      q2_maestroqa_answers.avg_grading_time_min: Vendor Average AHT
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    type: looker_line
    hidden_pivots: {}
    listen:
    - Agent Email: maestroqa_answers.qa_reviewer
    -
    row: 111
    col: 12
    width: 12
    height: 10
  - name: Individual's CSAT Survey Responses
    type: text
    title_text: Individual's CSAT Survey Responses
    subtitle_text: L30 Days
    body_text: ''
    row: 209
    col: 0
    width: 24
    height: 2
  - title: "'Bad' Satisfaction Response Comments"
    name: "'Bad' Satisfaction Response Comments"
    model: lk2_community_ops_legacy
    explore: zendesk_ticket
    type: looker_grid
    fields: [zendesk_csat.updated_at_utc_date, zendesk_ticket.url, zendesk_ticket.leo_international_country,
      zendesk_csat.comment]
    filters:
      zendesk_csat.score: Bad
      zendesk_ticket_metric_sets.solved_at_utc_date: 30 days
      zendesk_ticket.tag: "-%snap-internal%"
      zendesk_csat.comment: "-None"
    sorts: [zendesk_csat.updated_at_utc_date desc]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    hidden_pivots: {}
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
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    listen:
      Productivity Solved Contact Reason: zendesk_ticket.leo_contact_reason_grouped
      Agent Email: zendesk_agent.email
    row: 216
    col: 12
    width: 12
    height: 8
  - title: "'Good' Satisfaction Response Comments"
    name: "'Good' Satisfaction Response Comments"
    model: lk2_community_ops_legacy
    explore: zendesk_ticket
    type: looker_grid
    fields: [zendesk_csat.updated_at_utc_date, zendesk_ticket.url, zendesk_ticket.leo_international_country,
      zendesk_csat.comment]
    filters:
      zendesk_csat.score: Good
      zendesk_ticket_metric_sets.solved_at_utc_date: 30 days
      zendesk_ticket.tag: "-%snap-internal%"
      zendesk_csat.comment: "-None"
    sorts: [zendesk_csat.updated_at_utc_date desc]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    hidden_pivots: {}
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
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    listen:
      Productivity Solved Contact Reason: zendesk_ticket.leo_contact_reason_grouped
      Agent Email: zendesk_agent.email
    row: 216
    col: 0
    width: 12
    height: 8
  - title: Individual's LEO Satisfaction Survey Results
    name: Individual's LEO Satisfaction Survey Results
    model: lk2_community_ops_legacy
    explore: zendesk_ticket
    type: looker_grid
    fields: [zendesk_csat.score, zendesk_ticket.leo_international_country, zendesk_csat.count]
    filters:
      zendesk_csat.score: "-Offered but not given,-NULL"
      zendesk_ticket_metric_sets.solved_at_utc_date: 30 days
      zendesk_ticket.tag: "-%snap-internal%"
    sorts: [zendesk_csat.score desc]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    hidden_pivots: {}
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
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    listen:
      Productivity Solved Contact Reason: zendesk_ticket.leo_contact_reason_grouped
      Agent Email: zendesk_agent.email
    row: 211
    col: 0
    width: 24
    height: 5
  - name: Tickets QA'd as Reviewer (Individual) [L13 Weeks]
    title: Tickets QA'd as Reviewer (Individual) [L13 Weeks]
    merged_queries:
    - model: lk2_platform_integrity_standard
      explore: pi_leo_fte_zd_qa_scores
      type: looker_column
      fields: [pi_leo_fte_zd_qa_scores.qa_count, pi_leo_fte_zd_qa_scores.qa_date_week,
        qa_contact_reason_grouped]
      filters:
        pi_leo_fte_zd_qa_scores.qa_date_week: 13 weeks
      sorts: [pi_leo_fte_zd_qa_scores.qa_date_week desc, qa_contact_reason_grouped]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: dimension
        expression: if(${pi_leo_fte_zd_qa_scores.qa_process_type}="Production",${pi_leo_fte_zd_qa_scores.lp_type},${pi_leo_fte_zd_qa_scores.qa_process_type})
        label: QA Workflow
        value_format:
        value_format_name:
        dimension: qa_workflow
        _kind_hint: dimension
        _type_hint: string
      - category: dimension
        expression: if(${qa_workflow}="SW" OR ${qa_workflow}="CO","SW/CO",if(${qa_workflow}="Subpoena","Subpoena
          / Summons",if(${qa_workflow}="UN","User Notice",if(${qa_workflow}="PRTT
          & WT","PRTT / WT",${qa_workflow}))))
        label: QA Contact Reason Grouped
        value_format:
        value_format_name:
        dimension: qa_contact_reason_grouped
        _kind_hint: measure
        _type_hint: string
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
      stacking: normal
      limit_displayed_rows: false
      legend_position: center
      point_style: none
      show_value_labels: true
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      ordering: none
      show_null_labels: false
      show_totals_labels: true
      show_silhouette: false
      totals_color: "#808080"
      color_application:
        collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
        palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
        options:
          steps: 5
          reverse: false
      series_colors:
        Civil / Crim Def - zendesk_ticket.count_tickets: "#6A013A"
        EDR - zendesk_ticket.count_tickets: "#4276BE"
        General - zendesk_ticket.count_tickets: "#7363A9"
        International - zendesk_ticket.count_tickets: "#3FB0D5"
        Preservation - zendesk_ticket.count_tickets: "#E57947"
        Subpoena / Summons - zendesk_ticket.count_tickets: "#D5C679"
        PRTT / WT - zendesk_ticket.count_tickets: "#B42F37"
        Trial Appearance - zendesk_ticket.count_tickets: "#D59E79"
        PRTT / WT - pi_leo_fte_zd_qa_scores.qa_count: "#B42F37"
        Subpoena / Summons - pi_leo_fte_zd_qa_scores.qa_count: "#D5C679"
        SW/CO - pi_leo_fte_zd_qa_scores.qa_count: "#FBB556"
        User Notice - pi_leo_fte_zd_qa_scores.qa_count: "#9ED7D7"
        qa_contact_reason_grouped___null - pi_leo_fte_zd_qa_scores.qa_count: "#6A013A"
      defaults_version: 1
      hidden_pivots: {}
    - model: lk2_platform_integrity_legacy
      explore: maestroqa_rubric_answers
      type: table
      fields: [maestroqa_answers.created_week, maestroqa_templates.leo_process_grouped,
        maestroqa_answers.count]
      filters:
        maestroqa_answers.created_date: 13 weeks
        maestroqa_templates.leo_process_grouped: "-EMPTY,-NULL"
      sorts: [maestroqa_answers.created_week desc]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: maestroqa_answers.created_week
        source_field_name: pi_leo_fte_zd_qa_scores.qa_date_week
      - field_name: maestroqa_templates.leo_process_grouped
        source_field_name: qa_contact_reason_grouped
    color_application:
      collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
      palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
      options:
        steps: 5
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
    x_axis_zoom: true
    y_axis_zoom: true
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    hidden_pivots: {}
    type: looker_column
    hidden_fields: [pi_leo_fte_zd_qa_scores.qa_count, maestroqa_answers.count]
    pivots: [qa_contact_reason_grouped]
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: coalesce(${pi_leo_fte_zd_qa_scores.qa_count},0)+coalesce(${maestroqa_answers.count},0)
      label: QA Count
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: qa_count
      _type_hint: number
    listen:
    - Productivity QA Contact Reason: pi_leo_fte_zd_qa_scores.qa_process_type
      Productivity QA LP Type: pi_leo_fte_zd_qa_scores.lp_type
      Agent Email: pi_leo_fte_zd_qa_scores.qa_reviewer
    - Agent Email: zendesk_agent.email
    row: 24
    col: 12
    width: 12
    height: 11
  - name: Tickets QA'd as Reviewer (Individual) [L13 Months] (2)
    title: Tickets QA'd as Reviewer (Individual) [L13 Months]
    merged_queries:
    - model: lk2_platform_integrity_standard
      explore: pi_leo_fte_zd_qa_scores
      type: looker_column
      fields: [pi_leo_fte_zd_qa_scores.qa_date_month, qa_contact_reason_grouped, pi_leo_fte_zd_qa_scores.qa_count]
      filters:
        pi_leo_fte_zd_qa_scores.qa_date_date: 13 months
      sorts: [qa_contact_reason_grouped]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: dimension
        expression: if(${pi_leo_fte_zd_qa_scores.qa_process_type}="Production",${pi_leo_fte_zd_qa_scores.lp_type},${pi_leo_fte_zd_qa_scores.qa_process_type})
        label: QA Workflow
        value_format:
        value_format_name:
        dimension: qa_workflow
        _kind_hint: dimension
        _type_hint: string
      - category: dimension
        expression: if(${qa_workflow}="SW" OR ${qa_workflow}="CO","SW/CO",if(${qa_workflow}="Subpoena","Subpoena
          / Summons",if(${qa_workflow}="UN","User Notice",if(${qa_workflow}="PRTT
          & WT","PRTT / WT",${qa_workflow}))))
        label: QA Contact Reason Grouped
        value_format:
        value_format_name:
        dimension: qa_contact_reason_grouped
        _kind_hint: measure
        _type_hint: string
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
      stacking: normal
      limit_displayed_rows: false
      legend_position: center
      point_style: none
      show_value_labels: true
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      ordering: none
      show_null_labels: false
      show_totals_labels: true
      show_silhouette: false
      totals_color: "#808080"
      color_application:
        collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
        palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
        options:
          steps: 5
          reverse: false
      series_colors:
        Civil / Crim Def - zendesk_ticket.count_tickets: "#6A013A"
        EDR - zendesk_ticket.count_tickets: "#4276BE"
        General - zendesk_ticket.count_tickets: "#7363A9"
        International - zendesk_ticket.count_tickets: "#3FB0D5"
        Preservation - zendesk_ticket.count_tickets: "#E57947"
        Subpoena / Summons - zendesk_ticket.count_tickets: "#D5C679"
        PRTT / WT - zendesk_ticket.count_tickets: "#B42F37"
        Trial Appearance - zendesk_ticket.count_tickets: "#D59E79"
        PRTT / WT - pi_leo_fte_zd_qa_scores.qa_count: "#B42F37"
        Subpoena / Summons - pi_leo_fte_zd_qa_scores.qa_count: "#D5C679"
        SW/CO - pi_leo_fte_zd_qa_scores.qa_count: "#FBB556"
        User Notice - pi_leo_fte_zd_qa_scores.qa_count: "#9ED7D7"
        qa_contact_reason_grouped___null - pi_leo_fte_zd_qa_scores.qa_count: "#6A013A"
      defaults_version: 1
      hidden_pivots: {}
    - model: lk2_platform_integrity_legacy
      explore: maestroqa_rubric_answers
      type: table
      fields: [maestroqa_answers.created_month, maestroqa_templates.leo_process_grouped,
        maestroqa_answers.count]
      filters:
        maestroqa_answers.created_date: 13 months
        maestroqa_templates.leo_process_grouped: "-EMPTY,-NULL"
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: maestroqa_templates.leo_process_grouped
        source_field_name: qa_contact_reason_grouped
      - field_name: maestroqa_answers.created_month
        source_field_name: pi_leo_fte_zd_qa_scores.qa_date_month
    color_application:
      collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
      palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
      options:
        steps: 5
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
    x_axis_zoom: true
    y_axis_zoom: true
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    hidden_pivots: {}
    type: looker_column
    hidden_fields: [pi_leo_fte_zd_qa_scores.qa_count, maestroqa_answers.count]
    pivots: [qa_contact_reason_grouped]
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: coalesce(${pi_leo_fte_zd_qa_scores.qa_count},0)+coalesce(${maestroqa_answers.count},0)
      label: QA Count
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: qa_count
      _type_hint: number
    listen:
    - Productivity QA Contact Reason: pi_leo_fte_zd_qa_scores.qa_process_type
      Productivity QA LP Type: pi_leo_fte_zd_qa_scores.lp_type
      Agent Email: pi_leo_fte_zd_qa_scores.qa_reviewer
    - Agent Email: zendesk_agent.email
    row: 35
    col: 12
    width: 12
    height: 11
  filters:
  - name: Agent Email
    title: Agent Email
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
      options:
      - apandikow@snapchat.com
      - aquemuel@snapchat.com
      - bsundararajan@snapchat.com
      - byap@snapchat.com
      - ccoladonato@snapchat.com
      - dang2@snapchat.com
      - epanthradil@snapchat.com
      - kng@snapchat.com
      - kprice2@snapchat.com
      - lgourdine@snapchat.com
      - nelhannari@snapchat.com
      - schuku@snapchat.com
      - jcitron@snapchat.com
      - ocan@snapchat.com
      - pgermany@snapchat.com
      - rtodd@snapchat.com
      - akasare@snapchat.com
      - ishiao@snapchat.com
      - skorsbakke@snapchat.com
      - smalik3@snapchat.com
      - bli6@snapchat.com
      - rbright@snapchat.com
      - arai@snapchat.com
      - scovey@snapchat.com
      - nschembri@snapchat.com
      - xzhang13@snapchat.com
      - jhelm@snapchat.com
      - elim@snapchat.com
      - abussey@snapchat.com
      - lgonzalez2@snapchat.com
      - hkizhakkiniyakath@snapchat.com
      - gazuike@snapchat.com
      - sbaero@snapchat.com
      - klaughland@snapchat.com
      - mbacaloni@snapchat.com
      - abastiman@snapchat.com
      - rbenn@snapchat.com
    model: lk2_community_ops_legacy
    explore: zendesk_ticket
    listens_to_filters: []
    field: zendesk_agent.email
  - name: LEO Level
    title: LEO Level
    type: field_filter
    default_value: Specialist,Senior
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
      options:
      - Specialist
      - Senior
    model: lk2_community_ops_legacy
    explore: zendesk_ticket
    listens_to_filters: []
    field: zendesk_agent.leo_level
  - name: Agent Tags
    title: Agent Tags
    type: field_filter
    default_value: "-%enablement%"
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: lk2_community_ops_legacy
    explore: zendesk_ticket
    listens_to_filters: []
    field: zendesk_agent.tags
  - name: Productivity Solved Contact Reason
    title: Productivity Solved Contact Reason
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: lk2_community_ops_legacy
    explore: zendesk_ticket
    listens_to_filters: []
    field: zendesk_ticket.leo_contact_reason_grouped
  - name: Productivity QA Contact Reason
    title: Productivity QA Contact Reason
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: lk2_platform_integrity_standard
    explore: pi_leo_fte_zd_qa_scores
    listens_to_filters: []
    field: pi_leo_fte_zd_qa_scores.qa_process_type
  - name: Productivity QA LP Type
    title: Productivity QA LP Type
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
      options:
      - CO
      - SW
      - Subpoena
      - PRTT
      - WT
      - PRTT/SW Hybrid
    model: lk2_platform_integrity_standard
    explore: pi_leo_fte_zd_qa_scores
    listens_to_filters: []
    field: pi_leo_fte_zd_qa_scores.lp_type
  - name: Date Filter
    title: Date Filter
    type: field_filter
    default_value: 365 day
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
      options: []
    model: lk2_community_ops_legacy
    explore: zendesk_ticket
    listens_to_filters: []
    field: zendesk_ticket_metric_sets.solved_at_date
