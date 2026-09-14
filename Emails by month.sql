with all_emails_by_month as (
   SELECT
      accs.account_id AS id_account,
      date_trunc(date_add(s.date, INTERVAL sent_date day), month) AS sent_month,
      date_add(s.date, INTERVAL sent_date day) AS sent_date,
    FROM `DA.email_sent` es
    JOIN `DA.account_session` accs
      ON
        es.id_account = accs.account_id
    JOIN `DA.session` s
      ON
        s.ga_session_id = accs.ga_session_id
)

SELECT DISTINCT
  sent_month,
  id_account,
  COUNT(*)
    OVER (PARTITION BY sent_month, id_account)
    / COUNT(*) OVER (PARTITION BY sent_month)
    * 100
    AS sent_msg_percent_from_this_month,
  min(sent_date) OVER (PARTITION BY sent_month, id_account) AS first_sent_date,
  max(sent_date) OVER (PARTITION BY sent_month, id_account) AS last_sent_date
FROM all_emails_by_month
ORDER BY sent_month, id_account