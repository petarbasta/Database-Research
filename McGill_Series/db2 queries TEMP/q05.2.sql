SELECT DISTINCT c.credits, c.ccode
FROM enroll e, course c
WHERE e.ccode = c.ccode AND e.sid = 12345678
ORDER BY c.ccode;
