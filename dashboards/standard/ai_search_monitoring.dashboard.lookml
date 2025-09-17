- dashboard: ai_search_monitoring
  title: AI Search Monitoring
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: 98kl4fkn93IOHpIQdyvyXL
  elements:
  - title: Usage & Usage Rate
    name: Usage & Usage Rate
    model: lk2_community_ops_standard
    explore: community_help_center
    type: looker_line
    fields: [community_help_center.date_date, hits.count_quick_answer_users, community_help_center.count_users,
      feature_help_topic_users, hits.count_quick_answer_search]
    fill_fields: [community_help_center.date_date]
    filters:
      community_help_center.date_filter: 30 days
      hits.date_filter: 30 days
    sorts: [community_help_center.date_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${hits.count_quick_answer_users}/${feature_help_topic_users}"
      label: "% Feature Help Topic Users of AI Search"
      value_format:
      value_format_name: percent_1
      _kind_hint: measure
      table_calculation: feature_help_topic_users_of_ai_search
      _type_hint: number
    - category: measure
      expression:
      label: Feature Help Topic Users
      value_format:
      value_format_name:
      based_on: community_help_center.count_users
      _kind_hint: measure
      measure: feature_help_topic_users
      type: count_distinct
      _type_hint: number
      filters:
        hits.full_page_url: "%5122857810001920%"
    - category: table_calculation
      expression: "${hits.count_quick_answer_search}/${hits.count_quick_answer_users}"
      label: Searches / User
      value_format:
      value_format_name: decimal_1
      _kind_hint: measure
      table_calculation: searches_user
      _type_hint: number
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
    y_axes: [{label: '', orientation: left, series: [{axisId: hits.count_quick_answer_users,
            id: hits.count_quick_answer_users, name: Count Users}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: '', orientation: right, series: [{axisId: feature_help_topic_users_of_ai_search,
            id: feature_help_topic_users_of_ai_search, name: "% Feature Help Topic\
              \ Users of AI Search"}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, type: linear}, {label: !!null '', orientation: right,
        series: [{axisId: searches_user, id: searches_user, name: Searches / User}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_pivots: {}
    defaults_version: 1
    hidden_fields: [community_help_center.count_users, feature_help_topic_users, hits.count_quick_answer_search]
    listen:
      Event [ga4] Date: community_help_center.date_date
      Visitor ID [ga4]: community_help_center.fullVisitorId
    row: 2
    col: 12
    width: 12
    height: 8
  - title: Aggregate Search Failure Rate
    name: Aggregate Search Failure Rate
    model: lk2_community_ops_standard
    explore: community_help_center
    type: looker_line
    fields: [community_help_center.date_date, hits.count_quick_answer_no_results,
      hits.count_quick_answer_search_output]
    fill_fields: [community_help_center.date_date]
    filters:
      community_help_center.date_filter: 30 days
    sorts: [community_help_center.date_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${hits.count_quick_answer_users}/${community_help_center.count_users}"
      label: "% Visitors Using AI Search"
      value_format:
      value_format_name: percent_3
      _kind_hint: measure
      table_calculation: visitors_using_ai_search
      _type_hint: number
      is_disabled: true
    - category: table_calculation
      expression: "${hits.count_quick_answer_no_results}/${hits.count_quick_answer_search_output}"
      label: Search Failure Rate
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: search_failure_rate
      _type_hint: number
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
    y_axes: [{label: '', orientation: left, series: [{axisId: hits.count_quick_answer_no_results,
            id: hits.count_quick_answer_no_results, name: Count No Results}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: !!null '', orientation: right, series: [{axisId: search_failure_rate,
            id: search_failure_rate, name: Search Failure Rate}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      hits.count_quick_answer_no_results: column
      hits.count_quick_answer_search_output: column
    series_colors:
      hits.count_quick_answer_no_results: "#dae0e3"
      search_failure_rate: "#1A73E8"
    hidden_pivots: {}
    defaults_version: 1
    hidden_fields: [hits.count_quick_answer_search_output]
    note_state: collapsed
    note_display: hover
    note_text: This is the number of outputs where the AI response could not find
      an answer to a user search input.
    listen:
      Event [ga4] Date: community_help_center.date_date
      Visitor ID [ga4]: community_help_center.fullVisitorId
    row: 54
    col: 0
    width: 12
    height: 8
  - title: Query Input & Output Volume
    name: Query Input & Output Volume
    model: lk2_community_ops_standard
    explore: community_help_center
    type: looker_column
    fields: [community_help_center.date_date, hits.count_quick_answer_search, hits.count_quick_answer_search_output]
    fill_fields: [community_help_center.date_date]
    filters:
      community_help_center.date_filter: 30 days
      hits.date_filter: 30 days
    sorts: [community_help_center.date_date desc]
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
    x_axis_reversed: true
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: ordinal
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: hits.count_quick_answer_search,
            id: hits.count_quick_answer_search, name: Count Search Inputs}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      hits.count_quick_answer_no_results: "#dae0e3"
    x_axis_datetime_label: "%b %e"
    show_null_points: true
    interpolation: linear
    hidden_pivots: {}
    defaults_version: 1
    hidden_fields: [hits.count_quick_answer_search_output]
    listen:
      Event [ga4] Date: community_help_center.date_date
      Visitor ID [ga4]: community_help_center.fullVisitorId
    row: 2
    col: 0
    width: 12
    height: 8
  - title: CSAT Score
    name: CSAT Score
    model: lk2_community_ops_standard
    explore: community_help_center
    type: looker_line
    fields: [community_help_center.date_date, hits.count_quick_answer_search, hits.count_quick_answer_search_output,
      hits.count_quick_answer_csat_yes, hits.count_quick_answer_csat_no]
    fill_fields: [community_help_center.date_date]
    filters:
      community_help_center.date_filter: 30 days
      hits.date_filter: 30 days
    sorts: [community_help_center.date_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${hits.count_quick_answer_csat_yes}/ (${hits.count_quick_answer_csat_yes}+${hits.count_quick_answer_csat_no})"
      label: "% Positive Ratings (Surveys)"
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: positive_ratings_surveys
      _type_hint: number
    - category: table_calculation
      expression: "${hits.count_quick_answer_csat_no}/ (${hits.count_quick_answer_search_output})"
      label: "% Negative Ratings (Answers)"
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: negative_ratings_answers
      _type_hint: number
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
    color_application:
      collection_id: legacy
      palette_id: mixed_dark
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: hits.count_quick_answer_search_output,
            id: hits.count_quick_answer_search_output, name: Count Search Results},
          {axisId: hits.count_quick_answer_search, id: hits.count_quick_answer_search,
            name: Count Search Inputs}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      positive_ratings_surveys: "#33a02c"
      negative_ratings_answers: "#e31a1c"
    hidden_pivots: {}
    defaults_version: 1
    hidden_fields: [hits.count_quick_answer_search, hits.count_quick_answer_search_output,
      hits.count_quick_answer_csat_yes, hits.count_quick_answer_csat_no]
    listen:
      Event [ga4] Date: community_help_center.date_date
      Visitor ID [ga4]: community_help_center.fullVisitorId
    row: 64
    col: 12
    width: 12
    height: 8
  - title: CSAT Response Rate
    name: CSAT Response Rate
    model: lk2_community_ops_standard
    explore: community_help_center
    type: looker_line
    fields: [community_help_center.date_date, hits.count_quick_answer_search, hits.count_quick_answer_search_output,
      hits.count_quick_answer_csat_yes, hits.count_quick_answer_csat_no]
    fill_fields: [community_help_center.date_date]
    filters:
      community_help_center.date_filter: 30 days
    sorts: [community_help_center.date_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "(${hits.count_quick_answer_csat_yes}+${hits.count_quick_answer_csat_no})/${hits.count_quick_answer_search_output}"
      label: "% Response Given"
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: response_given
      _type_hint: number
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
    y_axes: [{label: '', orientation: left, series: [{axisId: hits.count_quick_answer_search_output,
            id: hits.count_quick_answer_search_output, name: Count Search Results},
          {axisId: hits.count_quick_answer_search, id: hits.count_quick_answer_search,
            name: Count Search Inputs}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      hits.count_quick_answer_no_results: "#dae0e3"
    hidden_pivots: {}
    defaults_version: 1
    hidden_fields: [hits.count_quick_answer_search, hits.count_quick_answer_search_output,
      hits.count_quick_answer_csat_yes, hits.count_quick_answer_csat_no]
    listen:
      Event [ga4] Date: community_help_center.date_date
      Visitor ID [ga4]: community_help_center.fullVisitorId
    row: 64
    col: 0
    width: 12
    height: 8
  - title: Breakdown of Queries by Validity
    name: Breakdown of Queries by Validity
    model: lk2_community_ops_standard
    explore: community_help_center
    type: looker_column
    fields: [community_help_center.date_date, is_valid_input, hits.count_quick_answer_search]
    pivots: [is_valid_input]
    fill_fields: [community_help_center.date_date]
    filters:
      community_help_center.date_filter: 30 days
      hits.date_filter: 30 days
    sorts: [is_valid_input, community_help_center.date_date desc]
    limit: 500
    column_limit: 50
    row_total: right
    dynamic_fields:
    - category: table_calculation
      expression: "${hits.count_quick_answer_search_valid}/${hits.count_quick_answer_search}"
      label: "% Valid Searches"
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: valid_searches
      _type_hint: number
      is_disabled: true
    - category: table_calculation
      expression: pivot_index(${hits.count_quick_answer_search_valid}, 2)/${hits.count_quick_answer_search_valid:row_total}
      label: "% AI Output from Valid Searches"
      value_format:
      value_format_name: percent_1
      _kind_hint: supermeasure
      table_calculation: ai_output_from_valid_searches
      _type_hint: number
      is_disabled: true
    - category: dimension
      expression: |-
        if(
          (if(matches_filter(${hits.search_input}, `%_ %_`), yes, no)
        OR
        ${zai_search_output_yesno}=yes), yes, no
        )
      label: Is Valid Input
      value_format:
      value_format_name:
      dimension: is_valid_input
      _kind_hint: dimension
      _type_hint: yesno
    - category: table_calculation
      expression: "${hits.count_quick_answer_search}/${hits.count_quick_answer_search:row_total}"
      label: "% of Total"
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: of_total
      _type_hint: number
    - category: dimension
      expression: |-
        case(
          when(contains(${hits.search_result},"إجابة الذكاء الاصطناعي غير متوفرة لهذا البحث. حاول إعادة صياغة سؤالك بكلمات"), no),
        when(contains(${hits.search_result},"Et AI-svar er ikke tilgængeligt for denne søgning"), no),
        when(contains(${hits.search_result},"Eine KI-Antwort ist für diese Suche nicht verfügbar"), no),
        when(contains(${hits.search_result},"Una respuesta de IA no está disponible para esta búsqueda"), no),
        when(contains(${hits.search_result},"AI-vastaus ei ole saatavilla tälle haulle"), no),
        when(contains(${hits.search_result},"Une réponse IA n'est pas disponible pour cette recherche"), no),
        when(contains(${hits.search_result},"इस खोज के लिए AI उत्तर उपलब्ध नहीं है। अलग कीवर्ड के साथ अपने प्रश्न को दोबारा"), no),
        when(contains(${hits.search_result},"Una risposta AI non è disponibile per questa ricerca"), no),
        when(contains(${hits.search_result},"この検索にはAI回答が利用できません。異なるキーワードで質問を言い換えるか、質問を簡潔にしてみてください。"), no),
        when(contains(${hits.search_result},"Et AI-svar er ikke tilgjengelig for dette søket"), no),
        when(contains(${hits.search_result},"Uma resposta de IA não está disponível para esta pesquisa"), no),
        when(contains(${hits.search_result},"ИИ-ответ недоступен для этого поиска"), no),
        when(contains(${hits.search_result},"Odpowiedź AI nie jest dostępna dla tego wyszukiwania"), no),
        when(contains(${hits.search_result},"Un răspuns AI nu este disponibil pentru această căutare"), no),
        when(contains(${hits.search_result},"Ett AI-svar är inte tillgängligt för denna sökning"), no),
        when(contains(${hits.search_result},"Bu arama için bir AI cevabı mevcut değil"), no),
        when(contains(${hits.search_result},"AI отговор не е наличен за това търсене"), no),
        when(contains(${hits.search_result},"AI odgovor nije dostupan za ovu pretragu"), no),
        when(contains(${hits.search_result},"AI odpověď není pro toto vyhledávání k dispozici"), no),
        when(contains(${hits.search_result},"AI vastus pole selle otsingu jaoks saadaval"), no),
        when(contains(${hits.search_result},"Μια απάντηση AI δεν είναι διαθέσιμη για αυτή την αναζήτηση. Δοκιμάστε να"), no),
        when(contains(${hits.search_result},"AI válasz nem érhető el ehhez a kereséshez"), no),
        when(contains(${hits.search_result},"Níl freagra AI ar fáil don chuardach seo"), no),
        when(contains(${hits.search_result},"AI atbilde nav pieejama šai meklēšanai"), no),
        when(contains(${hits.search_result},"AI atsakymas neprieinamas šiam paieškai"), no),
        when(contains(${hits.search_result},"Tweġiba AI mhix disponibbli għal din it-tiftix"), no),
        when(contains(${hits.search_result},"AI odpoveď nie je pre toto vyhľadávanie k dispozícii"), no),
        when(contains(${hits.search_result},"AI odgovor ni na voljo za to iskanje"), no),
        when(contains(${hits.search_result},"Something went wrong. Please try again later"), no),
        when(contains(${hits.search_result},"An AI Answer is not available for this search"), no),
        when(contains(${hits.search_result},"Ответ ИИ недоступен для этого поиска"), no),
        when(contains(${hits.search_result},"Bu arama için bir Yapay Zeka Yanıtı yok"), no),
        when(contains(${hits.search_result},"لا تتوفر إجابة مدعومة بالذكاء الاصطناعي لهذا البحث. حاول إعادة صياغة سؤالك باستخدام كلمات رئيسية مختلفة أو تبسيط سؤالك"), no),
        when(contains(${hits.search_result},"Er is geen AI-antwoord beschikbaar voor deze zoekopdracht"), no),
        when(contains(${hits.search_result},"No hay ninguna respuesta de IA disponible para esta búsqueda"), no),
        when(contains(${hits.search_result},"Umělá inteligence není pro toto vyhledávání dostupná"), no),
        when(contains(${hits.search_result},"Ett AI-svar finns inte tillgängligt för den här sökningen"), no),
        when(contains(${hits.search_result},"Una respuesta de AI no está disponible para esta búsqueda"), no),
            yes
        )
      label: zAI Search Output (Yes/No)
      value_format:
      value_format_name:
      dimension: zai_search_output_yesno
      _kind_hint: dimension
      _type_hint: yesno
    filter_expression: |-
      ${hits.quick_answer_yesno}=yes OR
      (
        ${hits.event_Category}="Quick Search Standalone" OR
        ${hits.event_Category}="Quick Search CSAT"
      )
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
    stacking: percent
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: desc
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: legacy
      palette_id: mixed_dark
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: valid_searches, id: valid_searches,
            name: "% Valid Searches"}], showLabels: true, showValues: true, maxValue: !!null '',
        minValue: !!null '', unpinAxis: true, tickDensity: default, type: linear},
      {label: !!null '', orientation: right, series: [{axisId: hits.quick_answer_length_avg,
            id: hits.quick_answer_length_avg, name: Search Input Length Average}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      Yes - hits.count_quick_answer_search_valid: "#33a02c"
      No - hits.count_quick_answer_search_valid: "#000000"
      Yes - of_total: "#33a02c"
      No - of_total: "#000000"
    series_labels:
      Yes - of_total: Valid Query
      No - of_total: Invalid Query
    show_null_points: true
    interpolation: linear
    hidden_pivots:
      "$$$_row_total_$$$":
        is_entire_pivot_hidden: true
    defaults_version: 1
    hidden_fields: [hits.count_quick_answer_search]
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
    note_state: collapsed
    note_display: hover
    note_text: A valid input contains at least two words, or one-word that generated
      a response (e.g. Snapchat+)
    listen:
      Event [ga4] Date: community_help_center.date_date
      Visitor ID [ga4]: community_help_center.fullVisitorId
    row: 20
    col: 0
    width: 12
    height: 8
  - title: Usage Map
    name: Usage Map
    model: lk2_community_ops_standard
    explore: community_help_center
    type: looker_geo_choropleth
    fields: [hits.count_quick_answer_users, community_help_center.country]
    filters:
      community_help_center.date_filter: 30 days
      hits.date_filter: 30 days
    sorts: [hits.count_quick_answer_users desc 0]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${hits.count_quick_answer_users}/${community_help_center.count_users}"
      label: "% Visitors Using AI Search"
      value_format:
      value_format_name: percent_3
      _kind_hint: measure
      table_calculation: visitors_using_ai_search
      _type_hint: number
      is_disabled: true
    map: auto
    map_projection: ''
    show_view_names: false
    quantize_colors: false
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
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    y_axes: [{label: '', orientation: left, series: [{axisId: hits.count_quick_answer_users,
            id: hits.count_quick_answer_users, name: Count Users}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: !!null '', orientation: right, series: [{axisId: visitors_using_ai_search,
            id: visitors_using_ai_search, name: "% Visitors Using AI Search"}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_pivots: {}
    defaults_version: 1
    hidden_fields: []
    listen:
      Event [ga4] Date: community_help_center.date_date
      Visitor ID [ga4]: community_help_center.fullVisitorId
    row: 10
    col: 12
    width: 12
    height: 8
  - name: Searches as % of CS Tickets
    title: Searches as % of CS Tickets
    merged_queries:
    - model: lk2_community_ops_legacy
      explore: zendesk_ticket
      type: looker_line
      fields: [zendesk_ticket.count_tickets, zendesk_ticket.created_date]
      fill_fields: [zendesk_ticket.created_date]
      filters:
        zendesk_ticket_initials.initial_form: feedback-1
      sorts: [zendesk_ticket.created_date desc]
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
      show_value_labels: false
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      show_null_points: true
      interpolation: linear
      x_axis_zoom: true
      y_axis_zoom: true
      reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
          margin_value: mean, margin_bottom: deviation, label_position: right, color: "#000000",
          value_format: ''}]
      defaults_version: 1
    - model: lk2_community_ops_standard
      explore: community_help_center
      type: table
      fields: [community_help_center.date_date, hits.count_quick_answer_search]
      fill_fields: [community_help_center.date_date]
      filters:
        community_help_center.date_filter: 30 days
        hits.date_filter: 30 days
      sorts: [community_help_center.date_date desc]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: community_help_center.date_date
        source_field_name: zendesk_ticket.created_date
    color_application:
      collection_id: legacy
      palette_id: mixed_dark
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: zendesk_ticket.count_tickets,
            id: zendesk_ticket.count_tickets, name: Count Tickets}, {axisId: hits.count_quick_answer_search,
            id: hits.count_quick_answer_search, name: Count Search Inputs}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: linear}, {
        label: '', orientation: right, series: [{axisId: search_of_tickets, id: search_of_tickets,
            name: Search % of Tickets}], showLabels: true, showValues: true, unpinAxis: true,
        tickDensity: default, type: linear}]
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
    series_colors:
      zendesk_ticket.count_tickets: "#1f78b4"
      hits.count_quick_answer_search: "#33a02c"
      search_of_tickets: "#000000"
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    type: looker_line
    hidden_pivots: {}
    dynamic_fields:
    - category: table_calculation
      expression: "${hits.count_quick_answer_search}/${zendesk_ticket.count_tickets}"
      label: Search % of Tickets
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: search_of_tickets
      _type_hint: number
    listen:
    - Event [ga4] Date: zendesk_ticket.created_date
    - Event [ga4] Date: community_help_center.date_date
      Visitor ID [ga4]: community_help_center.fullVisitorId
    row: 74
    col: 0
    width: 12
    height: 8
  - title: Query Input by Website Language
    name: Query Input by Website Language
    model: lk2_community_ops_standard
    explore: community_help_center
    type: looker_column
    fields: [community_help_center.date_date, hits.count_quick_answer_search, hits.count_quick_answer_search_output,
      hits.website_language]
    pivots: [hits.website_language]
    filters:
      community_help_center.date_filter: 30 days
      hits.date_filter: 30 days
    sorts: [hits.website_language, community_help_center.date_date desc]
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
    x_axis_reversed: true
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: ordinal
    y_axis_combined: true
    ordering: desc
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
      palette_id: 5d189dfc-4f46-46f3-822b-bfb0b61777b1
      options:
        steps: 5
        reverse: true
    y_axes: [{label: '', orientation: left, series: [{axisId: hits.count_quick_answer_search_output,
            id: hits.count_quick_answer_search_output, name: Count Search Results},
          {axisId: hits.count_quick_answer_search, id: hits.count_quick_answer_search,
            name: Count Search Inputs}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_series: [hits.count_quick_answer_search_output]
    series_colors:
      hits.count_quick_answer_no_results: "#dae0e3"
    x_axis_datetime_label: "%b %e"
    show_null_points: true
    interpolation: linear
    hidden_pivots: {}
    defaults_version: 1
    hidden_fields: [hits.count_quick_answer_search_output]
    listen:
      Event [ga4] Date: community_help_center.date_date
      Visitor ID [ga4]: community_help_center.fullVisitorId
    row: 10
    col: 0
    width: 12
    height: 8
  - title: Response Rate for Valid Queries
    name: Response Rate for Valid Queries
    model: lk2_community_ops_standard
    explore: community_help_center
    type: looker_line
    fields: [community_help_center.date_date, hits.count_quick_answer_search, zcount_no_results,
      hits.count_quick_answer_no_results]
    fill_fields: [community_help_center.date_date]
    filters:
      community_help_center.date_filter: 30 days
      hits.date_filter: 30 days
      is_valid_input: 'Yes'
    sorts: [community_help_center.date_date desc]
    limit: 5000
    column_limit: 50
    dynamic_fields:
    - category: dimension
      expression: |-
        if(
          (if(matches_filter(${hits.search_input}, `%_ %_`), yes, no)
        OR
        ${zai_search_output_yesno}=yes), yes, no
        )
      label: Is Valid Input
      value_format:
      value_format_name:
      dimension: is_valid_input
      _kind_hint: dimension
      _type_hint: yesno
    - category: table_calculation
      expression: 1-(${zcount_no_results}/${hits.count_quick_answer_search})
      label: "% Valid Queries Responded"
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: valid_queries_responded
      _type_hint: number
    - category: dimension
      expression: |-
        case(
          when(contains(${hits.search_result},"إجابة الذكاء الاصطناعي غير متوفرة لهذا البحث. حاول إعادة صياغة سؤالك بكلمات"), no),
        when(contains(${hits.search_result},"Et AI-svar er ikke tilgængeligt for denne søgning"), no),
        when(contains(${hits.search_result},"Eine KI-Antwort ist für diese Suche nicht verfügbar"), no),
        when(contains(${hits.search_result},"Una respuesta de IA no está disponible para esta búsqueda"), no),
        when(contains(${hits.search_result},"AI-vastaus ei ole saatavilla tälle haulle"), no),
        when(contains(${hits.search_result},"Une réponse IA n'est pas disponible pour cette recherche"), no),
        when(contains(${hits.search_result},"इस खोज के लिए AI उत्तर उपलब्ध नहीं है। अलग कीवर्ड के साथ अपने प्रश्न को दोबारा"), no),
        when(contains(${hits.search_result},"Una risposta AI non è disponibile per questa ricerca"), no),
        when(contains(${hits.search_result},"この検索にはAI回答が利用できません。異なるキーワードで質問を言い換えるか、質問を簡潔にしてみてください。"), no),
        when(contains(${hits.search_result},"Et AI-svar er ikke tilgjengelig for dette søket"), no),
        when(contains(${hits.search_result},"Uma resposta de IA não está disponível para esta pesquisa"), no),
        when(contains(${hits.search_result},"ИИ-ответ недоступен для этого поиска"), no),
        when(contains(${hits.search_result},"Odpowiedź AI nie jest dostępna dla tego wyszukiwania"), no),
        when(contains(${hits.search_result},"Un răspuns AI nu este disponibil pentru această căutare"), no),
        when(contains(${hits.search_result},"Ett AI-svar är inte tillgängligt för denna sökning"), no),
        when(contains(${hits.search_result},"Bu arama için bir AI cevabı mevcut değil"), no),
        when(contains(${hits.search_result},"AI отговор не е наличен за това търсене"), no),
        when(contains(${hits.search_result},"AI odgovor nije dostupan za ovu pretragu"), no),
        when(contains(${hits.search_result},"AI odpověď není pro toto vyhledávání k dispozici"), no),
        when(contains(${hits.search_result},"AI vastus pole selle otsingu jaoks saadaval"), no),
        when(contains(${hits.search_result},"Μια απάντηση AI δεν είναι διαθέσιμη για αυτή την αναζήτηση. Δοκιμάστε να"), no),
        when(contains(${hits.search_result},"AI válasz nem érhető el ehhez a kereséshez"), no),
        when(contains(${hits.search_result},"Níl freagra AI ar fáil don chuardach seo"), no),
        when(contains(${hits.search_result},"AI atbilde nav pieejama šai meklēšanai"), no),
        when(contains(${hits.search_result},"AI atsakymas neprieinamas šiam paieškai"), no),
        when(contains(${hits.search_result},"Tweġiba AI mhix disponibbli għal din it-tiftix"), no),
        when(contains(${hits.search_result},"AI odpoveď nie je pre toto vyhľadávanie k dispozícii"), no),
        when(contains(${hits.search_result},"AI odgovor ni na voljo za to iskanje"), no),
        when(contains(${hits.search_result},"Something went wrong. Please try again later"), no),
        when(contains(${hits.search_result},"An AI Answer is not available for this search"), no),
        when(contains(${hits.search_result},"Ответ ИИ недоступен для этого поиска"), no),
        when(contains(${hits.search_result},"Bu arama için bir Yapay Zeka Yanıtı yok"), no),
        when(contains(${hits.search_result},"لا تتوفر إجابة مدعومة بالذكاء الاصطناعي لهذا البحث. حاول إعادة صياغة سؤالك باستخدام كلمات رئيسية مختلفة أو تبسيط سؤالك"), no),
        when(contains(${hits.search_result},"Er is geen AI-antwoord beschikbaar voor deze zoekopdracht"), no),
        when(contains(${hits.search_result},"No hay ninguna respuesta de IA disponible para esta búsqueda"), no),
        when(contains(${hits.search_result},"Umělá inteligence není pro toto vyhledávání dostupná"), no),
        when(contains(${hits.search_result},"Ett AI-svar finns inte tillgängligt för den här sökningen"), no),
        when(contains(${hits.search_result},"Una respuesta de AI no está disponible para esta búsqueda"), no),
            yes
        )
      label: zAI Search Output (Yes/No)
      value_format:
      value_format_name:
      dimension: zai_search_output_yesno
      _kind_hint: dimension
      _type_hint: yesno
    - category: measure
      expression:
      label: zCount No Results
      value_format:
      value_format_name:
      based_on: hits.count_quick_answer_search_output
      _kind_hint: measure
      measure: zcount_no_results
      type: count
      _type_hint: number
      filters:
        zai_search_output_yesno: 'no'
    filter_expression: |-
      ${hits.quick_answer_yesno}=yes OR
      (
        ${hits.event_Category}="Quick Search Standalone" OR
        ${hits.event_Category}="Quick Search CSAT"
      )
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
    color_application:
      collection_id: legacy
      palette_id: mixed_dark
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: responded, id: responded,
            name: "% Responded"}], showLabels: true, showValues: true, unpinAxis: true,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      Yes - responded: "#33a02c"
      No - responded: "#000000"
      responded: "#33a02c"
      valid_queries_responded: "#33a02c"
    series_labels:
      No - responded: Invalid Input
      Yes - responded: Valid Input
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
    minimum_column_width: 75
    column_order: ["$$$_row_numbers_$$$", community_help_center.date_date, hits.search_input,
      hits.search_result, hits.source_link, hits.support_link]
    hidden_fields: [hits.count_quick_answer_search, zcount_no_results, hits.count_quick_answer_no_results]
    hidden_pivots: {}
    note_state: collapsed
    note_display: hover
    note_text: A valid input contains at least two words, or one-word that generated
      a response (e.g. Snapchat+)
    listen:
      Event [ga4] Date: community_help_center.date_date
      Visitor ID [ga4]: community_help_center.fullVisitorId
    row: 38
    col: 0
    width: 12
    height: 8
  - title: Search Failure Rate of Valid Queries
    name: Search Failure Rate of Valid Queries
    model: lk2_community_ops_standard
    explore: community_help_center
    type: looker_line
    fields: [community_help_center.date_date, hits.count_quick_answer_no_results,
      hits.count_quick_answer_search_output, zcount_no_results]
    fill_fields: [community_help_center.date_date]
    filters:
      community_help_center.date_filter: 30 days
      hits.date_filter: 30 days
      is_valid_input: 'Yes'
    sorts: [community_help_center.date_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${hits.count_quick_answer_users}/${community_help_center.count_users}"
      label: "% Visitors Using AI Search"
      value_format:
      value_format_name: percent_3
      _kind_hint: measure
      table_calculation: visitors_using_ai_search
      _type_hint: number
      is_disabled: true
    - category: table_calculation
      expression: "${zcount_no_results}/${hits.count_quick_answer_search_output}"
      label: Search Failure Rate
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: search_failure_rate
      _type_hint: number
    - category: dimension
      expression: |-
        if(
          (if(matches_filter(${hits.search_input}, `%_ %_`), yes, no)
        OR
        ${zai_search_output_yesno}=yes), yes, no
        )
      label: Is Valid Input
      value_format:
      value_format_name:
      dimension: is_valid_input
      _kind_hint: dimension
      _type_hint: yesno
    - category: dimension
      expression: |-
        case(
          when(contains(${hits.search_result},"إجابة الذكاء الاصطناعي غير متوفرة لهذا البحث. حاول إعادة صياغة سؤالك بكلمات"), no),
        when(contains(${hits.search_result},"Et AI-svar er ikke tilgængeligt for denne søgning"), no),
        when(contains(${hits.search_result},"Eine KI-Antwort ist für diese Suche nicht verfügbar"), no),
        when(contains(${hits.search_result},"Una respuesta de IA no está disponible para esta búsqueda"), no),
        when(contains(${hits.search_result},"AI-vastaus ei ole saatavilla tälle haulle"), no),
        when(contains(${hits.search_result},"Une réponse IA n'est pas disponible pour cette recherche"), no),
        when(contains(${hits.search_result},"इस खोज के लिए AI उत्तर उपलब्ध नहीं है। अलग कीवर्ड के साथ अपने प्रश्न को दोबारा"), no),
        when(contains(${hits.search_result},"Una risposta AI non è disponibile per questa ricerca"), no),
        when(contains(${hits.search_result},"この検索にはAI回答が利用できません。異なるキーワードで質問を言い換えるか、質問を簡潔にしてみてください。"), no),
        when(contains(${hits.search_result},"Et AI-svar er ikke tilgjengelig for dette søket"), no),
        when(contains(${hits.search_result},"Uma resposta de IA não está disponível para esta pesquisa"), no),
        when(contains(${hits.search_result},"ИИ-ответ недоступен для этого поиска"), no),
        when(contains(${hits.search_result},"Odpowiedź AI nie jest dostępna dla tego wyszukiwania"), no),
        when(contains(${hits.search_result},"Un răspuns AI nu este disponibil pentru această căutare"), no),
        when(contains(${hits.search_result},"Ett AI-svar är inte tillgängligt för denna sökning"), no),
        when(contains(${hits.search_result},"Bu arama için bir AI cevabı mevcut değil"), no),
        when(contains(${hits.search_result},"AI отговор не е наличен за това търсене"), no),
        when(contains(${hits.search_result},"AI odgovor nije dostupan za ovu pretragu"), no),
        when(contains(${hits.search_result},"AI odpověď není pro toto vyhledávání k dispozici"), no),
        when(contains(${hits.search_result},"AI vastus pole selle otsingu jaoks saadaval"), no),
        when(contains(${hits.search_result},"Μια απάντηση AI δεν είναι διαθέσιμη για αυτή την αναζήτηση. Δοκιμάστε να"), no),
        when(contains(${hits.search_result},"AI válasz nem érhető el ehhez a kereséshez"), no),
        when(contains(${hits.search_result},"Níl freagra AI ar fáil don chuardach seo"), no),
        when(contains(${hits.search_result},"AI atbilde nav pieejama šai meklēšanai"), no),
        when(contains(${hits.search_result},"AI atsakymas neprieinamas šiam paieškai"), no),
        when(contains(${hits.search_result},"Tweġiba AI mhix disponibbli għal din it-tiftix"), no),
        when(contains(${hits.search_result},"AI odpoveď nie je pre toto vyhľadávanie k dispozícii"), no),
        when(contains(${hits.search_result},"AI odgovor ni na voljo za to iskanje"), no),
        when(contains(${hits.search_result},"Something went wrong. Please try again later"), no),
        when(contains(${hits.search_result},"An AI Answer is not available for this search"), no),
        when(contains(${hits.search_result},"Ответ ИИ недоступен для этого поиска"), no),
        when(contains(${hits.search_result},"Bu arama için bir Yapay Zeka Yanıtı yok"), no),
        when(contains(${hits.search_result},"لا تتوفر إجابة مدعومة بالذكاء الاصطناعي لهذا البحث. حاول إعادة صياغة سؤالك باستخدام كلمات رئيسية مختلفة أو تبسيط سؤالك"), no),
        when(contains(${hits.search_result},"Er is geen AI-antwoord beschikbaar voor deze zoekopdracht"), no),
        when(contains(${hits.search_result},"No hay ninguna respuesta de IA disponible para esta búsqueda"), no),
        when(contains(${hits.search_result},"Umělá inteligence není pro toto vyhledávání dostupná"), no),
        when(contains(${hits.search_result},"Ett AI-svar finns inte tillgängligt för den här sökningen"), no),
        when(contains(${hits.search_result},"Una respuesta de AI no está disponible para esta búsqueda"), no),
            yes
        )
      label: zAI Search Output (Yes/No)
      value_format:
      value_format_name:
      dimension: zai_search_output_yesno
      _kind_hint: dimension
      _type_hint: yesno
    - category: measure
      expression:
      label: zCount No Results
      value_format:
      value_format_name:
      based_on: hits.count_quick_answer_search_output
      _kind_hint: measure
      measure: zcount_no_results
      type: count
      _type_hint: number
      filters:
        zai_search_output_yesno: 'no'
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
    color_application:
      collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
      palette_id: 5d189dfc-4f46-46f3-822b-bfb0b61777b1
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: hits.count_quick_answer_no_results,
            id: hits.count_quick_answer_no_results, name: Count No Results}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: !!null '', orientation: right, series: [{axisId: search_failure_rate,
            id: search_failure_rate, name: Search Failure Rate}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      hits.count_quick_answer_no_results: column
      hits.count_quick_answer_search_output: column
      zcount_no_results: column
    series_colors:
      zcount_no_results: "#dae0e3"
      search_failure_rate: "#1A73E8"
    hidden_pivots: {}
    defaults_version: 1
    hidden_fields: [hits.count_quick_answer_search_output, hits.count_quick_answer_no_results]
    note_state: collapsed
    note_display: hover
    note_text: This is the number of outputs where the AI response could not find
      an answer to a user search input when the input was valid
    listen:
      Event [ga4] Date: community_help_center.date_date
      Visitor ID [ga4]: community_help_center.fullVisitorId
    row: 54
    col: 12
    width: 12
    height: 8
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: '[{"type":"h1","children":[{"text":"Usage","bold":true}],"align":"center","id":"1a479"}]'
    rich_content_json: '{"format":"slate"}'
    row: 0
    col: 0
    width: 24
    height: 2
  - name: " (Copy 2)"
    type: text
    title_text: " (Copy 2)"
    subtitle_text: ''
    body_text: '[{"type":"h1","children":[{"text":"CSAT (Thumbs Up/Down)","bold":true}],"align":"center","id":"1a479"}]'
    rich_content_json: '{"format":"slate"}'
    row: 62
    col: 0
    width: 24
    height: 2
  - name: " (Copy 3)"
    type: text
    title_text: " (Copy 3)"
    subtitle_text: ''
    body_text: '[{"type":"h1","children":[{"text":"Other","bold":true}],"align":"center","id":"1a479"}]'
    rich_content_json: '{"format":"slate"}'
    row: 72
    col: 0
    width: 24
    height: 2
  - name: " (Copy)"
    type: text
    title_text: " (Copy)"
    subtitle_text: ''
    body_text: '[{"type":"h1","children":[{"text":"Query Validity","bold":true}],"align":"center","id":"1a479"}]'
    rich_content_json: '{"format":"slate"}'
    row: 18
    col: 0
    width: 24
    height: 2
  - title: Breakdown of Queries by Validity by Website Language
    name: Breakdown of Queries by Validity by Website Language
    model: lk2_community_ops_standard
    explore: community_help_center
    type: looker_column
    fields: [is_valid_input, hits.count_quick_answer_search, hits.website_language]
    pivots: [is_valid_input]
    filters:
      community_help_center.date_filter: 30 days
      hits.date_filter: 30 days
      hits.website_language: "-NULL"
      hits.count_quick_answer_search: ">0"
    sorts: [is_valid_input, hits.count_quick_answer_search desc 0]
    limit: 500
    column_limit: 50
    row_total: right
    dynamic_fields:
    - category: table_calculation
      expression: "${hits.count_quick_answer_search_valid}/${hits.count_quick_answer_search}"
      label: "% Valid Searches"
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: valid_searches
      _type_hint: number
      is_disabled: true
    - category: table_calculation
      expression: pivot_index(${hits.count_quick_answer_search_valid}, 2)/${hits.count_quick_answer_search_valid:row_total}
      label: "% AI Output from Valid Searches"
      value_format:
      value_format_name: percent_1
      _kind_hint: supermeasure
      table_calculation: ai_output_from_valid_searches
      _type_hint: number
      is_disabled: true
    - category: dimension
      expression: |-
        if(
          (if(matches_filter(${hits.search_input}, `%_ %_`), yes, no)
        OR
        ${zai_search_output_yesno}=yes), yes, no
        )
      label: Is Valid Input
      value_format:
      value_format_name:
      dimension: is_valid_input
      _kind_hint: dimension
      _type_hint: yesno
    - category: table_calculation
      expression: "${hits.count_quick_answer_search}/${hits.count_quick_answer_search:row_total}"
      label: "% of Total"
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: of_total
      _type_hint: number
    - category: dimension
      expression: |-
        case(
          when(contains(${hits.search_result},"إجابة الذكاء الاصطناعي غير متوفرة لهذا البحث. حاول إعادة صياغة سؤالك بكلمات"), no),
        when(contains(${hits.search_result},"Et AI-svar er ikke tilgængeligt for denne søgning"), no),
        when(contains(${hits.search_result},"Eine KI-Antwort ist für diese Suche nicht verfügbar"), no),
        when(contains(${hits.search_result},"Una respuesta de IA no está disponible para esta búsqueda"), no),
        when(contains(${hits.search_result},"AI-vastaus ei ole saatavilla tälle haulle"), no),
        when(contains(${hits.search_result},"Une réponse IA n'est pas disponible pour cette recherche"), no),
        when(contains(${hits.search_result},"इस खोज के लिए AI उत्तर उपलब्ध नहीं है। अलग कीवर्ड के साथ अपने प्रश्न को दोबारा"), no),
        when(contains(${hits.search_result},"Una risposta AI non è disponibile per questa ricerca"), no),
        when(contains(${hits.search_result},"この検索にはAI回答が利用できません。異なるキーワードで質問を言い換えるか、質問を簡潔にしてみてください。"), no),
        when(contains(${hits.search_result},"Et AI-svar er ikke tilgjengelig for dette søket"), no),
        when(contains(${hits.search_result},"Uma resposta de IA não está disponível para esta pesquisa"), no),
        when(contains(${hits.search_result},"ИИ-ответ недоступен для этого поиска"), no),
        when(contains(${hits.search_result},"Odpowiedź AI nie jest dostępna dla tego wyszukiwania"), no),
        when(contains(${hits.search_result},"Un răspuns AI nu este disponibil pentru această căutare"), no),
        when(contains(${hits.search_result},"Ett AI-svar är inte tillgängligt för denna sökning"), no),
        when(contains(${hits.search_result},"Bu arama için bir AI cevabı mevcut değil"), no),
        when(contains(${hits.search_result},"AI отговор не е наличен за това търсене"), no),
        when(contains(${hits.search_result},"AI odgovor nije dostupan za ovu pretragu"), no),
        when(contains(${hits.search_result},"AI odpověď není pro toto vyhledávání k dispozici"), no),
        when(contains(${hits.search_result},"AI vastus pole selle otsingu jaoks saadaval"), no),
        when(contains(${hits.search_result},"Μια απάντηση AI δεν είναι διαθέσιμη για αυτή την αναζήτηση. Δοκιμάστε να"), no),
        when(contains(${hits.search_result},"AI válasz nem érhető el ehhez a kereséshez"), no),
        when(contains(${hits.search_result},"Níl freagra AI ar fáil don chuardach seo"), no),
        when(contains(${hits.search_result},"AI atbilde nav pieejama šai meklēšanai"), no),
        when(contains(${hits.search_result},"AI atsakymas neprieinamas šiam paieškai"), no),
        when(contains(${hits.search_result},"Tweġiba AI mhix disponibbli għal din it-tiftix"), no),
        when(contains(${hits.search_result},"AI odpoveď nie je pre toto vyhľadávanie k dispozícii"), no),
        when(contains(${hits.search_result},"AI odgovor ni na voljo za to iskanje"), no),
        when(contains(${hits.search_result},"Something went wrong. Please try again later"), no),
        when(contains(${hits.search_result},"An AI Answer is not available for this search"), no),
        when(contains(${hits.search_result},"Ответ ИИ недоступен для этого поиска"), no),
        when(contains(${hits.search_result},"Bu arama için bir Yapay Zeka Yanıtı yok"), no),
        when(contains(${hits.search_result},"لا تتوفر إجابة مدعومة بالذكاء الاصطناعي لهذا البحث. حاول إعادة صياغة سؤالك باستخدام كلمات رئيسية مختلفة أو تبسيط سؤالك"), no),
        when(contains(${hits.search_result},"Er is geen AI-antwoord beschikbaar voor deze zoekopdracht"), no),
        when(contains(${hits.search_result},"No hay ninguna respuesta de IA disponible para esta búsqueda"), no),
        when(contains(${hits.search_result},"Umělá inteligence není pro toto vyhledávání dostupná"), no),
        when(contains(${hits.search_result},"Ett AI-svar finns inte tillgängligt för den här sökningen"), no),
        when(contains(${hits.search_result},"Una respuesta de AI no está disponible para esta búsqueda"), no),
            yes
        )
      label: zAI Search Output (Yes/No)
      value_format:
      value_format_name:
      dimension: zai_search_output_yesno
      _kind_hint: dimension
      _type_hint: yesno
    filter_expression: |-
      ${hits.quick_answer_yesno}=yes OR
      (
        ${hits.event_Category}="Quick Search Standalone" OR
        ${hits.event_Category}="Quick Search CSAT"
      )
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: percent
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: desc
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: legacy
      palette_id: mixed_dark
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: valid_searches, id: valid_searches,
            name: "% Valid Searches"}], showLabels: true, showValues: true, maxValue: !!null '',
        minValue: !!null '', unpinAxis: true, tickDensity: default, type: linear},
      {label: !!null '', orientation: right, series: [{axisId: hits.quick_answer_length_avg,
            id: hits.quick_answer_length_avg, name: Search Input Length Average}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      Yes - hits.count_quick_answer_search_valid: "#33a02c"
      No - hits.count_quick_answer_search_valid: "#000000"
      Yes - of_total: "#33a02c"
      No - of_total: "#000000"
    series_labels:
      Yes - of_total: Valid Query
      No - of_total: Invalid Query
    show_null_points: true
    interpolation: linear
    hidden_pivots:
      "$$$_row_total_$$$":
        is_entire_pivot_hidden: true
    defaults_version: 1
    hidden_fields: [hits.count_quick_answer_search]
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
    note_state: collapsed
    note_display: hover
    note_text: A valid input contains at least two words, or one-word that generated
      a response (e.g. Snapchat+)
    listen:
      Event [ga4] Date: community_help_center.date_date
      Visitor ID [ga4]: community_help_center.fullVisitorId
    row: 20
    col: 12
    width: 12
    height: 8
  - title: Response Rate for Valid Queries by Website Language
    name: Response Rate for Valid Queries by Website Language
    model: lk2_community_ops_standard
    explore: community_help_center
    type: looker_grid
    fields: [hits.website_language, hits.count_quick_answer_search, zcount_no_results,
      hits.count_quick_answer_no_results]
    filters:
      community_help_center.date_filter: 30 days
      hits.date_filter: 30 days
      is_valid_input: 'Yes'
    sorts: [hits.count_quick_answer_search desc]
    limit: 5000
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: 1-(${zcount_no_results}/${hits.count_quick_answer_search})
      label: "% Valid Queries Responded"
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: valid_queries_responded
      _type_hint: number
    - category: dimension
      expression: |-
        if(
          (if(matches_filter(${hits.search_input}, `%_ %_`), yes, no)
        OR
        ${zai_search_output_yesno}=yes), yes, no
        )
      label: Is Valid Input
      value_format:
      value_format_name:
      dimension: is_valid_input
      _kind_hint: dimension
      _type_hint: yesno
    - category: dimension
      expression: |-
        case(
          when(contains(${hits.search_result},"إجابة الذكاء الاصطناعي غير متوفرة لهذا البحث. حاول إعادة صياغة سؤالك بكلمات"), no),
        when(contains(${hits.search_result},"Et AI-svar er ikke tilgængeligt for denne søgning"), no),
        when(contains(${hits.search_result},"Eine KI-Antwort ist für diese Suche nicht verfügbar"), no),
        when(contains(${hits.search_result},"Una respuesta de IA no está disponible para esta búsqueda"), no),
        when(contains(${hits.search_result},"AI-vastaus ei ole saatavilla tälle haulle"), no),
        when(contains(${hits.search_result},"Une réponse IA n'est pas disponible pour cette recherche"), no),
        when(contains(${hits.search_result},"इस खोज के लिए AI उत्तर उपलब्ध नहीं है। अलग कीवर्ड के साथ अपने प्रश्न को दोबारा"), no),
        when(contains(${hits.search_result},"Una risposta AI non è disponibile per questa ricerca"), no),
        when(contains(${hits.search_result},"この検索にはAI回答が利用できません。異なるキーワードで質問を言い換えるか、質問を簡潔にしてみてください。"), no),
        when(contains(${hits.search_result},"Et AI-svar er ikke tilgjengelig for dette søket"), no),
        when(contains(${hits.search_result},"Uma resposta de IA não está disponível para esta pesquisa"), no),
        when(contains(${hits.search_result},"ИИ-ответ недоступен для этого поиска"), no),
        when(contains(${hits.search_result},"Odpowiedź AI nie jest dostępna dla tego wyszukiwania"), no),
        when(contains(${hits.search_result},"Un răspuns AI nu este disponibil pentru această căutare"), no),
        when(contains(${hits.search_result},"Ett AI-svar är inte tillgängligt för denna sökning"), no),
        when(contains(${hits.search_result},"Bu arama için bir AI cevabı mevcut değil"), no),
        when(contains(${hits.search_result},"AI отговор не е наличен за това търсене"), no),
        when(contains(${hits.search_result},"AI odgovor nije dostupan za ovu pretragu"), no),
        when(contains(${hits.search_result},"AI odpověď není pro toto vyhledávání k dispozici"), no),
        when(contains(${hits.search_result},"AI vastus pole selle otsingu jaoks saadaval"), no),
        when(contains(${hits.search_result},"Μια απάντηση AI δεν είναι διαθέσιμη για αυτή την αναζήτηση. Δοκιμάστε να"), no),
        when(contains(${hits.search_result},"AI válasz nem érhető el ehhez a kereséshez"), no),
        when(contains(${hits.search_result},"Níl freagra AI ar fáil don chuardach seo"), no),
        when(contains(${hits.search_result},"AI atbilde nav pieejama šai meklēšanai"), no),
        when(contains(${hits.search_result},"AI atsakymas neprieinamas šiam paieškai"), no),
        when(contains(${hits.search_result},"Tweġiba AI mhix disponibbli għal din it-tiftix"), no),
        when(contains(${hits.search_result},"AI odpoveď nie je pre toto vyhľadávanie k dispozícii"), no),
        when(contains(${hits.search_result},"AI odgovor ni na voljo za to iskanje"), no),
        when(contains(${hits.search_result},"Something went wrong. Please try again later"), no),
        when(contains(${hits.search_result},"An AI Answer is not available for this search"), no),
        when(contains(${hits.search_result},"Ответ ИИ недоступен для этого поиска"), no),
        when(contains(${hits.search_result},"Bu arama için bir Yapay Zeka Yanıtı yok"), no),
        when(contains(${hits.search_result},"لا تتوفر إجابة مدعومة بالذكاء الاصطناعي لهذا البحث. حاول إعادة صياغة سؤالك باستخدام كلمات رئيسية مختلفة أو تبسيط سؤالك"), no),
        when(contains(${hits.search_result},"Er is geen AI-antwoord beschikbaar voor deze zoekopdracht"), no),
        when(contains(${hits.search_result},"No hay ninguna respuesta de IA disponible para esta búsqueda"), no),
        when(contains(${hits.search_result},"Umělá inteligence není pro toto vyhledávání dostupná"), no),
        when(contains(${hits.search_result},"Ett AI-svar finns inte tillgängligt för den här sökningen"), no),
        when(contains(${hits.search_result},"Una respuesta de AI no está disponible para esta búsqueda"), no),
            yes
        )
      label: zAI Search Output (Yes/No)
      value_format:
      value_format_name:
      dimension: zai_search_output_yesno
      _kind_hint: dimension
      _type_hint: yesno
    - category: measure
      expression:
      label: zCount No Results
      value_format:
      value_format_name:
      based_on: hits.count_quick_answer_search_output
      _kind_hint: measure
      measure: zcount_no_results
      type: count
      _type_hint: number
      filters:
        zai_search_output_yesno: 'no'
    filter_expression: |-
      ${hits.quick_answer_yesno}=yes OR
      (
        ${hits.event_Category}="Quick Search Standalone" OR
        ${hits.event_Category}="Quick Search CSAT"
      )
    show_view_names: false
    show_row_numbers: true
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
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: legacy
      palette_id: mixed_dark
      options:
        steps: 5
    show_sql_query_menu_options: false
    column_order: ["$$$_row_numbers_$$$", community_help_center.date_date, hits.search_input,
      hits.search_result, hits.source_link, hits.support_link]
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      No - responded: Invalid Input
      Yes - responded: Valid Input
      hits.count_quick_answer_search: Count Valid Queries
    series_cell_visualizations:
      hits.count_quick_answer_search:
        is_active: false
    conditional_formatting: [{type: along a scale..., value: 0.7, background_color: "#33a02c",
        font_color: !!null '', color_application: {collection_id: legacy, palette_id: legacy_diverging2,
          options: {steps: 5, stepped: true, mirror: false, constraints: {mid: {type: number,
                value: 0.7}}}}, bold: false, italic: false, strikethrough: false,
        fields: [valid_queries_responded]}]
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
    show_null_points: true
    interpolation: linear
    y_axes: [{label: '', orientation: left, series: [{axisId: responded, id: responded,
            name: "% Responded"}], showLabels: true, showValues: true, unpinAxis: true,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      Yes - responded: "#33a02c"
      No - responded: "#000000"
      responded: "#33a02c"
      valid_queries_responded: "#33a02c"
    defaults_version: 1
    hidden_fields: [zcount_no_results, hits.count_quick_answer_no_results]
    hidden_pivots: {}
    note_state: collapsed
    note_display: hover
    note_text: A valid input contains at least two words, or one-word that generated
      a response (e.g. Snapchat+)
    listen:
      Event [ga4] Date: community_help_center.date_date
      Visitor ID [ga4]: community_help_center.fullVisitorId
    row: 38
    col: 12
    width: 12
    height: 8
  - name: " (Copy 4)"
    type: text
    title_text: " (Copy 4)"
    subtitle_text: ''
    body_text: '[{"type":"h1","children":[{"text":"Response Rate","bold":true}],"align":"center","id":"1a479"}]'
    rich_content_json: '{"format":"slate"}'
    row: 36
    col: 0
    width: 24
    height: 2
  - title: Examples of Valid Queries and Responses
    name: Examples of Valid Queries and Responses
    model: lk2_community_ops_standard
    explore: community_help_center
    type: looker_grid
    fields: [community_help_center.date_date, hits.website_language, hits.search_input,
      zai_search_output_yesno, hits.search_result, community_help_center.visitStartTime_hour]
    filters:
      community_help_center.date_filter: 14 days
      hits.date_filter: 30 days
      is_valid_input: 'Yes'
      hits.count_quick_answer_csat_no: '0'
      hits.count_quick_answer_csat_yes: '0'
    sorts: [community_help_center.visitStartTime_hour desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: dimension
      expression: |-
        if(
          (if(matches_filter(${hits.search_input}, `%_ %_`), yes, no)
        OR
        ${zai_search_output_yesno}=yes), yes, no
        )
      label: Is Valid Input
      value_format:
      value_format_name:
      dimension: is_valid_input
      _kind_hint: dimension
      _type_hint: yesno
    - category: dimension
      expression: |-
        case(
          when(contains(${hits.search_result},"إجابة الذكاء الاصطناعي غير متوفرة لهذا البحث. حاول إعادة صياغة سؤالك بكلمات"), no),
        when(contains(${hits.search_result},"Et AI-svar er ikke tilgængeligt for denne søgning"), no),
        when(contains(${hits.search_result},"Eine KI-Antwort ist für diese Suche nicht verfügbar"), no),
        when(contains(${hits.search_result},"Una respuesta de IA no está disponible para esta búsqueda"), no),
        when(contains(${hits.search_result},"AI-vastaus ei ole saatavilla tälle haulle"), no),
        when(contains(${hits.search_result},"Une réponse IA n'est pas disponible pour cette recherche"), no),
        when(contains(${hits.search_result},"इस खोज के लिए AI उत्तर उपलब्ध नहीं है। अलग कीवर्ड के साथ अपने प्रश्न को दोबारा"), no),
        when(contains(${hits.search_result},"Una risposta AI non è disponibile per questa ricerca"), no),
        when(contains(${hits.search_result},"この検索にはAI回答が利用できません。異なるキーワードで質問を言い換えるか、質問を簡潔にしてみてください。"), no),
        when(contains(${hits.search_result},"Et AI-svar er ikke tilgjengelig for dette søket"), no),
        when(contains(${hits.search_result},"Uma resposta de IA não está disponível para esta pesquisa"), no),
        when(contains(${hits.search_result},"ИИ-ответ недоступен для этого поиска"), no),
        when(contains(${hits.search_result},"Odpowiedź AI nie jest dostępna dla tego wyszukiwania"), no),
        when(contains(${hits.search_result},"Un răspuns AI nu este disponibil pentru această căutare"), no),
        when(contains(${hits.search_result},"Ett AI-svar är inte tillgängligt för denna sökning"), no),
        when(contains(${hits.search_result},"Bu arama için bir AI cevabı mevcut değil"), no),
        when(contains(${hits.search_result},"AI отговор не е наличен за това търсене"), no),
        when(contains(${hits.search_result},"AI odgovor nije dostupan za ovu pretragu"), no),
        when(contains(${hits.search_result},"AI odpověď není pro toto vyhledávání k dispozici"), no),
        when(contains(${hits.search_result},"AI vastus pole selle otsingu jaoks saadaval"), no),
        when(contains(${hits.search_result},"Μια απάντηση AI δεν είναι διαθέσιμη για αυτή την αναζήτηση. Δοκιμάστε να"), no),
        when(contains(${hits.search_result},"AI válasz nem érhető el ehhez a kereséshez"), no),
        when(contains(${hits.search_result},"Níl freagra AI ar fáil don chuardach seo"), no),
        when(contains(${hits.search_result},"AI atbilde nav pieejama šai meklēšanai"), no),
        when(contains(${hits.search_result},"AI atsakymas neprieinamas šiam paieškai"), no),
        when(contains(${hits.search_result},"Tweġiba AI mhix disponibbli għal din it-tiftix"), no),
        when(contains(${hits.search_result},"AI odpoveď nie je pre toto vyhľadávanie k dispozícii"), no),
        when(contains(${hits.search_result},"AI odgovor ni na voljo za to iskanje"), no),
        when(contains(${hits.search_result},"Something went wrong. Please try again later"), no),
        when(contains(${hits.search_result},"An AI Answer is not available for this search"), no),
        when(contains(${hits.search_result},"Ответ ИИ недоступен для этого поиска"), no),
        when(contains(${hits.search_result},"Bu arama için bir Yapay Zeka Yanıtı yok"), no),
        when(contains(${hits.search_result},"لا تتوفر إجابة مدعومة بالذكاء الاصطناعي لهذا البحث. حاول إعادة صياغة سؤالك باستخدام كلمات رئيسية مختلفة أو تبسيط سؤالك"), no),
        when(contains(${hits.search_result},"Er is geen AI-antwoord beschikbaar voor deze zoekopdracht"), no),
        when(contains(${hits.search_result},"No hay ninguna respuesta de IA disponible para esta búsqueda"), no),
        when(contains(${hits.search_result},"Umělá inteligence není pro toto vyhledávání dostupná"), no),
        when(contains(${hits.search_result},"Ett AI-svar finns inte tillgängligt för den här sökningen"), no),
        when(contains(${hits.search_result},"Una respuesta de AI no está disponible para esta búsqueda"), no),
            yes
        )
      label: zAI Search Output (Yes/No)
      value_format:
      value_format_name:
      dimension: zai_search_output_yesno
      _kind_hint: dimension
      _type_hint: yesno
    - category: table_calculation
      expression: "${hits.count_quick_answer_search_valid}/${hits.count_quick_answer_search}"
      label: "% Valid Searches"
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: valid_searches
      _type_hint: number
      is_disabled: true
    - category: table_calculation
      expression: pivot_index(${hits.count_quick_answer_search_valid}, 2)/${hits.count_quick_answer_search_valid:row_total}
      label: "% AI Output from Valid Searches"
      value_format:
      value_format_name: percent_1
      _kind_hint: supermeasure
      table_calculation: ai_output_from_valid_searches
      _type_hint: number
      is_disabled: true
    - category: table_calculation
      expression: "${hits.count_quick_answer_search}/${hits.count_quick_answer_search:row_total}"
      label: "% of Total"
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: of_total
      _type_hint: number
      is_disabled: true
    filter_expression: |-
      ${hits.quick_answer_yesno}=yes OR
      (
        ${hits.event_Category}="Quick Search Standalone" OR
        ${hits.event_Category}="Quick Search CSAT"
      )
    show_view_names: false
    show_row_numbers: true
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
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: legacy
      palette_id: mixed_dark
      options:
        steps: 5
    show_sql_query_menu_options: false
    column_order: ["$$$_row_numbers_$$$", community_help_center.date_date, hits.website_language,
      hits.search_input, zai_search_output_yesno, hits.search_result]
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      Yes - of_total: Valid Query
      No - of_total: Invalid Query
      zai_search_output_yesno: Is Response?
    series_column_widths:
      community_help_center.date_date: 100
      hits.website_language: 100
      hits.search_input: 372
      zai_search_output_yesno: 75
    series_text_format:
      zai_search_output_yesno: {}
    conditional_formatting: []
    truncate_column_names: false
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
    stacking: percent
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: desc
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: valid_searches, id: valid_searches,
            name: "% Valid Searches"}], showLabels: true, showValues: true, maxValue: !!null '',
        minValue: !!null '', unpinAxis: true, tickDensity: default, type: linear},
      {label: !!null '', orientation: right, series: [{axisId: hits.quick_answer_length_avg,
            id: hits.quick_answer_length_avg, name: Search Input Length Average}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      Yes - hits.count_quick_answer_search_valid: "#33a02c"
      No - hits.count_quick_answer_search_valid: "#000000"
      Yes - of_total: "#33a02c"
      No - of_total: "#000000"
    show_null_points: true
    interpolation: linear
    hidden_pivots: {}
    defaults_version: 1
    hidden_fields: [community_help_center.visitStartTime_hour]
    hidden_points_if_no:
    note_state: collapsed
    note_display: hover
    note_text: A valid input contains at least two words, or one-word that generated
      a response (e.g. Snapchat+)
    listen:
      Event [ga4] Date: community_help_center.date_date
      Visitor ID [ga4]: community_help_center.fullVisitorId
    row: 46
    col: 0
    width: 24
    height: 8
  - title: Examples of Invalid Queries
    name: Examples of Invalid Queries
    model: lk2_community_ops_standard
    explore: community_help_center
    type: looker_grid
    fields: [community_help_center.date_date, hits.website_language, hits.search_input]
    filters:
      community_help_center.date_filter: 14 days
      hits.date_filter: 30 days
      is_valid_input: 'No'
    sorts: [community_help_center.date_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${hits.count_quick_answer_search_valid}/${hits.count_quick_answer_search}"
      label: "% Valid Searches"
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: valid_searches
      _type_hint: number
      is_disabled: true
    - category: table_calculation
      expression: pivot_index(${hits.count_quick_answer_search_valid}, 2)/${hits.count_quick_answer_search_valid:row_total}
      label: "% AI Output from Valid Searches"
      value_format:
      value_format_name: percent_1
      _kind_hint: supermeasure
      table_calculation: ai_output_from_valid_searches
      _type_hint: number
      is_disabled: true
    - category: dimension
      expression: |-
        if(
          (if(matches_filter(${hits.search_input}, `%_ %_`), yes, no)
        OR
        ${zai_search_output_yesno}=yes), yes, no
        )
      label: Is Valid Input
      value_format:
      value_format_name:
      dimension: is_valid_input
      _kind_hint: dimension
      _type_hint: yesno
    - category: table_calculation
      expression: "${hits.count_quick_answer_search}/${hits.count_quick_answer_search:row_total}"
      label: "% of Total"
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: of_total
      _type_hint: number
      is_disabled: true
    - category: dimension
      expression: |-
        case(
          when(contains(${hits.search_result},"إجابة الذكاء الاصطناعي غير متوفرة لهذا البحث. حاول إعادة صياغة سؤالك بكلمات"), no),
        when(contains(${hits.search_result},"Et AI-svar er ikke tilgængeligt for denne søgning"), no),
        when(contains(${hits.search_result},"Eine KI-Antwort ist für diese Suche nicht verfügbar"), no),
        when(contains(${hits.search_result},"Una respuesta de IA no está disponible para esta búsqueda"), no),
        when(contains(${hits.search_result},"AI-vastaus ei ole saatavilla tälle haulle"), no),
        when(contains(${hits.search_result},"Une réponse IA n'est pas disponible pour cette recherche"), no),
        when(contains(${hits.search_result},"इस खोज के लिए AI उत्तर उपलब्ध नहीं है। अलग कीवर्ड के साथ अपने प्रश्न को दोबारा"), no),
        when(contains(${hits.search_result},"Una risposta AI non è disponibile per questa ricerca"), no),
        when(contains(${hits.search_result},"この検索にはAI回答が利用できません。異なるキーワードで質問を言い換えるか、質問を簡潔にしてみてください。"), no),
        when(contains(${hits.search_result},"Et AI-svar er ikke tilgjengelig for dette søket"), no),
        when(contains(${hits.search_result},"Uma resposta de IA não está disponível para esta pesquisa"), no),
        when(contains(${hits.search_result},"ИИ-ответ недоступен для этого поиска"), no),
        when(contains(${hits.search_result},"Odpowiedź AI nie jest dostępna dla tego wyszukiwania"), no),
        when(contains(${hits.search_result},"Un răspuns AI nu este disponibil pentru această căutare"), no),
        when(contains(${hits.search_result},"Ett AI-svar är inte tillgängligt för denna sökning"), no),
        when(contains(${hits.search_result},"Bu arama için bir AI cevabı mevcut değil"), no),
        when(contains(${hits.search_result},"AI отговор не е наличен за това търсене"), no),
        when(contains(${hits.search_result},"AI odgovor nije dostupan za ovu pretragu"), no),
        when(contains(${hits.search_result},"AI odpověď není pro toto vyhledávání k dispozici"), no),
        when(contains(${hits.search_result},"AI vastus pole selle otsingu jaoks saadaval"), no),
        when(contains(${hits.search_result},"Μια απάντηση AI δεν είναι διαθέσιμη για αυτή την αναζήτηση. Δοκιμάστε να"), no),
        when(contains(${hits.search_result},"AI válasz nem érhető el ehhez a kereséshez"), no),
        when(contains(${hits.search_result},"Níl freagra AI ar fáil don chuardach seo"), no),
        when(contains(${hits.search_result},"AI atbilde nav pieejama šai meklēšanai"), no),
        when(contains(${hits.search_result},"AI atsakymas neprieinamas šiam paieškai"), no),
        when(contains(${hits.search_result},"Tweġiba AI mhix disponibbli għal din it-tiftix"), no),
        when(contains(${hits.search_result},"AI odpoveď nie je pre toto vyhľadávanie k dispozícii"), no),
        when(contains(${hits.search_result},"AI odgovor ni na voljo za to iskanje"), no),
        when(contains(${hits.search_result},"Something went wrong. Please try again later"), no),
        when(contains(${hits.search_result},"An AI Answer is not available for this search"), no),
        when(contains(${hits.search_result},"Ответ ИИ недоступен для этого поиска"), no),
        when(contains(${hits.search_result},"Bu arama için bir Yapay Zeka Yanıtı yok"), no),
        when(contains(${hits.search_result},"لا تتوفر إجابة مدعومة بالذكاء الاصطناعي لهذا البحث. حاول إعادة صياغة سؤالك باستخدام كلمات رئيسية مختلفة أو تبسيط سؤالك"), no),
        when(contains(${hits.search_result},"Er is geen AI-antwoord beschikbaar voor deze zoekopdracht"), no),
        when(contains(${hits.search_result},"No hay ninguna respuesta de IA disponible para esta búsqueda"), no),
        when(contains(${hits.search_result},"Umělá inteligence není pro toto vyhledávání dostupná"), no),
        when(contains(${hits.search_result},"Ett AI-svar finns inte tillgängligt för den här sökningen"), no),
        when(contains(${hits.search_result},"Una respuesta de AI no está disponible para esta búsqueda"), no),
            yes
        )
      label: zAI Search Output (Yes/No)
      value_format:
      value_format_name:
      dimension: zai_search_output_yesno
      _kind_hint: dimension
      _type_hint: yesno
    filter_expression: |-
      ${hits.quick_answer_yesno}=yes OR
      (
        ${hits.event_Category}="Quick Search Standalone" OR
        ${hits.event_Category}="Quick Search CSAT"
      )
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
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    stacking: percent
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: desc
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: legacy
      palette_id: mixed_dark
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: valid_searches, id: valid_searches,
            name: "% Valid Searches"}], showLabels: true, showValues: true, maxValue: !!null '',
        minValue: !!null '', unpinAxis: true, tickDensity: default, type: linear},
      {label: !!null '', orientation: right, series: [{axisId: hits.quick_answer_length_avg,
            id: hits.quick_answer_length_avg, name: Search Input Length Average}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      Yes - hits.count_quick_answer_search_valid: "#33a02c"
      No - hits.count_quick_answer_search_valid: "#000000"
      Yes - of_total: "#33a02c"
      No - of_total: "#000000"
    series_labels:
      Yes - of_total: Valid Query
      No - of_total: Invalid Query
    show_null_points: true
    interpolation: linear
    hidden_pivots: {}
    defaults_version: 1
    hidden_fields: []
    note_state: collapsed
    note_display: hover
    note_text: A valid input contains at least two words, or one-word that generated
      a response (e.g. Snapchat+)
    listen:
      Event [ga4] Date: community_help_center.date_date
      Visitor ID [ga4]: community_help_center.fullVisitorId
    row: 28
    col: 0
    width: 24
    height: 8
  filters:
  - name: Event [ga4] Date
    title: Event [ga4] Date
    type: field_filter
    default_value: 14 day
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
      options: []
    model: lk2_community_ops_standard
    explore: community_help_center
    listens_to_filters: []
    field: community_help_center.date_date
  - name: Visitor ID [ga4]
    title: Visitor ID [ga4]
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: lk2_community_ops_standard
    explore: community_help_center
    listens_to_filters: []
    field: community_help_center.fullVisitorId
