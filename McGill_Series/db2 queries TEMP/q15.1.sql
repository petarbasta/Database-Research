SELECT ccode, credits
FROM course
WHERE dept = 'computer science' AND ccode IN
(
  SELECT ccode
	FROM enroll
	WHERE term = 'winter 2018'
	GROUP BY ccode
	HAVING COUNT(*) >= 5
)
ORDER BY ccode;

