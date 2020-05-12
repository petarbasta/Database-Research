SELECT AVG(cnt) AS avgenrollment
FROM
(
  SELECT count(*) cnt
  FROM enroll
  WHERE term = 'winter 2018'
  GROUP BY ccode
)t
;
