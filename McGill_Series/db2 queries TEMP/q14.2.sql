SELECT COUNT(*) as numcourses, dept
FROM course
GROUP BY dept
ORDER BY numcourses DESC, dept
;
