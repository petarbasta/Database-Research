SELECT DISTINCT COALESCE(cnt, 0) as numstudents, c.ccode
FROM
(
  SELECT ccode, COUNT(*) as cnt
  FROM enroll
  WHERE term = 'winter 2018'
  GROUP BY ccode
)e RIGHT OUTER JOIN courseoffer c
  ON e.ccode = c.ccode
WHERE c.term = 'winter 2018'
ORDER BY c.ccode
;
