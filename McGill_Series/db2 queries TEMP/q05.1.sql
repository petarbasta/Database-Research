SELECT DISTINCT c.ccode, c.credits
FROM enroll e, course c
WHERE e.ccode = c.ccode AND e.sid = 12345678
ORDER BY c.ccode;
