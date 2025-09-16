view: pi_leo_fte_zd_qa_questions_scores {
  view_label: "LEO QA Question Scores"

  dimension: id {
    primary_key: yes
    hidden: yes
    sql: CONCAT(CAST(${pi_leo_fte_zd_qa_scores.index} AS STRING),'|', CAST(${question_text} AS STRING)) ;;
  }

  dimension: sheet_source {
    type: string
    hidden: yes
  }

  dimension: question_text {
    type: string
  }

  dimension: question_category {
    type: string
  }

  dimension: question_weight {
    type: number
    sql: CAST(${TABLE}.question_weight AS STRING) ;;
  }

  dimension: question_name {
    type: string
  }

  dimension: question_score {
    type: number
    description: "0 for incorrect or 1 for correct"
    sql: ${TABLE}.question_score ;;
  }

  dimension: value_yes_no {
    type: yesno
    label: "Value"
    description: "Does the question have a score a positive score?"
    sql: ${question_score} = 1 ;;
  }

  dimension: value_is_null {
    type: yesno
    label: "Value is Null"
    description: "Does the question have a score at all?"
    sql: ${question_score} IS NULL ;;
  }

  measure: weighted_score {
    type: sum
    label: "Weighted Score"
    sql: ${TABLE}.question_weight * ${question_score} ;;
    drill_fields: [detail*]
  }

  measure: question_count {
    type: count
    drill_fields: [detail*]
  }

  measure: questions_correct {
    type: sum
    label: "Questions Correct Count"
    sql: ${question_score} ;;
    drill_fields: [detail*]
    description: "Checked questions"
  }

  measure: questions_incorrect {
    type: sum
    label: "Questions Incorrect Count"
    sql: IF(${question_score}=0,1,0) ;;
    drill_fields: [detail*]
    description: "Unchecked questions"
  }

  measure: percent_true {
    label: "Percent Questions Correct"
    type: number
    sql: ${questions_correct} / ${question_count} ;;
    value_format: "0.00%"
    drill_fields: [detail*]
    description: "Percent questions checked"
  }

  measure: percent_false {
    label: "Percent Questions Incorrect"
    type: number
    sql: 1 - (${questions_correct} / ${question_count}) ;;
    value_format: "0.00%"
    drill_fields: [detail*]
    description: "Percent questions unchecked"
  }

  set: detail {
    fields: [
      pi_leo_fte_zd_qa_scores.qa_date_date,
      pi_leo_fte_zd_qa_scores.qa_reviewer,
      pi_leo_fte_zd_qa_scores.qa_recipient,
      pi_leo_fte_zd_qa_scores.case_number,
      pi_leo_fte_zd_qa_scores.action_date_date,
      pi_leo_fte_zd_qa_scores.score,
      pi_leo_fte_zd_qa_scores.qa_process_type,
      pi_leo_fte_zd_qa_scores.sheet_source,
      question_category,
      question_weight,
      question_text,
      question_name,
      question_score
    ]
  }

}
