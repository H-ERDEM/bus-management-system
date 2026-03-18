--- 1. TEMEL TABLOLARIN OLUŞTURULMASI ---

CREATE TABLE yolcu (
    yolcu_id serial primary key,
    ad varchar(50) not null,
    soyad varchar(50) not null,
    email varchar(100) unique,
    cep_tel varchar(15)
);

CREATE TABLE sofor (
    sofor_id serial primary key,
    sofor_adi varchar(50) not null,
    sofor_soyadi varchar(50) not null
);

CREATE TABLE hat (
    hat_id serial primary key,
    hat_adi varchar(50) not null unique
);

CREATE TABLE durak (
    durak_id serial primary key,
    durak_konum text not null
);

CREATE TABLE otobus (
    plaka_id varchar(15) primary key,
    kapasite integer
);

--- 2. İLİŞKİLİ TABLOLAR VE KART SİSTEMİ ---

CREATE TABLE kart (
    kart_id serial primary key,
    kart_durum varchar(20) not null,
    kart_tipi varchar(20) not null,
    sahip_yolcu_id integer references yolcu(yolcu_id)
);

CREATE TABLE bakiye (
    bakiye_id serial primary key,
    miktar numeric(10,2) not null default 0.00,
    kullanilan_tarih date,
    kart_id integer unique references kart(kart_id)
);

CREATE TABLE bildirim (
    bildirim_id serial primary key,
    olusturma_tarihi date not null,
    icerik varchar(50) not null,
    ilgili_yolcu_id integer references yolcu(yolcu_id)
);

CREATE TABLE hat_durak (
    hat_id integer references hat(hat_id),
    durak_id integer references durak(durak_id),
    primary key (hat_id, durak_id)
);

-- DÜZELTME: kart_id tipi KART tablosuyla uyumlu olması için INTEGER yapıldı (BIGINT hataya sebep olabilirdi)
CREATE TABLE KART_ISLEM (
    kart_islem_id serial primary key,
    islem_tarihi timestamp not null,
    islem_ucreti numeric(5, 2),
    islem_sonuc varchar(50) not null,
    kart_id INTEGER references KART(kart_id) 
);

CREATE TABLE yolculuk (
    yolculuk_id serial primary key,
    saat time not null,
    ucret numeric(5, 2) not null,
    baslangic_durak integer references durak(durak_id),
    bitis_durak integer references durak(durak_id),
    otobus_id varchar(15) references otobus(plaka_id),
    hat_id integer references hat(hat_id),
    sofor_id integer references sofor(sofor_id)
);

CREATE TABLE yolculuk_yolcu (
    yolculuk_id integer references yolculuk(yolculuk_id),
    yolcu_id integer references yolcu(yolcu_id),
    primary key (yolculuk_id, yolcu_id)
);

CREATE TABLE sofor_otobus (
    sofor_id integer references sofor(sofor_id),
    plaka_id varchar(15) references otobus(plaka_id),
    primary key (sofor_id, plaka_id)
);

--- 3. ALT TİP (KALITIM) TABLOLARI VE ÖZEL BİLDİRİMLER ---

CREATE TABLE yolculuk_bildirim (
    bildirim_id integer PRIMARY KEY REFERENCES bildirim(bildirim_id),
    icerik_detay text
);

CREATE TABLE durak_bildirim ( 
    bildirim_id integer PRIMARY KEY REFERENCES bildirim(bildirim_id),
    ilgili_durak_id integer REFERENCES durak(durak_id)
);

CREATE TABLE sofor_bildirim ( 
    bildirim_id integer PRIMARY KEY REFERENCES bildirim(bildirim_id),
    ilgili_sofor_id integer REFERENCES sofor(sofor_id)
);

CREATE TABLE ogrenci ( 
    yolcu_id integer PRIMARY KEY REFERENCES yolcu(yolcu_id),
    ogrenci_belgesi_tarihi date
);

CREATE TABLE engelli ( 
    yolcu_id integer PRIMARY KEY REFERENCES yolcu(yolcu_id),
    engelli_belgesi_tarihi date
);

CREATE TABLE yas_65_uzeri ( 
    yolcu_id integer PRIMARY KEY REFERENCES yolcu(yolcu_id),
    yas integer
);

CREATE TABLE memur ( 
    yolcu_id integer PRIMARY KEY REFERENCES yolcu(yolcu_id),
    kurum_adi varchar(50) NOT NULL
);

--- 4. VERİ EKLEME (INSERT) İŞLEMLERİ ---

INSERT INTO yolcu (ad, soyad, email, cep_tel) VALUES
('Ahmet', 'Yılmaz', 'ahmet.y@mail.com', '5301112233'),
('Ayşe', 'Kaya', 'ayse.k@mail.com', '5312223344'),
('Mehmet', 'Demir', 'mehmet.d@mail.com', '5323334455'),
('Fatma', 'Çelik', 'fatma.c@mail.com', '5334445566'),
('Ali', 'Öztürk', 'ali.o@mail.com', '5345556677'),
('Ömer Burak', 'Karakaya', 'omerburak.k@mail.com', '5356667788'),
('Emre', 'Aydın', 'emre.a@mail.com', '5367778899'),
('Deniz', 'Güneş', 'deniz.g@mail.com', '5378889900'),
('Can', 'Aksoy', 'can.a@mail.com', '5389990011'),
('Selin', 'Eren', 'selin.e@mail.com', '5390001122');

INSERT INTO sofor (sofor_adi, sofor_soyadi) VALUES
('Kenan', 'Yıldız'), ('Selin', 'Polat'), ('Veli', 'Çınar'), ('Emel', 'Gündoğdu'), ('Okan', 'Aksoy'),
('Mert', 'Yıldız'), ('Burak', 'Polat'), ('Abuzer', 'Kaya'), ('Elif', 'Hakverdi'), ('Emre', 'Aksoy');

INSERT INTO hat (hat_adi) VALUES ('2E'), ('10Z'), ('153A'), ('152A'), ('401K'), ('17A'), ('2K'), ('17C'), ('401B'), ('6A');

INSERT INTO durak (durak_konum) VALUES ('İnönü Mah.'), ('Kaldırım Sok.'), ('Yüzakı Cad.'), ('AVM Meydanı'), ('Erenler Sok.'), 
('Turgut Özal Mah.'), ('Gültepe Cad.'), ('Hürriyet Meydanı'), ('İstiklal Sok.'), ('Jandarma Kavşağı');

INSERT INTO otobus (plaka_id, kapasite) VALUES ('44M123', 40), ('44M135', 50), ('44M175', 45), ('44M524', 45), ('44M868', 50), 
('44M976', 35), ('44M482', 40), ('44M591', 45), ('44M602', 50), ('44M237', 50);

INSERT INTO kart (kart_durum, kart_tipi, sahip_yolcu_id) VALUES
('Aktif', 'Normal', 1), ('Aktif', 'Öğrenci', 2), ('Pasif', 'Normal', 3), ('Aktif', 'Engelli', 4), ('Aktif', 'Memur', 5),
('Aktif', 'Normal', 6), ('Aktif', 'Normal', 7), ('Pasif', 'Normal', 8), ('Aktif', '65+', 9), ('Aktif', 'Normal', 10);

INSERT INTO bakiye (miktar, kullanilan_tarih, kart_id) VALUES
(50.00, '2025-11-24', 1), (30.00, '2025-11-23', 2), (0.00, null, 3), (75.50, '2025-11-24', 4), (100.00,'2025-11-22', 5),
(20.00, '2025-11-24', 6), (45.00, '2025-11-23', 7), (0.00, null, 8), (60.00, '2025-11-24', 9), (10.00, '2025-11-25', 10);

INSERT INTO bildirim (olusturma_tarihi, icerik, ilgili_yolcu_id) VALUES
('2025-11-20', 'Otobüs çok geç geldi.', 1), ('2025-11-24', 'Şoför hızlı araç kullanıyor.', 8), ('2025-11-21', 'Durak tabelası kırılmış.', 3);

INSERT INTO sofor_otobus (sofor_id, plaka_id) VALUES (1,'44M123'), (2,'44M135'), (8,'44M591');

INSERT INTO yolculuk (saat, ucret, baslangic_durak, bitis_durak, otobus_id, hat_id, sofor_id) VALUES
('07:00:00', 5.50, 1, 5, '44M123', 1, 1);

INSERT INTO engelli (yolcu_id, engelli_belgesi_tarihi) VALUES (4, '2024-08-10');
INSERT INTO memur (yolcu_id, kurum_adi) VALUES (5, 'Çevre ve Şehircilik');
INSERT INTO ogrenci (yolcu_id, ogrenci_belgesi_tarihi) VALUES (2, '2025-09-10');
INSERT INTO yas_65_uzeri (yolcu_id, yas) VALUES (9, 74);

--- 5. GÜNCELLEMELER VE CONSTRAINT DÜZENLEMELERİ ---

-- DÜZELTME: Aynı constraint'i iki kere eklememek için DROP eklendi.
ALTER TABLE sofor_otobus DROP CONSTRAINT IF EXISTS sofor_otobus_plaka_id_fkey;
ALTER TABLE sofor_otobus ADD CONSTRAINT sofor_otobus_plaka_id_fkey FOREIGN KEY (plaka_id) REFERENCES otobus(plaka_id) ON UPDATE CASCADE;

ALTER TABLE yolculuk DROP CONSTRAINT IF EXISTS yolculuk_otobus_id_fkey;
ALTER TABLE yolculuk ADD CONSTRAINT yolculuk_otobus_id_fkey FOREIGN KEY (otobus_id) REFERENCES otobus(plaka_id) ON UPDATE CASCADE;

--- 6. FONKSİYONLAR VE TRIGGERLAR ---

-- Şoför kazancı hesaplama
CREATE OR REPLACE FUNCTION sofor_otobus_kazanc_hesapla(p_sofor_id INTEGER, p_plaka_id VARCHAR)
RETURNS NUMERIC(10, 2) LANGUAGE plpgsql AS $$
DECLARE
    toplam_ucret NUMERIC(10, 2) := 0.00;
BEGIN
    SELECT SUM(y.ucret) INTO toplam_ucret FROM yolculuk y WHERE y.sofor_id = p_sofor_id AND y.otobus_id = p_plaka_id;
    RETURN COALESCE(toplam_ucret, 0.00);
END;
$$;

-- Kart bakiye güncelleme trigger fonksiyonu
CREATE OR REPLACE FUNCTION kart_bakiye_guncelle()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    IF NEW.islem_sonuc = 'Başarılı Biniş' THEN
        UPDATE bakiye
        SET miktar = miktar - NEW.islem_ucreti,
            kullanilan_tarih = NEW.islem_tarihi::DATE
        WHERE kart_id = NEW.kart_id;       
    END IF;
    RETURN NEW;
END;
$$;

-- Trigger tanımlama
DROP TRIGGER IF EXISTS trg_kart_islem_kaydi_guncelle ON KART_ISLEM;
CREATE TRIGGER trg_kart_islem_kaydi_guncelle
AFTER INSERT ON KART_ISLEM
FOR EACH ROW EXECUTE FUNCTION kart_bakiye_guncelle();

--- 7. VIEW (RAPORLAMA) ---

CREATE OR REPLACE VIEW v_bildirim_raporu AS
SELECT
    b.bildirim_id, b.olusturma_tarihi, b.icerik, y.ad AS yolcu_ad, y.soyad AS yolcu_soyad,
    CASE
        WHEN yb.bildirim_id IS NOT NULL THEN 'Yolculuk/Genel Şikayet'
        WHEN sb.bildirim_id IS NOT NULL THEN 'Şoför Şikayeti'
        WHEN db.bildirim_id IS NOT NULL THEN 'Durak Şikayeti'
        ELSE 'Diğer'
    END AS bildirim_tipi,
    yb.icerik_detay AS detay, s.sofor_adi, s.sofor_soyadi, d.durak_konum
FROM bildirim b
JOIN yolcu y ON b.ilgili_yolcu_id = y.yolcu_id
LEFT JOIN yolculuk_bildirim yb ON b.bildirim_id = yb.bildirim_id
LEFT JOIN sofor_bildirim sb ON b.bildirim_id = sb.bildirim_id
LEFT JOIN sofor s ON sb.ilgili_sofor_id = s.sofor_id
LEFT JOIN durak_bildirim db ON b.bildirim_id = db.bildirim_id
LEFT JOIN durak d ON db.ilgili_durak_id = d.durak_id;

--- TEST ---
-- Bir işlem ekleyip trigger'ı test edelim
INSERT INTO KART_ISLEM (islem_tarihi, islem_ucreti, islem_sonuc, kart_id) 
VALUES (CURRENT_TIMESTAMP, 5.50, 'Başarılı Biniş', 1);

SELECT * FROM bakiye WHERE kart_id = 1;
SELECT * FROM v_bildirim_raporu;
