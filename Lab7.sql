Лабортори-7:
Гүйцэтгэсэн: Г.Энхлэн 

1. Дараах relational  algebra-ын үйлдлүүдийг тайлбайрла.
a) 50-аас дээш үнэтэй өрөөнүүдийн hotelNo мэдээллийг харуулна. (Projection)
b) Room хүснэгт болон Hotel хүснэгтүүдээс hotelNo нь адилхан байх мэдээллийг харуулна. (Selection and  Cartesian product)
c) Room хүснэгтээс өрөө нь 50-аас дээш үнэтэй байх  буудлын нэрийг харуулна. (Projection and (natural join and selection))
d) Guest хүснэгт дээр Booking хүснэгтийн "1-Jan-2002" оноос хойших хэвлэгдсэн номыг ямар зочид  үзсэн болохыг мэдээллийг харуулна. (right join)
e) 50-аас дээш үнэтэй өрөөнүүдийн мэдээллийг  Room болон Hotel хүснэгтээс hotelNo ижилхэн байх бүх мэдээллийг  харуулна. (Semi join)
f) Booking болон Guest хүснэгтийг guestNo-ээр natural join хийгээд, Hotel хүснэгтийн London хот дахь мэдээллийг гаргаад, 2 хүснэгтийн мэдээллийг hotelNo-р хасаад зочидын нэр, буудлын дугаарыг харуулна. (Division).
 
2. Дараах даалгавруудын relational algebra-г бичнэ үү.
a) PG-гээр эхэлсэн үл хөдлөх хөрөнгийн кодтой, House төрлийн орон сууцны мэдээллийг гаргана уу.
        ∏* (σpropertyNo LIKE "PG%" AND type="House"(Propertyforrent))
 
b) 15000 дээш цалинтэй эмэгтэй ажилчдын мэдээллийг гаргана уу.
        ∏* (σsalary>15000 AND sex="M" (staff))  
 
c) 10-р сард төрсөн, эрэгтэй ажилчдын мэдээллийг харуулна уу.                    
        ∏* (σDOB LIKE "%10%" AND sex="F" (staff))  

d) Түрээс нь 400-600 байх, Glasgow хотод байрлах үл хөдлөх хөрөнгийн мэдээллийг гаргана уу.  
        ∏* (σrent BETWEEN 400 AND 600 AND city="Glasgow"(Propertyforrent))

e) Үл хөдлөх хөрөнгийг үзээд "no dining room" гэж сэтгэгдэл үлдээсэн харилцагчийн дугаар, үзсэн огноог гаргана уу.
        ∏ clientNo, viewDate(σcomment="no dining room"(viewing))

3. Дараах даалгаврын query-г бичнэ үү.
-- 1
SELECT p.propertyNo, p.city, p.rent, s.staffNo, s.fName, s.position1
FROM propertyforrent p, staff s
WHERE p.staffNo=s.staffNo
-- 2
SELECT s.branchNo, s.staffNo, AVG(rent) AS avge, MAX(rent) AS maxg, MIN(rent) AS minn
FROM propertyforrent p, staff s
WHERE p.staffNo=s.staffNo
GROUP BY s.branchNo
-- 3
SELECT b.*, p.*
FROM branch b FULL JOIN 
propertyforrent p ON b.city=p.city
-- 4
SELECT b.*, p.*
FROM branch b LEFT JOIN 
propertyforrent p ON b.city=p.city

SELECT b.*, p.*
FROM branch b RIGHT JOIN 
propertyforrent p ON b.city=p.city 
-- 5
SELECT city FROM branch
except
SELECT city FROM propertyforrent
-- 6
SELECT city FROM branch
intersect
SELECT city FROM propertyforrent
-- 7
SELECT s.staffNo, s.fName, s.position1, b.city, b.street
FROM staff s, branch b
WHERE s.staffNo IN(SELECT staffNo FROM registration WHERE clientNo IN(SELECT clientNo FROM client1 WHERE fName LIKE "M%")) AND s.branchNo=b.branchNo
-- 8
SELECT pr.fName, pr.address, pr.telNo, p.city, p.type1, p.rent
FROM privateowner pr, propertyforrent p
WHERE p.staffNo IN(SELECT staffNo FROM registration WHERE clientNo IN(SELECT clientNo FROM client1 WHERE fName="Mary")) AND p.ownerNo=pr.ownerNo
