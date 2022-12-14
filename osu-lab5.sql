-- 1.Ажилчдын мэдээллийг салбараар нь ангилж албан тушаал бүрийн дээрх хагас сарын цалинг гаргана уу

SELECT branchNo, position1, salary/2 AS salDiff
FROM staff
GROUP BY branchNo, position1;

-- 2.Ажилчдын мэдээллийг албан тушаалаар нь ангилж, албан тушаал тус бүр дээр хэдэн эрэгтэй хэдэн эмэгтэй ажилчид ажиллаж байгааг шүүж гаргана уу Ажилчдын тоог буурахаар эрэмбэлнэ уу

SELECT position1, sex, COUNT(sex) AS too
FROM staff
GROUP BY position1, sex
ORDER BY too DESC; 


-- 3.Нэгээс олон ажилчидтай салбарын ажилчдын тоо болон нийт цалингийн хэмжээг гаргана уу

SELECT branchNo, COUNT(staffNo)AS Staffcount, SUM(salary)
FROM staff
GROUP BY branchNo
HAVING Staffcount>1;

-- 4. 0141 357 7419 гэсэн утастай үл хөдлөх хөрөнгө эзэмшигчийн түрээсийн үнээс их түрээсийн үнэтэй үл хөдлөх хөрөнгийн ownerNo propertyNo rent, type, rooms талбарын мэдээллийг гаргана уу

SELECT ownerNo, propertyNo, rent, type1, rooms
FROM propertyforrent
WHERE rent>SOME(SELECT rent
		FROM propertyforrent
		WHERE ownerNo=(SELECT ownerNo
				FROM privateowner
				WHERE telNo="0141-357-7419"));
				
-- 5.Үл хөдлөх хөрөнгийг үзээд too small гэж сэтгэгдэл үлдээсэн харилцагчийн үзсэн үл хөдлөх хөрөнгө аль хотод байрладаг, хэдэн өрөөтэй, ямар үнэтэй байгааг гаргана уу

SELECT city, rooms, rent
FROM propertyforrent
WHERE propertyNo=(SELECT propertyNo
			FROM viewing
			WHERE comment1="too small")
			
-- 6.Mike ийн бүртгэлийг хийсэн ажилтны хариуцан ажиллаж буй үл хөдлөх хөрөнгийн мэдээллийг гаргана уу

SELECT *
FROM propertyforrent
WHERE staffNo=(SELECT staffNo
		FROM registration
		WHERE clientNo=(SELECT clientNo
				FROM client1
				WHERE fName="Mike"));
				
-- 7.Бүртгэлийн хүснэгтэд 2003 3 7 нд бүртгэл хийсэн ажилтны ажилладаг салбарын дугаар, тухайн салбар байрлах гудамж, уг ажилтны код, нэр, төрсөн огноог харуулна уу

SELECT b.branchNo, b.street, s.staffNo, s.DOB
  FROM Staff s, Branch b
  WHERE s.branchNo=( SELECT branchNo
                     FROM  Registration
                      WHERE dateJoined="2003-03-07" ) AND s.branchNo=b.branchNo

						
-- 8."Carol" н түрээсийн үнээс бага түрээсийн үнэтэй үл хөдлөх хөрөнгийн мэдээллийг гаргана уу

SELECT *
FROM propertyforrent
WHERE rent<ALL(SELECT rent
		FROM propertyforrent
		WHERE ownerNo=(SELECT ownerNo
				FROM privateowner
				WHERE fName="Carol"));
				
-- 9.Салбарыг хотуудаар ангилж хот бүрд хэдэн салбартайг тоолж гаргана уу

SELECT branchNo, city, COUNT(branchNo) diffBranch
FROM branch
GROUP BY city;

-- 10."Tony" н түрээсийн үнээс их түрээсийн үнэтэй үл хөдлөх хөрөнгийн мэдээллийг гаргана уу

SELECT *
FROM propertyforrent
WHERE rent>ALL(SELECT rent
		FROM propertyforrent
		WHERE ownerNo=(SELECT ownerNo
				FROM privateowner
				WHERE fName="Tony"));
				
-- 11.Харилцагчдын хамгийн их сонирхсон үл хөдлөх хөрөнгийн мэдээллийг харуулна уу

SELECT *
FROM propertyforrent
WHERE propertyNo IN(SELECT propertyNo
		  FROM viewing
		  GROUP BY propertyNo
		  ORDER BY COUNT(propertyNo)DESC) LIMIT 2;


-- 12.Хамгийн сүүлд бүртгэсэн харилцагчийн мэдээллийг харуулна уу

SELECT *
FROM client1
WHERE clientNo=(SELECT clientNo
		FROM registration
		WHERE dateJoined>=ALL(SELECT dateJoined
					FROM registration));
					
-- 13.Бүртгэлийн хүснэгтийг бусад хүснэгттэй холбон дараах мэдээллийг гаргана уу. Үүнд Салбарын дугаар, тухайн салбар байрлаж буй хотын нэр, шуудангийн дугаар, ажилтны код болон нэр, албан тушаал, бүртгүүлсэн харилцагчийн нэр, утасны дугаар, сонирхож буй үл хөдлөх хөрөнгийн төрөл

SELECT b.branchNo, b.city, b.postcode, s.staffNo, s.fName, s.lName, s.position1, c.clientNo, c.telNo, c.prefType
FROM branch b, staff s, client1 c, registration r
WHERE r.`branchNo`=b.`branchNo` AND r.`staffNo`=s.`staffNo` AND r.`clientNo`=c.`clientNo`

-- 14.Бүртгэлийн хүснэгтэд 2004 1 2 нд бүртгэл хийсэн ажилтны код болон түүний харьяалагддаг салбарын мэдээллийг гаргана уу

SELECT s.`staffNo`,b.*
FROM staff s, branch b
WHERE s.`branchNo`=b.`branchNo` AND s.`staffNo`=(SELECT staffNo
						 FROM registration
						 WHERE dateJoined="2004-01-02");
						 
-- 15.Үл хөдлөх хөрөнгө үзсэн хүснэгтэд 2004 оны 5 р сард бүртгэгдсэн харилцагчдын мэдээллийг гаргана уу

SELECT *
FROM client1
WHERE clientNo IN(SELECT clientNo
		  FROM viewing
		  WHERE viewDate>="2004-05-01" AND viewDate<="2004-5-31");
		  
-- 16.Хоёроос олон үл хөдлөх хөрөнгө бүртгэгдсэн хотын нэр, үл хөдлөх хөрөнгийн тоог гаргана уу

SELECT city, COUNT(propertyNo) AS too
FROM propertyforrent
GROUP BY city
HAVING too>2;

-- 17.C үсгээр эхэлсэн нэртэй Fname хүний түрээслүүлэх гэж буй үл хөдлөх хөрөнгийг хариуцан ажиллаж буй ажилтны мэдээллийг салбарын мэдээлэлтэй нь харуулна уу.

SELECT s.*, b.*
FROM staff s, branch b
WHERE s.`branchNo`=b.`branchNo` AND s.`staffNo`IN(SELECT staffNo
						 FROM propertyforrent
						 WHERE ownerNo=(SELECT ownerNo
								FROM privateowner
								WHERE fName LIKE "C%"));

-- 18.B 003 салбарын ажилтан тус бүрийн хариуцаж байгаа үл хөдлөх хөрөнгийн тоо болон салбарын дугаарыг гаргана уу.

SELECT branchNo, staffNo, COUNT(propertyNo)AS too 
FROM propertyforrent
WHERE branchNo="B003" AND staffno!=""
GROUP BY staffNo
