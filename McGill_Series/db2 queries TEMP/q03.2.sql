SELECT DISTINCT c.credits, c.ccode
FROM course c, courseoffer o 
WHERE c.ccode = o.ccode
  AND c.dept = 'computer science'
	AND o.term = 'winter 2018' 
ORDER BY ccode;