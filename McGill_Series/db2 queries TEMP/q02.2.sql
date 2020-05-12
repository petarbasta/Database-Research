SELECT credits, ccode
FROM course 
WHERE dept = 'computer science'
  AND ccode in (SELECT ccode FROM courseoffer WHERE term = 'winter 2018')
ORDER BY ccode;
