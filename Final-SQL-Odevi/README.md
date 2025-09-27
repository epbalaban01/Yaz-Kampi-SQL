# 📦 Online Alışveriş Platformu SQL Ödevi



<p align="center">
  <img src="https://socialify.git.ci/epbalaban01/Yaz-Kampi-SQL/image?description=1&font=Jost&pattern=Charlie+Brown&theme=Light" alt="Project Image" width="600"/>
</p>

## 🌟 Proje Hakkında
Bu proje, bir **online alışveriş platformu** için SQL veritabanı tasarımı ve sorgulama işlemlerini içermektedir.  
Amaç, **MSSQL kullanarak tablolar oluşturma, veri ekleme, güncelleme ve raporlama sorguları** ile pratik yapmaktır.

**Öne Çıkan Özellikler:**
- Müşteri, ürün, satıcı ve sipariş yönetimi
- Kategori bazlı ve satış bazlı raporlama
- İleri seviye SQL sorguları ile analiz

## 🗂 Veritabanı ve Tablolar

**Veritabanı Adı:** `OnlineAlisveris`

### 1️⃣ Müşteri
| Alan | Tip | Özellik |
|------|-----|---------|
| musteri_id | INT | PRIMARY KEY, IDENTITY(1,1) |
| ad | NVARCHAR(50) | NOT NULL |
| soyad | NVARCHAR(50) | NOT NULL |
| email | NVARCHAR(100) | UNIQUE |
| sehir | NVARCHAR(50) |  |
| kayit_tarihi | DATE | DEFAULT GETDATE() |

### 2️⃣ Kategori
| Alan | Tip | Özellik |
|------|-----|---------|
| kategori_id | INT | PRIMARY KEY, IDENTITY(1,1) |
| ad | NVARCHAR(100) | NOT NULL |

### 3️⃣ Satıcı
| Alan | Tip | Özellik |
|------|-----|---------|
| satici_id | INT | PRIMARY KEY, IDENTITY(1,1) |
| ad | NVARCHAR(100) | NOT NULL |
| adres | NVARCHAR(200) |  |

### 4️⃣ Ürün
| Alan | Tip | Özellik |
|------|-----|---------|
| urun_id | INT | PRIMARY KEY, IDENTITY(1,1) |
| ad | NVARCHAR(100) | NOT NULL |
| fiyat | DECIMAL(10,2) | NOT NULL |
| stok | INT | NOT NULL |
| kategori_id | INT | FOREIGN KEY -> Kategori(kategori_id) |
| satici_id | INT | FOREIGN KEY -> Satici(satici_id) |

### 5️⃣ Sipariş
| Alan | Tip | Özellik |
|------|-----|---------|
| siparis_id | INT | PRIMARY KEY, IDENTITY(1,1) |
| musteri_id | INT | FOREIGN KEY -> Musteri(musteri_id) |
| tarih | DATE | DEFAULT GETDATE() |
| toplam_tutar | DECIMAL(10,2) |  |
| odeme_turu | NVARCHAR(50) |  |

### 6️⃣ Sipariş Detay
| Alan | Tip | Özellik |
|------|-----|---------|
| detay_id | INT | PRIMARY KEY, IDENTITY(1,1) |
| siparis_id | INT | FOREIGN KEY -> Siparis(siparis_id) |
| urun_id | INT | FOREIGN KEY -> Urun(urun_id) |
| adet | INT | NOT NULL |
| fiyat | DECIMAL(10,2) | NOT NULL |

## ER Diyagramı:

<p align="center">
  <img width="824" height="512" alt="image" src="https://github.com/user-attachments/assets/a3572e17-7c22-4c18-8db6-9cab9873b5bd" />

## 📝 Veri Ekleme ve Güncelleme

#### Veri Ekleme
```sql

INSERT INTO Kategori (ad) VALUES 
('Elektronik'), ('Giyim'), ('Ev & Yaşam');

INSERT INTO Satici (ad, adres) VALUES
('Teknobiyotik', 'İstanbul'),
('Moda Life', 'Ankara'),
('Koçtaş', 'Bursa'),
('Decathlon', 'İzmir');

INSERT INTO Musteri (ad, soyad, email, sehir) VALUES
('Ali', 'Yılmaz', 'ali.yilmaz@gmail.com', 'İstanbul'),
('Ramazan', 'Çevik', 'ramazan.cevik@gmail.com', 'Ankara'),
('Emre', 'Altuner', 'emre.altuner@gmail.com', 'İzmir'),
('Oğuzhan', 'Çelik', 'oguzhan.celik@gmail.com', 'Bursa'),
('Burak', 'Koç', 'burak.koc@gmail.com', 'Antalya'),
('İsmail', 'Yılmaz', 'ismail.yilmaz@gmail.com', 'İstanbul'),
('Cem', 'Aydın', 'cem.aydin@gmail.com', 'İzmir'),
('Ahmet', 'Kara', 'ahmet.kara@gmail.com', 'Ankara'),
('Musa', 'Yıldız', 'musa.yildiz@gmail.com', 'Bursa'),
('Polat', 'Alemdar', 'polat.alemdar@gmail.com', 'İstanbul');

INSERT INTO Urun (ad, fiyat, stok, kategori_id, satici_id) VALUES
('Laptop', 15000, 10, 1, 1),
('Telefon', 12000, 20, 1, 1),
('Tişört', 250, 50, 2, 2),
('Koltuk', 5000, 5, 3, 3),
('Elbise', 400, 30, 2, 2),
('Televizyon', 8000, 15, 1, 1),
('Ayakkabı', 600, 40, 2, 4),
('Masa', 1200, 10, 3, 3);

INSERT INTO Siparis (musteri_id, toplam_tutar, odeme_turu) VALUES
(1, 15250, 'Kredi Kartı'),
(2, 12000, 'Nakit'),
(3, 1600, 'Kredi Kartı'),
(4, 5400, 'Kredi Kartı'),
(5, 1800, 'Nakit'),
(6, 20000, 'Kredi Kartı');

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
```

#### Veri Güncelleme

```sql
UPDATE Urun SET stok = stok - 1 WHERE urun_id = 1;
UPDATE Urun SET stok = stok - 2 WHERE urun_id = 3;
UPDATE Musteri SET sehir = 'İzmir' WHERE musteri_id = 2;
```
#### Veri Silme

```sql
DELETE FROM Urun WHERE urun_id = 5;
```

#### TRUNCATE
```sql
TRUNCATE TABLE Siparis_Detay;

```

## 🔍 C. Veri Sorgulama ve Raporlama

### 1️⃣ Temel Sorgular

#### En çok sipariş veren 5 müşteri
```sql
SELECT TOP 5 M.ad, M.soyad, COUNT(S.siparis_id) AS siparis_sayisi
FROM Musteri M
JOIN Siparis S ON M.musteri_id = S.musteri_id
GROUP BY M.ad, M.soyad
ORDER BY siparis_sayisi DESC;

```

### En çok satılan ürünler
```sql
SELECT U.ad AS urun_adi, SUM(D.adet) AS toplam_adet
FROM Urun U
JOIN Siparis_Detay D ON U.urun_id = D.urun_id
GROUP BY U.ad
ORDER BY toplam_adet DESC;

```

### En yüksek cirosu olan satıcılar
```sql
SELECT S.ad AS satici_adi, SUM(D.adet * D.fiyat) AS toplam_ciro
FROM Satici S
JOIN Urun U ON S.satici_id = U.satici_id
JOIN Siparis_Detay D ON U.urun_id = D.urun_id
GROUP BY S.ad
ORDER BY toplam_ciro DESC;

```

### 2️⃣ Aggregate & Group By

### Şehirlere göre müşteri sayısı
```sql
SELECT sehir, COUNT(*) AS musteri_sayisi
FROM Musteri
GROUP BY sehir;
```

### Kategori bazlı toplam satışlar
```sql
SELECT K.ad AS kategori, SUM(D.adet * D.fiyat) AS toplam_satis
FROM Kategori K
JOIN Urun U ON K.kategori_id = U.kategori_id
JOIN Siparis_Detay D ON U.urun_id = D.urun_id
GROUP BY K.ad;
```

### Aylara göre sipariş sayısı
```sql
SELECT YEAR(tarih) AS yil, MONTH(tarih) AS ay, COUNT(*) AS siparis_sayisi
FROM Siparis
GROUP BY YEAR(tarih), MONTH(tarih)
ORDER BY yil, ay;
```

### 3️⃣ JOIN’ler

### Siparişlerde müşteri + ürün + satıcı bilgisi
```sql
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

```

### Hiç satılmamış ürünler
```sql
SELECT U.ad AS urun_adi
FROM Urun U
LEFT JOIN Siparis_Detay D ON U.urun_id = D.urun_id
WHERE D.urun_id IS NULL;
```

### Hiç sipariş vermemiş müşteriler
```sql
SELECT M.ad, M.soyad
FROM Musteri M
LEFT JOIN Siparis S ON M.musteri_id = S.musteri_id
WHERE S.siparis_id IS NULL;
```

## 🔍 D. İleri Seviye Görevler (Opsiyonel)

### En çok kazanç sağlayan ilk 3 kategori
```sql
SELECT TOP 3 K.ad, SUM(D.adet * D.fiyat) AS kazanc
FROM Kategori K
JOIN Urun U ON K.kategori_id = U.kategori_id
JOIN Siparis_Detay D ON U.urun_id = D.urun_id
GROUP BY K.ad
ORDER BY kazanc DESC;
```
### Ortalama sipariş tutarını geçen siparişler
```sql
SELECT *
FROM Siparis
WHERE toplam_tutar > (SELECT AVG(toplam_tutar) FROM Siparis);

```
### En az bir kez Elektronik ürün satın alan müşteriler
```sql
SELECT DISTINCT M.ad, M.soyad
FROM Musteri M
JOIN Siparis S ON M.musteri_id = S.musteri_id
JOIN Siparis_Detay D ON S.siparis_id = D.siparis_id
JOIN Urun U ON D.urun_id = U.urun_id
JOIN Kategori K ON U.kategori_id = K.kategori_id
WHERE K.ad = 'Elektronik';

```

## 🚀 Kullanım

1. `OnlineAlisveris.sql` dosyasını MSSQL Server Management Studio (SSMS) ile açın.
2. Dosyayı **F5** tuşuna basarak çalıştırın.
3. Tüm veritabanı, tablolar, veriler ve sorgular otomatik olarak oluşturulacaktır.
4. Projenin kısa dokümantasyonu ve tasarım raporu için Word dosyasına bakabilirsiniz:[`Dökümantasyon.docx`](https://github.com/epbalaban01/Yaz-Kampi-SQL/raw/refs/heads/main/Final-SQL-Odevi/Online%20Al%C4%B1%C5%9Fveri%C5%9F%20Bitirme%20%C3%96devi.docx)

## 🔧 Notlar
- Tablolar arası `foreign key` ilişkileri kurulmuştur.
- Tarih ve varsayılan değerler `DEFAULT GETDATE()` ile belirlenmiştir.
- Türkçe karakterler için `NVARCHAR` kullanılmıştır.

#
> <b>Öneriler, istekler ve sorunlar için lütfen iletişime geçin! :)</b>



