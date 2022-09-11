-- Бодлого 1
SELECT fName
FROM staff
UNION ALL
SELECT fName
FROM client1
UNION ALL 
SELECT fName 
FROM privateowner;

-- Бодлого 2
SELECT fName, lName, telNo
FROM client1
WHERE telNo LIKE "%22%"
UNION 
SELECT fName, lName, telNo
FROM privateowner
WHERE telno LIKE "%22%";

-- Бодлого 3
SELECT o.*, s.`fName`, s.`staffNo`, s.`position1`
FROM privateowner o, staff s, propertyforrent p
WHERE o.`ownerNo`=p.`ownerNo` AND
      s.`staffNo`=p.`staffNo` AND
      p.`rooms`=3 AND p.`type1`="Flat";	

-- Бодлого 4
CREATE TABLE backup1 AS 
SELECT *
FROM propertyforrent;

-- Бодлого 5
SELECT s.`staffNo`, s.`fName`, s.`lName`, s.`position1`, b.city, s.`branchNO`,  b.postcode
FROM staff s, branch b, registration r
WHERE r.branchNo=b.branchNo AND r.staffNo=s.`staffNo` AND s.staffNo=(SELECT staffNo
								     FROM registration
								     WHERE clientNo=(SELECT clientNo
										     FROM client1
										     WHERE fName="John"));

-- Бодлого 6
SELECT *
FROM client1
WHERE clientNo IN(SELECT clientNo
		FROM viewing
		WHERE propertyNo IN(SELECT propertyNo
				  FROM propertyforrent
				  WHERE ownerNo=(SELECT ownerNo
						 FROM privateowner
						 WHERE fName="Tony")));

-- Бодлого 7
SELECT branchNo, city, COUNT(propertyNo) AS too
FROM propertyforrent
GROUP BY city
HAVING too>2;


-- Бодлого 8
CREATE TABLE StaffPropCount AS
SELECT s.staffNo, fName, lName, COUNT(p.propertyNo) AS propCount 
FROM staff s, propertyforrent p
WHERE s.staffNo=p.staffNo
GROUP BY s.staffNo;


-- Бодлого 9
CREATE TABLE BranchInf AS
SELECT b.branchNo, b.city, COUNT(s.staffNo) AS staffcount
FROM branch b, staff s
WHERE s.branchNo=b.branchNo
GROUP BY b.branchNo;


-- Бодлого 10
SELECT branchNo, staffNo, COUNT(propertyNo) AS too
FROM propertyforrent
WHERE branchNo="B005"
GROUP BY staffNo;


-- Бодлого 11 
SELECT o.ownerNo, o.address, o.telNo, p.city, p.type1, s.fName, s.`lName`, s.position1
FROM privateowner o, propertyforrent p, staff s, viewing v
WHERE o.ownerNo=p.ownerNo AND   
      s.staffNo=p.StaffNo AND
      v.propertyNo=p.propertyNo AND 
      v.`comment1`="no dining room";
      
      
-- Бодлого 12
SELECT b.city, s.`position1`, COUNT(s.`staffNo`)AS too
FROM branch b, staff s
WHERE s.`branchNO`=b.branchNo
GROUP BY city, position1;


-- Бодлого 13
SELECT o.address, o.fName, o.lName, p.`propertyNo`, p.`rooms`
FROM privateowner o, propertyforrent p
WHERE p.`ownerNo`=o.`ownerNo` AND p.staffNo="";


-- Бодлого 14
SELECT s.`fName`, s.`lName`, s.`position1`, b.street, c.fName, c.lName, c.maxRent
FROM staff s, branch b, client1 c, registration r
WHERE   r.branchNo=b.branchNo AND
	r.clientNo=c.clientNo AND
	r.staffNo=s.`staffNo`;
	

-- Бодлого 15
SELECT *
FROM propertyforrent
WHERE staffNo=(SELECT staffNo
		FROM registration
		WHERE clientNo=(SELECT clientNo
				FROM client1
				WHERE fName="Mary"));


-- Бодлого 16
SELECT c.clientNo, c.fName, c.telNo, p.rooms, p.rent, o.fName, o.telNo
FROM client1 c, propertyforrent p, privateowner o, viewing v
WHERE v.`clientNo`=c.`clientNo` AND
      v.`propertyNo`=p.`propertyNo` AND
      p.`ownerNo`=o.`ownerNo` AND
      v.`comment1`="too remote";



