-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.8.2-alpha1
-- PostgreSQL version: 9.4
-- Project Site: pgmodeler.com.br
-- Model Author: ---

SET check_function_bodies = false;
-- ddl-end --

-- object: earsip | type: ROLE --
-- DROP ROLE IF EXISTS earsip;
CREATE ROLE earsip WITH 
	INHERIT
	LOGIN
	ENCRYPTED PASSWORD '********';
-- ddl-end --


-- Database creation must be done outside an multicommand file.
-- These commands were put in this file only for convenience.
-- -- object: earsip | type: DATABASE --
-- -- DROP DATABASE IF EXISTS earsip;
-- CREATE DATABASE earsip
-- 	ENCODING = 'UTF8'
-- 	LC_COLLATE = 'en_GB.UTF8'
-- 	LC_CTYPE = 'en_GB.UTF8'
-- 	TABLESPACE = pg_default
-- 	OWNER = earsip
-- ;
-- -- ddl-end --
-- 

-- object: public.log | type: TABLE --
-- DROP TABLE IF EXISTS public.log CASCADE;
CREATE TABLE public.log(
	id date NOT NULL,
	menu_id integer,
	pegawai_id integer,
	nama character varying(128),
	aksi character varying(32),
	CONSTRAINT pk_log PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE public.log IS 'LOG';
-- ddl-end --
ALTER TABLE public.log OWNER TO earsip;
-- ddl-end --

-- object: log_pk | type: INDEX --
-- DROP INDEX IF EXISTS public.log_pk CASCADE;
CREATE UNIQUE INDEX log_pk ON public.log
	USING btree
	(
	  id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: ref_user__log_fk | type: INDEX --
-- DROP INDEX IF EXISTS public.ref_user__log_fk CASCADE;
CREATE INDEX ref_user__log_fk ON public.log
	USING btree
	(
	  pegawai_id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: ref__menu__log_fk | type: INDEX --
-- DROP INDEX IF EXISTS public.ref__menu__log_fk CASCADE;
CREATE INDEX ref__menu__log_fk ON public.log
	USING btree
	(
	  menu_id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: public.menu_akses | type: TABLE --
-- DROP TABLE IF EXISTS public.menu_akses CASCADE;
CREATE TABLE public.menu_akses(
	menu_id integer NOT NULL,
	grup_id integer NOT NULL,
	hak_akses_id smallint DEFAULT 0,
	CONSTRAINT pk_menu_akses PRIMARY KEY (menu_id,grup_id)

);
-- ddl-end --
COMMENT ON TABLE public.menu_akses IS 'HAK AKSES TERHADAP MENU';
-- ddl-end --
ALTER TABLE public.menu_akses OWNER TO earsip;
-- ddl-end --

-- object: menu_akses_pk | type: INDEX --
-- DROP INDEX IF EXISTS public.menu_akses_pk CASCADE;
CREATE UNIQUE INDEX menu_akses_pk ON public.menu_akses
	USING btree
	(
	  menu_id,
	  grup_id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: ref_mnu__mnu_acs_fk | type: INDEX --
-- DROP INDEX IF EXISTS public.ref_mnu__mnu_acs_fk CASCADE;
CREATE INDEX ref_mnu__mnu_acs_fk ON public.menu_akses
	USING btree
	(
	  menu_id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: ref__group__mnu_acs_fk | type: INDEX --
-- DROP INDEX IF EXISTS public.ref__group__mnu_acs_fk CASCADE;
CREATE INDEX ref__group__mnu_acs_fk ON public.menu_akses
	USING btree
	(
	  grup_id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: ref__akses_akses_fk | type: INDEX --
-- DROP INDEX IF EXISTS public.ref__akses_akses_fk CASCADE;
CREATE INDEX ref__akses_akses_fk ON public.menu_akses
	USING btree
	(
	  hak_akses_id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: public.m_arsip | type: TABLE --
-- DROP TABLE IF EXISTS public.m_arsip CASCADE;
CREATE TABLE public.m_arsip(
	berkas_id integer NOT NULL,
	kode_folder character varying(255),
	kode_rak character varying(255),
	kode_box character varying(255),
	CONSTRAINT pk_m_arsip PRIMARY KEY (berkas_id)

);
-- ddl-end --
COMMENT ON TABLE public.m_arsip IS 'MASTER ARSIP';
-- ddl-end --
ALTER TABLE public.m_arsip OWNER TO earsip;
-- ddl-end --

-- object: m_arsip_pk | type: INDEX --
-- DROP INDEX IF EXISTS public.m_arsip_pk CASCADE;
CREATE UNIQUE INDEX m_arsip_pk ON public.m_arsip
	USING btree
	(
	  berkas_id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: public.m_berkas_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.m_berkas_id_seq CASCADE;
CREATE SEQUENCE public.m_berkas_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE public.m_berkas_id_seq OWNER TO earsip;
-- ddl-end --

-- object: public.m_berkas | type: TABLE --
-- DROP TABLE IF EXISTS public.m_berkas CASCADE;
CREATE TABLE public.m_berkas(
	id integer NOT NULL DEFAULT nextval('public.m_berkas_id_seq'::regclass),
	pid integer,
	pegawai_id integer,
	berkas_klas_id integer,
	unit_kerja_id integer,
	berkas_tipe_id integer,
	tipe_file smallint DEFAULT 0,
	mime character varying(255),
	sha character varying(255),
	nama character varying(255),
	tgl_unggah date NOT NULL DEFAULT ('now'::text)::date,
	tgl_dibuat date,
	nomor character varying(64),
	pembuat character varying(255),
	judul character varying(255),
	masalah character varying(255),
	jra_aktif smallint DEFAULT 1,
	jra_inaktif smallint DEFAULT 1,
	status smallint DEFAULT 1,
	status_hapus smallint DEFAULT 1,
	akses_berbagi_id smallint DEFAULT 0,
	arsip_status_id smallint DEFAULT 0,
	n_output_images integer NOT NULL DEFAULT 0,
	CONSTRAINT pk_m_berkas PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE public.m_berkas IS 'MASTER BERKAS';
-- ddl-end --
COMMENT ON COLUMN public.m_berkas.status IS '1 = AKTIF; 2 : INAKTIF';
-- ddl-end --
ALTER TABLE public.m_berkas OWNER TO earsip;
-- ddl-end --

-- object: m_berkas_pk | type: INDEX --
-- DROP INDEX IF EXISTS public.m_berkas_pk CASCADE;
CREATE UNIQUE INDEX m_berkas_pk ON public.m_berkas
	USING btree
	(
	  id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: ref_tipe_arsip_fk | type: INDEX --
-- DROP INDEX IF EXISTS public.ref_tipe_arsip_fk CASCADE;
CREATE INDEX ref_tipe_arsip_fk ON public.m_berkas
	USING btree
	(
	  berkas_tipe_id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: ref__klas__arsip_fk | type: INDEX --
-- DROP INDEX IF EXISTS public.ref__klas__arsip_fk CASCADE;
CREATE INDEX ref__klas__arsip_fk ON public.m_berkas
	USING btree
	(
	  berkas_klas_id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: ref__unit__berkas_fk | type: INDEX --
-- DROP INDEX IF EXISTS public.ref__unit__berkas_fk CASCADE;
CREATE INDEX ref__unit__berkas_fk ON public.m_berkas
	USING btree
	(
	  unit_kerja_id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: ref__pegawai__berkas_fk | type: INDEX --
-- DROP INDEX IF EXISTS public.ref__pegawai__berkas_fk CASCADE;
CREATE INDEX ref__pegawai__berkas_fk ON public.m_berkas
	USING btree
	(
	  pegawai_id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: ref__akses_berkas_fk | type: INDEX --
-- DROP INDEX IF EXISTS public.ref__akses_berkas_fk CASCADE;
CREATE INDEX ref__akses_berkas_fk ON public.m_berkas
	USING btree
	(
	  akses_berbagi_id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: ref__arsip_status_fk | type: INDEX --
-- DROP INDEX IF EXISTS public.ref__arsip_status_fk CASCADE;
CREATE INDEX ref__arsip_status_fk ON public.m_berkas
	USING btree
	(
	  arsip_status_id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: public.m_berkas_berbagi_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.m_berkas_berbagi_id_seq CASCADE;
CREATE SEQUENCE public.m_berkas_berbagi_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE public.m_berkas_berbagi_id_seq OWNER TO earsip;
-- ddl-end --

-- object: public.m_berkas_berbagi | type: TABLE --
-- DROP TABLE IF EXISTS public.m_berkas_berbagi CASCADE;
CREATE TABLE public.m_berkas_berbagi(
	bagi_ke_peg_id integer NOT NULL,
	berkas_id integer NOT NULL,
	id integer NOT NULL DEFAULT nextval('public.m_berkas_berbagi_id_seq'::regclass),
	CONSTRAINT pk_m_berkas_berbagi PRIMARY KEY (bagi_ke_peg_id,berkas_id,id)

);
-- ddl-end --
COMMENT ON TABLE public.m_berkas_berbagi IS 'MASTER UNTUK BERBAGI BERKAS';
-- ddl-end --
ALTER TABLE public.m_berkas_berbagi OWNER TO earsip;
-- ddl-end --

-- object: m_berkas_berbagi_pk | type: INDEX --
-- DROP INDEX IF EXISTS public.m_berkas_berbagi_pk CASCADE;
CREATE UNIQUE INDEX m_berkas_berbagi_pk ON public.m_berkas_berbagi
	USING btree
	(
	  bagi_ke_peg_id,
	  berkas_id,
	  id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: ref_pegawai__berbagi_fk | type: INDEX --
-- DROP INDEX IF EXISTS public.ref_pegawai__berbagi_fk CASCADE;
CREATE INDEX ref_pegawai__berbagi_fk ON public.m_berkas_berbagi
	USING btree
	(
	  bagi_ke_peg_id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: ref__berkas__berbagi_fk | type: INDEX --
-- DROP INDEX IF EXISTS public.ref__berkas__berbagi_fk CASCADE;
CREATE INDEX ref__berkas__berbagi_fk ON public.m_berkas_berbagi
	USING btree
	(
	  berkas_id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: public.m_grup_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.m_grup_id_seq CASCADE;
CREATE SEQUENCE public.m_grup_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE public.m_grup_id_seq OWNER TO earsip;
-- ddl-end --

-- object: public.m_grup | type: TABLE --
-- DROP TABLE IF EXISTS public.m_grup CASCADE;
CREATE TABLE public.m_grup(
	id integer NOT NULL DEFAULT nextval('public.m_grup_id_seq'::regclass),
	nama character varying(64),
	keterangan character varying(255),
	CONSTRAINT pk_m_grup PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE public.m_grup IS 'GRUP PEGAWAI';
-- ddl-end --
ALTER TABLE public.m_grup OWNER TO earsip;
-- ddl-end --

-- object: m_grup_pk | type: INDEX --
-- DROP INDEX IF EXISTS public.m_grup_pk CASCADE;
CREATE UNIQUE INDEX m_grup_pk ON public.m_grup
	USING btree
	(
	  id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: public.m_menu_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.m_menu_id_seq CASCADE;
CREATE SEQUENCE public.m_menu_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE public.m_menu_id_seq OWNER TO earsip;
-- ddl-end --

-- object: public.m_menu | type: TABLE --
-- DROP TABLE IF EXISTS public.m_menu CASCADE;
CREATE TABLE public.m_menu(
	id integer NOT NULL DEFAULT nextval('public.m_menu_id_seq'::regclass),
	icon character varying(16),
	pid bigint,
	nama_ref character varying(128),
	nama character varying(128),
	CONSTRAINT pk_m_menu PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE public.m_menu IS 'MASTER MENU';
-- ddl-end --
ALTER TABLE public.m_menu OWNER TO earsip;
-- ddl-end --

-- object: m_menu_pk | type: INDEX --
-- DROP INDEX IF EXISTS public.m_menu_pk CASCADE;
CREATE UNIQUE INDEX m_menu_pk ON public.m_menu
	USING btree
	(
	  id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: public.m_pegawai_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.m_pegawai_id_seq CASCADE;
CREATE SEQUENCE public.m_pegawai_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE public.m_pegawai_id_seq OWNER TO earsip;
-- ddl-end --

-- object: public.m_pegawai | type: TABLE --
-- DROP TABLE IF EXISTS public.m_pegawai CASCADE;
CREATE TABLE public.m_pegawai(
	id integer NOT NULL DEFAULT nextval('public.m_pegawai_id_seq'::regclass),
	unit_kerja_id integer,
	grup_id integer,
	jabatan_id integer,
	nip character varying(64),
	nama character varying(128),
	psw character varying(255),
	psw_expire date DEFAULT '2000-01-01'::date,
	status smallint DEFAULT 1,
	CONSTRAINT pk_m_pegawai PRIMARY KEY (id),
	CONSTRAINT ak_key_2_m_pegawa UNIQUE (nip)

);
-- ddl-end --
COMMENT ON TABLE public.m_pegawai IS 'MASTER USER/PEGAWAI';
-- ddl-end --
COMMENT ON COLUMN public.m_pegawai.status IS '0 = NON AKTIF; 1 = AKTIF ';
-- ddl-end --
ALTER TABLE public.m_pegawai OWNER TO earsip;
-- ddl-end --

-- object: m_pegawai_pk | type: INDEX --
-- DROP INDEX IF EXISTS public.m_pegawai_pk CASCADE;
CREATE UNIQUE INDEX m_pegawai_pk ON public.m_pegawai
	USING btree
	(
	  id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: ref__group__user_fk | type: INDEX --
-- DROP INDEX IF EXISTS public.ref__group__user_fk CASCADE;
CREATE INDEX ref__group__user_fk ON public.m_pegawai
	USING btree
	(
	  grup_id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: ref__jab__pegawai_fk | type: INDEX --
-- DROP INDEX IF EXISTS public.ref__jab__pegawai_fk CASCADE;
CREATE INDEX ref__jab__pegawai_fk ON public.m_pegawai
	USING btree
	(
	  jabatan_id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: ref__unit_peg_fk | type: INDEX --
-- DROP INDEX IF EXISTS public.ref__unit_peg_fk CASCADE;
CREATE INDEX ref__unit_peg_fk ON public.m_pegawai
	USING btree
	(
	  unit_kerja_id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: public.m_sysconfig | type: TABLE --
-- DROP TABLE IF EXISTS public.m_sysconfig CASCADE;
CREATE TABLE public.m_sysconfig(
	repository_root character varying(1024) NOT NULL,
	max_upload_size integer DEFAULT 5000
);
-- ddl-end --
COMMENT ON TABLE public.m_sysconfig IS 'MASTER KONFIGURASI SYSTEM';
-- ddl-end --
ALTER TABLE public.m_sysconfig OWNER TO earsip;
-- ddl-end --

-- object: public.m_unit_kerja_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.m_unit_kerja_id_seq CASCADE;
CREATE SEQUENCE public.m_unit_kerja_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE public.m_unit_kerja_id_seq OWNER TO earsip;
-- ddl-end --

-- object: public.m_unit_kerja | type: TABLE --
-- DROP TABLE IF EXISTS public.m_unit_kerja CASCADE;
CREATE TABLE public.m_unit_kerja(
	id integer NOT NULL DEFAULT nextval('public.m_unit_kerja_id_seq'::regclass),
	kode character varying(32) NOT NULL,
	nama character varying(128),
	nama_pimpinan character varying(128),
	keterangan character varying(255),
	urutan integer DEFAULT 0,
	CONSTRAINT pk_m_unit_kerja PRIMARY KEY (id),
	CONSTRAINT ak_key_2_m_unit_k UNIQUE (kode)

);
-- ddl-end --
COMMENT ON TABLE public.m_unit_kerja IS 'MASTER UNIT KERJA';
-- ddl-end --
ALTER TABLE public.m_unit_kerja OWNER TO earsip;
-- ddl-end --

-- object: m_unit_kerja_pk | type: INDEX --
-- DROP INDEX IF EXISTS public.m_unit_kerja_pk CASCADE;
CREATE UNIQUE INDEX m_unit_kerja_pk ON public.m_unit_kerja
	USING btree
	(
	  id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: public.peminjaman_rinci | type: TABLE --
-- DROP TABLE IF EXISTS public.peminjaman_rinci CASCADE;
CREATE TABLE public.peminjaman_rinci(
	peminjaman_id integer NOT NULL,
	berkas_id integer NOT NULL,
	CONSTRAINT pk_peminjaman_rinci PRIMARY KEY (peminjaman_id,berkas_id)

);
-- ddl-end --
COMMENT ON TABLE public.peminjaman_rinci IS 'PEMINJAMAN DETAIL';
-- ddl-end --
ALTER TABLE public.peminjaman_rinci OWNER TO earsip;
-- ddl-end --

-- object: peminjaman_rinci_pk | type: INDEX --
-- DROP INDEX IF EXISTS public.peminjaman_rinci_pk CASCADE;
CREATE UNIQUE INDEX peminjaman_rinci_pk ON public.peminjaman_rinci
	USING btree
	(
	  peminjaman_id,
	  berkas_id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: ref__berkas__pin_rin_fk | type: INDEX --
-- DROP INDEX IF EXISTS public.ref__berkas__pin_rin_fk CASCADE;
CREATE INDEX ref__berkas__pin_rin_fk ON public.peminjaman_rinci
	USING btree
	(
	  berkas_id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: public.r_akses_berbagi | type: TABLE --
-- DROP TABLE IF EXISTS public.r_akses_berbagi CASCADE;
CREATE TABLE public.r_akses_berbagi(
	id smallint NOT NULL,
	keterangan character varying(255),
	CONSTRAINT pk_r_akses_berbagi PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE public.r_akses_berbagi IS 'REFERENSI UNTUK BERBAGI AKSES';
-- ddl-end --
ALTER TABLE public.r_akses_berbagi OWNER TO earsip;
-- ddl-end --

-- object: r_akses_berbagi_pk | type: INDEX --
-- DROP INDEX IF EXISTS public.r_akses_berbagi_pk CASCADE;
CREATE UNIQUE INDEX r_akses_berbagi_pk ON public.r_akses_berbagi
	USING btree
	(
	  id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: public.r_akses_menu | type: TABLE --
-- DROP TABLE IF EXISTS public.r_akses_menu CASCADE;
CREATE TABLE public.r_akses_menu(
	id smallint NOT NULL,
	keterangan character varying(255),
	CONSTRAINT pk_r_akses_menu PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE public.r_akses_menu IS 'REFERENSI AKSES MENU
';
-- ddl-end --
ALTER TABLE public.r_akses_menu OWNER TO earsip;
-- ddl-end --

-- object: r_akses_menu_pk | type: INDEX --
-- DROP INDEX IF EXISTS public.r_akses_menu_pk CASCADE;
CREATE UNIQUE INDEX r_akses_menu_pk ON public.r_akses_menu
	USING btree
	(
	  id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: public.r_arsip_status | type: TABLE --
-- DROP TABLE IF EXISTS public.r_arsip_status CASCADE;
CREATE TABLE public.r_arsip_status(
	id smallint NOT NULL,
	keterangan character varying(255),
	CONSTRAINT pk_r_arsip_status PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE public.r_arsip_status IS 'REFERENSI ARSIP STATUS';
-- ddl-end --
ALTER TABLE public.r_arsip_status OWNER TO earsip;
-- ddl-end --

-- object: r_arsip_status_pk | type: INDEX --
-- DROP INDEX IF EXISTS public.r_arsip_status_pk CASCADE;
CREATE UNIQUE INDEX r_arsip_status_pk ON public.r_arsip_status
	USING btree
	(
	  id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: public.r_berkas_klas_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.r_berkas_klas_id_seq CASCADE;
CREATE SEQUENCE public.r_berkas_klas_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE public.r_berkas_klas_id_seq OWNER TO earsip;
-- ddl-end --

-- object: public.r_berkas_klas | type: TABLE --
-- DROP TABLE IF EXISTS public.r_berkas_klas CASCADE;
CREATE TABLE public.r_berkas_klas(
	id integer NOT NULL DEFAULT nextval('public.r_berkas_klas_id_seq'::regclass),
	unit_kerja_id integer,
	kode character varying(6) NOT NULL,
	nama character varying(64) NOT NULL,
	keterangan character varying(255) NOT NULL,
	jra_aktif integer NOT NULL DEFAULT 1,
	jra_inaktif integer NOT NULL DEFAULT 1,
	CONSTRAINT pk_r_berkas_klas PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE public.r_berkas_klas IS 'REFERENSI KLASIFIKASI BERKAS';
-- ddl-end --
ALTER TABLE public.r_berkas_klas OWNER TO earsip;
-- ddl-end --

-- object: r_berkas_klas_pk | type: INDEX --
-- DROP INDEX IF EXISTS public.r_berkas_klas_pk CASCADE;
CREATE UNIQUE INDEX r_berkas_klas_pk ON public.r_berkas_klas
	USING btree
	(
	  id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: ref__unit__klas_fk | type: INDEX --
-- DROP INDEX IF EXISTS public.ref__unit__klas_fk CASCADE;
CREATE INDEX ref__unit__klas_fk ON public.r_berkas_klas
	USING btree
	(
	  unit_kerja_id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: public.r_berkas_tipe_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.r_berkas_tipe_id_seq CASCADE;
CREATE SEQUENCE public.r_berkas_tipe_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE public.r_berkas_tipe_id_seq OWNER TO earsip;
-- ddl-end --

-- object: public.r_berkas_tipe | type: TABLE --
-- DROP TABLE IF EXISTS public.r_berkas_tipe CASCADE;
CREATE TABLE public.r_berkas_tipe(
	id integer NOT NULL DEFAULT nextval('public.r_berkas_tipe_id_seq'::regclass),
	nama character varying(64),
	keterangan character varying(255),
	CONSTRAINT pk_r_berkas_tipe PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE public.r_berkas_tipe IS 'REFERENSI TIPE ARSIP';
-- ddl-end --
ALTER TABLE public.r_berkas_tipe OWNER TO earsip;
-- ddl-end --

-- object: r_berkas_tipe_pk | type: INDEX --
-- DROP INDEX IF EXISTS public.r_berkas_tipe_pk CASCADE;
CREATE UNIQUE INDEX r_berkas_tipe_pk ON public.r_berkas_tipe
	USING btree
	(
	  id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: public.r_ir_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.r_ir_id_seq CASCADE;
CREATE SEQUENCE public.r_ir_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE public.r_ir_id_seq OWNER TO earsip;
-- ddl-end --

-- object: public.r_ir | type: TABLE --
-- DROP TABLE IF EXISTS public.r_ir CASCADE;
CREATE TABLE public.r_ir(
	id integer NOT NULL DEFAULT nextval('public.r_ir_id_seq'::regclass),
	berkas_klas_id integer,
	keterangan character varying(64),
	CONSTRAINT pk_r_ir PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE public.r_ir IS 'REFERNSI INDEKS RELATIF';
-- ddl-end --
ALTER TABLE public.r_ir OWNER TO earsip;
-- ddl-end --

-- object: r_ir_pk | type: INDEX --
-- DROP INDEX IF EXISTS public.r_ir_pk CASCADE;
CREATE UNIQUE INDEX r_ir_pk ON public.r_ir
	USING btree
	(
	  id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: ref__klas__ir_fk | type: INDEX --
-- DROP INDEX IF EXISTS public.ref__klas__ir_fk CASCADE;
CREATE INDEX ref__klas__ir_fk ON public.r_ir
	USING btree
	(
	  berkas_klas_id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: public.r_jabatan_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.r_jabatan_id_seq CASCADE;
CREATE SEQUENCE public.r_jabatan_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE public.r_jabatan_id_seq OWNER TO earsip;
-- ddl-end --

-- object: public.r_jabatan | type: TABLE --
-- DROP TABLE IF EXISTS public.r_jabatan CASCADE;
CREATE TABLE public.r_jabatan(
	id integer NOT NULL DEFAULT nextval('public.r_jabatan_id_seq'::regclass),
	nama character varying(128),
	keterangan character varying(255),
	urutan integer DEFAULT 0,
	CONSTRAINT pk_r_jabatan PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE public.r_jabatan IS 'REFERENSI JABATAN';
-- ddl-end --
ALTER TABLE public.r_jabatan OWNER TO earsip;
-- ddl-end --

-- object: r_jabatan_pk | type: INDEX --
-- DROP INDEX IF EXISTS public.r_jabatan_pk CASCADE;
CREATE UNIQUE INDEX r_jabatan_pk ON public.r_jabatan
	USING btree
	(
	  id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: public.r_pemusnahan_metoda_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.r_pemusnahan_metoda_id_seq CASCADE;
CREATE SEQUENCE public.r_pemusnahan_metoda_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE public.r_pemusnahan_metoda_id_seq OWNER TO earsip;
-- ddl-end --

-- object: public.r_pemusnahan_metoda | type: TABLE --
-- DROP TABLE IF EXISTS public.r_pemusnahan_metoda CASCADE;
CREATE TABLE public.r_pemusnahan_metoda(
	id integer NOT NULL DEFAULT nextval('public.r_pemusnahan_metoda_id_seq'::regclass),
	nama character varying(128),
	keterangan character varying(255),
	CONSTRAINT pk_r_pemusnahan_metoda PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE public.r_pemusnahan_metoda IS 'REFERENSI METODA PEMUSNAHAN';
-- ddl-end --
ALTER TABLE public.r_pemusnahan_metoda OWNER TO earsip;
-- ddl-end --

-- object: r_pemusnahan_metoda_pk | type: INDEX --
-- DROP INDEX IF EXISTS public.r_pemusnahan_metoda_pk CASCADE;
CREATE UNIQUE INDEX r_pemusnahan_metoda_pk ON public.r_pemusnahan_metoda
	USING btree
	(
	  id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: public.t_pemindahan_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.t_pemindahan_id_seq CASCADE;
CREATE SEQUENCE public.t_pemindahan_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE public.t_pemindahan_id_seq OWNER TO earsip;
-- ddl-end --

-- object: public.t_pemindahan | type: TABLE --
-- DROP TABLE IF EXISTS public.t_pemindahan CASCADE;
CREATE TABLE public.t_pemindahan(
	id integer NOT NULL DEFAULT nextval('public.t_pemindahan_id_seq'::regclass),
	unit_kerja_id integer,
	kode character varying(255),
	tgl date,
	status smallint,
	nama_petugas character varying(128),
	pj_unit_kerja character varying(128),
	pj_unit_arsip character varying(128),
	CONSTRAINT pk_t_pemindahan PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE public.t_pemindahan IS 'TRANSAKSI PEMINDAHAN';
-- ddl-end --
COMMENT ON COLUMN public.t_pemindahan.status IS '0 = TIDAK LENGKAP; 1 LENGKAP';
-- ddl-end --
ALTER TABLE public.t_pemindahan OWNER TO earsip;
-- ddl-end --

-- object: t_pemindahan_pk | type: INDEX --
-- DROP INDEX IF EXISTS public.t_pemindahan_pk CASCADE;
CREATE UNIQUE INDEX t_pemindahan_pk ON public.t_pemindahan
	USING btree
	(
	  id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: ref__unit_pindah_fk | type: INDEX --
-- DROP INDEX IF EXISTS public.ref__unit_pindah_fk CASCADE;
CREATE INDEX ref__unit_pindah_fk ON public.t_pemindahan
	USING btree
	(
	  unit_kerja_id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: public.t_pemindahan_rinci | type: TABLE --
-- DROP TABLE IF EXISTS public.t_pemindahan_rinci CASCADE;
CREATE TABLE public.t_pemindahan_rinci(
	pemindahan_id integer NOT NULL,
	berkas_id integer NOT NULL,
	CONSTRAINT pk_t_pemindahan_rinci PRIMARY KEY (pemindahan_id,berkas_id)

);
-- ddl-end --
COMMENT ON TABLE public.t_pemindahan_rinci IS 'RINCIAN PEMINDAHAN';
-- ddl-end --
ALTER TABLE public.t_pemindahan_rinci OWNER TO earsip;
-- ddl-end --

-- object: t_pemindahan_rinci_pk | type: INDEX --
-- DROP INDEX IF EXISTS public.t_pemindahan_rinci_pk CASCADE;
CREATE UNIQUE INDEX t_pemindahan_rinci_pk ON public.t_pemindahan_rinci
	USING btree
	(
	  pemindahan_id,
	  berkas_id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: ref_pindah___rinci_fk | type: INDEX --
-- DROP INDEX IF EXISTS public.ref_pindah___rinci_fk CASCADE;
CREATE INDEX ref_pindah___rinci_fk ON public.t_pemindahan_rinci
	USING btree
	(
	  pemindahan_id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: ref_berkas__pindah_fk | type: INDEX --
-- DROP INDEX IF EXISTS public.ref_berkas__pindah_fk CASCADE;
CREATE INDEX ref_berkas__pindah_fk ON public.t_pemindahan_rinci
	USING btree
	(
	  berkas_id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: public.t_peminjaman_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.t_peminjaman_id_seq CASCADE;
CREATE SEQUENCE public.t_peminjaman_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE public.t_peminjaman_id_seq OWNER TO earsip;
-- ddl-end --

-- object: public.t_peminjaman | type: TABLE --
-- DROP TABLE IF EXISTS public.t_peminjaman CASCADE;
CREATE TABLE public.t_peminjaman(
	id integer NOT NULL DEFAULT nextval('public.t_peminjaman_id_seq'::regclass),
	unit_kerja_peminjam_id integer,
	nama_petugas character varying(128),
	nama_pimpinan_petugas character varying(128),
	nama_peminjam character varying(128),
	nama_pimpinan_peminjam character varying(128),
	tgl_pinjam date,
	tgl_batas_kembali date,
	tgl_kembali date,
	keterangan character varying(255),
	CONSTRAINT pk_t_peminjaman PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE public.t_peminjaman IS 'TRANSAKSI PEMINJAMAN';
-- ddl-end --
ALTER TABLE public.t_peminjaman OWNER TO earsip;
-- ddl-end --

-- object: t_peminjaman_pk | type: INDEX --
-- DROP INDEX IF EXISTS public.t_peminjaman_pk CASCADE;
CREATE UNIQUE INDEX t_peminjaman_pk ON public.t_peminjaman
	USING btree
	(
	  id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: ref__unit__pinjam_fk | type: INDEX --
-- DROP INDEX IF EXISTS public.ref__unit__pinjam_fk CASCADE;
CREATE INDEX ref__unit__pinjam_fk ON public.t_peminjaman
	USING btree
	(
	  unit_kerja_peminjam_id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: public.t_pemusnahan_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.t_pemusnahan_id_seq CASCADE;
CREATE SEQUENCE public.t_pemusnahan_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE public.t_pemusnahan_id_seq OWNER TO earsip;
-- ddl-end --

-- object: public.t_pemusnahan | type: TABLE --
-- DROP TABLE IF EXISTS public.t_pemusnahan CASCADE;
CREATE TABLE public.t_pemusnahan(
	id integer NOT NULL DEFAULT nextval('public.t_pemusnahan_id_seq'::regclass),
	metoda_id integer NOT NULL,
	nama_petugas character varying(128),
	tgl date,
	pj_unit_kerja character varying(128),
	pj_berkas_arsip character varying(128),
	CONSTRAINT pk_t_pemusnahan PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE public.t_pemusnahan IS 'TRANSAKSI PEMUSNAHAN';
-- ddl-end --
ALTER TABLE public.t_pemusnahan OWNER TO earsip;
-- ddl-end --

-- object: t_pemusnahan_pk | type: INDEX --
-- DROP INDEX IF EXISTS public.t_pemusnahan_pk CASCADE;
CREATE UNIQUE INDEX t_pemusnahan_pk ON public.t_pemusnahan
	USING btree
	(
	  id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: ref__metoda___pemusnahan_fk | type: INDEX --
-- DROP INDEX IF EXISTS public.ref__metoda___pemusnahan_fk CASCADE;
CREATE INDEX ref__metoda___pemusnahan_fk ON public.t_pemusnahan
	USING btree
	(
	  metoda_id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: public.t_pemusnahan_rinci | type: TABLE --
-- DROP TABLE IF EXISTS public.t_pemusnahan_rinci CASCADE;
CREATE TABLE public.t_pemusnahan_rinci(
	pemusnahan_id integer NOT NULL,
	berkas_id integer NOT NULL,
	keterangan character varying(255),
	jml_lembar smallint,
	jml_set smallint,
	jml_berkas smallint,
	CONSTRAINT pk_t_pemusnahan_rinci PRIMARY KEY (pemusnahan_id,berkas_id)

);
-- ddl-end --
COMMENT ON TABLE public.t_pemusnahan_rinci IS 'PEMUSNAHAN DETAIL';
-- ddl-end --
ALTER TABLE public.t_pemusnahan_rinci OWNER TO earsip;
-- ddl-end --

-- object: t_pemusnahan_rinci_pk | type: INDEX --
-- DROP INDEX IF EXISTS public.t_pemusnahan_rinci_pk CASCADE;
CREATE UNIQUE INDEX t_pemusnahan_rinci_pk ON public.t_pemusnahan_rinci
	USING btree
	(
	  pemusnahan_id,
	  berkas_id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: ref_musnah__musnah_rinci_fk | type: INDEX --
-- DROP INDEX IF EXISTS public.ref_musnah__musnah_rinci_fk CASCADE;
CREATE INDEX ref_musnah__musnah_rinci_fk ON public.t_pemusnahan_rinci
	USING btree
	(
	  pemusnahan_id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: ref__berkas_rinci_fk | type: INDEX --
-- DROP INDEX IF EXISTS public.ref__berkas_rinci_fk CASCADE;
CREATE INDEX ref__berkas_rinci_fk ON public.t_pemusnahan_rinci
	USING btree
	(
	  berkas_id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: public.t_tim_pemusnahan | type: TABLE --
-- DROP TABLE IF EXISTS public.t_tim_pemusnahan CASCADE;
CREATE TABLE public.t_tim_pemusnahan(
	pemusnahan_id integer NOT NULL,
	nomor smallint NOT NULL,
	nama character varying(128),
	jabatan character varying(128),
	CONSTRAINT pk_t_tim_pemusnahan PRIMARY KEY (pemusnahan_id,nomor)

);
-- ddl-end --
COMMENT ON TABLE public.t_tim_pemusnahan IS 'TIM PEMUSNAHAN';
-- ddl-end --
ALTER TABLE public.t_tim_pemusnahan OWNER TO earsip;
-- ddl-end --

-- object: t_tim_pemusnahan_pk | type: INDEX --
-- DROP INDEX IF EXISTS public.t_tim_pemusnahan_pk CASCADE;
CREATE UNIQUE INDEX t_tim_pemusnahan_pk ON public.t_tim_pemusnahan
	USING btree
	(
	  pemusnahan_id,
	  nomor
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: ref__musnah__team_fk | type: INDEX --
-- DROP INDEX IF EXISTS public.ref__musnah__team_fk CASCADE;
CREATE INDEX ref__musnah__team_fk ON public.t_tim_pemusnahan
	USING btree
	(
	  pemusnahan_id
	)	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: public.delete_pegawai | type: FUNCTION --
-- DROP FUNCTION IF EXISTS public.delete_pegawai(integer) CASCADE;
CREATE FUNCTION public.delete_pegawai ( _id integer)
	RETURNS character varying
	LANGUAGE plpgsql
	VOLATILE 
	CALLED ON NULL INPUT
	SECURITY INVOKER
	COST 100
	AS $$

declare c int;
BEGIN
	SELECT	count(id)
	INTO	c
	FROM	m_berkas
	WHERE	pegawai_id = _id
	AND		pid != 0;
	IF c > 0 THEN
		return 'failure';
	END IF;
	delete from m_berkas where pegawai_id = _id;
	delete from m_pegawai where id = _id;
	return 'success';
END;

$$;
-- ddl-end --
ALTER FUNCTION public.delete_pegawai(integer) OWNER TO earsip;
-- ddl-end --

-- object: public.update_menu_akses | type: FUNCTION --
-- DROP FUNCTION IF EXISTS public.update_menu_akses(integer,integer,integer) CASCADE;
CREATE FUNCTION public.update_menu_akses ( _menu_id integer,  _grup_id integer,  _hak_akses_id integer)
	RETURNS void
	LANGUAGE plpgsql
	VOLATILE 
	CALLED ON NULL INPUT
	SECURITY INVOKER
	COST 100
	AS $$

BEGIN
	LOOP
		UPDATE	menu_akses
		SET		hak_akses_id	= _hak_akses_id
		WHERE	menu_id			= _menu_id
		and		grup_id			= _grup_id;
		IF found THEN
			RETURN;
		END IF;
		BEGIN
			INSERT INTO	menu_akses (menu_id, grup_id, hak_akses_id)
			VALUES (_menu_id, _grup_id, _hak_akses_id);
			RETURN;
		EXCEPTION WHEN unique_violation THEN
			-- do nothing, and loop to try the UPDATE again
		END;
	END LOOP;
END;

$$;
-- ddl-end --
ALTER FUNCTION public.update_menu_akses(integer,integer,integer) OWNER TO earsip;
-- ddl-end --

-- object: public.get_berkas_path | type: FUNCTION --
-- DROP FUNCTION IF EXISTS public.get_berkas_path(integer) CASCADE;
CREATE FUNCTION public.get_berkas_path ( _berkas_id integer)
	RETURNS character varying
	LANGUAGE plpgsql
	VOLATILE 
	CALLED ON NULL INPUT
	SECURITY INVOKER
	COST 100
	AS $$

declare _id int;
declare _nama varchar (255);
begin
	if _berkas_id = 0 then
		return '';
	end if;

	select	pid
	,		nama
	into	_id, _nama
	from	m_berkas
	where	id = _berkas_id;

	return get_berkas_path (_id) || '/' || _nama;
end;

$$;
-- ddl-end --
ALTER FUNCTION public.get_berkas_path(integer) OWNER TO earsip;
-- ddl-end --

-- object: public.datediff | type: FUNCTION --
-- DROP FUNCTION IF EXISTS public.datediff(character varying,timestamp,timestamp) CASCADE;
CREATE FUNCTION public.datediff ( units character varying,  start_t timestamp,  end_t timestamp)
	RETURNS integer
	LANGUAGE plpgsql
	VOLATILE 
	CALLED ON NULL INPUT
	SECURITY INVOKER
	COST 100
	AS $$

   DECLARE
     diff_interval INTERVAL; 
     diff INT = 0;
     years_diff INT = 0;
   BEGIN
     IF units IN ('yy', 'yyyy', 'year', 'mm', 'm', 'month') THEN
       years_diff = DATE_PART('year', end_t) - DATE_PART('year', start_t);
 
       IF units IN ('yy', 'yyyy', 'year') THEN
         -- SQL Server does not count full years passed (only difference between year parts)
         RETURN years_diff;
       ELSE
         -- If end month is less than start month it will subtracted
         RETURN years_diff * 12 + (DATE_PART('month', end_t) - DATE_PART('month', start_t)); 
       END IF;
     END IF;
 
     -- Minus operator returns interval 'DDD days HH:MI:SS'  
     diff_interval = end_t - start_t;
 
     diff = diff + DATE_PART('day', diff_interval);
 
     IF units IN ('wk', 'ww', 'week') THEN
       diff = diff/7;
       RETURN diff;
     END IF;
 
     IF units IN ('dd', 'd', 'day') THEN
       RETURN diff;
     END IF;
 
     diff = diff * 24 + DATE_PART('hour', diff_interval); 
 
     IF units IN ('hh', 'hour') THEN
        RETURN diff;
     END IF;
 
     diff = diff * 60 + DATE_PART('minute', diff_interval);
 
     IF units IN ('mi', 'n', 'minute') THEN
        RETURN diff;
     END IF;
 
     diff = diff * 60 + DATE_PART('second', diff_interval);
 
     RETURN diff;
   END;

$$;
-- ddl-end --
ALTER FUNCTION public.datediff(character varying,timestamp,timestamp) OWNER TO earsip;
-- ddl-end --

-- object: public.dateadd | type: FUNCTION --
-- DROP FUNCTION IF EXISTS public.dateadd(character varying,integer,timestamp) CASCADE;
CREATE FUNCTION public.dateadd ( difftype character varying,  incrementvalue integer,  inputdate timestamp)
	RETURNS timestamp
	LANGUAGE plpgsql
	VOLATILE 
	CALLED ON NULL INPUT
	SECURITY INVOKER
	COST 100
	AS $$

DECLARE
   YEAR_CONST Char(15) := 'year';
   MONTH_CONST Char(15) := 'month';
   DAY_CONST Char(15) := 'day';

   dateTemp Date;
   intervals interval;
BEGIN
   IF lower($1) = lower(YEAR_CONST) THEN
       select cast(cast(incrementvalue as character varying) || ' year' as interval) into intervals;
   ELSEIF lower($1) = lower(MONTH_CONST) THEN
       select cast(cast(incrementvalue as character varying) || ' months' as interval) into intervals;
   ELSEIF lower($1) = lower(DAY_CONST) THEN
       select cast(cast(incrementvalue as character varying) || ' day' as interval) into intervals;
   END IF;

   dateTemp:= inputdate + intervals;

   RETURN dateTemp;
END;

$$;
-- ddl-end --
ALTER FUNCTION public.dateadd(character varying,integer,timestamp) OWNER TO earsip;
-- ddl-end --

-- object: fk_log_ref_user__m_pegawa | type: CONSTRAINT --
-- ALTER TABLE public.log DROP CONSTRAINT IF EXISTS fk_log_ref_user__m_pegawa CASCADE;
ALTER TABLE public.log ADD CONSTRAINT fk_log_ref_user__m_pegawa FOREIGN KEY (pegawai_id)
REFERENCES public.m_pegawai (id) MATCH SIMPLE
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_log_ref__menu_m_menu | type: CONSTRAINT --
-- ALTER TABLE public.log DROP CONSTRAINT IF EXISTS fk_log_ref__menu_m_menu CASCADE;
ALTER TABLE public.log ADD CONSTRAINT fk_log_ref__menu_m_menu FOREIGN KEY (menu_id)
REFERENCES public.m_menu (id) MATCH SIMPLE
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_menu_aks_ref_mnu___m_menu | type: CONSTRAINT --
-- ALTER TABLE public.menu_akses DROP CONSTRAINT IF EXISTS fk_menu_aks_ref_mnu___m_menu CASCADE;
ALTER TABLE public.menu_akses ADD CONSTRAINT fk_menu_aks_ref_mnu___m_menu FOREIGN KEY (menu_id)
REFERENCES public.m_menu (id) MATCH SIMPLE
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_menu_aks_ref__akse_r_akses_ | type: CONSTRAINT --
-- ALTER TABLE public.menu_akses DROP CONSTRAINT IF EXISTS fk_menu_aks_ref__akse_r_akses_ CASCADE;
ALTER TABLE public.menu_akses ADD CONSTRAINT fk_menu_aks_ref__akse_r_akses_ FOREIGN KEY (hak_akses_id)
REFERENCES public.r_akses_menu (id) MATCH SIMPLE
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_menu_aks_ref__grou_m_grup | type: CONSTRAINT --
-- ALTER TABLE public.menu_akses DROP CONSTRAINT IF EXISTS fk_menu_aks_ref__grou_m_grup CASCADE;
ALTER TABLE public.menu_akses ADD CONSTRAINT fk_menu_aks_ref__grou_m_grup FOREIGN KEY (grup_id)
REFERENCES public.m_grup (id) MATCH SIMPLE
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_m_arsip_ref__arsi_m_berkas | type: CONSTRAINT --
-- ALTER TABLE public.m_arsip DROP CONSTRAINT IF EXISTS fk_m_arsip_ref__arsi_m_berkas CASCADE;
ALTER TABLE public.m_arsip ADD CONSTRAINT fk_m_arsip_ref__arsi_m_berkas FOREIGN KEY (berkas_id)
REFERENCES public.m_berkas (id) MATCH SIMPLE
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_m_berkas_ref_tipe__r_berkas | type: CONSTRAINT --
-- ALTER TABLE public.m_berkas DROP CONSTRAINT IF EXISTS fk_m_berkas_ref_tipe__r_berkas CASCADE;
ALTER TABLE public.m_berkas ADD CONSTRAINT fk_m_berkas_ref_tipe__r_berkas FOREIGN KEY (berkas_tipe_id)
REFERENCES public.r_berkas_tipe (id) MATCH SIMPLE
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_m_berkas_ref__akse_r_akses_ | type: CONSTRAINT --
-- ALTER TABLE public.m_berkas DROP CONSTRAINT IF EXISTS fk_m_berkas_ref__akse_r_akses_ CASCADE;
ALTER TABLE public.m_berkas ADD CONSTRAINT fk_m_berkas_ref__akse_r_akses_ FOREIGN KEY (akses_berbagi_id)
REFERENCES public.r_akses_berbagi (id) MATCH SIMPLE
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_m_berkas_ref__arsi_r_arsip_ | type: CONSTRAINT --
-- ALTER TABLE public.m_berkas DROP CONSTRAINT IF EXISTS fk_m_berkas_ref__arsi_r_arsip_ CASCADE;
ALTER TABLE public.m_berkas ADD CONSTRAINT fk_m_berkas_ref__arsi_r_arsip_ FOREIGN KEY (arsip_status_id)
REFERENCES public.r_arsip_status (id) MATCH SIMPLE
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_m_berkas_ref__klas_r_berkas | type: CONSTRAINT --
-- ALTER TABLE public.m_berkas DROP CONSTRAINT IF EXISTS fk_m_berkas_ref__klas_r_berkas CASCADE;
ALTER TABLE public.m_berkas ADD CONSTRAINT fk_m_berkas_ref__klas_r_berkas FOREIGN KEY (berkas_klas_id)
REFERENCES public.r_berkas_klas (id) MATCH SIMPLE
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_m_berkas_ref__pega_m_pegawa | type: CONSTRAINT --
-- ALTER TABLE public.m_berkas DROP CONSTRAINT IF EXISTS fk_m_berkas_ref__pega_m_pegawa CASCADE;
ALTER TABLE public.m_berkas ADD CONSTRAINT fk_m_berkas_ref__pega_m_pegawa FOREIGN KEY (pegawai_id)
REFERENCES public.m_pegawai (id) MATCH SIMPLE
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_m_berkas_ref__unit_m_unit_k | type: CONSTRAINT --
-- ALTER TABLE public.m_berkas DROP CONSTRAINT IF EXISTS fk_m_berkas_ref__unit_m_unit_k CASCADE;
ALTER TABLE public.m_berkas ADD CONSTRAINT fk_m_berkas_ref__unit_m_unit_k FOREIGN KEY (unit_kerja_id)
REFERENCES public.m_unit_kerja (id) MATCH SIMPLE
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_m_berkas_ref_pegaw_m_pegawa | type: CONSTRAINT --
-- ALTER TABLE public.m_berkas_berbagi DROP CONSTRAINT IF EXISTS fk_m_berkas_ref_pegaw_m_pegawa CASCADE;
ALTER TABLE public.m_berkas_berbagi ADD CONSTRAINT fk_m_berkas_ref_pegaw_m_pegawa FOREIGN KEY (bagi_ke_peg_id)
REFERENCES public.m_pegawai (id) MATCH SIMPLE
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_m_berkas_ref__berk_m_berkas | type: CONSTRAINT --
-- ALTER TABLE public.m_berkas_berbagi DROP CONSTRAINT IF EXISTS fk_m_berkas_ref__berk_m_berkas CASCADE;
ALTER TABLE public.m_berkas_berbagi ADD CONSTRAINT fk_m_berkas_ref__berk_m_berkas FOREIGN KEY (berkas_id)
REFERENCES public.m_berkas (id) MATCH SIMPLE
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_m_pegawa_ref__grou_m_grup | type: CONSTRAINT --
-- ALTER TABLE public.m_pegawai DROP CONSTRAINT IF EXISTS fk_m_pegawa_ref__grou_m_grup CASCADE;
ALTER TABLE public.m_pegawai ADD CONSTRAINT fk_m_pegawa_ref__grou_m_grup FOREIGN KEY (grup_id)
REFERENCES public.m_grup (id) MATCH SIMPLE
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_m_pegawa_ref__jab__r_jabata | type: CONSTRAINT --
-- ALTER TABLE public.m_pegawai DROP CONSTRAINT IF EXISTS fk_m_pegawa_ref__jab__r_jabata CASCADE;
ALTER TABLE public.m_pegawai ADD CONSTRAINT fk_m_pegawa_ref__jab__r_jabata FOREIGN KEY (jabatan_id)
REFERENCES public.r_jabatan (id) MATCH SIMPLE
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_m_pegawa_ref__unit_m_unit_k | type: CONSTRAINT --
-- ALTER TABLE public.m_pegawai DROP CONSTRAINT IF EXISTS fk_m_pegawa_ref__unit_m_unit_k CASCADE;
ALTER TABLE public.m_pegawai ADD CONSTRAINT fk_m_pegawa_ref__unit_m_unit_k FOREIGN KEY (unit_kerja_id)
REFERENCES public.m_unit_kerja (id) MATCH SIMPLE
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_peminjam_ref_pmj_a_t_peminj | type: CONSTRAINT --
-- ALTER TABLE public.peminjaman_rinci DROP CONSTRAINT IF EXISTS fk_peminjam_ref_pmj_a_t_peminj CASCADE;
ALTER TABLE public.peminjaman_rinci ADD CONSTRAINT fk_peminjam_ref_pmj_a_t_peminj FOREIGN KEY (peminjaman_id)
REFERENCES public.t_peminjaman (id) MATCH SIMPLE
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_peminjam_ref__berk_m_berkas | type: CONSTRAINT --
-- ALTER TABLE public.peminjaman_rinci DROP CONSTRAINT IF EXISTS fk_peminjam_ref__berk_m_berkas CASCADE;
ALTER TABLE public.peminjaman_rinci ADD CONSTRAINT fk_peminjam_ref__berk_m_berkas FOREIGN KEY (berkas_id)
REFERENCES public.m_berkas (id) MATCH SIMPLE
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_r_berkas_ref__unit_m_unit_k | type: CONSTRAINT --
-- ALTER TABLE public.r_berkas_klas DROP CONSTRAINT IF EXISTS fk_r_berkas_ref__unit_m_unit_k CASCADE;
ALTER TABLE public.r_berkas_klas ADD CONSTRAINT fk_r_berkas_ref__unit_m_unit_k FOREIGN KEY (unit_kerja_id)
REFERENCES public.m_unit_kerja (id) MATCH SIMPLE
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_r_ir_ref__klas_r_berkas | type: CONSTRAINT --
-- ALTER TABLE public.r_ir DROP CONSTRAINT IF EXISTS fk_r_ir_ref__klas_r_berkas CASCADE;
ALTER TABLE public.r_ir ADD CONSTRAINT fk_r_ir_ref__klas_r_berkas FOREIGN KEY (berkas_klas_id)
REFERENCES public.r_berkas_klas (id) MATCH SIMPLE
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_t_pemind_ref__unit_m_unit_k | type: CONSTRAINT --
-- ALTER TABLE public.t_pemindahan DROP CONSTRAINT IF EXISTS fk_t_pemind_ref__unit_m_unit_k CASCADE;
ALTER TABLE public.t_pemindahan ADD CONSTRAINT fk_t_pemind_ref__unit_m_unit_k FOREIGN KEY (unit_kerja_id)
REFERENCES public.m_unit_kerja (id) MATCH SIMPLE
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_t_pemind_ref_berka_m_berkas | type: CONSTRAINT --
-- ALTER TABLE public.t_pemindahan_rinci DROP CONSTRAINT IF EXISTS fk_t_pemind_ref_berka_m_berkas CASCADE;
ALTER TABLE public.t_pemindahan_rinci ADD CONSTRAINT fk_t_pemind_ref_berka_m_berkas FOREIGN KEY (berkas_id)
REFERENCES public.m_berkas (id) MATCH SIMPLE
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_t_pemind_ref_pinda_t_pemind | type: CONSTRAINT --
-- ALTER TABLE public.t_pemindahan_rinci DROP CONSTRAINT IF EXISTS fk_t_pemind_ref_pinda_t_pemind CASCADE;
ALTER TABLE public.t_pemindahan_rinci ADD CONSTRAINT fk_t_pemind_ref_pinda_t_pemind FOREIGN KEY (pemindahan_id)
REFERENCES public.t_pemindahan (id) MATCH SIMPLE
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_t_peminj_ref__unit_m_unit_k | type: CONSTRAINT --
-- ALTER TABLE public.t_peminjaman DROP CONSTRAINT IF EXISTS fk_t_peminj_ref__unit_m_unit_k CASCADE;
ALTER TABLE public.t_peminjaman ADD CONSTRAINT fk_t_peminj_ref__unit_m_unit_k FOREIGN KEY (unit_kerja_peminjam_id)
REFERENCES public.m_unit_kerja (id) MATCH SIMPLE
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_t_pemusn_ref__meto_r_pemusn | type: CONSTRAINT --
-- ALTER TABLE public.t_pemusnahan DROP CONSTRAINT IF EXISTS fk_t_pemusn_ref__meto_r_pemusn CASCADE;
ALTER TABLE public.t_pemusnahan ADD CONSTRAINT fk_t_pemusn_ref__meto_r_pemusn FOREIGN KEY (metoda_id)
REFERENCES public.r_pemusnahan_metoda (id) MATCH SIMPLE
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_t_pemusn_ref_musna_t_pemusn | type: CONSTRAINT --
-- ALTER TABLE public.t_pemusnahan_rinci DROP CONSTRAINT IF EXISTS fk_t_pemusn_ref_musna_t_pemusn CASCADE;
ALTER TABLE public.t_pemusnahan_rinci ADD CONSTRAINT fk_t_pemusn_ref_musna_t_pemusn FOREIGN KEY (pemusnahan_id)
REFERENCES public.t_pemusnahan (id) MATCH SIMPLE
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_t_pemusn_ref__berk_m_berkas | type: CONSTRAINT --
-- ALTER TABLE public.t_pemusnahan_rinci DROP CONSTRAINT IF EXISTS fk_t_pemusn_ref__berk_m_berkas CASCADE;
ALTER TABLE public.t_pemusnahan_rinci ADD CONSTRAINT fk_t_pemusn_ref__berk_m_berkas FOREIGN KEY (berkas_id)
REFERENCES public.m_berkas (id) MATCH SIMPLE
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_t_tim_pe_ref__musn_t_pemusn | type: CONSTRAINT --
-- ALTER TABLE public.t_tim_pemusnahan DROP CONSTRAINT IF EXISTS fk_t_tim_pe_ref__musn_t_pemusn CASCADE;
ALTER TABLE public.t_tim_pemusnahan ADD CONSTRAINT fk_t_tim_pe_ref__musn_t_pemusn FOREIGN KEY (pemusnahan_id)
REFERENCES public.t_pemusnahan (id) MATCH SIMPLE
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --


