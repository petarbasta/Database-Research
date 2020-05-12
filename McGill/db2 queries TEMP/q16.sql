SELECT dept
FROM
(
  SELECT distinct dept, sid
  FROM course c, enroll e
  WHERE c.ccode = e.ccode AND e.term = 'winter 2018'
)s
GROUP BY dept
HAVING COUNT(*) =
(
  SELECT COUNT(distinct sid)
  FROM enroll
  WHERE term = 'winter 2018'
)
ORDER BY dept
;
