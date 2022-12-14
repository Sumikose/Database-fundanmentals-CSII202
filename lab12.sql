-- Лаб 12
-- 1. Бүртгэлийн хүснэгтээс хэн хэнтэй ажилласныг нэг өгүүлбэрээр буюу 1 баганад оруулж харуулна уу. Жишээ: L.Julie 1 sariin 2-nd London-n salbart K.John-toi ajiljee.  SUBSTRING, CONCAT функцуудыг ашиглана уу.

SELECT CONCAT (SUBSTRING(s.IName,1,1),'.',s.fName,' ',MONTH (r.dateJoined),' ','сарын ',DAY(r.dateJoined),'-нд ',b.city,' салбарт', ' ',
SUBSTRING(c.IName,1,1),'.',c.fName,'-тaй ажилласан байна.') AS Бүртгэлийн_хүснэгт
FROM registration r, staff s, branch b, client1 c
WHERE b.branchNo=r.branchNo AND r.client1No=c.client1No AND s.staffNo=r.staffNo; 

-- 2. StaffInfo хүснэгт үүсгэнэ үү. staffNo, fullName, POSITION, branchAddress, propCount, clientCount гэсэн багануудтай. Хүснэгтэнд QUERY ашиглан өгөгдөл оруулна уу.

CREATE TABLE staffInfo AS
SELECT CONCAT(b.street,' ', b.city) AS bAddress, CONCAT(s.IName,' ', s.fName)AS fullName, s.staffNo, s.position1,
COUNT(p.propertyNo) AS propCount, COUNT( r.client1No) AS clientCount
FROM staff s  
LEFT JOIN branch b ON s.branchNo=b.branchNo 
LEFT JOIN propertyforrent p ON p.staffNo=s.staffNo 
LEFT JOIN registration r ON r.staffNo=s.staffNo
GROUP BY s.staffNo;

-- 3. B003 салбарын хариуцан ажиллаж байгаа үл хөдлөх хөрөнгийн үнийг 15%-аар нэмэгдүүлнэ үү

UPDATE PropertyForRent
SET rent=rent+rent*0.15
WHERE branchno="B003";

-- 4. Tony Shaw-н үл хөдлөх хөрөнгийн үнийг 400, ажилтны дугаарыг SA9 болгоно уу.

UPDATE propertyforrent p
LEFT JOIN privateowner pr ON pr.ownerNo=p.ownerNo
SET p.staffNo="SA9", p.rent=400
WHERE pr.IName="Shaw" AND pr.fName="Tony";

UPDATE PropertyForRent
SET rent=400, staffno="SA9"
WHERE ownerNo IN (SELECT ownerno
		  FROM PrivateOwner
		  WHERE fname="Tony" AND lname="Shaw");

-- 5. Үл хөдлөх хөрөнгийн үнийг 15%-аар нэмэгдүүлнэ үү.

UPDATE PropertyForRent
SET rent=rent+rent*0.15;

-- 6. Бүртгэлийн хүснэгтэд 4-р сард бүртгэсэн мэдээллийг 5-н сар болгож өөрчилнө үү.

UPDATE registration 
SET dateJoined=DATE_ADD(dateJoined, INTERVAL 1 MONTH)
WHERE dateJoined LIKE '%-04-%';

-- 7. Үл хөдлөх хөрөнгийн нөөц хүснэгтээс хариуцах ажилтангүй мэдээллийг устгана уу

CREATE TABLE noots AS
SELECT*
FROM PropertyForRent
 
DELETE 
FROM noots
WHERE staffNo="";

-- 8. Үл хөдлөх хөрөнгийн нөөц хүснэгтээс 16 Argyll St гудамжинд байрладаг, House төрлийн 
орон сууцны мэдээллийг устгана уу.
DELETE 
FROM нөөц_хүснэгт
WHERE street="16 Argyll St" AND type1="House";

-- Даалгавар
-- 1. Зочид буудлын захиалгын мэдээллийг нэг өгүүлбэрт оруулж харуул. Жишээ: Бат "Улаанбаатар" зочид буудлын 45000 үнэтэй "VIP" өрөөнд 2020-10-01-нд буудаллажээ

SELECT CONCAT(g.guestName,' ',h.hotelName,' ','зочид буудлын',' ',r.price,' ','үнэтэй "VIP" өрөөнд байрлажээ') AS Зочид_буудлын_захиалгын_мэдээлэл
FROM hotel h, guest g, room r, booking b
WHERE  b.roomNo=r.roomNo AND h.hotelNo=b.hotelNo AND g.guestNo=b.guestNo;

-- 2. Зочид буудлуудын хамгийн хямд үнэтэй, шууд захиалах боломжтой өрөөнүүдийн мэдээллийг шүүж харуулна уу.

SELECT r.* 
FROM room r LEFT JOIN booking b ON r.roomNo=b.roomNo 
WHERE b.dateFrom IS NULL AND b.dateTo IS NULL OR NOW()<b.dateFrom AND NOW()<b.dateTo 
ORDER BY r.price ASC 

SELECT RoomNo, HotelNo, bed, price
FROM room
WHERE price =(SELECT MIN(price) 
              FROM room) AND roomNo IN(SELECT roomNo 
                                       FROM booking 
                                       WHERE (SELECT NOW()) NOT BETWEEN datefrom AND dateTo);

-- 3. Хамгийн цөөн тоогоор захиалга авсан зочид буудлын өрөөний мэдээллийг үнийг нь өсөхөөр эрэмбэлж гаргана уу.

SELECT r.*, COUNT(b.dateFrom) AS zahialga_awsan_too
FROM room r LEFT JOIN booking b ON r.roomNo=b.roomNo 
GROUP BY r.roomNo 
HAVING COUNT(b.dateFrom)<2
ORDER BY r.price ASC 

-- 4. Зочид буудал бүрийн сүүлийн 3 сарын хугацаанд буудалласан зочдын мэдээллийг харуул.

SELECT g.*, b.dateFrom, b.dateTo
FROM guest g LEFT JOIN  booking b ON b.guestNo=g.guestNo
WHERE  NOW()>b.dateTo AND 
NOW()>b.dateFrom AND b.dateTo>DATE_ADD(NOW(), INTERVAL -3 MONTH) AND b.dateFrom>DATE_ADD(NOW(), INTERVAL -3 MONTH);

-- 5. Зочид буудал бүрт хамгийн олон удаа буудалласан 1, 1 зочны мэдээллийг харуулна

SELECT b.hotelNo,g.guestNo,g.guestName,g.phonenumber
FROM booking b,guest g
WHERE g.guestNo=b.guestNo
GROUP BY b.hotelNo
ORDER BY COUNT(b.guestNo) DESC

-- 6.Зочид буудлын нөөц хүснэгт үүсгэж мэдээллийг хуулж оруулах QUERY бичнэ үү.
 
CREATE TABLE nootts AS
SELECT *
FROM hotel 

-- 7. HotelInformation гэсэн хүснэгт үүсгэж QUERY-ээр тохирох өгөгдлүүдийг оруулна уу. HotelInformation(HotelNo, HotelName, RoomCount, MaxPrice, MinPrice, AvgPrice, City)

CREATE TABLE  HotelInformation AS
SELECT h.hotelNo, h.hotelName, COUNT(r.roomNo) AS RoomCount, MAX(r.price) AS MaxPrice, MIN(r.price) AS MinPrice, AVG(r.price) AS AvgPrice, h.city 
FROM hotel h 
LEFT JOIN room r ON h.hotelNo=r.hotelNo
GROUP BY h.hotelName 

CREATE TABLE HotelInformation AS
SELECT h.hotelno,h.hotelname,COUNT(r.roomno) AS RoomCount,MAX(r.price),MIN(r.price),AVG(r.price),h.city
FROM hotel h,room r
WHERE h.hotelno=r.hotelno
GROUP BY r.hotelno;


-- 8. blue sky зочид буудлын өрөөний үнийг 0.2 хувиар нэмэгдүүлнэ үү

UPDATE room r
LEFT JOIN hotel h ON r.hotelNo=h.hotelNo
SET r.price=r.price*1.002
WHERE h.hotelName="Bogd";

UPDATE room r,hotel h
SET r.price=r.price+r.price*0.2
WHERE r.hotelno=h.hotelno AND h.hotelname="Bogd" ;
