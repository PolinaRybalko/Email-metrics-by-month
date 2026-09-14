# Email-metrics-by-month
Email data for traching the emails sent by month

For each account and each month we need the following data: 
1. how many emails were sent to this account in a given month;
2. what percentage does the number of emails constitute out of all emails sent in this month;
3. the first date the email was sent in this month;
4. the last date the email was sent this month.

Note: sent_date is a field in emails_sent table which represents the number of days it took after the session to send the email. That's why I needed to calculate this field using date_add function.
