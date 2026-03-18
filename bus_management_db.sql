
CREATE TABLE yolcu(
yolcu_id serial primary key,
ad varchar(50) not null,
soyad varchar(50) not null,
email varchar(100) unique,
cep_tel varchar(15)
);

insert into yolcu (ad,soyad,email,cep_tel) values
('Ahmet', 'Yılmaz', 'ahmet.y@mail.com', '5301112233'),
('Ayşe', 'Kaya', 'ayse.k@mail.com', '5312223344'),
('Mehmet', 'Demir', 'mehmet.d@mail.com', '5323334455'),
('Fatma', 'Çelik', 'fatma.c@mail.com', '5334445566'),
('Ali', 'Öztürk', 'ali.o@mail.com', '5345556677'),
('Ömer Burak', 'Karakaya', 'omerburak.k@mail.com', '5356667788'),
('Emre', 'Aydın', 'emre.a@mail.com', '5367778899'),
('Deniz', 'Güneş', 'deniz.g@mail.com', '5378889900'),
('Can', 'Aksoy', 'can.a@mail.com', '5389990011'),
('Selin', 'Eren', 'selin.e@mail.com', '5390001122'),
('Büşra', 'Erdem', 'busra.e@mail.com', '5401012020'),
('Gamze', 'Tuna', 'gamze.t@mail.com', '5412123131');


CREATE TABLE sofor(
sofor_id serial primary key,
sofor_adi varchar(50) not null,
sofor_soyadi varchar(50) not null
);
insert into sofor (sofor_adi, sofor_soyadi) values
('Kenan', 'Yıldız'),
('Selin', 'Polat'),
('Veli', 'Çınar'),
('Emel', 'Gündoğdu'),
('Okan', 'Aksoy'),
('Mert', 'Yıldız'),
('Burak', 'Polat'),
('Abuzer', 'Kaya'),
('Elif', 'Hakverdi'),
('Emre', 'Aksoy');

CREATE TABLE hat(
hat_id serial primary key,
hat_adi varchar(50) not null unique
);

insert into hat (hat_adi) values
('2E'),
('10Z'),
('153A'),
('152A'),
('401K'),
('17A'),
('2K'),
('17C'),
('401B'),
('6A');


CREATE TABLE durak(
durak_id serial primary key,
durak_konum text not null
);

insert into durak (durak_konum) values
('İnönü Mah.'),
('Kaldırım Sok.'),
('Yüzakı Cad.'),
('AVM Meydanı'),
('Erenler Sok.'),
('Turgut Özal Mah.'),
('Gültepe Cad.'),
('Hürriyet Meydanı'),
('İstiklal Sok.'),
('Jandarma Kavşağı');


CREATE TABLE otobus(
plaka_id varchar(15) primary key,
kapasite integer
);
insert into otobus (plaka_id, kapasite) values
('44M123', 40),
('44M135', 50),
('44M175', 45),
('44M524', 45),
('44M868', 50),
('44M976', 35),
('44M482', 40),
('44M591', 45),
('44M602', 50),
('44M237', 50);

CREATE TABLE kart(
kart_id serial primary key,
kart_durum varchar(20) not null,
kart_tipi varchar(20) not null,
sahip_yolcu_id integer references yolcu(yolcu_id) -- Yolcu tablosuna dış anahtar
);
insert into kart (kart_durum, kart_tipi, sahip_yolcu_id) values
('Aktif', 'Normal', 1),
('Aktif', 'Öğrenci', 2),
('Pasif', 'Normal', 3),
('Aktif', 'Engelli', 4),
('Aktif', 'Memur', 5),
('Aktif', 'Normal', 6),
('Aktif', 'Normal', 7),
('Pasif', 'Normal', 8),
('Aktif', '65+', 9),
('Aktif', 'Normal', 10);

CREATE TABLE bakiye(
bakiye_id serial primary key,
miktar numeric(10,2) not null default 0.00,
kullanilan_tarih date,
kart_id integer unique references kart(kart_id) -- Kart tablosuna dış anahtar ve unique kısıt
);

insert into bakiye (miktar, kullanilan_tarih, kart_id) values
(50.00, '2025-11-24', 1),
(30.00, '2025-11-23', 2),
(0.00,  null, 3),
(75.50, '2025-11-24', 4),
(100.00,'2025-11-22', 5),
(20.00, '2025-11-24', 6),
(45.00, '2025-11-23', 7),
(0.00,  null, 8),
(60.00, '2025-11-24', 9),
(10.00, '2025-11-25', 10);


CREATE TABLE bildirim(
bildirim_id serial primary key,
olusturma_tarihi date not null,
icerik varchar(50) not null,
ilgili_yolcu_id integer references yolcu(yolcu_id)
);
insert into bildirim (olusturma_tarihi, icerik, ilgili_yolcu_id) values
('2025-11-20', 'Otobüs çok geç geldi.', 1),
('2025-11-21', 'Şoför sert fren yaptı.', 2),
('2025-11-21', 'Durak tabelası kırılmış.', 3),
('2025-11-22', 'Klima çalışmıyordu.', 4),
('2025-11-22', 'Şoför telefonla konuşuyordu.', 5),
('2025-11-23', 'Durakta çöp birikmiş.', 6),
('2025-11-23', 'Biniş sırasında kart okumadı.', 7),
('2025-11-24', 'Şoför hızlı araç kullanıyor.', 8),
('2025-11-24', 'Durak ismi hatalı yazılmış.', 9),
('2025-11-25', 'Otobüs güzergahı değiştirmiş.', 10);

CREATE TABLE hat_durak(
hat_id integer references hat(hat_id),
durak_id integer references durak(durak_id),
primary key (hat_id, durak_id)
);

insert into hat_durak (hat_id, durak_id) values
(1, 1),
(1, 3),
(1, 7),
(1, 9),
(2, 2),
(2, 4),
(2, 6),
(2, 10),
(3, 1),
(4, 8);


CREATE TABLE KART_ISLEM (
kart_islem_id serial primary key,
islem_tarihi timestamp not null,
islem_ucreti numeric(5, 2),
islem_sonuc varchar(50) not null,
kart_id BIGINT references KART(kart_id) -- Doğru tip: BIGINT
);

INSERT INTO KART_ISLEM (islem_tarihi, islem_ucreti, islem_sonuc, kart_id) VALUES
('2025-11-25 08:00:00', 5.50, 'Başarılı Biniş', 1),
('2025-11-25 09:15:00', 5.50, 'Başarılı Biniş', 2),
('2025-11-25 10:30:00', 5.50, 'Başarılı Biniş', 3),
('2025-11-25 12:45:00', 0.00, 'Reddedildi (Bakiye Yetersiz)', 4),
('2025-11-26 11:00:00', 50.00, 'Bakiye Yükleme', 5),
('2025-11-26 16:30:00', 5.50, 'Başarılı Biniş', 6),
('2025-11-27 07:45:00', 5.50, 'Başarılı Biniş', 7),
('2025-11-27 14:20:00', 5.50, 'Başarılı Biniş', 8),
('2025-11-28 09:05:00', 5.50, 'Başarılı Biniş', 9),
('2025-11-28 18:50:00', 5.50, 'Başarılı Biniş', 10);

create table yolculuk(
yolculuk_id serial primary key,
saat time not null,
ucret numeric(5, 2) not null,
baslangic_durak integer references durak(durak_id),
bitis_durak integer references durak(durak_id),
otobus_id varchar(15) references otobus(plaka_id),
hat_id integer references hat(hat_id),
sofor_id integer references sofor(sofor_id)
);
INSERT INTO yolculuk (saat, ucret, baslangic_durak, bitis_durak, otobus_id, hat_id, sofor_id) VALUES
('07:00:00', 5.50, 1, 5, '44M123', 1, 1),   -- Şoför 1 -> Plaka 44M123
('08:15:00', 5.50, 3, 10, '44M135', 2, 2),   -- Şoför 2 -> Plaka 44M135
('09:30:00', 5.50, 8, 10, '44M175', 3, 3),   -- Şoför 3 -> Plaka 44M175
('10:45:00', 5.50, 7, 2, '44M524', 4, 4),   -- Şoför 4 -> Plaka 44M524
('12:00:00', 5.50, 1, 6, '44M868', 5, 5),   -- Şoför 5 -> Plaka 44M868
('13:15:00', 5.50, 4, 10, '44M976', 6, 6),   -- Şoför 6 -> Plaka 44M976
('14:30:00', 5.50, 1, 8, '44M482', 7, 7),   -- Şoför 7 -> Plaka 44M482
('15:45:00', 5.50, 9, 10, '44M591', 8, 8),   -- Şoför 8 -> Plaka 44M591
('17:00:00', 5.50, 2, 1, '44M602', 9, 9),   -- Şoför 9 -> Plaka 44M602
('18:15:00', 5.50, 6, 7, '44M237', 10, 10); -- Şoför 10 -> Plaka 44M237


CREATE TABLE yolculuk_yolcu(
yolculuk_id integer references yolculuk(yolculuk_id),
yolcu_id integer references yolcu(yolcu_id),
primary key (yolculuk_id, yolcu_id)
);
insert into yolculuk_yolcu (yolculuk_id, yolcu_id) values
(1, 1),
(2, 2),
(3, 5),
(4, 6),
(5, 7),
(6, 8),
(7, 10),
(9, 1),
(10, 2),
(8, 5);

CREATE TABLE sofor_otobus(
sofor_id integer references sofor(sofor_id),
plaka_id varchar(15) references otobus(plaka_id),
primary key (sofor_id, plaka_id)
);
insert into sofor_otobus (sofor_id, plaka_id) values
(1,'44M123'),
(2,'44M135'),
(3,'44M175'),
(4,'44M524'),
(5,'44M868'),
(6,'44M976'),
(7,'44M482'),
(8,'44M591'),
(9,'44M602'),
(10,'44M237');

CREATE TABLE yolculuk_bildirim (
bildirim_id integer PRIMARY KEY REFERENCES bildirim(bildirim_id),
icerik_detay text
);

CREATE TABLE durak_bildirim ( bildirim_id integer PRIMARY KEY REFERENCES bildirim(bildirim_id),
ilgili_durak_id integer REFERENCES durak(durak_id)
);

CREATE TABLE sofor_bildirim ( bildirim_id integer PRIMARY KEY REFERENCES bildirim(bildirim_id),
ilgili_sofor_id integer REFERENCES sofor(sofor_id)
);

CREATE TABLE ogrenci ( yolcu_id integer PRIMARY KEY REFERENCES yolcu(yolcu_id),
ogrenci_belgesi_tarihi date
);

CREATE TABLE engelli ( yolcu_id integer PRIMARY KEY REFERENCES yolcu(yolcu_id),
engelli_belgesi_tarihi date
);

CREATE TABLE yas_65_uzeri ( yolcu_id integer PRIMARY KEY REFERENCES yolcu(yolcu_id),
yas integer
);

CREATE TABLE memur ( yolcu_id integer PRIMARY KEY REFERENCES yolcu(yolcu_id),
kurum_adi varchar(50) NOT NULL
);

INSERT INTO engelli (yolcu_id, engelli_belgesi_tarihi) VALUES
(4, '2024-08-10');

INSERT INTO memur (yolcu_id, kurum_adi) VALUES
(5, 'Çevre ve Şehircilik');

INSERT INTO ogrenci (yolcu_id, ogrenci_belgesi_tarihi) VALUES
(2, '2025-09-10');

INSERT INTO yas_65_uzeri (yolcu_id, yas) VALUES
(9, 74);

Select * From yas_65_uzeri ;

INSERT INTO durak_bildirim (bildirim_id, ilgili_durak_id) VALUES
(3, 3);

INSERT INTO yolculuk_bildirim (bildirim_id, icerik_detay) VALUES
(1, 'Otobüsün planlanan saati 18:00 idi, 18:45de geldi.');

INSERT INTO sofor_bildirim (bildirim_id, ilgili_sofor_id) VALUES
(8, 8);

UPDATE kart
SET kart_durum = 'Pasif'
FROM bakiye
WHERE kart.kart_id = bakiye.kart_id
AND kart.kart_tipi = 'Normal'
AND bakiye.kullanilan_tarih < '2025-11-24'
AND bakiye.miktar > 0.00;

UPDATE bakiye
SET miktar = miktar * 0.90
FROM kart
WHERE bakiye.kart_id = kart.kart_id
AND kart.kart_durum = 'Pasif'
AND bakiye.kullanilan_tarih < '2025-11-24'
AND kart.kart_tipi = 'Normal';


ALTER TABLE sofor_otobus
DROP CONSTRAINT sofor_otobus_plaka_id_fkey;

ALTER TABLE sofor_otobus
ADD CONSTRAINT sofor_otobus_plaka_id_fkey
FOREIGN KEY (plaka_id)
REFERENCES otobus(plaka_id)
ON UPDATE CASCADE;

-- sofor_otobus tablosuna CASCADE 
ALTER TABLE sofor_otobus
ADD CONSTRAINT sofor_otobus_plaka_id_fkey
FOREIGN KEY (plaka_id)
REFERENCES otobus(plaka_id)
ON UPDATE CASCADE;


-- yolculuk tablosuna CASCADE 
ALTER TABLE yolculuk
DROP CONSTRAINT yolculuk_otobus_id_fkey;

ALTER TABLE yolculuk
ADD CONSTRAINT yolculuk_otobus_id_fkey
FOREIGN KEY (otobus_id)
REFERENCES otobus(plaka_id)
ON UPDATE CASCADE;

SELECT yolculuk_id, otobus_id, saat
FROM yolculuk
WHERE otobus_id = '44M123';


UPDATE otobus
SET plaka_id = '44M001'
WHERE plaka_id = '44M123';


SELECT yolculuk_id, otobus_id, saat
FROM yolculuk
WHERE otobus_id = '44M12';






--Fonksiyon
CREATE FUNCTION sofor_otobus_kazanc_hesapla(
    p_sofor_id INTEGER,
    p_plaka_id VARCHAR
    
)
RETURNS NUMERIC(10, 2)
LANGUAGE plpgsql
AS $$
DECLARE
    toplam_ucret NUMERIC(10, 2) := 0.00;
BEGIN

  
    SELECT SUM(y.ucret)
    INTO toplam_ucret
    FROM yolculuk y
    WHERE
        y.sofor_id = p_sofor_id AND
        y.otobus_id = p_plaka_id;
        
    IF toplam_ucret IS NULL THEN
        toplam_ucret := 0.00;
    END IF;
    RETURN toplam_ucret;
END;
$$;
--gösterim
SELECT
    sofor.sofor_adi,
    sofor.sofor_soyadi,
    sofor_otobus.plaka_id,
    sofor_otobus_kazanc_hesapla(sofor_otobus.sofor_id, sofor_otobus.plaka_id) AS kazanc_tutari
FROM
    sofor
INNER JOIN
    sofor_otobus ON sofor.sofor_id = sofor_otobus.sofor_id
ORDER BY
    kazanc_tutari DESC, sofor.sofor_soyadi ASC;



        
CREATE OR REPLACE FUNCTION kart_bakiye_guncelle()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.islem_sonuc = 'Başarılı Biniş' THEN
        UPDATE bakiye
        SET
            miktar = miktar - NEW.islem_ucreti,
            kullanilan_tarih = NEW.islem_tarihi::DATE 
        WHERE
            kart_id = NEW.kart_id;       
    END IF;
    RETURN NEW;
END;
$$;

--trigerr
CREATE TRIGGER trg_kart_islem_kaydi_guncelle
AFTER INSERT ON KART_ISLEM
FOR EACH ROW
EXECUTE FUNCTION kart_bakiye_guncelle();

--kontrol
SELECT kart_id, miktar, kullanilan_tarih FROM bakiye WHERE kart_id = 1;

--başarılı biniş ekleme
INSERT INTO KART_ISLEM (islem_tarihi, islem_ucreti, islem_sonuc, kart_id) VALUES
('2025-12-01 07:30:00', 5.50, 'Başarılı Biniş', 1);
SELECT kart_id, miktar, kullanilan_tarih FROM bakiye WHERE kart_id = 1;







CREATE OR REPLACE VIEW v_bildirim_raporu AS
SELECT
    b.bildirim_id,
    b.olusturma_tarihi,
    b.icerik,
    
    y.ad AS yolcu_ad,        
    y.soyad AS yolcu_soyad,   
   
    CASE
        WHEN yb.bildirim_id IS NOT NULL THEN 'Yolculuk/Genel Şikayet'
        WHEN sb.bildirim_id IS NOT NULL THEN 'Şoför Şikayeti'
        WHEN db.bildirim_id IS NOT NULL THEN 'Durak Şikayeti'
        ELSE 'Diğer'
    END AS bildirim_tipi,
 
    yb.icerik_detay AS detay, 
    s.sofor_adi,
    s.sofor_soyadi,
    d.durak_konum
    
FROM
    bildirim b
JOIN
    yolcu y ON b.ilgili_yolcu_id = y.yolcu_id
LEFT JOIN
    yolculuk_bildirim yb ON b.bildirim_id = yb.bildirim_id
LEFT JOIN
    sofor_bildirim sb ON b.bildirim_id = sb.bildirim_id
LEFT JOIN
    sofor s ON sb.ilgili_sofor_id = s.sofor_id
LEFT JOIN
    durak_bildirim db ON b.bildirim_id = db.bildirim_id
LEFT JOIN
    durak d ON db.ilgili_durak_id = d.durak_id
ORDER BY
    b.olusturma_tarihi DESC;


SELECT * FROM v_bildirim_raporu;

	