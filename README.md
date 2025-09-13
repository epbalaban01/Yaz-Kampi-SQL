# 📚 Yaz-Kampi-SQL Kütüphane Ödevi

<p align="center"><img src="https://socialify.git.ci/epbalaban01/Yaz-Kampi-SQL/image?name=1&amp;owner=1&amp;theme=Light" alt="project-image"></p>

---

## 🌟 Açıklama
Bu proje, bir kütüphane kitap envanterini takip etmek amacıyla hazırlanmıştır.  
Amaç, **MSSQL kullanarak tablo oluşturma, veri ekleme ve filtreleme/sorgulama** işlemlerini uygulamaktır.  
İlişkili tablolar yoktur; tüm işlemler tek tablo (`Books`) üzerinde gerçekleştirilmiştir.

**Özellikler:**
- Tek tablo ile kitap envanteri yönetimi
- Fiyat, stok ve yayın yılı kısıtlamaları
- Farklı filtreleme ve sıralama sorguları

---

## 🗂 Veritabanı ve Tablo

- **Veritabanı Adı:** KutuphaneDB
- **Tablo Adı:** Books
  
| Alan | Tip | Özellik |
|------|-----|---------|
| book_id | INT | PRIMARY KEY |
| title | NVARCHAR(255) | NOT NULL |
| author | NVARCHAR(255) | NOT NULL |
| genre | NVARCHAR(50) |  |
| price | DECIMAL(10,2) | >= 0 |
| stock_qty | INT | >= 0 |
| published_year | INT | 1900–2025 |
| added_at | DATE |  |

---

## 📝 Veri Girişi
Tabloya **15 kitap** eklenmiştir.  
INSERT komutları ile tüm veriler eklenmiştir.

---

## 🔍 Sorgular (Görevler)

### 1️⃣ Tüm kitapların title, author, price alanlarını fiyatı artan şekilde sıralayarak listeleyin.
```sql
SELECT title, author, price FROM Books ORDER BY price ASC;
```

### 2️⃣ Türü 'roman' olan kitapları A→Z title sırasıyla gösterin.
```sql
SELECT title, author, genre FROM Books WHERE genre = N'roman' ORDER BY title ASC;
```

### 3️⃣ Fiyatı 80 ile 120 (dahil) arasındaki kitapları listeleyin (BETWEEN).
```sql
SELECT title, price FROM Books WHERE price BETWEEN 80 AND 120;

```
### 4️⃣ Stok adedi 20’den az olan kitapları bulun (title, stock_qty).
```sql
SELECT title, stock_qty FROM Books WHERE stock_qty < 20;

```

### 5️⃣ title içinde 'zaman' geçen kitapları LIKE ile filtreleyin (büyük/küçük harf durumunu not edin).
```sql
SELECT title FROM Books WHERE LOWER(title) LIKE N'%zaman%';

```

### 6️⃣ genre değeri 'roman' veya 'bilim' olanları IN ile listeleyin.
```sql
SELECT title, genre FROM Books WHERE genre IN (N'roman', N'bilim');

```

### 7️⃣ `published_year` değeri 2000 ve sonrası olan kitapları, en yeni yıldan eskiye doğru sıralayın.
```sql
SELECT title, published_year FROM Books WHERE published_year >= 2000 ORDER BY published_year DESC;

```

### 8️⃣ Son 10 gün içinde eklenen kitapları bulun (added_at tarihine göre).
```sql
SELECT title, added_at FROM Books WHERE added_at >= DATEADD(DAY, -10, GETDATE());

```

### 9️⃣ En pahalı 5 kitabı price azalan sırada listeleyin (LIMIT 5).
```sql
SELECT TOP 5 title, price FROM Books ORDER BY price DESC;

```

### 🔟 Stok adedi 30 ile 60 arasında olan kitapları price artan şekilde sıralayın.
```sql
SELECT title, stock_qty, price FROM Books WHERE stock_qty BETWEEN 30 AND 60 ORDER BY price ASC;

```

---

## 🚀 Kullanım

1. `kutuphane.sql` dosyasını MSSQL Server Management Studio (SSMS) ile açın.
2. Dosyayı **F5** tuşuna basarak çalıştırın.
3. Tüm veritabanı, tablo, veriler ve sorgular otomatik olarak oluşturulacaktır.

## 🔧 Notlar
- Tabloda `CHECK constraint` kullanılmıştır: fiyat ve stok negatif olamaz, yayın yılı 1900–2025 arasıdır.
- Türkçe karakterler için `NVARCHAR` ve `N'...'` kullanılmıştır.

 
---
> <b>Öneriler, istekler ve sorunların varsa lütfen bize ulaşın! :)</b>
