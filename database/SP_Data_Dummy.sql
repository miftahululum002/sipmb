
DROP PROCEDURE if exists data_dummy;
DELIMITER $$
CREATE PROCEDURE data_dummy() 
BEGIN 
	# deklarasi variabel dan tipe data yang diperlukan 
	DECLARE i, n INT;
	DECLARE jalur INT;
		DECLARE no_pendaftar VARCHAR(20);
		DECLARE nama VARCHAR(100);
		DECLARE nisn VARCHAR(15);
		DECLARE nik VARCHAR(20);
		DECLARE tempat_lahir VARCHAR(60);
		DECLARE tanggal_lahir date;
		DECLARE jenis_kelamin VARCHAR(30);
		DECLARE no_hp VARCHAR(20);
		DECLARE id_prodi1 INT;
		DECLARE id_prodi2 INT;
		DECLARE nominal_bayar VARCHAR(15);
		DECLARE id_bank VARCHAR(10);
		DECLARE is_bayar VARCHAR(10);
		
	DECLARE pendaftar_id INT;
	DECLARE tingkat_prestasi VARCHAR(30);
	DECLARE nama_prestasi VARCHAR(255);
	DECLARE tahun int;
	DECLARE url_dokumen VARCHAR(255);
	
	# inisialisasi nilai awal untuk increment i
	SET i = 0;

	# inisialisasi menyatakan banyaknya looping
	SET n = 1000;
	# looping 1000 kali 
	
	WHILE i < n DO 
		-- statement # increment
		
		# id_jalur
      SET jalur = (SELECT id_jalur FROM jalur_masuk ORDER BY RAND() LIMIT 1);
  		SET no_pendaftar = (select CONCAT('P', YEAR(CURRENT_DATE()), jalur, (i+1)));
  		
  		SET nama = (SELECT CONCAT('Miftahul Ulum ', (i+1)));
  		SET nisn = (SELECT CONCAT('1234567', (i+1)));
  		SET nik = (SELECT CONCAT('350708120499', (i+1)));
  		SET tempat_lahir = 'MALANG';
  		
  		SET tanggal_lahir = (SELECT '2000-12-31' - INTERVAL FLOOR(RAND() * 30) DAY);
  		SET jenis_kelamin = 'Perempuan';
  		SET no_hp = (SELECT CONCAT('082255441', (i+1)));
  		
  		SET id_prodi1 = (SELECT id_prodi FROM prodi ORDER BY RAND() LIMIT 1);
  		SET id_prodi2 = (SELECT id_prodi FROM prodi ORDER BY RAND() LIMIT 1);
  		
  		SET nominal_bayar = 150000;
  		SET id_bank = (SELECT id_bank FROM bank ORDER BY RAND() LIMIT 1);
  		SET is_bayar = 1;
  	
      IF jalur = 1 THEN
         SET nominal_bayar = null;
         SET id_bank = NULL;
         SET is_bayar = 1;
      END IF;
      
      IF (i+1) % 5 = 0 then
      	SET jenis_kelamin = 'Laki-laki';
      	SET tempat_lahir = 'Jakarta';
      END if;
      
      if (i+1) % 3 = 0 then
      	SET is_bayar = 0;
      END if;
         
      # insert data dummy ke tabel pendaftar    
      INSERT INTO pendaftar (id_jalur, no_pendaftar,nama, nisn, nik, tempat_lahir, tanggal_lahir, jenis_kelamin, no_hp,
		id_prodi1, id_prodi2, nominal_bayar, id_bank, is_bayar)
      VALUES(jalur, no_pendaftar,nama, nisn, nik, tempat_lahir, tanggal_lahir, jenis_kelamin, no_hp, id_prodi1, 
		id_prodi2, nominal_bayar, id_bank, is_bayar);
		SET pendaftar_id = (SELECT LAST_INSERT_ID());
		
		if jalur = 3 then
			SET tingkat_prestasi ='NASIONAL';
			SET tahun = (SELECT YEAR(CURRENT_DATE()));
			
			if (1+i) % 6 = 0 then
				SET tingkat_prestasi = 'INTERNASIONAL';
				SET tahun = ((SELECT YEAR(CURRENT_DATE())) - 1);
			END if;
			SET nama_prestasi = (SELECT CONCAT('Prestasi ', tingkat_prestasi,' ', nama));
			
			SET url_dokumen = (SELECT CONCAT('public/uploads/prestasi/', pendaftar_id));
			INSERT INTO pendaftar_prestasi(id_pendaftar, tingkat_prestasi, nama_prestasi, tahun, url_dokumen)
			VALUES(pendaftar_id, tingkat_prestasi, nama_prestasi, tahun, url_dokumen);
		END if;
		
		SET i = i + 1; 
	END WHILE; 
END 
$$


CALL data_dummy();