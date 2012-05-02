--
-- m_sysconfig
--
insert into m_sysconfig (repository_root) values ('/repository');

--
-- r_jabatan
--

INSERT INTO r_jabatan (id, nama, keterangan) VALUES (1, 'Direktur Utama','Jabatan utama Direktur');
INSERT INTO r_jabatan (id, nama, keterangan) VALUES (2, 'Teknisi','Teknisi');

--
-- m_grup
--

INSERT INTO m_grup (id, nama, keterangan) VALUES (1, 'Administrator', 'Admin aplikasi');
INSERT INTO m_grup (id, nama, keterangan) VALUES (2, 'Pusat Berkas', 'Mengatur seluruh arsip aktif');
INSERT INTO m_grup (id, nama, keterangan) VALUES (3, 'Pusat Arsip', 'Mengatur seluruh arsip inaktif');


INSERT INTO m_unit_kerja (id, kode, nama, nama_pimpinan, keterangan) VALUES (1, 'DIRUT', 'DIREKTUR UTAMA', '','');
INSERT INTO m_unit_kerja (id, kode, nama, nama_pimpinan, keterangan) VALUES (2, 'DIRPEM', 'DIREKTUR PEMASARAN', '','');
INSERT INTO m_unit_kerja (id, kode, nama, nama_pimpinan, keterangan) VALUES (3, 'DIRUM', 'DIREKTUR UMUM', '','');
INSERT INTO m_unit_kerja (id, kode, nama, nama_pimpinan, keterangan) VALUES (4, 'DIROPS', 'DIREKTUR OPERASIONAL', '','');
INSERT INTO m_unit_kerja (id, kode, nama, nama_pimpinan, keterangan) VALUES (5, 'DIRKEP', 'DIREKTUR KEPATUHAN', '','');
INSERT INTO m_unit_kerja (id, kode, nama, nama_pimpinan, keterangan) VALUES (6, 'PERC', 'DIVISI PERENCANAAN DAN PENGEMBANGAN', '','');
INSERT INTO m_unit_kerja (id, kode, nama, nama_pimpinan, keterangan) VALUES (7, 'KRD', 'DIVISI KREDIT', '','');
INSERT INTO m_unit_kerja (id, kode, nama, nama_pimpinan, keterangan) VALUES (8, 'US', 'UNIT USAHA SYARIAH', '','');
INSERT INTO m_unit_kerja (id, kode, nama, nama_pimpinan, keterangan) VALUES (9, 'PEM', 'PEMASARAN', '','');
INSERT INTO m_unit_kerja (id, kode, nama, nama_pimpinan, keterangan) VALUES (10, 'UM', 'DIVISI UMUM', '','');
INSERT INTO m_unit_kerja (id, kode, nama, nama_pimpinan, keterangan) VALUES (11, 'SDM', 'DIVISI SDM', '','');
INSERT INTO m_unit_kerja (id, kode, nama, nama_pimpinan, keterangan) VALUES (12, 'MKHU', 'DIVISI MKHU', '','');
INSERT INTO m_unit_kerja (id, kode, nama, nama_pimpinan, keterangan) VALUES (13, 'SKAI', 'SATUAN KERJA AUDIT INTERN', '','');
INSERT INTO m_unit_kerja (id, kode, nama, nama_pimpinan, keterangan) VALUES (14, 'TSI', 'DIVISI TSI & AKUNTANSI - TSI', '','');
INSERT INTO m_unit_kerja (id, kode, nama, nama_pimpinan, keterangan) VALUES (15, 'AKT', 'DIVISI TSI & AKUNTANSI - AKUNTANSI', '','');
INSERT INTO m_unit_kerja (id, kode, nama, nama_pimpinan, keterangan) VALUES (16, 'AMU', 'TIM AMU', '','');
INSERT INTO m_unit_kerja (id, kode, nama, nama_pimpinan, keterangan) VALUES (17, 'DT', 'DIVISI DANA DAN TREASURY - TREASURY', '','');
INSERT INTO m_unit_kerja (id, kode, nama, nama_pimpinan, keterangan) VALUES (18, 'TEK', 'TEKNISI IT', '','');


--
-- m_pegawai
--

INSERT INTO m_pegawai (unit_kerja_id, grup_id, jabatan_id, nip, nama, psw, status) VALUES (18, 1, 2, '1', 'Administrator', 'admin', 1);
INSERT INTO m_pegawai (unit_kerja_id, grup_id, jabatan_id, nip, nama, psw, status) VALUES (1, 2, 2, 'NIP.0001', 'Pusat Berkas', 'berkas', 1);
INSERT INTO m_pegawai (unit_kerja_id, grup_id, jabatan_id, nip, nama, psw, status) VALUES (10, 3, 2, 'NIP.0002', 'Pusat Arsip', 'arsip', 1);

--
-- m_berkas_klas
--

INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (1, 1, '0101', 'Rapat Intern', 'Naskah - naskah yang berkaitan dengan rapat Direktur Utama dengan para Direksi dalam membahas kasus - kasus tertentu atau rapat rutin dari tahap persiapan, pelaksanaan sampai notulen hasil rapat intern');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (2, 1, '0102', 'Rapat Extern', 'Naskah - naskah yang berkaitan dengan rapat Direktur Utama dengan pihak extern dari tahap persiapan, pelaksanaan sampai notulen hasil rapat');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (3, 1, '0201', 'Kerjasama Direktur Utama dengan Pihak Ketiga', 'Naskah - naskah yang berkaitan dengan kerjasama Direktur Utama perihal operasional Bank');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (4, 1, '0301', 'Pembinaan Ke Unit Operasional', 'Naskah - naskah yang berkaitan dengan surat - surat pembinaan ke Unit-unit Operasional');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (5, 1, '0401', 'Berita Acara Serah Terima Jabatan', 'Naskah - naskah yang berhubungan dengan Berita Acara Serah Terima Jabatan, dalam hal Direktur Utama melaksanakan perjalanan dinas lebih dari 3 (tiga) hari');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (6, 1, '0501', 'Undangan Kepada Intern', 'Naskah - naskah yang berkaitan dengan undangan dari Direktur Utama untuk pihak intern Bank Jateng');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (7, 1, '0502', 'Undangan Kepada Extern', 'Naskah - naskah yang berkaitan dengan undangan dari Direktur Utama untuk pihak extern Bank Jateng');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (8, 1, '0601', 'IJIN', 'Naskah - naskah yang berkaitan dengan ijin Direktur Utama kepada Pemegang Saham atau Dewan Komisaris');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (9, 1, '0701', 'Lain - lain', 'Naskah - naskah yang berkaitan dengan kegiatan / aktivitas Direktur Utama di lembaga extern');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (10, 1, '1502', 'Laporan', 'Naskah - naskah yang berkaitan dengan laporan Direktur Utama mulai dari tahap persiapan, pelaksanaan sampai notulen hasil rapat intern');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (11, 2, '0101', 'Rapat Intern', 'Naskah - naskah yang berkaitan dengan rapat Direktur Pemasaran dengan pihak intern dalam membahas kasus - kasus tertentu atau rapat rutin dari tahap persiapan, pelaksanaan sampai notulen hasil rapat');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (12, 2, '0102', 'Rapat Extern', 'Naskah - naskah yang berkaitan dengan rapat Direktur Pemasaran dengan pihak extern mulai dari tahap persiapan, pelaksanaan sampai notulen hasil rapat');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (13, 2, '0201', 'Kerjasama Direktur Pemasaran dengan Pihak Ketiga (Dana)', 'Naskah - naskah yang berkaitan dengan kerjasama Direktur Pemasaran dengan pihak ketiga dibidang penghimpunan dana');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (14, 2, '0202', 'Kerjasama Direktur Pemasaran dengan Pihak Ketiga (Kredit)', 'Naskah - naskah yang berkaitan dengan kerjasama Direktur Pemasaran dengan pihak ketiga dibidang perkreditan');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (15, 2, '0301', 'Pembinaan Ke Unit-unit Operasional', 'Naskah - naskah yang berkaitan dengan surat pembinaan Direktur Pemasaran ke Unit-unit Operasional, berkaitan dengan evaluasi kinerja, pencapaian target, dll');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (16, 2, '0401', 'Berita Acara Serah Terima Jabatan', 'Naskah - naskah yang berkaitan dengan Berita Acara Serah Terima Jabatan dalam hal Direktur Pemasaran melaksanakan perjalanan dinas lebih dari 3 (tiga) hari');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (17, 2, '0501', 'Undangan Direktur Pemasaran', 'Naskah - naskah yang berkaitan dengan undangan dari Direktur Pemasaran');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (18, 2, '0601', 'IJIN', 'Naskah - naskah yang berkaitan dengan ijin Direktur Pemasaran kepada Direktur Utama, Pemegang Saham Pengendali, atau Dewan Komisaris');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (19, 2, '0801', 'Kebinjakan Direktur Pemasaran pada Unit Syariah', 'Naskah - naskah yang berkaitan dengan semua kebijakan Direktu Pemasaran pada Unit Syariah');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (20, 2, '1501', 'Laporan Berkala', 'Naskah - naskah yang berkaitan dengan laporan dari tahap persiapan, pelaksanaan, hingga pembuatan lapora secara berkala (harian, mingguan, dua mingguan, bulanan, triwulan, semesteran, tahunan)');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (21, 2, '1502', 'Laporan Insidental', 'Naskah - naskah yang berkaitan dengan laporan dari tahap persiapan, pelaksanaan, hingga pembuatan laporan secara insidentil');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (22, 3, '0101', 'Rapat Intern', 'Naskah - naskah yang berkaitan dengan rapat Direktur Umum dengan pihak intern dalam membahas kasus - kasus tertentu atau rapat rutin dari tahap persiapan, pelaksanaan sampai notulen hasil rapat');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (23, 3, '0102', 'Rapat Extern', 'Naskah - naskah yang berkaitan dengan rapat Direktur Umum dengan pihak extern mulai dari tahap persiapan, pelaksanaan sampai notulen hasil rapat');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (24, 3, '0201', 'Kerjasama Direktur Umum dengan Pihak Ketiga', 'Naskah - naskah yang berkaitan dengan kerjasama Direktur Umum dengan pihak ketiga');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (25, 3, '0301', 'Pembinaan Ke Unit-unit Operasional', 'Naskah - naskah yang berkaitan dengan surat pembinaan Direktur Umum ke Unit-unit Operasional');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (26, 3, '0401', 'Berita Acara Serah Terima Jabatan', 'Naskah - naskah yang berkaitan dengan Berita Acara Serah Terima Jabatan dalam hal Direktur Umum melaksanakan perjalanan dinas lebih dari 3 (tiga) hari');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (27, 3, '0501', 'Undangan Direktur Umum', 'Naskah - naskah yang berkaitan dengan undangan dari Direktur Umum');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (28, 3, '0601', 'IJIN', 'Naskah - naskah yang berkaitan dengan ijin Direktur Umum kepada Direktur Utama atau Dewan Komisaris');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (29, 3, '1501', 'Laporan Berkala', 'Naskah - naskah yang berkaitan dengan laporan dari tahap persiapan, pelaksanaan, hingga pembuatan lapora secara berkala (harian, mingguan, dua mingguan, bulanan, triwulan, semesteran, tahunan)');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (30, 3, '1502', 'Laporan Insidentil', 'Naskah - naskah yang berkaitan dengan laporan dari tahap persiapan, pelaksanaan, hingga pembuatan laporan secara insidentil');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (31, 4, '0101', 'Rapat Intern', 'Naskah - naskah yang berkaitan dengan rapat Direktur Operasional dengan pihak intern dalam membahas kasus - kasus tertentu atau rapat rutin dari tahap persiapan, pelaksanaan sampai notulen hasil rapat');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (32, 4, '0102', 'Rapat Extern', 'Naskah - naskah yang berkaitan dengan rapat Direktur Operasional dengan pihak extern mulai dari tahap persiapan, pelaksanaan sampai notulen hasil rapat');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (33, 4, '0201', 'Kerjasama Direktur Operasional dengan Pihak Ketiga', 'Naskah - naskah yang berkaitan dengan kerjasama Direktur Operasional dengan pihak ketiga dalam bidang Akuntansi dan Teknologi Informasi');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (34, 4, '0301', 'Pembinaan Ke Unit-unit Operasional', 'Naskah - naskah yang berkaitan dengan surat pembinaan Direktur Operasional ke Unit-unit Operasional perihal Akuntansi, Teknologi Informasi, dll');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (35, 4, '0401', 'Berita Acara Serah Terima Jabatan', 'Naskah - naskah yang berkaitan dengan Berita Acara Serah Terima Jabatan dalam hal Direktur Operasional melaksanakan perjalanan dinas lebih dari 3 (tiga) hari');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (36, 4, '0501', 'Undangan Direktur Operasional', 'Naskah - naskah yang berkaitan dengan undangan dari Direktur Operasional');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (37, 4, '0601', 'IJIN', 'Naskah - naskah yang berkaitan dengan ijin Direktur Operasional kepada Direktur Utama atau Dewan Komisaris');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (38, 4, '1501', 'Laporan Berkala', 'Naskah - naskah yang berkaitan dengan laporan dari tahap persiapan, pelaksanaan, hingga pembuatan lapora secara berkala (harian, mingguan, dua mingguan, bulanan, triwulan, semesteran, tahunan)');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (39, 4, '1502', 'Laporan Insidentil', 'Naskah - naskah yang berkaitan dengan laporan dari tahap persiapan, pelaksanaan, hingga pembuatan laporan secara insidentil');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (40, 5, '0101', 'Rapat Intern', 'Naskah - naskah yang berkaitan dengan rapat Direktur Kepatuhan dengan pihak intern dalam membahas kasus - kasus tertentu atau rapat rutin dari tahap persiapan, pelaksanaan sampai notulen hasil rapat');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (41, 5, '0102', 'Rapat Extern', 'Naskah - naskah yang berkaitan dengan rapat Direktur Kepatuhan dengan pihak extern mulai dari tahap persiapan, pelaksanaan sampai notulen hasil rapat');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (42, 5, '0301', 'Pembinaan Ke Unit-unit Operasional', 'Naskah - naskah yang berkaitan dengan penyampaian hasil ranking DPK dll, ke Unit-unit operasional');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (43, 5, '0501', 'Undangan Direktur Kepatuhan', 'Naskah - naskah yang berkaitan dengan undangan dari Direktur Kepatuhan');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (44, 5, '1501', 'Laporan Berkala', 'Naskah - naskah yang berkaitan dengan laporan dari tahap persiapan, pelaksanaan, hingga pembuatan lapora secara berkala (harian, mingguan, dua mingguan, bulanan, triwulan, semesteran, tahunan)');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (45, 5, '1502', 'Laporan Insidentil', 'Naskah - naskah yang berkaitan dengan laporan dari tahap persiapan, pelaksanaan, hingga pembuatan laporan ke KPK, PPATK, dll. secara insidentil');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (46, 6, '0101', 'Rencana Kerja dan Evaluasi', 'Naskah - naskah yang berkaitan dengan proses perencanaan kerja dan evaluasi dari tahap persiapan berupa pengumpulan data, pengeolahan hingga program kerja tercipta');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (47, 6, '0102', 'Statistik', 'Naskah - naskah yang berkaitan dengan permintaan, penerimaan, pengiriman data-data untuk keperluan statistik');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (48, 6, '0201', 'Penelitian dan Pengembangan', 'Naskah - naskah yang berkaitan dengan penelitian dan pengembangan perusahaan antara lain Pasar, Produk dan Kantor');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (49, 6, '0202', 'Periklanan dan Advertorial', 'Naskah - naskah yang berkaitan dengan penawaran iklan dan advertorial');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (50, 6, '0203', 'Perancangan atau Design', 'Naskah - naskah yang berkaitan dengan perancangan / design produk');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (51, 6, '0301', 'Pembianaan Anak Perusahaan', 'Naskah - naskah yang berkaitan dengan pembinaan anak perusahaan dan penyertaan modal Bank Jateng misalnya pada BPR, BPD secuties, Asuransi dll');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (52, 6, '1401', 'Undangan Intern', 'Naskah - naskah yang berkaitan dengan undangan dari Divisi Perencanaan kepada pihak Intern Bank Jateng');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (53, 6, '1402', 'Undangan Extern', 'Naskah - naskah yang berkaitan dengan undangan dari Divisi Perencanaan kepada pihak Extern');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (54, 6, '1501', 'Laporan Berkala', 'Naskah - naskah yang berkaitan dengan laporan dari tahap persiapan, pelaksanaan, hingga pembuatan lapora secara berkala (harian, mingguan, dua mingguan, bulanan, triwulan, semesteran, tahunan)');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (55, 6, '1502', 'Laporan Insidentil', 'Naskah - naskah yang berkaitan dengan laporan dari tahap persiapan, pelaksanaan, hingga pembuatan laporan secara insidentil');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (56, 7, '0101', 'Treasury dan Trading Intern', 'Naskah - naskah yang berkaitan dengan Cabang dan Capem (Intern Bank Jateng)');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (57, 7, '0102', 'Treasury dan Trading Ekstern', 'Naskah - naskah yang berkaitan dengan pihak luar (Ekstern)');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (58, 7, '0201', 'Settlement Intern', 'Naskah - naskah yang berkaitan dengan Cabang dan Capem (Intern Bank Jateng)');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (59, 7, '0202', 'Settlement Ekstern', 'Naskah - naskah yang berkaitan dengan pihak luar (Ekstern)');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (60, 7, '0301', 'Transaksi Luar Negeri Intern', 'Naskah - naskah yang berkaitan dengan Cabang dan Capem (Intern Bank Jateng)');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (61, 7, '0302', 'Transaksi Luar Negeri Ekstern', 'Naskah - naskah yang berkaitan dengan pihak luar (Ekstern)');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (62, 7, '0401', 'Kebijakan Dana dan Jasa Luar Negeri Intern', 'Naskah - naskah yang berkaitan dengan Cabang dan Capem (Intern Bank Jateng)');
INSERT INTO r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan) VALUES (63, 7, '0402', 'Kebijakan Dana dan Jasa Luar Negeri Ekstern', 'Naskah - naskah yang berkaitan dengan pihak luar (Ekstern)');


--
-- m_menu menu
--

INSERT INTO m_menu (id, pid, nama, nama_ref) VALUES (1, 0, 'Administrasi', 'adm');
INSERT INTO m_menu (id, pid, nama, nama_ref) VALUES (2, 1, 'Sistem', 'adm_sistem');
INSERT INTO m_menu (id, pid, nama, nama_ref) VALUES (3, 1, 'Hak Akses', 'adm_hak_akses');
INSERT INTO m_menu (id, pid, nama, nama_ref) VALUES (4, 0, 'Referensi', 'ref');
INSERT INTO m_menu (id, pid, nama, nama_ref) VALUES (5, 4, 'Tipe Arsip', 'ref_arsip_tipe');
INSERT INTO m_menu (id, pid, nama, nama_ref) VALUES (6, 4, 'Metoda Pemusnahan', 'ref_metoda_pemsnahan');
INSERT INTO m_menu (id, pid, nama, nama_ref) VALUES (7, 4, 'Klasifikasi Arsip', 'mas_klasifikasi_arsip');
INSERT INTO m_menu (id, pid, nama, nama_ref) VALUES (8, 4, 'Indeks Relatif', 'mas_indeks_relatif');
INSERT INTO m_menu (id, pid, nama, nama_ref) VALUES (9, 0, 'Master', 'mas');
INSERT INTO m_menu (id, pid, nama, nama_ref) VALUES (10, 9, 'Group & User', 'mas_user');
INSERT INTO m_menu (id, pid, nama, nama_ref) VALUES (11, 9, 'Unit Kerja', 'mas_unit_kerja');
INSERT INTO m_menu (id, pid, nama, nama_ref) VALUES (12, 9, 'Petugas', 'mas_petugas');
INSERT INTO m_menu (id, pid, nama, nama_ref) VALUES (13, 9, 'Arsip', 'mas_arsip');
INSERT INTO m_menu (id, pid, nama, nama_ref) VALUES (14, 0, 'Transaksi', 'trans');
INSERT INTO m_menu (id, pid, nama, nama_ref) VALUES (15, 14, 'Penyerahan', 'trans_penyerahan');
INSERT INTO m_menu (id, pid, nama, nama_ref) VALUES (16, 14, 'Peminjaman', 'trans_peminjaman');
INSERT INTO m_menu (id, pid, nama, nama_ref) VALUES (17, 14, 'Pengembalian', 'trans_pengembalian');
INSERT INTO m_menu (id, pid, nama, nama_ref) VALUES (18, 14, 'Pemusnahan', 'trans_pemusnahan');
INSERT INTO m_menu (id, pid, nama, nama_ref) VALUES (19, 0, 'Laporan', 'lap');
INSERT INTO m_menu (id, pid, nama, nama_ref) VALUES (20, 19, 'Arsip JRA', 'lap_arsip_jra');

--
-- r_akses_menu
--
INSERT INTO r_akses_menu (id, keterangan) VALUES (0, 'Tanpa Akses');
INSERT INTO r_akses_menu (id, keterangan) VALUES (1, 'View');
INSERT INTO r_akses_menu (id, keterangan) VALUES (2, 'Insert');
INSERT INTO r_akses_menu (id, keterangan) VALUES (3, 'Update');
INSERT INTO r_akses_menu (id, keterangan) VALUES (4, 'Delete');

--
-- m_menu_akses
--

INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (1, 1,  4);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (2, 1,  4);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (3, 1,  4);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (4, 1,  4);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (5, 1,  4);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (6, 1,  4);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (7, 1,  4);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (8, 1,  4);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (9, 1,  4);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (10, 1, 4);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (11, 1, 4);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (12, 1, 4);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (13, 1, 4);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (14, 1, 4);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (15, 1, 4);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (16, 1, 4);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (17, 1, 4);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (18, 1, 4);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (19, 1, 4);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (20, 1, 4);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (1, 2,  0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (2, 2,  0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (3, 2,  0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (4, 2,  0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (5, 2,  0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (6, 2,  0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (7, 2,  0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (8, 2,  0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (9, 2,  0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (10, 2, 0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (11, 2, 0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (12, 2, 0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (13, 2, 0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (14, 2, 0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (15, 2, 0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (16, 2, 0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (17, 2, 0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (18, 2, 0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (19, 2, 0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (20, 2, 0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (1, 3,  0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (2, 3,  0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (3, 3,  0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (4, 3,  0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (5, 3,  0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (6, 3,  0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (7, 3,  0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (8, 3,  0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (9, 3,  0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (10, 3, 0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (11, 3, 0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (12, 3, 0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (13, 3, 0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (14, 3, 0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (15, 3, 0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (16, 3, 0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (17, 3, 0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (18, 3, 0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (19, 3, 0);
INSERT INTO menu_akses (menu_id, grup_id, hak_akses_id) VALUES (20, 3, 0);

--
-- r_berkas_tipe
--

INSERT INTO r_berkas_tipe(nama, keterangan) VALUES('Formulir', 'Berkas berupa formulir');
INSERT INTO r_berkas_tipe(nama, keterangan) VALUES('Berita Acara', 'Berkas berupa berita acara');
INSERT INTO r_berkas_tipe(nama, keterangan) VALUES('Gambar', 'Berkas berupa gambar diam');
INSERT INTO r_berkas_tipe(nama, keterangan) VALUES('Video', 'Berkas berupa gambar bergerak');
INSERT INTO r_berkas_tipe(nama, keterangan) VALUES('Suara', 'Berkas berupa suara');

--
-- r_akses_berbagi
--

INSERT INTO r_akses_berbagi(id, keterangan) VALUES(1, 'Lihat (user tertentu)');
INSERT INTO r_akses_berbagi(id, keterangan) VALUES(2, 'Merubah (user tertentu)');
INSERT INTO r_akses_berbagi(id, keterangan) VALUES(3, 'Lihat (global)');
INSERT INTO r_akses_berbagi(id, keterangan) VALUES(4, 'Merubah (global)');

--
-- r_arsip_status
--

INSERT INTO r_arsip_status(id, keterangan) VALUES(0, 'Ada');
INSERT INTO r_arsip_status(id, keterangan) VALUES(1, 'Dipinjam');
INSERT INTO r_arsip_status(id, keterangan) VALUES(2, 'Hilang');
INSERT INTO r_arsip_status(id, keterangan) VALUES(3, 'Musnah');
