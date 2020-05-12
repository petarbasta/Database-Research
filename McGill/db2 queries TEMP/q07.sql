SELECT DISTINCT ccode
FROM courseoffer
WHERE term = 'winter 2017' AND ccode NOT IN
  (SELECT ccode FROM courseoffer WHERE term = 'winter 2018')
ORDER BY ccode;
