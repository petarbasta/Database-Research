SELECT COUNT(*) as numstudents, ccode
FROM enroll
WHERE term = 'winter 2018'
GROUP BY ccode
UNION
SELECT 0 as numstudents, ccode
FROM courseoffer
WHERE term = 'winter 2018' AND ccode NOT IN
( SELECT ccode FROM enroll WHERE term = 'winter 2018' )
ORDER BY ccode
;
