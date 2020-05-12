SELECT sname, sid
FROM student
WHERE sid IN
(
  SELECT sid
	FROM enroll
	WHERE (ccode, term) IN (SELECT ccode, term FROM enroll WHERE sid = 12345678) 
	  AND sid <> 12345678
)
ORDER BY sid;

