SELECT credits, ccode
FROM course
WHERE dept = 'computer science' AND credits IN (3, 1)
ORDER BY credits DESC, ccode;
