SELECT dept, COUNT(*) as numcourses
FROM course
GROUP BY dept
ORDER BY numcourses DESC, dept
;
