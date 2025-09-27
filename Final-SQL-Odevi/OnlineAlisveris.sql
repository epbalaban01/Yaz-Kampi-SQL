
/* ============================ Online Alýþveriþ Platformu Veri Tabaný Scripti ============================ */

-- 1) VERÝ TABANI OLUÞTUR
CREATE DATABASE OnlineAlisveris;
GO
USE OnlineAlisveris;
GO

--**************************************************************************----


-- 2) TABLOLAR
--A. Veri Tabaný Tasarýmý

CREATE TABLE Musteri (
    musteri_id INT PRIMARY KEY IDENTITY(1,1),
    ad NVARCHAR(50) NOT NULL,
    soyad NVARCHAR(50) NOT NULL,
    email NVARCHAR(100) UNIQUE,
    sehir NVARCHAR(50),
    kayit_tarihi DATE DEFAULT GETDATE()
);

CREATE TABLE Kategori (
    kategori_id INT PRIMARY KEY IDENTITY(1,1),
    ad NVARCHAR(100) NOT NULL
);

CREATE TABLE Satici (
    satici_id INT PRIMARY KEY IDENTITY(1,1),
    ad NVARCHAR(100) NOT NULL,
    adres NVARCHAR(200)
);

CREATE TABLE Urun (
    urun_id INT PRIMARY KEY IDENTITY(1,1),
    ad NVARCHAR(100) NOT NULL,
    fiyat DECIMAL(10,2) NOT NULL,
    stok INT NOT NULL,
    kategori_id INT FOREIGN KEY REFERENCES Kategori(kategori_id),
    satici_id INT FOREIGN KEY REFERENCES Satici(satici_id)
);

CREATE TABLE Siparis (
    siparis_id INT PRIMARY KEY IDENTITY(1,1),
    musteri_id INT FOREIGN KEY REFERENCES Musteri(musteri_id),
    tarih DATE DEFAULT GETDATE(),
    toplam_tutar DECIMAL(10,2),
    odeme_turu NVARCHAR(50)
);

CREATE TABLE Siparis_Detay (
    detay_id INT PRIMARY KEY IDENTITY(1,1),
    siparis_id INT FOREIGN KEY REFERENCES Siparis(siparis_id),
    urun_id INT FOREIGN KEY REFERENCES Urun(urun_id),
    adet INT NOT NULL,
    fiyat DECIMAL(10,2) NOT NULL
);

--**************************************************************************----

-- B. Veri Ekleme ve Güncelleme

-- 3) VERÝ EKLEME (Geniþletilmiþ)

INSERT INTO Kategori (ad) VALUES 
('Elektronik'), ('Giyim'), ('Ev & Yaþam');

INSERT INTO Satici (ad, adres) VALUES
('Teknobiyotik', 'Ýstanbul'),
('Moda Life', 'Ankara'),
('Koçtaþ', 'Bursa'),
('Decathlon', 'Ýzmir');

INSERT INTO Musteri (ad, soyad, email, sehir) VALUES
('Ali', 'Yýlmaz', 'ali.yilmaz@gmail.com', 'Ýstanbul'),
('Ramazan', 'Çevik', 'ramazan.cevik@gmail.com', 'Ankara'),
('Emre', 'Altuner', 'emre.altuner@gmail.com', 'Ýzmir'),
('Oðuzhan', 'Çelik', 'oguzhan.celik@gmail.com', 'Bursa'),
('Burak', 'Koç', 'burak.koc@gmail.com', 'Antalya'),
('Ýsmail', 'Yýlmaz', 'ismail.yilmaz@gmail.com', 'Ýstanbul'),
('Cem', 'Aydýn', 'cem.aydin@gmail.com', 'Ýzmir'),
('Ahmet', 'Kara', 'ahmet.kara@gmail.com', 'Ankara'),
('Musa', 'Yýldýz', 'musa.yildiz@gmail.com', 'Bursa'),
('Polat', 'Alemdar', 'polat.alemdar@gmail.com', 'Ýstanbul');

INSERT INTO Urun (ad, fiyat, stok, kategori_id, satici_id) VALUES
('Laptop', 15000, 10, 1, 1),
('Telefon', 12000, 20, 1, 1),
('Tiþört', 250, 50, 2, 2),
('Koltuk', 5000, 5, 3, 3),
('Elbise', 400, 30, 2, 2),
('Televizyon', 8000, 15, 1, 1),
('Ayakkabý', 600, 40, 2, 4),
('Masa', 1200, 10, 3, 3);

INSERT INTO Siparis (musteri_id, toplam_tutar, odeme_turu) VALUES
(1, 15250, 'Kredi Kartý'),
(2, 12000, 'Nakit'),
(3, 1600, 'Kredi Kartý'),
(4, 5400, 'Kredi Kartý'),
(5, 1800, 'Nakit'),
(6, 20000, 'Kredi Kartý');

INSERT INTO Siparis_Detay (siparis_id, urun_id, adet, fiyat) VALUES
(1, 1, 1, 15000),  
(1, 3, 1, 250),
(2, 2, 1, 12000),
(3, 3, 2, 250),
(3, 7, 1, 600),
(4, 4, 1, 5000),
(4, 8, 1, 1200),
(5, 7, 3, 600),
(6, 1, 1, 15000),
(6, 6, 1, 8000);

-- 4) GÜNCELLEME
UPDATE Urun SET stok = stok - 1 WHERE urun_id = 1;
UPDATE Urun SET stok = stok - 2 WHERE urun_id = 3;
UPDATE Musteri SET sehir = 'Ýzmir' WHERE musteri_id = 2;

-- 5) SÝLME
DELETE FROM Urun WHERE urun_id = 5;

-- 6) TRUNCATE
-- TRUNCATE TABLE Siparis_Detay;


--**************************************************************************----

-- C. Veri Sorgulama ve Raporlama

-- En çok sipariþ veren 5 müþteri
SELECT TOP 5 M.ad, M.soyad, COUNT(S.siparis_id) AS siparis_sayisi
FROM Musteri M
JOIN Siparis S ON M.musteri_id = S.musteri_id
GROUP BY M.ad, M.soyad
ORDER BY siparis_sayisi DESC;

-- En çok satýlan ürünler
SELECT U.ad AS urun_adi, SUM(D.adet) AS toplam_adet
FROM Urun U
JOIN Siparis_Detay D ON U.urun_id = D.urun_id
GROUP BY U.ad
ORDER BY toplam_adet DESC;

-- En yüksek cirosu olan satýcýlar
SELECT S.ad AS satici_adi, SUM(D.adet * D.fiyat) AS toplam_ciro
FROM Satici S
JOIN Urun U ON S.satici_id = U.satici_id
JOIN Siparis_Detay D ON U.urun_id = D.urun_id
GROUP BY S.ad
ORDER BY toplam_ciro DESC;

-- Þehirlere göre müþteri sayýsý
SELECT sehir, COUNT(*) AS musteri_sayisi
FROM Musteri
GROUP BY sehir;

-- Kategori bazlý toplam satýþlar
SELECT K.ad AS kategori, SUM(D.adet * D.fiyat) AS toplam_satis
FROM Kategori K
JOIN Urun U ON K.kategori_id = U.kategori_id
JOIN Siparis_Detay D ON U.urun_id = D.urun_id
GROUP BY K.ad;

-- Aylara göre sipariþ sayýsý
SELECT YEAR(tarih) AS yil, MONTH(tarih) AS ay, COUNT(*) AS siparis_sayisi
FROM Siparis
GROUP BY YEAR(tarih), MONTH(tarih)
ORDER BY yil, ay;

-- Sipariþlerde müþteri + ürün + satýcý
SELECT 
    S.siparis_id,
    M.ad + ' ' + M.soyad AS musteri,
    U.ad AS urun,
    D.adet,
    D.fiyat,
    Sa.ad AS satici
FROM Siparis S
JOIN Musteri M ON S.musteri_id = M.musteri_id
JOIN Siparis_Detay D ON S.siparis_id = D.siparis_id
JOIN Urun U ON D.urun_id = U.urun_id
JOIN Satici Sa ON U.satici_id = Sa.satici_id;

-- Hiç satýlmamýþ ürünler
SELECT U.ad AS urun_adi
FROM Urun U
LEFT JOIN Siparis_Detay D ON U.urun_id = D.urun_id
WHERE D.urun_id IS NULL;

-- Hiç sipariþ vermemiþ müþteriler
SELECT M.ad, M.soyad
FROM Musteri M
LEFT JOIN Siparis S ON M.musteri_id = S.musteri_id
WHERE S.siparis_id IS NULL;

--**************************************************************************----

-- D. Ýleri Seviye Görevler

-- En çok kazanç saðlayan ilk 3 kategori
SELECT TOP 3 K.ad, SUM(D.adet * D.fiyat) AS kazanc
FROM Kategori K
JOIN Urun U ON K.kategori_id = U.kategori_id
JOIN Siparis_Detay D ON U.urun_id = D.urun_id
GROUP BY K.ad
ORDER BY kazanc DESC;

-- Ortalama sipariþ tutarýný geçen sipariþler
SELECT *
FROM Siparis
WHERE toplam_tutar > (SELECT AVG(toplam_tutar) FROM Siparis);

-- En az bir kez Elektronik ürünü alan müþteriler
SELECT DISTINCT M.ad, M.soyad
FROM Musteri M
JOIN Siparis S ON M.musteri_id = S.musteri_id
JOIN Siparis_Detay D ON S.siparis_id = D.siparis_id
JOIN Urun U ON D.urun_id = U.urun_id
JOIN Kategori K ON U.kategori_id = K.kategori_id
WHERE K.ad = 'Elektronik';
