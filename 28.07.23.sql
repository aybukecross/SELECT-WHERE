C - CREATE
R - READ(SELECT)
U - UPDATE
D - DELETE/DROP

SELECT * FROM calisanlar3

-- vakkoda çalışan kişinin iş yerini tredyola çevirme

UPDATE calisanlar3
SET isyeri= 'Trendyol'
WHERE id= 123456789

UPDATE calisanlar3 SET isim='Veli Yıldırım', sehir='Bursa' WHERE id=567890123

SELECT * FROM calisanlar3

--  markalar tablosundaki marka_id değeri 102 ye 
-- eşit veya büyük olanların marka_id'sini 2 ile çarparak değiştirin.

UPDATE markalar 
SET marka_id=marka_id*2
WHERE marka_id>=102

SELECT * FROM markalar

-- markalar tablosundaki tüm markaların calisan_sayisi değerlerini
-- marka_id ile toplayarak güncelleyiniz.

UPDATE markalar 
SET calisan_sayisi = marka_id+calisan_sayisi

--calisanlar3 tablosundan Ali Seker'in isyerini, 
--'Veli Yıldırım' ın isyeri ismi ile güncelleyiniz.

UPDATE calisanlar3
SET isyeri=(SELECT isyeri FROM calisanlar3 WHERE isim='Veli Yıldırım')
WHERE isim='Ali Seker';

--calisanlar3 tablosunda maasi 1500 olanların isyerini, markalar tablosunda
--calisan_sayisi 20000 den fazla olan markanın ismi ile değiştiriniz

SELECT * FROM calisanlar3
SELECT * FROM markalar

UPDATE calisanlar3
SET isyeri=(SELECT marka_isim FROM markalar WHERE calisan_sayisi>20000) -- select isyeri eşittir lcwaikiki yazıp sonrasında 
--onu nasıl çekeceğinin komutunu yazabilirsin
WHERE maas=1500

--calisanlar3 tablosundaki isyeri 'Vakko' olanların sehir bilgisinin sonuna ' Şubesi' ekleyiniz.

SELECT * FROM calisanlar3

UPDATE calisanlar3
SET sehir=sehir || ' Şubesi'
WHERE isyeri='Vakko'

SELECT * FROM calisanlar3

-- ORDER BY - sütunları artan ya da azalan şeklinde sıralar
-- ASC VE DESC

CREATE TABLE person
(
	ssn char(9),
	isim varchar(50),
	soyisim varchar(50),  
	adres varchar(50)
);

INSERT INTO person VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO person VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO person VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO person VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO person VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO person VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');
INSERT INTO person VALUES(256789018, 'Samet','Bulut', 'Izmir'); 
INSERT INTO person VALUES(256789013, 'Veli','Cem', 'Bursa'); 
INSERT INTO person VALUES(256789010, 'Samet','Bulut', 'Ankara'); 

SELECT * FROM person;

-- adresleri artan şekilde sıralar

SELECT * FROM person ORDER BY adres ASC

SELECT * FROM person ORDER BY soyisim DESC

-- soyadı bulut olanları azalan olarak düzenle

SELECT * FROM person  WHERE soyisim='Bulut' ORDER BY soyisim DESC

-- UNION ALL - iki farklı sorgunun sonucunu tek bi sütunda gösterir(tekrarlı)
-- UNION - aynısı ama tekrarlı, kesişimleri iki kere sayıyo

DROP TABLE developers;

CREATE TABLE developers(
id SERIAL PRIMARY KEY,
name varchar(50),
email varchar(50) UNIQUE,
salary real,
prog_lang varchar(20),
city varchar(50),
age int	
);

INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Abdullah Bey','abdullah@mail.com',4000,'Java','Ankara',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Mehmet Bey','mehmet@mail.com',5000,'JavaScript','Istanbul',35);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Ayşenur Hanım ','aysenur@mail.com',5000,'Java','Izmir',38);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Kübra Hanım','kubra@mail.com',4000,'JavaScript','Istanbul',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Muhammed Bey','muhammed@mail.com',6000,'Java','Izmir',25);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Fevzi Bey','fevzi@mail.com',6000,'Html','Istanbul',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Enes Bey','enes@mail.com',5500,'Css','Ankara',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Tansu Hanım','tansu@mail.com',5000,'Java','Bursa',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Said Bey','said@mail.com',4500,'Html','Izmir',33);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Mustafa Bey','mustafa@mail.com',4500,'Css','Bursa',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Hakan Bey','hakan@mail.com',7000,'C++','Konya',38);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Deniz Bey','deniz@mail.com',4000,'C#','Istanbul',30);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Ummu Hanım','ummu@mail.com',4000,'C#','Bursa',29);


CREATE TABLE contact_info(
address_id int,
street varchar(30),
number int,	
city varchar(30),
FOREIGN KEY(address_id) REFERENCES developers(id)	
);

INSERT INTO contact_info VALUES(1,'Kaya Sok.',5,'Bursa');
INSERT INTO contact_info VALUES(2,'Kaya Sok.',3,'Ankara');
INSERT INTO contact_info VALUES(3,'Can Sok.',10,'Bursa');
INSERT INTO contact_info VALUES(4,'Gül Sok.',12,'Ankara');
INSERT INTO contact_info VALUES(5,'Can Sok.',4,'Afyon');
INSERT INTO contact_info VALUES(6,'Taş Sok.',6,'Bolu');
INSERT INTO contact_info VALUES(7,'Dev Sok.',6,'Sivas');
INSERT INTO contact_info VALUES(8,'Dev Sok.',8,'Van');


SELECT * FROM developers;
SELECT * FROM contact_info;

--Yaşı 25’den büyük olan developer isimlerini ve 
--yaşı 30'dan küçük developerların kullandığı prog. dillerini
--tekrarsız gösteren sorguyu yaziniz

SELECT name FROM developers WHERE age>25
UNION --kesişimsiz
SELECT prog_lang FROM developers WHERE age<30

--Java kullananların maaşını ve prog. dilini ve 
--JavaScript kullananların yaşını ve prog. dilini
--tekrarlı gösteren sorguyu yaziniz
--tekrarsız gösteren sorguyu yaziniz

SELECT salary,prog_lang FROM developers WHERE prog_lang='Java'
UNION
SELECT age, prog_lang FROM developers WHERE prog_lang= 'JavaScript'

-- LIKE