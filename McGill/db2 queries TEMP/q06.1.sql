SELECT c.ccode, c.credits
FROM enroll e, course c
WHERE e.ccode = c.ccode
  AND e.sid = 12345678  AND e.term = 'winter 2018'
ORDER BY c.ccode;
