view: chc_support_site_csat {
  sql_table_name: `businesshelpcenteranalytics.support_site_csat.support_site_csat_agg` ;;

  dimension: pk {
    type: string
    sql: CONCAT(${TABLE}.clientId, "|", ${TABLE}.ga_session_id, "|", ${TABLE}.date) ;;
    primary_key: yes
    hidden: yes
  }

  dimension: date {
    type: date
    sql: TIMESTAMP(${TABLE}.date) ;;
  }

  dimension: csat_reason  {
    group_label: "CSAT"
    label: "CSAT Reason"
    sql: CASE
          WHEN ${TABLE}.event_label LIKE '%answer my question or solve my problem%'
                    OR ${TABLE}.event_label LIKE '%Denne artikel besvarede ikke mit spørgsmål eller løste mit problem%'
                    OR ${TABLE}.event_label LIKE '%Dieser Artikel hat meine Frage nicht beantwortet und mein Problem nicht gelöst.%'
                    OR ${TABLE}.event_label LIKE '%answer my question or solve my problem%'
                    OR ${TABLE}.event_label LIKE '%Este artículo no respondió mi pregunta o solucionó mi problema%'
                    OR ${TABLE}.event_label LIKE '%pas résolu mon problème%'
                    OR ${TABLE}.event_label LIKE '%non ha risposto alla mia domanda o non ha risolto il mio problema%'
                    OR ${TABLE}.event_label LIKE '%Dit artikel heeft mijn vraag niet beantwoord of mijn probleem niet opgelost%'
                    OR ${TABLE}.event_label LIKE '%この記事は私の質問に答えず、私の問題を解決しませんでした%'
                    OR ${TABLE}.event_label LIKE '%Denne artikkelen besvarte ikke spørsmålet eller løste problemet mitt%'
                    OR ${TABLE}.event_label LIKE '%Este artigo não respondeu à minha pergunta ou não resolveu meu problema%'
                    OR ${TABLE}.event_label LIKE '%Artikkeli ei vastannut kysymykseeni eikä ratkaissut ongelmaani%'
                    OR ${TABLE}.event_label LIKE '%Den här artikeln svarade inte på min fråga eller löste inte mitt problem%'
                    OR ${TABLE}.event_label LIKE 'Este artículo no respondió a mi pregunta ni resolvió mi problema'
                    OR ${TABLE}.event_label LIKE 'इस लेख से मेरे सवाल का जवाब नहीं मिला या मेरी समस्या का समाधान नहीं हुआ'
                    OR ${TABLE}.event_label LIKE '%لم يجيب هذا المقال على سؤالي أو يحل مشكلتي%' THEN "This article didn't answer my question or solve my problem"
                  WHEN ${TABLE}.event_label LIKE '%This article was hard to understand%'
                    OR ${TABLE}.event_label LIKE '%Denne artikel var svær at forstå%'
                    OR ${TABLE}.event_label LIKE '%Dieser Artikel war schwer zu verstehen.%'
                    OR ${TABLE}.event_label LIKE '%This article was hard to understand%'
                    OR ${TABLE}.event_label LIKE '%Este artículo fue difícil de entender%'
                    OR ${TABLE}.event_label LIKE '%Cet article était difficile à comprendre%'
                    OR ${TABLE}.event_label LIKE '%Questo articolo è stato difficile da comprendere%'
                    OR ${TABLE}.event_label LIKE '%Dit artikel was moeilijk te begrijpen.%'
                    OR ${TABLE}.event_label LIKE '%この記事は分かりにくかった%'
                    OR ${TABLE}.event_label LIKE '%Denne artikkelen var vanskelig å forstå%'
                    OR ${TABLE}.event_label LIKE '%Este artigo foi difícil de entender%'
                    OR ${TABLE}.event_label LIKE '%Tämä artikkeli oli vaikeaselkoinen%'
                    OR ${TABLE}.event_label LIKE '%Den här artikeln är svårt att förstå%'
                    OR ${TABLE}.event_label LIKE 'Ovaj članak je teško razumjeti'
                    OR ${TABLE}.event_label LIKE 'इस लेख को समझना मुश्किल था'
                    OR ${TABLE}.event_label LIKE '%كان من الصعب فهم هذه المقالة%' THEN "This article was hard to understand"
                  WHEN ${TABLE}.event_label LIKE '%match what I see in Snapchat%'
                    OR ${TABLE}.event_label LIKE '%Denne artikel er ikke korrekt eller svarer ikke til det, jeg ser på Snapchat%'
                    OR ${TABLE}.event_label LIKE '%Dieser Artikel ist nicht präzise oder stimmt nicht mit dem überein, was ich in Snapchat sehe.%'
                    OR ${TABLE}.event_label LIKE '%match what I see in Snapchat%'
                    OR ${TABLE}.event_label LIKE '%Este artículo no es preciso o no coincide con lo que veo en Snapchat%'
                    OR ${TABLE}.event_label LIKE '%pas exact ou ne correspond pas à ce que je vois sur Snapchat.%'
                    OR ${TABLE}.event_label LIKE '%Questo articolo non è preciso o non corrisponde a cosa vedo su Snapchat%'
                    OR ${TABLE}.event_label LIKE '%Dit artikel is niet nauwkeurig of past niet bij wat ik in Snapchat zie.%'
                    OR ${TABLE}.event_label LIKE '%この記事は不正確であるか、Snapchatに表示されるものと一致しない%'
                    OR ${TABLE}.event_label LIKE '%Denne artikkelen er upresis eller stemmer ikke med det jeg ser på Snapchat%'
                    OR ${TABLE}.event_label LIKE '%Este artigo não é muito preciso ou não corresponde ao que vejo no Snapchat%'
                    OR ${TABLE}.event_label LIKE '%Tämän artikkelin sisältö ei pidä paikaansa tai vastaa Snapchatissa näkemääni sisältöä%'
                    OR ${TABLE}.event_label LIKE '%Den här artikeln är inte korrekt eller matchar inte det jag ser i Snapchat%'
                    OR ${TABLE}.event_label LIKE 'Тази статия не е точна или не съответства на това, което виждам в Snapchat'
                    OR ${TABLE}.event_label LIKE 'Níl an t-alt seo cruinn nó ní thagann sé leis an méid a fheiceann mé ar Snapchat'
                    OR ${TABLE}.event_label LIKE 'यह लेख सटीक नहीं है या Snapchat में मैंने जो देखा है उससे मेल नहीं खाता'
                    OR ${TABLE}.event_label LIKE '%هذه المقالة غير دقيقة أو لا تتوافق مع ما أراه على سناب شات%' THEN "This article isnt accurate or doesnt match what I see in Snapchat"
        WHEN ${TABLE}.event_label LIKE '%like how the feature described in this article works%'
          OR ${TABLE}.event_label LIKE '%Jeg bryder mig ikke om, hvordan den funktion, der er beskrevet i denne artikel, fungerer%'
          OR ${TABLE}.event_label LIKE '%Mir gefällt nicht, wie das in diesem Artikel beschriebene Feature funktioniert.%'
          OR ${TABLE}.event_label LIKE '%like how the feature described in this article works%'
          OR ${TABLE}.event_label LIKE '%No me gusta cómo funciona la función descrita en este artículo%'
          OR ${TABLE}.event_label LIKE '%pas comment la fonctionnalité décrite dans cet article fonctionne%'
          OR ${TABLE}.event_label LIKE '%Non mi piace come funziona la funzionalità descritta in questo articolo%'
          OR ${TABLE}.event_label LIKE '%Ik hou niet van hoe de functie in dit artikel beschreven, werkt.%'
          OR ${TABLE}.event_label LIKE '%この記事で説明されている機能の仕組みが好きではない%'
          OR ${TABLE}.event_label LIKE '%Jeg liker ikke måten funksjonen som er beskrevet i denne artikkelen fungerer på%'
          OR ${TABLE}.event_label LIKE '%Não gosto de como o recurso descrito neste artigo funciona%'
          OR ${TABLE}.event_label LIKE '%En pidä siitä, miten tässä artikkelissa kuvailtu ominaisuus toimii%'
          OR ${TABLE}.event_label LIKE '%Jag gillar inte hur funktionen som beskrivs i den här artikeln fungerar%'
          OR ${TABLE}.event_label LIKE 'इस लेख में बताया गया फ़ीचर जिस तरीके से काम करता है, वह मुझे पसंद नहीं है'
          OR ${TABLE}.event_label LIKE '%لا أحب طريقة عمل الميزة الموضّحة في هذه المقالة%' THEN "I dont like how the feature described in this article works"
      ELSE NULL END

            ;;
    type: string
    description: "CSAT Survey reason selections after negative rating."
  }

  dimension: event_Label {
    type: string
    sql:${TABLE}.event_label  ;;
  }

  dimension: item_list_name{
    type: string
    sql: ${TABLE}.item_list_name ;;
    hidden: yes
  }

  measure: count_csat_yes {
    type: count_distinct
    label: "Count CSAT Yes [ga4]"
    sql: ${TABLE}.clientId ;;
    filters: [event_Label: "Vote: Yes", item_list_name: "Article CSAT"]
    group_label: "CSAT"
    description: "Count of distinct Yes votes based on the visitor ID and page that the vote was submitted on"
  }

  measure: count_csat_no {
    type: count_distinct
    label: "Count CSAT No [ga4]"
    sql: ${community_help_center.visitor_page} ;;
    filters: [event_Label: "Vote: Yes", item_list_name: "Article CSAT"]
    group_label: "CSAT"
    description: "Count of distinct No votes based on the visitor ID and page that the vote was submitted on"
  }

  measure: count_csat_votes {
    type: number
    label: "Count CSAT Votes [ga4]"
    sql: ${count_csat_yes}+${count_csat_no} ;;
    group_label: "CSAT"
    description: "Count of distinct Yes and No votes based on the visitor ID and page that the vote was submitted on"
  }

  measure: percent_csat_yes {
    sql: ${count_csat_yes}/NULLIF((${count_csat_yes}+${count_csat_no}), 0) ;;
    type: number
    value_format_name: percent_0
    label: "% CSAT Yes (Surveys) [ga4]"
    description: "% of Yes survery responses to Article CSAT survey as a proportion of all survery responses (yes + no); distinct only"
    group_label: "CSAT"
  }

  # measure: percent_csat_no_sessions {
  #   sql: ${count_csat_no}/NULLIF(${article_sessions}, 0) ;;
  #   type: number
  #   value_format_name: percent_2
  #   label: "% CSAT No (Sessions) [ga4]"
  #   description: "% of No survery responses to Article CSAT survey as a proportion of all sessions with Article views"
  #   group_label: "CSAT"
  # }


}
