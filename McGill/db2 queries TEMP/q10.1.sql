SELECT ccode, term, grade
FROM enroll e
WHERE e.sid = 12345678 
  AND EXISTS
(
  SELECT * FROM course WHERE dept = 'computer science' and ccode = e.ccode
)
ORDER BY ccode, term;

