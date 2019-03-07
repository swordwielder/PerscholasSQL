-- By: Qi Chen

-- 3-A, select # courses and join department with  course.
SELECT 
    Department.Name 'Department Name',
    COUNT(Course.Name) '# Courses'
FROM
    Department
        JOIN
    Course ON Course.DeptId = Department.Id
GROUP BY Department.Id
ORDER BY COUNT(Course.Name) ASC;

-- 3-B, select # students and join course with student course.
SELECT 
    Course.Name 'Course Name',
    COUNT(StudentCourse.StudentId) '# Student'
FROM
    Course
        JOIN
    StudentCourse ON StudentCourse.CourseId = Course.Id
GROUP BY StudentCourse.CourseId
ORDER BY COUNT(StudentCourse.StudentId) DESC , Course.Name ASC;


-- 3-C1, select #faculty and join course with faculty course
SELECT 
    Course.Name 'Course Name',
    COUNT(FacultyCourse.FacultyId) '#Faculty'
FROM
    Course
        LEFT JOIN
    FacultyCourse ON Course.Id = FacultyCourse.CourseId
GROUP BY Course.Id
HAVING COUNT(FacultyCourse.FacultyId) = 0
ORDER BY 'Course Name' ASC;

-- 3-C2, select # students in those courses of the statement above.
SELECT 
    Course.Name 'Course Name',
    COUNT(StudentCourse.StudentId) '#Students'
FROM
    StudentCourse
        LEFT JOIN
    Course ON StudentCourse.CourseId = Course.Id
        LEFT JOIN
    FacultyCourse ON Course.Id = FacultyCourse.CourseId
GROUP BY Course.Id
HAVING COUNT(FacultyCourse.FacultyId) = 0
ORDER BY Course.Name ASC;

-- 3-D, select amount of students in each year
SELECT 
    COUNT(DISTINCT StudentId) AS Students,
    YEAR(StartDate) AS Year
FROM
    StudentCourse
GROUP BY Year
ORDER BY Year ASC;

-- 3-E, select amount of students in every august
SELECT 
    COUNT(StudentId) AS Students, StartDate AS Year
FROM
    StudentCourse
WHERE
    MONTH(StartDate) = 8
GROUP BY Year
ORDER BY Year ASC;

-- 3-F, select #courses and join students with student &course and department
SELECT 
    Student.FirstName,
    Student.LastName,
    COUNT(Course.Id) AS NumCourses
FROM
    Student
        JOIN
    StudentCourse ON Student.Id = StudentCourse.StudentId
        JOIN
    Course ON StudentCourse.CourseId = Course.Id
        JOIN
    Department ON Course.DeptId = Department.Id
WHERE
    Department.Id = Student.MajorId
GROUP BY Student.Id
ORDER BY NumCourses ASC , LastName ASC;

-- 3-G, select students who made below average
SELECT 
    FirstName,
    LastName,
    ROUND(AVG(StudentCourse.Progress), 1) AS Average
FROM
    Student
        JOIN
    StudentCourse ON Student.Id = StudentCourse.StudentId
GROUP BY Student.Id
HAVING Average < 50
ORDER BY Average DESC;

-- 3-H1, select average progress for each course.
SELECT 
    Name, AVG(Progress) AS Average
FROM
    Course
        JOIN
    StudentCourse ON Course.Id = StudentCourse.CourseId
GROUP BY Course.Id
ORDER BY Average DESC;

-- 3-H2, selects max of the average
SELECT 
    MAX(Average) 'Max average'
FROM
    (SELECT 
        Name, AVG(Progress) AS 'Average'
    FROM
        Course
    JOIN StudentCourse ON Course.Id = StudentCourse.CourseId
    GROUP BY Course.Id
    ORDER BY Average DESC) AS Outer_Query;
    
-- 3-H3, selects average progress and join faculty with courses.
SELECT 
    Faculty.FirstName,
    Faculty.LastName,
    AVG(Progress) AS Average
FROM
    Faculty
        JOIN
    FacultyCourse ON FacultyCourse.FacultyId = Faculty.Id
        JOIN
    Course ON Course.Id = FacultyCourse.CourseId
        JOIN
    StudentCourse ON Course.Id = StudentCourse.CourseId
GROUP BY Faculty.Id;

-- 3-H4, selects average and multiply by the max in H-2.
SELECT 
    Faculty.FirstName,
    Faculty.LastName,
    AVG(Progress) AS Average
FROM
    Faculty
        JOIN
    FacultyCourse ON FacultyCourse.FacultyId = Faculty.Id
        JOIN
    Course ON Course.Id = FacultyCourse.CourseId
        JOIN
    StudentCourse ON Course.Id = StudentCourse.CourseId
GROUP BY Faculty.Id
HAVING Average > 0.9 * (SELECT 
        MAX(Average) 'Max average'
    FROM
        (SELECT 
            Name, AVG(Progress) AS 'Average'
        FROM
            Course
        JOIN StudentCourse ON Course.Id = StudentCourse.CourseId
        GROUP BY Course.Id
        ORDER BY Average DESC) AS Outer_Query)
ORDER BY Average DESC;

-- 3-I, show the grades for all students. 
SELECT 
    FirstName,
    LastName,
    CASE
        WHEN MIN(Progress) < 40 THEN 'F'
        WHEN MIN(Progress) < 50 THEN 'D'
        WHEN MIN(Progress) < 60 THEN 'C'
        WHEN MIN(Progress) < 70 THEN 'B'
        WHEN MIN(Progress) >= 70 THEN 'A'
    END 'MIN GRADE',
    CASE
        WHEN MAX(Progress) < 40 THEN 'F'
        WHEN MAX(Progress) < 50 THEN 'D'
        WHEN MAX(Progress) < 60 THEN 'C'
        WHEN MAX(Progress) < 70 THEN 'B'
        WHEN MAX(Progress) >= 70 THEN 'A'
    END 'MAX GRADE'
FROM
    Student
        JOIN
    StudentCourse ON Student.Id = StudentCourse.StudentId
GROUP BY Student.Id;

