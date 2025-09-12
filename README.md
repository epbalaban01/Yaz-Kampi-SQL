# 📚 Yaz-Kampi-SQL Kütüphane Ödevi

![Project Image](images/project-image.png)

## 🌟 Açıklama
Bu proje, bir kütüphane kitap envanterini takip etmek amacıyla hazırlanmıştır.  
Amaç, **MSSQL kullanarak tablo oluşturma, veri ekleme ve filtreleme/sorgulama** işlemlerini uygulamaktır.  
Tüm işlemler **tek tablo (Books)** üzerinde gerçekleştirilmiştir; ilişkili tablolar yoktur.

---

## 🗂 Veritabanı ve Tablo

- **Veritabanı Adı:** KutuphaneDB
- **Tablo Adı:** Books
- **Alanlar:**
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
Tüm veriler `INSERT` komutları ile girilmiştir.

---

## 🔍 Sorgular (Görevler)

1. Tüm kitapların `title`, `author`, `price` alanlarını **fiyatı artan** şekilde listeleme.
2. Türü **'roman'** olan kitapları `title` A→Z sırasıyla listeleme.
3. Fiyatı **80 ile 120** arasındaki kitaplar.
4. Stok adedi **20’den az** olan kitaplar (`title`, `stock_qty`).
5. `title` içinde **'zaman'** geçen kitaplar.
6. `genre` değeri **'roman'** veya **'bilim'** olanlar.
7. `published_year` 2000 ve sonrası olan kitaplar, en yeni yıldan eskiye sıralı.
8. Son 10 gün içinde eklenen kitaplar.
9. En pahalı **5 kitap**.
10. Stok adedi **30–60** arasında olan kitaplar, fiyat artan şekilde sıralı.

---

## ⚡ Örnek Sorgu
```sql
-- Fiyatı artan şekilde tüm kitaplar
SELECT title, author, price
FROM Books
ORDER BY price ASC;
