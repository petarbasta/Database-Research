SELECT ccode, COUNT(*) as numstudents
FROM enroll
WHERE term = 'winter 2018'
GROUP BY ccode
UNION
SELECT ccode, 0 as numstudents
FROM courseoffer
WHERE term = 'winter 2018' AND ccode NOT IN
( SELECT ccode FROM enroll WHERE term = 'winter 2018' )
ORDER BY ccode
;
