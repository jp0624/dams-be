SET @lesson_id=500;

SELECT LessonCode, Country,LanguageCode, LessonName, 
  CONCAT('INSERT INTO lesson ( lesson_id, status_id, vehicle_id, type_id, url_private, description, name, code) VALUES(', @lesson_id:=@lesson_id+1, ', 1, 1, 1, '''', ''', ''',''', LessonName, ''',''', LessonCode, ''');') FROM (SELECT DISTINCT l.LessonName, l.LessonCode, c.Country, l1.LanguageCode FROM Course c
  INNER JOIN Lesson l ON l.CourseID = c.CourseID
  INNER JOIN Language l1 ON l.LanguageTypeID = l1.LanguageTypeID
WHERE
  l.CourseID IN (23,36,38,78,79,80,81,85,88,90,93,98,100,102,104,109,110,111,112,113,114,115,116,117,118,130,159,170,175,188,201,214,222,225,226,227,228,229,239,298,466,468,469,474,475,476,483,521,522,524,525,526,528,529,530,605,643,644,645,651,654,655,659,687,689,730,738,823,824,825,826,831,1051,1082) 
  AND c.CourseType=1
  AND c.VehicleType='Passenger Vehicles'
  AND l.LessonCode !='' AND l1.LanguageCode = 'en' AND c.Country='US'
  AND l.LessonCode NOT IN (
      'DDT-T',
      'DRW',
      'DST',
      'ESR',
      'FTG',
      'JCT',
      'LNC',
      'LTR',
      'MOT',
      'PRK',
      'RUR',
      'SPD',
      'WEA',
      'ABS',
      'ATH',
      'DBS',
      'DEF',
      'DER',
      'DPS',
      'DUI',
      'GAS',
      'INP',
      'INS',
      'NDR',
      'RAR',
      'RND',
      'SBT',
      'SEA',
      'SUV',
      'VHM'
  )
ORDER BY l.LessonCode,  c.Country, l1.LanguageCode) llist;



SELECT CONCAT('INSERT INTO course_lesson(course_lesson_id, course_id, lesson_id, _order) values(', lesson_id,',', 25, ',', lesson_id, ',', lesson_id+13-501, ');') FROM lesson 
  WHERE lesson_id>=500