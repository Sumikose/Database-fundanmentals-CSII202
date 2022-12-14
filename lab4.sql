1.Эрэгтэй ажилчдын ажилчны дугаар,овог,нэр болон төрсөн огноог харуулахдаа төрсөн огноог буурахаар эрэмбэлж харуулна уу
SELECT StaffNo, fName,lName,dob,sex
FROM staff
WHERE sex="M"
ORDER BY dob DESC;

2.3 болон 4-н өрөөтэй үл хөдлөх хөрөнгийн мэдээллийг харуулахдаа түрээсийн үнийг өсөхөөр эрэмбэлж харуулна уу
SELECT *
FROM PropertyForRent
WHERE rooms=3 OR rooms=4
ORDER BY rent;

3.B үсгээр эхэлсэн овогтой ажилчдын мэдээллийг шүүж гаргана уу.
SELECT *
FROM staff
WHERE lName LIKE "B%";

4.2 удаа 1 орсон утасны дугаартай түрээслэгчдийн мэдээллийг шүүж гаргана уу.
SELECT *
FROM client1
WHERE telNo LIKE "%1%1%";

5.Тухайн үл хөдлөх хөрөнгийг үзээд харилцагчийн сэтгэгдэл үлдээсэн үл хөдлөх хөрөнгийн мэдээллийг гаргана уу.
SELECT *
FROM Viewing
WHERE comment1 NOT LIKE " ";

6.Нийт ажилтны цалингийн дунджийг харуулна уу. Үр дүнгийн баганы нэрийг SalaryAVG болгож өөрчилнө үү.
SELECT AVG(salary) AS SalaryAVG
FROM Staff;

7.B003 салбарын ажилчдын хамгийн их, хамгийн бага, дундаж цалингийн мэдээллийг харуулна уу.
SELECT MAX(salary), MIN(salary), AVG(salary)
FROM staff
WHERE BranchNo="B003";

8.B005 салбарын эрэгтэй ажилчдын тоо болон хамгийн их, хамгийн бага, цалингийн нийлбэрийг харуулна уу.
SELECT COUNT(BranchNo), MAX(salary), MIN(salary), SUM(salary)
FROM staff
WHERE branchNo="B005" AND sex="M";

9.3-н өрөөтэй Flat төрлийн орон сууцны түрээсийн үнийн нийлбэр болон хамгийн их үнийн саналыг гаргана уу.
SELECT SUM(rent), MAX(rent)
FROM PropertyForRent
WHERE rooms=3 AND type1="Flat"

10.Glasgow хотод байрлах, үл хөдлөх хөрөнгийн дугаар нь 6-аар төгссөн үл хөдлөх хөрөнгийн мэдээллийг харуулна уу.
SELECT *
FROM PropertyForRent
WHERE propertyNo LIKE "%6";

11.6 Argyll St гудамжинд байрладаг салбарын дугаар, шуудангийн хаягийг гаргана уу.
SELECT branchNo, postcode
FROM branch
WHERE street="16 Argyll St";

12.B003, B005 салбарт ажилладаг ажилчдын нэр, албан тушаалыг харуулна уу. Цалингаар нь эрэмбэлнэ үү.
SELECT fName, lName, position1
FROM Staff
WHERE branchNo="B003" OR branchNo="B005"
ORDER BY salary;

13.3-н өрөөтэй орон сууц хариуцан ажиллаж байгаа ажилчдын дугаар, үл хөдлөх хөрөнгийн дугаар, түрээсийн 
   үнийн мэдээллийг гаргана уу. Салбар, түрээсийн үнээр нь эрэмбэлж харуулна уу.
SELECT staffNo, propertyNo, rent
FROM PropertyForRent
WHERE type1="flat" AND rooms=3
ORDER BY BranchNo, rent;

14.4 өрөөтэй, 400–ээс их үнэтэй,ажилтан хариуцаж авсан үл хөдлөх хөрөнгийн мэдээллийг харуулна уу. 
SELECT *
FROM PropertyForRent
WHERE rooms=4 AND rent>=400 AND StaffNo NOT LIKE " ";

15.Тухайн үл хөдлөх хөрөнгийг үзээд сэтгэгдэл үлдээгээгүй үл хөдлөх хөрөнгийн мэдээллийг гаргана уу.
SELECT *
FROM Viewing
WHERE comment1 LIKE " ";

16.PG-гээр эхэлсэн үл хөдлөх хөрөнгийн кодтой, House төрлийн орон сууцны мэдээллийг гаргана уу.
SELECT *
FROM PropertyForRent
WHERE propertyNo LIKE "PG%" AND type1="house";

17.2003 онд бүртгэл хийгдсэн харилцагчийн код болон салбарын дугаарыг харуулна уу.
SELECT clientNo, BranchNo
FROM Registration
WHERE dateJoined LIKE "2003%";

18."e" үсгээр төгссөн овогтой харилцагчдын нэр болон утасны дугаарыг шүүж гаргана уу.
SELECT fName, lName, telNo
FROM client1
WHERE lName LIKE "%e";

19.Гурван удаа 8 орсон утасны дугаартай харилцагчдын мэдээллийг шүүж гаргана уу.
SELECT *
FROM client1
WHERE telNo LIKE "%8%8%8%";

20.10-р сард төрсөн, эрэгтэй ажилчид эсвэл 1-р сард төрсөн, эмэгтэй ажилчдын мэдээллийг гаргана уу.
SELECT *
FROM Staff
WHERE dob LIKE "%10%" AND sex="M" OR dob LIKE "%01%" AND sex="F";

21.London хотод ажилладаг ажилчдын нэр, албан тушаал, цалингийн мэдээллийг харуулна уу. Цалингаар нь эрэмбэлнэ үү.
SELECT fName, lName, position1, salary
FROM Staff
WHERE BranchNo IN(
		SELECT BranchNo
		FROM branch
		WHERE city="London"
		  );
		  
22.Aline хэдэн оны хэдэн сарын хэдний өдөр ямар дугаартай үл хөдлөх хөрөнгө үзээд юу гэсэн сэтгэгдэл үлдээсэн бэ?
SELECT viewDate,propertyNo, comment1
FROM Viewing
WHERE clientNo=(
		SELECT clientNo
		FROM client1
		WHERE fName="Aline"
		);
		
23.4-н өрөөтэй орон сууц хариуцан ажиллаж байгаа эрэгтэй ажилчдын овог, нэр, албан тушаалын мэдээллийг гаргана уу.
   Салбараар нь эрэмбэлж харуулна уу.
SELECT fName, lName, position1
FROM Staff
WHERE StaffNo IN(
		SELECT StaffNo
		FROM PropertyForRent
		WHERE rooms=4 AND type1="flat"
		)		
ORDER BY BranchNo;

24.Үл хөдлөх хөрөнгийн мэдээллийг төрлөөр нь ангилж, төрөл бүрийн хувьд хамгийн их болон хамгийн бага үнийн мэдээллийг
   харуулна уу.
SELECT type1,MAX(rent),MIN(rent)
FROM PropertyForRent
GROUP BY type1;

25.Хамгийн залуу ажилтны мэдээлэл болон түүний ажилладаг салбарын мэдээллийг гаргана уу.
SELECT *
FROM branch
WHERE branchNo=(SELECT branchNo
		FROM staff
		WHERE dob=(
			   SELECT MAX(dob)
			   FROM staff
			   )
		);
		
26.Ажилчдын цалин нь хамгийн бага цалинтай ажилчдын цалингаас хэр зөрүүтэй байгааг харуулна уу.
SELECT StaffNo, salary, salary-(SELECT MIN(salary) FROM staff)
FROM staff
WHERE salary>(
	      SELECT MIN(salary)
	      FROM staff
	      );
	      
27.16 Argyll St гудамжинд байрлах салбарт ажилладаг ажилтны хариуцаж авсан үл хөдлөх хөрөнгийн мэдээллийг гаргана уу.
SELECT *
FROM PropertyForRent
WHERE BranchNo=(
		SELECT BranchNo
		FROM branch
		WHERE street="16 Argyll St"
		);
		
28.B003 салбарын ажилчдын цалингаас их цалинтай ажилчдын мэдээллийг харуулна уу.
SELECT *
FROM staff
WHERE salary>ALL(
		 SELECT salary
		 FROM staff
		 WHERE branchNo="B003"
		 );
