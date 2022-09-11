CREATE TABLE Hotel(
	HotelNo VARCHAR(20),
	HotelName VARCHAR(20),
	city VARCHAR(20),
	PRIMARY KEY (HotelNo)
);
CREATE TABLE Room(
	RoomNo VARCHAR(20),
	HotelNo VARCHAR(20),
	bed INT,
	price INT,
	PRIMARY KEY (RoomNo),
	FOREIGN KEY (HotelNo) REFERENCES Hotel(HotelNo)
);
CREATE TABLE Booking(
	HotelNo VARCHAR(20),
	RoomNo VARCHAR(20),
	GuestNo VARCHAR(20),
	dateFrom DATE,
	dateTo DATE,
	FOREIGN KEY (HotelNo) REFERENCES Hotel(HotelNo),
	FOREIGN KEY (RoomNo) REFERENCES Room(RoomNo),
	FOREIGN KEY (GuestNo) REFERENCES Guest(GuestNo)
);
CREATE TABLE Guest(
	GuestNo VARCHAR(20),
	GuestName VARCHAR(20),
	GuestAddress VARCHAR(20),
	phonenumber INT,
	PRIMARY KEY (GuestNo)
);

INSERT INTO Hotel(hotelNo,hotelname,city)
VALUES("Hotel01","Hangai","Ovorkhangai"),
      ("Hotel02","Bogd","Arvaikheer"),
      ("Hotel03","Noyn","Arhangai"),
      ("Hotel04","Burd","Hovd"),
      ("Hotel05","Gerelt","Hovd");
INSERT INTO Room(roomNo,hotelno,bed,price)
VALUES("room1","Hotel01",1,100),
      ("room2","Hotel02",2,200),
      ("room3","Hotel03",3,350),
      ("room4","Hotel04",4,200),
      ("room5","Hotel05",1,300),
      ("room6","Hotel01",2,400),
      ("room7","Hotel02",3,300),
      ("room8","Hotel03",4,160),
      ("room9","Hotel04",1,200),
      ("room10","Hotel05",2,200),
      ("room11","Hotel03",3,150),
      ("room12","Hotel04",4,200);
INSERT INTO Booking(hotelNo,RoomNo,guestNo,datefrom,dateto)
VALUES("Hotel01","room1","G01","2021-1-1","2021-1-10"),
      ("Hotel02","room2","G02","2021-1-14","2021-1-15"),
      ("Hotel03","room3","G03","2021-1-20","2021-1-29"),
      ("Hotel04","room4","G04","2021-9-2","2021-9-17"),
      ("Hotel05","room5","G05","2021-1-17","2021-1-28"),
      ("Hotel01","room6","G06","2021-10-2","2021-1-2"),
      ("Hotel02","room1","G01","2021-9-2","2021-9-17"),
      ("Hotel03","room2","G02","2021-10-2","2021-10-17"),
      ("Hotel04","room3","G03","2021-1-17","2021-1-28"),
      ("Hotel05","room4","G04","2021-10-29","2021-11-2"),
      ("Hotel01","room5","G05","2021-2-17","2021-1-27"),
      ("Hotel02","room6","G06","2021-10-29","2021-1-2"),
      ("Hotel03","room1","G01","2021-1-11","2021-1-20");
 INSERT INTO Guest(guestno,guestname,guestaddress,phonenumber)
VALUES("G01","Mark","Mark20",88783237),
      ("G02","Bataa","Bataa10",89327483),
      ("G03","Ganaa","Ganaa30",88234672),
      ("G04","Dulmaa","Dulmaa40",96623876),
      ("G05","Boldoo","Boldoo50",99732477),
      ("G06","Nomin","Nomin39",89237688),
      ("G07","Jamyan","Jamyan89",95238743),
      ("G08","Suldee","Suldee78",99237438),
      ("G09","Juni","Juni26",90928374),
      ("G12","Hangai","Hangai67",98873483);
Bodlogo
1.Зочид буудлуудын өрөөний дэлгэрэнгүй мэдээллийг гарга.Үүнд хотын нэр,буудлын нэр,өрөөний дугаар болон үнийн мэдээллийг гаргаж
үнээр нь эрэмбэлнэ үү.
SELECT h.city,h.hotelName,r.hotelNo,r.price
FROM hotel h,room r
WHERE h.hotelno=r.hotelno
ORDER BY price
2.100-300-н үнэтэй өрөөнүүдийг буудлын мэдээллийн хамтаар харуулна уу.
SELECT r.*,h.*
FROM room r 
LEFT JOIN hotel h ON r.hotelNo=h.hotelNo
WHERE r.price BETWEEN 100 AND 300 
3.Хамгийн олон өрөөтэй зочид буудлын мэдээллийг гаргана уу.
SELECT h.*
FROM room r, hotel h
WHERE r.hotelno=h.hotelno
GROUP BY r.hotelno
ORDER BY COUNT(r.roomno) DESC
LIMIT 1;
4.Зочид буудал тус бүр хэдэн өрөөтэй болон өрөөнүүдийн хамгийн хямд, их, дундаж үнийн мэдээллийг харуулна уу.
SELECT h.hotelname,COUNT(r.roomno) AS OrooniiToo, MIN(r.price),MAX(r.price),AVG(r.price)
FROM room r, hotel h
WHERE r.hotelno=h.hotelno
GROUP BY h.hotelno
5.Mark гэсэн нэртэй хүний буудалсан буудлын мэдээлэл, өрөөний мэдээллийг шүүж гаргана уу.
SELECT h.*,r.*
FROM booking b,guest g,hotel h,room r
WHERE b.guestno=g.guestno AND g.guestname="Mark" AND b.hotelno=h.hotelno AND h.hotelno=r.hotelno
6.Өнөөдрийн байдлаар зочинтой байгаа өрөөний дугаар,орны тоо,үнэ,зочны нэр,утасны дугаар болон тухайн өрөө аль хотод
байрладаг ямар нэртэй буудлын өрөө болохыг харуулна уу. NOW() функцийг ашиглана уу.
SELECT r.roomNo, r.bed, r.price, g.guestName, g.phonenumber, h.hotelname, h.city 
FROM room r, hotel h, guest g, booking b
WHERE g.guestNo=b.guestNo AND b.hotelNo=h.hotelNo AND r.roomNo=b.roomNo AND g.guestNo IN(SELECT guestNo
                                                                                         FROM booking b
                                                                                         WHERE guestNo!="" AND dateFrom<NOW() AND dateTo>NOW();
7.Зочинтой өрөөний захиалга дуусах хугацааг хоногоор харуулна уу. DATEDIFF()функцийг ашиглана уу.
SELECT *,DATEDIFF(dateto,(SELECT NOW()))
FROM booking
WHERE NOW() BETWEEN datefrom AND dateto;
8.Хамгийн их зочинтой зочид буудлын өрөөний мэдээллийг харуулна уу.
SELECT * 
FROM hotel
WHERE hotelNo = (SELECT hotelNo
        FROM booking
        WHERE (SELECT NOW()) BETWEEN dateFrom AND dateTo
        GROUP BY hotelNo
        ORDER BY COUNT(guestNo) DESC
        LIMIT 1)
9.300-с бага үнэтэй өрөө шууд захиалах боломжтой буудлуудын мэдээллийг гаргана уу.
SELECT h.*,r.price
FROM hotel h,room r,booking b
WHERE r.price < 300 AND h.hotelno=r.hotelno AND b.dateto<NOW() AND b.hotelno=h.hotelno;
10.Хамгийн удаан хугацаагаар буудалсан зочны дугаар,нэр,буудлын дугаар,буудал байрлах хот,өрөөний дугаар,үнийн мэдээллийг
гаргана уу.
SELECT b.guestNo,b.hotelNo,g.guestName,h.city,b.roomNo,r.price
FROM booking b ,hotel h, room r,guest g
WHERE b.roomNo=r.roomNo AND b.hotelNo=h.hotelNo AND b.guestNo=g.guestNo
GROUP BY b.hotelNo
ORDER BY MAX(DATEDIFF(b.dateTo,b.dateFrom)) DESC
LIMIT 1;