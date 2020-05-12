SELECT credits, ccode
FROM course
WHERE ccode IN
(
  SELECT ccode FROM enroll WHERE term = 'winter 2018' and sid = 12345678
	  INTERSECT
  SELECT ccode FROM enroll WHERE term = 'winter 2018' and sid = 12345679
)
ORDER BY ccode;

