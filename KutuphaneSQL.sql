 /*
SQL Giriş – Uygulamalı Proje Ödevi (Kütüphane Konsepti)

Senaryo
Bir «Kütüphane – Kitap Envanteri» için tek bir tablo ile çalışacaksınız. Amaç, filtreleme
(WHERE, BETWEEN, IN, LIKE), sıralama (ORDER BY) ve sınırlama (LIMIT) konularını
pekiştirmektir. İlişki/JOIN yoktur.

1) İstenen Tablo Yapısı (Şema – Script YOK)
Tablo adı: books
• book_id – tamsayı, birincil anahtar olacak şekilde tasarlayın (benzersiz).
• title – metin, boş bırakılamaz.
• author – metin, boş bırakılamaz.
• genre – metin (örn. roman, bilim, çocuk, tarih, kişisel gelişim).
• price – ondalıklı sayı (ör. 0’dan küçük olamaz).
• stock– tamsayı (negatif olamaz).
• published_year – tamsayı (ör. 1900–2025 aralığı).
• added_at – tarih (kitabın envantere eklenme tarihi).
Not: Uygun veri tiplerini seçmek ve temel mantıksal kısıtları tanımlamak sizdedir.
*/

CREATE DATABASE KutuphaneDB;
GO
USE KutuphaneDB;
GO

-- 1. İstenen Tablo Yapısı 
 
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title NVARCHAR(255) NOT NULL,
    author NVARCHAR(255) NOT NULL,
    genre NVARCHAR(50),
    price DECIMAL(10,2) CONSTRAINT chk_price CHECK (price >= 0),
    stock_qty INT CONSTRAINT chk_stock CHECK (stock_qty >= 0),
    published_year INT CONSTRAINT chk_year CHECK (published_year BETWEEN 1500 AND 2025),
    added_at DATE
);
GO

-- 2. Eklenecek Hedef Veri Listesi 
 
INSERT INTO Books (book_id, title, author, genre, price, stock_qty, published_year, added_at)
VALUES 
(1, N'Kayıp Zamanın İzinde', N'M. Proust', N'roman', 129.90, 25, 1913, '2025-08-20'),
(2, N'Simyacı', N'P. Coelho', N'roman', 89.50, 40, 1988, '2025-08-21'),
(3, N'Sapiens', N'Y. N. Harari', N'tarih', 159.00, 18, 2011, '2025-08-25'),
(4, N'İnce Memed', N'Y. Kemal', N'roman', 99.90, 12, 1955, '2025-08-22'),
(5, N'Körlük', N'J. Saramago', N'roman', 119.00, 7, 1995, '2025-08-28'),
(6, N'Dune', N'F. Herbert', N'bilim', 149.00, 30, 1965, '2025-09-01'),
(7, N'Hayvan Çiftliği', N'G. Orwell', N'roman', 79.90, 55, 1945, '2025-08-23'),
(8, N'1984', N'G. Orwell', N'roman', 99.00, 35, 1949, '2025-08-24'),
(9, N'Nutuk', N'M. K. Atatürk', N'tarih', 139.00, 20, 1927, '2025-08-27'),
(10, N'Küçük Prens', N'A. de Saint-Exupéry', N'çocuk', 69.90, 80, 1943, '2025-08-26'),
(11, N'Başlangıç', N'D. Brown', N'roman', 109.00, 22, 2017, '2025-09-02'),
(12, N'Atomik Alışkanlıklar', N'J. Clear', N'kişisel gelişim', 129.00, 28, 2018, '2025-09-03'),
(13, N'Zamanın Kısa Tarihi', N'S. Hawking', N'bilim', 119.50, 16, 1988, '2025-08-29'),
(14, N'Şeker Portakalı', N'J. M. de Vasconcelos', N'roman', 84.90, 45, 1968, '2025-08-30'),
(15, N'Bir İdam Mahkûmunun Son Günü', N'V. Hugo', N'roman', 74.90, 26, 1829, '2025-08-31');  
GO

-- 3. Görevler – Yalnızca Filtreleme (SELECT)

--1. Tüm kitapların title, author, price alanlarını fiyatı artan şekilde sıralayarak listeleyin.
SELECT title, author, price FROM Books ORDER BY price ASC;
GO

-- 2. Türü 'roman' olan kitapları A→Z title sırasıyla gösterin.
SELECT * FROM Books WHERE genre = N'roman' ORDER BY title ASC;
GO

-- 3. Fiyatı 80 ile 120 (dahil) arasındaki kitapları listeleyin (BETWEEN)
SELECT * FROM Books WHERE price BETWEEN 80 AND 120;
GO

-- 4. Stok adedi 20’den az olan kitapları bulun (title, stock_qty).
SELECT title, stock_qty FROM Books WHERE stock_qty < 20;
GO

-- 5. title içinde 'zaman' geçen kitapları LIKE ile filtreleyin (büyük/küçük harf durumunu not edin).
SELECT * FROM Books WHERE LOWER(title) LIKE N'%zaman%';
GO
-- 6. genre değeri 'roman' veya 'bilim' olanları IN ile listeleyin.
SELECT * FROM Books WHERE genre IN (N'roman', N'bilim');
GO

-- 7. published_year değeri 2000 ve sonrası olan kitapları, en yeni yıldan eskiye doğru sıralayın.
SELECT * FROM Books WHERE published_year >= 2000 ORDER BY published_year DESC;
GO

-- 8. Son 10 gün içinde eklenen kitapları bulun (added_at tarihine göre).
SELECT * FROM Books WHERE added_at >= DATEADD(DAY, -10, GETDATE());
GO
-- 9. En pahalı 5 kitabı price azalan sırada listeleyin (LIMIT 5).
SELECT TOP 5 * FROM Books ORDER BY price DESC;
GO

-- 10. Stok adedi 30 ile 60 arasında olan kitapları price artan şekilde sıralayın.
SELECT * FROM Books WHERE stock_qty BETWEEN 30 AND 60 ORDER BY price ASC;
GO

