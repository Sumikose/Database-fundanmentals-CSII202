1.
SELECT staffNo, fName, lName, DOB
FROM staff
WHERE sex="M" 
ORDER BY DOB DESC; 

2.
SELECT*
FROM PropertyForRent
WHERE rooms BETWEEN 3 AND 4 
ORDER BY rent ASC;

3.
SELECT*
FROM Staff
WHERE lName LIKE "B%";

4.
SELECT*
FROM PrivateOwner
WHERE telNo LIKE "%1%1%"; 

5.
SELECT*
FROM PropertyForRent
WHERE propertyNo IN 
                 (SELECT propertyNo
                  FROM Viewing
                  WHERE comment1!="");

6.
SELECT AVG(salary) AS salaryAVG
FROM Staff; 

7.
SELECT MAX(salary), MIN(salary), AVG(salary)
FROM Staff
WHERE branchNo="B003";

8.
SELECT sex, COUNT(staffNo) AS myCount, MAX(salary), MIN(salary), SUM(salary)
FROM Staff
WHERE branchNo="B005" AND sex="M";

9.
SELECT type1, SUM(rent), MAX(rent) 
FROM PropertyForRent
WHERE rooms=3 AND type1="Flat";

10.
SELECT*
FROM PropertyForRent
WHERE city="Glasgow" AND propertyNo LIKE "%6";

11.
SELECT branchNo, postcode
FROM Branch
WHERE street="16 Argyll St";

12.
SELECT lName, position1, salary, branchNo
FROM Staff
WHERE branchNo="B003" OR branchNo="B005"
ORDER BY salary;

13.
SELECT staffNo, propertyNo, rent
FROM PropertyForRent
WHERE rooms=3
ORDER BY branchNo, rent;

14.
SELECT*
FROM PropertyForRent
WHERE branchNo IN
               (SELECT branchNo
                FROM staff) AND rooms=4 AND rent>400;

15.
SELECT*
FROM PropertyForRent
WHERE propertyNo IN 
                 (SELECT propertyNo
                  FROM Viewing
                  WHERE comment1="");

16.
SELECT*
FROM PropertyForRent
WHERE propertyNo LIKE "PG%" AND type1="House";

17.
SELECT clientNo, BranchNo, dateJoined
FROM Registration
WHERE dateJoined BETWEEN "2003-01-01" AND "2003-12-31";

18.
SELECT fName, lName, telNo
FROM client1
WHERE fName LIKE "%e";

19.
SELECT*
FROM client1
WHERE telNo LIKE "%8%8%8%";

20.
SELECT*
FROM Staff
WHERE DOB LIKE "%10%" AND sex="M" OR DOB LIKE "%01%" AND sex="F";

21.
SELECT fName, lName, position1, salary
FROM Staff
WHERE branchNo IN
               (SELECT branchNo
                FROM Branch
                WHERE city="London")
                ORDER BY salary ASC;

22.
SELECT*
FROM Viewing
WHERE clientNo IN
              (SELECT clientNo
               FROM client1
               WHERE fName="Aline");


23.
SELECT fName, lName, position1, branchNo
FROM Staff
WHERE branchNo IN 
               (SELECT branchNo 
                FROM PropertyForRent
                WHERE rooms=4) AND sex="M"
                ORDER BY branchNo ASC;
                 
                 
24. 
SELECT type1, MAX(rent), MIN(rent)
FROM PropertyForRent
GROUP BY type1;

25.
SELECT*
FROM Branch b, Staff s
WHERE s.branchNo=
		(SELECT branchNo
		 FROM Staff
		 WHERE DOB=
			(SELECT MAX(DOB)
			 FROM staff)) AND s.branchNo=b.branchNo;
			
			 
		   
26.
SELECT staffNo, salary, salary-(SELECT MIN(salary) FROM staff) AS salDiff
FROM staff
WHERE salary>(SELECT MIN(salary) FROM staff); 

27.
SELECT*
FROM PropertyForRent
WHERE branchNo IN (SELECT branchNo
                   FROM branch
		   WHERE street="16 Argyll St");

28.
SELECT*
FROM staff
WHERE salary>ALL (SELECT salary
		  FROM staff
		  WHERE branchNo="B003");