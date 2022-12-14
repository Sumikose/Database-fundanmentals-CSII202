SELECT staffNo,fName,lName,DOB
FROM staff
WHERE sex="M" ORDER BY DOB DESC; 


SELECT*
FROM PropertyForRent
WHERE rooms>3 AND rooms<4 
ORDER BY rent ASC;


SELECT*
FROM staff
WHERE fName LIKE "B%";


SELECT*
FROM privateowner
WHERE telNo LIKE "%1%1%"; 


SELECT*
FROM Viewing
WHERE comment1!=".";


SELECT AVG(salary) AS salaryAVG
FROM staff; 


SELECT MAX(salary),MIN(salary),AVG(salary)
FROM staff
WHERE branchNo="B003";


SELECT COUNT(staffNo) AS mycount, MAX(salary), MIN(salary), SUM(salary)
FROM staff
WHERE branchNo="B005" AND sex="M";


SELECT SUM(rent), MAX(rent)
FROM PropertyForRent
WHERE rooms=3 AND type1="Flat";


SELECT*
FROM PropertyForRent
WHERE city="Glasgow" AND propertyNo LIKE "%6";


SELECT branchNo,postcode
FROM branch
WHERE street="16 Argyll ST";


SELECT fName, lName, position1
FROM staff
WHERE branchNo="B003" AND branchNo="B005"
ORDER BY salary;


SELECT staffNo, propertyNo, rent
FROM PropertyForRent
WHERE rooms=3
ORDER BY branchNo, rent;

 
SELECT*
FROM PropertyForRent
WHERE rooms=4 AND rent>400;


SELECT*
FROM viewing
WHERE comment1!="";


SELECT*
FROM PropertyForRent
WHERE propertyNo LIKE "PG%" AND type1="House";


SELECT clientNo, BranchNo
FROM Registration
WHERE dateJoined>"2003-01-01" AND dateJoined<"2003-12-31";


SELECT lName, telNo
FROM client1
WHERE fName LIKE "%e";


SELECT*
FROM client1
WHERE telNo LIKE "%8%8%8%";


SELECT*
FROM staff
WHERE (DOB LIKE "10%" AND sex="M") OR (DOB LIKE "1%" AND sex="F");


SELECT fName, lName, position1, salary
FROM staff
WHERE branchNo IN
          (SELECT branchNo
           FROM branch
           WHERE city="London")
           ORDER BY salary;

 
SELECT clientNo, fName, lName, propertyNo, viewDate, comment1
FROM client1
WHERE clientNo IN
           (SELECT clientNo
            FROM viewing
            WHERE clientNo="CR56");


SELECT fName, lName, position1
FROM PropertyForRent
WHERE  rooms="4" AND sex="M" AND clientNo IN
                                       (SELECT clientNo
                                        FROM viewing
                                        WHERE sex="M")
                                        ORDER BY branchNo;

 
SELECT type1, COUNT(propertyNo) AS COUNT2, MAX(rent), MIN(rent)
FROM PropertyForRent
GROUP BY propertyNo
ORDER BY propertyNo;

 
SELECT staffNo, fName, lName, position1, branchNo
FROM staff
WHERE branchNo IN (SELECT branchNo
		   FROM branch
		   WHERE ORDER BY DOB ASC);
		   

SELECT staffNo, salary, salary-(SELECT MIN(salary) FROM staff) AS diff
FROM staff
WHERE salary>(SELECT MIN(salary) FROM staff); 


SELECT propertyNo, street, city, postcode, type1, rooms, rent
FROM PropertyForRent
WHERE branchNo IN (SELECT branchNo
                  FROM branch
		  WHERE street="16 Argyll St");


SELECT*
FROM staff
WHERE salary>ALL (SELECT salary
		  FROM staff
		  WHERE branchNo="B003");
