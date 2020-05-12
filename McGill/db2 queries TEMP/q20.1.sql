SELECT ccode, COUNT(*) as numstudents
FROM enroll
WHERE term = 'winter 2018'
GROUP BY ccode
HAVING COUNT(*) >= ALL
(
  SELECT COUNT(*) cnt
  FROM enroll
  WHERE term = 'winter 2018'
  GROUP BY ccode
)
ORDER BY ccode
;
