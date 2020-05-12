SELECT ccode, credits
FROM course c
WHERE dept = 'computer science'
  AND EXISTS (SELECT * FROM courseoffer WHERE term = 'winter 2018' AND ccode = c.ccode)
ORDER BY ccode;
