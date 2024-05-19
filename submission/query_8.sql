INSERT INTO
deeptianievarghese22866.host_activity_reduced
WITH
  yesterday AS (
    SELECT
      *
    FROM
deeptianievarghese22866.host_activity_reduced
    WHERE
      month_start = '2023-08-01'
  ),
  today AS (
    SELECT
      *
    FROM
deeptianievarghese22866.daily_web_metrics
    WHERE
      DATE = DATE('2023-08-03')
  )
SELECT
  COALESCE(t.user_id, y.host) AS host,
  COALESCE(t.metric_name, y.metric_name) AS metric_name,
  COALESCE(
    y.metric_array,
    REPEAT(
      NULL,
      CAST(
        DATE_DIFF('day', DATE('2023-08-01'), t.date) AS INTEGER
      )
    )
  ) || ARRAY[t.metric_value] AS metric_array,
  '2023-08-01' AS month_start
FROM
  today t
  FULL OUTER JOIN yesterday y ON t.user_id = y.host
  AND t.metric_name = y.metric_name



