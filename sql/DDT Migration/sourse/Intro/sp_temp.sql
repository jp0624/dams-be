SELECT DISTINCT t.CourseID, t.LessonID, t.title, IF(UPPER(LEFT(t.LangID,2))='GB', 'EN', UPPER(LEFT(t.LangID,2))) language, c.Country, l.LessonCode FROM tempvariblesslides1 t 
INNER JOIN ad_main.course c ON c.CourseID = t.CourseID AND c.VehicleType = 'Passenger Vehicles' AND C.CourseType=1
INNER JOIN ad_main.lesson l ON l.LessonID = t.LessonID AND l.LessonTypeID=8 AND l.CourseID = c.CourseID
  WHERE NOT l.LessonCode IS NULL AND NOT l.LessonCode = '' AND l.LessonCode='AOM'
ORDER BY l.LessonCode, c.Country;

SELECT COUNT(*) FROM ad_main.course c 
INNER JOIN ad_main.lesson l ON l.LessonTypeID=8 AND l.CourseID = c.CourseID AND c.VehicleType = 'Passenger Vehicles' AND C.CourseType=1
  WHERE NOT l.LessonCode IS NULL AND NOT l.LessonCode = '' AND l.LessonCode='AOM'
ORDER BY l.LessonCode, c.Country;