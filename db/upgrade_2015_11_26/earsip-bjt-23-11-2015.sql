PGDMP                     
    s            earsip    9.1.4    9.1.4 �    z           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            {           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            |           1262    34886    earsip    DATABASE     �   CREATE DATABASE earsip WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Indonesian_Indonesia.1252' LC_CTYPE = 'Indonesian_Indonesia.1252';
    DROP DATABASE earsip;
             earsip    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            }           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    5            ~           0    0    public    ACL     �   REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;
                  postgres    false    5            �            3079    11639    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false                       0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    200            �            1255    35292 @   dateadd(character varying, integer, timestamp without time zone)    FUNCTION     X  CREATE FUNCTION dateadd(difftype character varying, incrementvalue integer, inputdate timestamp without time zone) RETURNS timestamp without time zone
    LANGUAGE plpgsql
    AS $_$
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
$_$;
 y   DROP FUNCTION public.dateadd(difftype character varying, incrementvalue integer, inputdate timestamp without time zone);
       public       earsip    false    622    5            �            1255    35291 U   datediff(character varying, timestamp without time zone, timestamp without time zone)    FUNCTION     �  CREATE FUNCTION datediff(units character varying, start_t timestamp without time zone, end_t timestamp without time zone) RETURNS integer
    LANGUAGE plpgsql
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
 �   DROP FUNCTION public.datediff(units character varying, start_t timestamp without time zone, end_t timestamp without time zone);
       public       earsip    false    622    5            �            1255    35288    delete_pegawai(integer)    FUNCTION     h  CREATE FUNCTION delete_pegawai(_id integer) RETURNS character varying
    LANGUAGE plpgsql
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
 2   DROP FUNCTION public.delete_pegawai(_id integer);
       public       earsip    false    622    5            �            1255    35290    get_berkas_path(integer)    FUNCTION     V  CREATE FUNCTION get_berkas_path(_berkas_id integer) RETURNS character varying
    LANGUAGE plpgsql
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
 :   DROP FUNCTION public.get_berkas_path(_berkas_id integer);
       public       earsip    false    5    622            �            1255    35289 ,   update_menu_akses(integer, integer, integer)    FUNCTION       CREATE FUNCTION update_menu_akses(_menu_id integer, _grup_id integer, _hak_akses_id integer) RETURNS void
    LANGUAGE plpgsql
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
 c   DROP FUNCTION public.update_menu_akses(_menu_id integer, _grup_id integer, _hak_akses_id integer);
       public       earsip    false    622    5            �            1259    34887    log    TABLE     �   CREATE TABLE log (
    id date NOT NULL,
    menu_id integer,
    pegawai_id integer,
    nama character varying(128),
    aksi character varying(32)
);
    DROP TABLE public.log;
       public         earsip    false    5            �           0    0 	   TABLE log    COMMENT        COMMENT ON TABLE log IS 'LOG';
            public       earsip    false    161            �            1259    34905    m_arsip    TABLE     �   CREATE TABLE m_arsip (
    berkas_id integer NOT NULL,
    kode_folder character varying(255),
    kode_rak character varying(255),
    kode_box character varying(255)
);
    DROP TABLE public.m_arsip;
       public         earsip    false    5            �           0    0    TABLE m_arsip    COMMENT     ,   COMMENT ON TABLE m_arsip IS 'MASTER ARSIP';
            public       earsip    false    163            �            1259    34916    m_berkas    TABLE       CREATE TABLE m_berkas (
    id integer NOT NULL,
    pid integer,
    pegawai_id integer,
    berkas_klas_id integer,
    unit_kerja_id integer,
    berkas_tipe_id integer,
    tipe_file smallint DEFAULT 0,
    mime character varying(255),
    sha character varying(255),
    nama character varying(255),
    tgl_unggah date DEFAULT ('now'::text)::date NOT NULL,
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
    n_output_images integer DEFAULT 0 NOT NULL
);
    DROP TABLE public.m_berkas;
       public         earsip    false    1984    1985    1986    1987    1988    1989    1990    1991    1992    5            �           0    0    TABLE m_berkas    COMMENT     .   COMMENT ON TABLE m_berkas IS 'MASTER BERKAS';
            public       earsip    false    165            �           0    0    COLUMN m_berkas.status    COMMENT     ?   COMMENT ON COLUMN m_berkas.status IS '1 = AKTIF; 2 : INAKTIF';
            public       earsip    false    165            �            1259    34943    m_berkas_berbagi    TABLE     �   CREATE TABLE m_berkas_berbagi (
    bagi_ke_peg_id integer NOT NULL,
    berkas_id integer NOT NULL,
    id integer NOT NULL
);
 $   DROP TABLE public.m_berkas_berbagi;
       public         earsip    false    5            �           0    0    TABLE m_berkas_berbagi    COMMENT     D   COMMENT ON TABLE m_berkas_berbagi IS 'MASTER UNTUK BERBAGI BERKAS';
            public       earsip    false    167            �            1259    34941    m_berkas_berbagi_id_seq    SEQUENCE     y   CREATE SEQUENCE m_berkas_berbagi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.m_berkas_berbagi_id_seq;
       public       earsip    false    167    5            �           0    0    m_berkas_berbagi_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE m_berkas_berbagi_id_seq OWNED BY m_berkas_berbagi.id;
            public       earsip    false    166            �           0    0    m_berkas_berbagi_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('m_berkas_berbagi_id_seq', 19, true);
            public       earsip    false    166            �            1259    34914    m_berkas_id_seq    SEQUENCE     q   CREATE SEQUENCE m_berkas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.m_berkas_id_seq;
       public       earsip    false    5    165            �           0    0    m_berkas_id_seq    SEQUENCE OWNED BY     5   ALTER SEQUENCE m_berkas_id_seq OWNED BY m_berkas.id;
            public       earsip    false    164            �           0    0    m_berkas_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('m_berkas_id_seq', 1242, true);
            public       earsip    false    164            �            1259    34954    m_grup    TABLE     x   CREATE TABLE m_grup (
    id integer NOT NULL,
    nama character varying(64),
    keterangan character varying(255)
);
    DROP TABLE public.m_grup;
       public         earsip    false    5            �           0    0    TABLE m_grup    COMMENT     +   COMMENT ON TABLE m_grup IS 'GRUP PEGAWAI';
            public       earsip    false    169            �            1259    34952    m_grup_id_seq    SEQUENCE     o   CREATE SEQUENCE m_grup_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.m_grup_id_seq;
       public       earsip    false    169    5            �           0    0    m_grup_id_seq    SEQUENCE OWNED BY     1   ALTER SEQUENCE m_grup_id_seq OWNED BY m_grup.id;
            public       earsip    false    168            �           0    0    m_grup_id_seq    SEQUENCE SET     4   SELECT pg_catalog.setval('m_grup_id_seq', 3, true);
            public       earsip    false    168            �            1259    34963    m_menu    TABLE     �   CREATE TABLE m_menu (
    id integer NOT NULL,
    icon character varying(16),
    pid bigint,
    nama_ref character varying(128),
    nama character varying(128)
);
    DROP TABLE public.m_menu;
       public         earsip    false    5            �           0    0    TABLE m_menu    COMMENT     *   COMMENT ON TABLE m_menu IS 'MASTER MENU';
            public       earsip    false    171            �            1259    34961    m_menu_id_seq    SEQUENCE     o   CREATE SEQUENCE m_menu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.m_menu_id_seq;
       public       earsip    false    171    5            �           0    0    m_menu_id_seq    SEQUENCE OWNED BY     1   ALTER SEQUENCE m_menu_id_seq OWNED BY m_menu.id;
            public       earsip    false    170            �           0    0    m_menu_id_seq    SEQUENCE SET     5   SELECT pg_catalog.setval('m_menu_id_seq', 1, false);
            public       earsip    false    170            �            1259    34972 	   m_pegawai    TABLE     +  CREATE TABLE m_pegawai (
    id integer NOT NULL,
    unit_kerja_id integer,
    grup_id integer,
    jabatan_id integer,
    nip character varying(64),
    nama character varying(128),
    psw character varying(255),
    psw_expire date DEFAULT '2000-01-01'::date,
    status smallint DEFAULT 1
);
    DROP TABLE public.m_pegawai;
       public         earsip    false    1997    1998    5            �           0    0    TABLE m_pegawai    COMMENT     5   COMMENT ON TABLE m_pegawai IS 'MASTER USER/PEGAWAI';
            public       earsip    false    173            �           0    0    COLUMN m_pegawai.status    COMMENT     C   COMMENT ON COLUMN m_pegawai.status IS '0 = NON AKTIF; 1 = AKTIF ';
            public       earsip    false    173            �            1259    34970    m_pegawai_id_seq    SEQUENCE     r   CREATE SEQUENCE m_pegawai_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.m_pegawai_id_seq;
       public       earsip    false    5    173            �           0    0    m_pegawai_id_seq    SEQUENCE OWNED BY     7   ALTER SEQUENCE m_pegawai_id_seq OWNED BY m_pegawai.id;
            public       earsip    false    172            �           0    0    m_pegawai_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('m_pegawai_id_seq', 17, true);
            public       earsip    false    172            �            1259    34986    m_sysconfig    TABLE     }   CREATE TABLE m_sysconfig (
    repository_root character varying(1024) NOT NULL,
    max_upload_size integer DEFAULT 5000
);
    DROP TABLE public.m_sysconfig;
       public         earsip    false    1999    5            �           0    0    TABLE m_sysconfig    COMMENT     =   COMMENT ON TABLE m_sysconfig IS 'MASTER KONFIGURASI SYSTEM';
            public       earsip    false    174            �            1259    34995    m_unit_kerja    TABLE     �   CREATE TABLE m_unit_kerja (
    id integer NOT NULL,
    kode character varying(32) NOT NULL,
    nama character varying(128),
    nama_pimpinan character varying(128),
    keterangan character varying(255),
    urutan integer DEFAULT 0
);
     DROP TABLE public.m_unit_kerja;
       public         earsip    false    2001    5            �           0    0    TABLE m_unit_kerja    COMMENT     6   COMMENT ON TABLE m_unit_kerja IS 'MASTER UNIT KERJA';
            public       earsip    false    176            �            1259    34993    m_unit_kerja_id_seq    SEQUENCE     u   CREATE SEQUENCE m_unit_kerja_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.m_unit_kerja_id_seq;
       public       earsip    false    176    5            �           0    0    m_unit_kerja_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE m_unit_kerja_id_seq OWNED BY m_unit_kerja.id;
            public       earsip    false    175            �           0    0    m_unit_kerja_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('m_unit_kerja_id_seq', 29, true);
            public       earsip    false    175            �            1259    34895 
   menu_akses    TABLE     }   CREATE TABLE menu_akses (
    menu_id integer NOT NULL,
    grup_id integer NOT NULL,
    hak_akses_id smallint DEFAULT 0
);
    DROP TABLE public.menu_akses;
       public         earsip    false    1982    5            �           0    0    TABLE menu_akses    COMMENT     :   COMMENT ON TABLE menu_akses IS 'HAK AKSES TERHADAP MENU';
            public       earsip    false    162            �            1259    35008    peminjaman_rinci    TABLE     f   CREATE TABLE peminjaman_rinci (
    peminjaman_id integer NOT NULL,
    berkas_id integer NOT NULL
);
 $   DROP TABLE public.peminjaman_rinci;
       public         earsip    false    5            �           0    0    TABLE peminjaman_rinci    COMMENT     :   COMMENT ON TABLE peminjaman_rinci IS 'PEMINJAMAN DETAIL';
            public       earsip    false    177            �            1259    35015    r_akses_berbagi    TABLE     b   CREATE TABLE r_akses_berbagi (
    id smallint NOT NULL,
    keterangan character varying(255)
);
 #   DROP TABLE public.r_akses_berbagi;
       public         earsip    false    5            �           0    0    TABLE r_akses_berbagi    COMMENT     E   COMMENT ON TABLE r_akses_berbagi IS 'REFERENSI UNTUK BERBAGI AKSES';
            public       earsip    false    178            �            1259    35021    r_akses_menu    TABLE     _   CREATE TABLE r_akses_menu (
    id smallint NOT NULL,
    keterangan character varying(255)
);
     DROP TABLE public.r_akses_menu;
       public         earsip    false    5            �           0    0    TABLE r_akses_menu    COMMENT     :   COMMENT ON TABLE r_akses_menu IS 'REFERENSI AKSES MENU
';
            public       earsip    false    179            �            1259    35027    r_arsip_status    TABLE     a   CREATE TABLE r_arsip_status (
    id smallint NOT NULL,
    keterangan character varying(255)
);
 "   DROP TABLE public.r_arsip_status;
       public         earsip    false    5            �           0    0    TABLE r_arsip_status    COMMENT     =   COMMENT ON TABLE r_arsip_status IS 'REFERENSI ARSIP STATUS';
            public       earsip    false    180            �            1259    35035    r_berkas_klas    TABLE       CREATE TABLE r_berkas_klas (
    id integer NOT NULL,
    unit_kerja_id integer,
    kode character varying(6) NOT NULL,
    nama character varying(64) NOT NULL,
    keterangan text NOT NULL,
    jra_aktif integer DEFAULT 1 NOT NULL,
    jra_inaktif integer DEFAULT 1 NOT NULL
);
 !   DROP TABLE public.r_berkas_klas;
       public         earsip    false    2003    2004    5            �           0    0    TABLE r_berkas_klas    COMMENT     B   COMMENT ON TABLE r_berkas_klas IS 'REFERENSI KLASIFIKASI BERKAS';
            public       earsip    false    182            �            1259    35033    r_berkas_klas_id_seq    SEQUENCE     v   CREATE SEQUENCE r_berkas_klas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.r_berkas_klas_id_seq;
       public       earsip    false    5    182            �           0    0    r_berkas_klas_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE r_berkas_klas_id_seq OWNED BY r_berkas_klas.id;
            public       earsip    false    181            �           0    0    r_berkas_klas_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('r_berkas_klas_id_seq', 258, true);
            public       earsip    false    181            �            1259    35047    r_berkas_tipe    TABLE        CREATE TABLE r_berkas_tipe (
    id integer NOT NULL,
    nama character varying(64),
    keterangan character varying(255)
);
 !   DROP TABLE public.r_berkas_tipe;
       public         earsip    false    5            �           0    0    TABLE r_berkas_tipe    COMMENT     :   COMMENT ON TABLE r_berkas_tipe IS 'REFERENSI TIPE ARSIP';
            public       earsip    false    184            �            1259    35045    r_berkas_tipe_id_seq    SEQUENCE     v   CREATE SEQUENCE r_berkas_tipe_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.r_berkas_tipe_id_seq;
       public       earsip    false    184    5            �           0    0    r_berkas_tipe_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE r_berkas_tipe_id_seq OWNED BY r_berkas_tipe.id;
            public       earsip    false    183            �           0    0    r_berkas_tipe_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('r_berkas_tipe_id_seq', 6, true);
            public       earsip    false    183            �            1259    35056    r_ir    TABLE     q   CREATE TABLE r_ir (
    id integer NOT NULL,
    berkas_klas_id integer,
    keterangan character varying(64)
);
    DROP TABLE public.r_ir;
       public         earsip    false    5            �           0    0 
   TABLE r_ir    COMMENT     4   COMMENT ON TABLE r_ir IS 'REFERNSI INDEKS RELATIF';
            public       earsip    false    186            �            1259    35054    r_ir_id_seq    SEQUENCE     m   CREATE SEQUENCE r_ir_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.r_ir_id_seq;
       public       earsip    false    5    186            �           0    0    r_ir_id_seq    SEQUENCE OWNED BY     -   ALTER SEQUENCE r_ir_id_seq OWNED BY r_ir.id;
            public       earsip    false    185            �           0    0    r_ir_id_seq    SEQUENCE SET     3   SELECT pg_catalog.setval('r_ir_id_seq', 1, false);
            public       earsip    false    185            �            1259    35066 	   r_jabatan    TABLE     �   CREATE TABLE r_jabatan (
    id integer NOT NULL,
    nama character varying(128),
    keterangan character varying(255),
    urutan integer DEFAULT 0
);
    DROP TABLE public.r_jabatan;
       public         earsip    false    2008    5            �           0    0    TABLE r_jabatan    COMMENT     3   COMMENT ON TABLE r_jabatan IS 'REFERENSI JABATAN';
            public       earsip    false    188            �            1259    35064    r_jabatan_id_seq    SEQUENCE     r   CREATE SEQUENCE r_jabatan_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.r_jabatan_id_seq;
       public       earsip    false    188    5            �           0    0    r_jabatan_id_seq    SEQUENCE OWNED BY     7   ALTER SEQUENCE r_jabatan_id_seq OWNED BY r_jabatan.id;
            public       earsip    false    187            �           0    0    r_jabatan_id_seq    SEQUENCE SET     7   SELECT pg_catalog.setval('r_jabatan_id_seq', 4, true);
            public       earsip    false    187            �            1259    35076    r_pemusnahan_metoda    TABLE     �   CREATE TABLE r_pemusnahan_metoda (
    id integer NOT NULL,
    nama character varying(128),
    keterangan character varying(255)
);
 '   DROP TABLE public.r_pemusnahan_metoda;
       public         earsip    false    5            �           0    0    TABLE r_pemusnahan_metoda    COMMENT     G   COMMENT ON TABLE r_pemusnahan_metoda IS 'REFERENSI METODA PEMUSNAHAN';
            public       earsip    false    190            �            1259    35074    r_pemusnahan_metoda_id_seq    SEQUENCE     |   CREATE SEQUENCE r_pemusnahan_metoda_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.r_pemusnahan_metoda_id_seq;
       public       earsip    false    190    5            �           0    0    r_pemusnahan_metoda_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE r_pemusnahan_metoda_id_seq OWNED BY r_pemusnahan_metoda.id;
            public       earsip    false    189            �           0    0    r_pemusnahan_metoda_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('r_pemusnahan_metoda_id_seq', 3, true);
            public       earsip    false    189            �            1259    35085    t_pemindahan    TABLE       CREATE TABLE t_pemindahan (
    id integer NOT NULL,
    unit_kerja_id integer,
    kode character varying(255),
    tgl date,
    status smallint,
    nama_petugas character varying(128),
    pj_unit_kerja character varying(128),
    pj_unit_arsip character varying(128)
);
     DROP TABLE public.t_pemindahan;
       public         earsip    false    5            �           0    0    TABLE t_pemindahan    COMMENT     9   COMMENT ON TABLE t_pemindahan IS 'TRANSAKSI PEMINDAHAN';
            public       earsip    false    192            �           0    0    COLUMN t_pemindahan.status    COMMENT     I   COMMENT ON COLUMN t_pemindahan.status IS '0 = TIDAK LENGKAP; 1 LENGKAP';
            public       earsip    false    192            �            1259    35083    t_pemindahan_id_seq    SEQUENCE     u   CREATE SEQUENCE t_pemindahan_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.t_pemindahan_id_seq;
       public       earsip    false    192    5            �           0    0    t_pemindahan_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE t_pemindahan_id_seq OWNED BY t_pemindahan.id;
            public       earsip    false    191            �           0    0    t_pemindahan_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('t_pemindahan_id_seq', 21, true);
            public       earsip    false    191            �            1259    35096    t_pemindahan_rinci    TABLE     h   CREATE TABLE t_pemindahan_rinci (
    pemindahan_id integer NOT NULL,
    berkas_id integer NOT NULL
);
 &   DROP TABLE public.t_pemindahan_rinci;
       public         earsip    false    5            �           0    0    TABLE t_pemindahan_rinci    COMMENT     =   COMMENT ON TABLE t_pemindahan_rinci IS 'RINCIAN PEMINDAHAN';
            public       earsip    false    193            �            1259    35106    t_peminjaman    TABLE     �  CREATE TABLE t_peminjaman (
    id integer NOT NULL,
    unit_kerja_peminjam_id integer,
    nama_petugas character varying(128),
    nama_pimpinan_petugas character varying(128),
    nama_peminjam character varying(128),
    nama_pimpinan_peminjam character varying(128),
    tgl_pinjam date,
    tgl_batas_kembali date,
    tgl_kembali date,
    keterangan character varying(255)
);
     DROP TABLE public.t_peminjaman;
       public         earsip    false    5            �           0    0    TABLE t_peminjaman    COMMENT     9   COMMENT ON TABLE t_peminjaman IS 'TRANSAKSI PEMINJAMAN';
            public       earsip    false    195            �            1259    35104    t_peminjaman_id_seq    SEQUENCE     u   CREATE SEQUENCE t_peminjaman_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.t_peminjaman_id_seq;
       public       earsip    false    195    5            �           0    0    t_peminjaman_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE t_peminjaman_id_seq OWNED BY t_peminjaman.id;
            public       earsip    false    194            �           0    0    t_peminjaman_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('t_peminjaman_id_seq', 12, true);
            public       earsip    false    194            �            1259    35119    t_pemusnahan    TABLE     �   CREATE TABLE t_pemusnahan (
    id integer NOT NULL,
    metoda_id integer NOT NULL,
    nama_petugas character varying(128),
    tgl date,
    pj_unit_kerja character varying(128),
    pj_berkas_arsip character varying(128)
);
     DROP TABLE public.t_pemusnahan;
       public         earsip    false    5            �           0    0    TABLE t_pemusnahan    COMMENT     9   COMMENT ON TABLE t_pemusnahan IS 'TRANSAKSI PEMUSNAHAN';
            public       earsip    false    197            �            1259    35117    t_pemusnahan_id_seq    SEQUENCE     u   CREATE SEQUENCE t_pemusnahan_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.t_pemusnahan_id_seq;
       public       earsip    false    197    5            �           0    0    t_pemusnahan_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE t_pemusnahan_id_seq OWNED BY t_pemusnahan.id;
            public       earsip    false    196            �           0    0    t_pemusnahan_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('t_pemusnahan_id_seq', 38, true);
            public       earsip    false    196            �            1259    35127    t_pemusnahan_rinci    TABLE     �   CREATE TABLE t_pemusnahan_rinci (
    pemusnahan_id integer NOT NULL,
    berkas_id integer NOT NULL,
    keterangan character varying(255),
    jml_lembar smallint,
    jml_set smallint,
    jml_berkas smallint
);
 &   DROP TABLE public.t_pemusnahan_rinci;
       public         earsip    false    5            �           0    0    TABLE t_pemusnahan_rinci    COMMENT     <   COMMENT ON TABLE t_pemusnahan_rinci IS 'PEMUSNAHAN DETAIL';
            public       earsip    false    198            �            1259    35135    t_tim_pemusnahan    TABLE     �   CREATE TABLE t_tim_pemusnahan (
    pemusnahan_id integer NOT NULL,
    nomor smallint NOT NULL,
    nama character varying(128),
    jabatan character varying(128)
);
 $   DROP TABLE public.t_tim_pemusnahan;
       public         earsip    false    5            �           0    0    TABLE t_tim_pemusnahan    COMMENT     7   COMMENT ON TABLE t_tim_pemusnahan IS 'TIM PEMUSNAHAN';
            public       earsip    false    199            �           2604    34919    id    DEFAULT     \   ALTER TABLE ONLY m_berkas ALTER COLUMN id SET DEFAULT nextval('m_berkas_id_seq'::regclass);
 :   ALTER TABLE public.m_berkas ALTER COLUMN id DROP DEFAULT;
       public       earsip    false    165    164    165            �           2604    34946    id    DEFAULT     l   ALTER TABLE ONLY m_berkas_berbagi ALTER COLUMN id SET DEFAULT nextval('m_berkas_berbagi_id_seq'::regclass);
 B   ALTER TABLE public.m_berkas_berbagi ALTER COLUMN id DROP DEFAULT;
       public       earsip    false    167    166    167            �           2604    34957    id    DEFAULT     X   ALTER TABLE ONLY m_grup ALTER COLUMN id SET DEFAULT nextval('m_grup_id_seq'::regclass);
 8   ALTER TABLE public.m_grup ALTER COLUMN id DROP DEFAULT;
       public       earsip    false    168    169    169            �           2604    34966    id    DEFAULT     X   ALTER TABLE ONLY m_menu ALTER COLUMN id SET DEFAULT nextval('m_menu_id_seq'::regclass);
 8   ALTER TABLE public.m_menu ALTER COLUMN id DROP DEFAULT;
       public       earsip    false    171    170    171            �           2604    34975    id    DEFAULT     ^   ALTER TABLE ONLY m_pegawai ALTER COLUMN id SET DEFAULT nextval('m_pegawai_id_seq'::regclass);
 ;   ALTER TABLE public.m_pegawai ALTER COLUMN id DROP DEFAULT;
       public       earsip    false    173    172    173            �           2604    34998    id    DEFAULT     d   ALTER TABLE ONLY m_unit_kerja ALTER COLUMN id SET DEFAULT nextval('m_unit_kerja_id_seq'::regclass);
 >   ALTER TABLE public.m_unit_kerja ALTER COLUMN id DROP DEFAULT;
       public       earsip    false    176    175    176            �           2604    35038    id    DEFAULT     f   ALTER TABLE ONLY r_berkas_klas ALTER COLUMN id SET DEFAULT nextval('r_berkas_klas_id_seq'::regclass);
 ?   ALTER TABLE public.r_berkas_klas ALTER COLUMN id DROP DEFAULT;
       public       earsip    false    182    181    182            �           2604    35050    id    DEFAULT     f   ALTER TABLE ONLY r_berkas_tipe ALTER COLUMN id SET DEFAULT nextval('r_berkas_tipe_id_seq'::regclass);
 ?   ALTER TABLE public.r_berkas_tipe ALTER COLUMN id DROP DEFAULT;
       public       earsip    false    183    184    184            �           2604    35059    id    DEFAULT     T   ALTER TABLE ONLY r_ir ALTER COLUMN id SET DEFAULT nextval('r_ir_id_seq'::regclass);
 6   ALTER TABLE public.r_ir ALTER COLUMN id DROP DEFAULT;
       public       earsip    false    185    186    186            �           2604    35069    id    DEFAULT     ^   ALTER TABLE ONLY r_jabatan ALTER COLUMN id SET DEFAULT nextval('r_jabatan_id_seq'::regclass);
 ;   ALTER TABLE public.r_jabatan ALTER COLUMN id DROP DEFAULT;
       public       earsip    false    188    187    188            �           2604    35079    id    DEFAULT     r   ALTER TABLE ONLY r_pemusnahan_metoda ALTER COLUMN id SET DEFAULT nextval('r_pemusnahan_metoda_id_seq'::regclass);
 E   ALTER TABLE public.r_pemusnahan_metoda ALTER COLUMN id DROP DEFAULT;
       public       earsip    false    190    189    190            �           2604    35088    id    DEFAULT     d   ALTER TABLE ONLY t_pemindahan ALTER COLUMN id SET DEFAULT nextval('t_pemindahan_id_seq'::regclass);
 >   ALTER TABLE public.t_pemindahan ALTER COLUMN id DROP DEFAULT;
       public       earsip    false    192    191    192            �           2604    35109    id    DEFAULT     d   ALTER TABLE ONLY t_peminjaman ALTER COLUMN id SET DEFAULT nextval('t_peminjaman_id_seq'::regclass);
 >   ALTER TABLE public.t_peminjaman ALTER COLUMN id DROP DEFAULT;
       public       earsip    false    194    195    195            �           2604    35122    id    DEFAULT     d   ALTER TABLE ONLY t_pemusnahan ALTER COLUMN id SET DEFAULT nextval('t_pemusnahan_id_seq'::regclass);
 >   ALTER TABLE public.t_pemusnahan ALTER COLUMN id DROP DEFAULT;
       public       earsip    false    196    197    197            a          0    34887    log 
   TABLE DATA               ;   COPY log (id, menu_id, pegawai_id, nama, aksi) FROM stdin;
    public       earsip    false    161   y"      c          0    34905    m_arsip 
   TABLE DATA               F   COPY m_arsip (berkas_id, kode_folder, kode_rak, kode_box) FROM stdin;
    public       earsip    false    163   �"      d          0    34916    m_berkas 
   TABLE DATA                 COPY m_berkas (id, pid, pegawai_id, berkas_klas_id, unit_kerja_id, berkas_tipe_id, tipe_file, mime, sha, nama, tgl_unggah, tgl_dibuat, nomor, pembuat, judul, masalah, jra_aktif, jra_inaktif, status, status_hapus, akses_berbagi_id, arsip_status_id, n_output_images) FROM stdin;
    public       earsip    false    165   �"      e          0    34943    m_berkas_berbagi 
   TABLE DATA               B   COPY m_berkas_berbagi (bagi_ke_peg_id, berkas_id, id) FROM stdin;
    public       earsip    false    167   =X      f          0    34954    m_grup 
   TABLE DATA               /   COPY m_grup (id, nama, keterangan) FROM stdin;
    public       earsip    false    169   zX      g          0    34963    m_menu 
   TABLE DATA               8   COPY m_menu (id, icon, pid, nama_ref, nama) FROM stdin;
    public       earsip    false    171   �X      h          0    34972 	   m_pegawai 
   TABLE DATA               h   COPY m_pegawai (id, unit_kerja_id, grup_id, jabatan_id, nip, nama, psw, psw_expire, status) FROM stdin;
    public       earsip    false    173   QZ      i          0    34986    m_sysconfig 
   TABLE DATA               @   COPY m_sysconfig (repository_root, max_upload_size) FROM stdin;
    public       earsip    false    174   P\      j          0    34995    m_unit_kerja 
   TABLE DATA               R   COPY m_unit_kerja (id, kode, nama, nama_pimpinan, keterangan, urutan) FROM stdin;
    public       earsip    false    176   }\      b          0    34895 
   menu_akses 
   TABLE DATA               =   COPY menu_akses (menu_id, grup_id, hak_akses_id) FROM stdin;
    public       earsip    false    162   �^      k          0    35008    peminjaman_rinci 
   TABLE DATA               =   COPY peminjaman_rinci (peminjaman_id, berkas_id) FROM stdin;
    public       earsip    false    177   m_      l          0    35015    r_akses_berbagi 
   TABLE DATA               2   COPY r_akses_berbagi (id, keterangan) FROM stdin;
    public       earsip    false    178   �_      m          0    35021    r_akses_menu 
   TABLE DATA               /   COPY r_akses_menu (id, keterangan) FROM stdin;
    public       earsip    false    179   `      n          0    35027    r_arsip_status 
   TABLE DATA               1   COPY r_arsip_status (id, keterangan) FROM stdin;
    public       earsip    false    180   Y`      o          0    35035    r_berkas_klas 
   TABLE DATA               c   COPY r_berkas_klas (id, unit_kerja_id, kode, nama, keterangan, jra_aktif, jra_inaktif) FROM stdin;
    public       earsip    false    182   �`      p          0    35047    r_berkas_tipe 
   TABLE DATA               6   COPY r_berkas_tipe (id, nama, keterangan) FROM stdin;
    public       earsip    false    184   ~      q          0    35056    r_ir 
   TABLE DATA               7   COPY r_ir (id, berkas_klas_id, keterangan) FROM stdin;
    public       earsip    false    186   �~      r          0    35066 	   r_jabatan 
   TABLE DATA               :   COPY r_jabatan (id, nama, keterangan, urutan) FROM stdin;
    public       earsip    false    188   �~      s          0    35076    r_pemusnahan_metoda 
   TABLE DATA               <   COPY r_pemusnahan_metoda (id, nama, keterangan) FROM stdin;
    public       earsip    false    190         t          0    35085    t_pemindahan 
   TABLE DATA               q   COPY t_pemindahan (id, unit_kerja_id, kode, tgl, status, nama_petugas, pj_unit_kerja, pj_unit_arsip) FROM stdin;
    public       earsip    false    192   y      u          0    35096    t_pemindahan_rinci 
   TABLE DATA               ?   COPY t_pemindahan_rinci (pemindahan_id, berkas_id) FROM stdin;
    public       earsip    false    193   ��      v          0    35106    t_peminjaman 
   TABLE DATA               �   COPY t_peminjaman (id, unit_kerja_peminjam_id, nama_petugas, nama_pimpinan_petugas, nama_peminjam, nama_pimpinan_peminjam, tgl_pinjam, tgl_batas_kembali, tgl_kembali, keterangan) FROM stdin;
    public       earsip    false    195   �      w          0    35119    t_pemusnahan 
   TABLE DATA               a   COPY t_pemusnahan (id, metoda_id, nama_petugas, tgl, pj_unit_kerja, pj_berkas_arsip) FROM stdin;
    public       earsip    false    197   �      x          0    35127    t_pemusnahan_rinci 
   TABLE DATA               l   COPY t_pemusnahan_rinci (pemusnahan_id, berkas_id, keterangan, jml_lembar, jml_set, jml_berkas) FROM stdin;
    public       earsip    false    198   ނ      y          0    35135    t_tim_pemusnahan 
   TABLE DATA               H   COPY t_tim_pemusnahan (pemusnahan_id, nomor, nama, jabatan) FROM stdin;
    public       earsip    false    199   ��                  2606    34981    ak_key_2_m_pegawa 
   CONSTRAINT     N   ALTER TABLE ONLY m_pegawai
    ADD CONSTRAINT ak_key_2_m_pegawa UNIQUE (nip);
 E   ALTER TABLE ONLY public.m_pegawai DROP CONSTRAINT ak_key_2_m_pegawa;
       public         earsip    false    173    173                       2606    35006    ak_key_2_m_unit_k 
   CONSTRAINT     R   ALTER TABLE ONLY m_unit_kerja
    ADD CONSTRAINT ak_key_2_m_unit_k UNIQUE (kode);
 H   ALTER TABLE ONLY public.m_unit_kerja DROP CONSTRAINT ak_key_2_m_unit_k;
       public         earsip    false    176    176            �           2606    34891    pk_log 
   CONSTRAINT     A   ALTER TABLE ONLY log
    ADD CONSTRAINT pk_log PRIMARY KEY (id);
 4   ALTER TABLE ONLY public.log DROP CONSTRAINT pk_log;
       public         earsip    false    161    161            �           2606    34912 
   pk_m_arsip 
   CONSTRAINT     P   ALTER TABLE ONLY m_arsip
    ADD CONSTRAINT pk_m_arsip PRIMARY KEY (berkas_id);
 <   ALTER TABLE ONLY public.m_arsip DROP CONSTRAINT pk_m_arsip;
       public         earsip    false    163    163            �           2606    34933    pk_m_berkas 
   CONSTRAINT     K   ALTER TABLE ONLY m_berkas
    ADD CONSTRAINT pk_m_berkas PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.m_berkas DROP CONSTRAINT pk_m_berkas;
       public         earsip    false    165    165            �           2606    34948    pk_m_berkas_berbagi 
   CONSTRAINT     v   ALTER TABLE ONLY m_berkas_berbagi
    ADD CONSTRAINT pk_m_berkas_berbagi PRIMARY KEY (bagi_ke_peg_id, berkas_id, id);
 N   ALTER TABLE ONLY public.m_berkas_berbagi DROP CONSTRAINT pk_m_berkas_berbagi;
       public         earsip    false    167    167    167    167            �           2606    34959 	   pk_m_grup 
   CONSTRAINT     G   ALTER TABLE ONLY m_grup
    ADD CONSTRAINT pk_m_grup PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.m_grup DROP CONSTRAINT pk_m_grup;
       public         earsip    false    169    169            �           2606    34968 	   pk_m_menu 
   CONSTRAINT     G   ALTER TABLE ONLY m_menu
    ADD CONSTRAINT pk_m_menu PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.m_menu DROP CONSTRAINT pk_m_menu;
       public         earsip    false    171    171                       2606    34979    pk_m_pegawai 
   CONSTRAINT     M   ALTER TABLE ONLY m_pegawai
    ADD CONSTRAINT pk_m_pegawai PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.m_pegawai DROP CONSTRAINT pk_m_pegawai;
       public         earsip    false    173    173                       2606    35004    pk_m_unit_kerja 
   CONSTRAINT     S   ALTER TABLE ONLY m_unit_kerja
    ADD CONSTRAINT pk_m_unit_kerja PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.m_unit_kerja DROP CONSTRAINT pk_m_unit_kerja;
       public         earsip    false    176    176            �           2606    34900    pk_menu_akses 
   CONSTRAINT     ]   ALTER TABLE ONLY menu_akses
    ADD CONSTRAINT pk_menu_akses PRIMARY KEY (menu_id, grup_id);
 B   ALTER TABLE ONLY public.menu_akses DROP CONSTRAINT pk_menu_akses;
       public         earsip    false    162    162    162                       2606    35012    pk_peminjaman_rinci 
   CONSTRAINT     q   ALTER TABLE ONLY peminjaman_rinci
    ADD CONSTRAINT pk_peminjaman_rinci PRIMARY KEY (peminjaman_id, berkas_id);
 N   ALTER TABLE ONLY public.peminjaman_rinci DROP CONSTRAINT pk_peminjaman_rinci;
       public         earsip    false    177    177    177                       2606    35019    pk_r_akses_berbagi 
   CONSTRAINT     Y   ALTER TABLE ONLY r_akses_berbagi
    ADD CONSTRAINT pk_r_akses_berbagi PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.r_akses_berbagi DROP CONSTRAINT pk_r_akses_berbagi;
       public         earsip    false    178    178                       2606    35025    pk_r_akses_menu 
   CONSTRAINT     S   ALTER TABLE ONLY r_akses_menu
    ADD CONSTRAINT pk_r_akses_menu PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.r_akses_menu DROP CONSTRAINT pk_r_akses_menu;
       public         earsip    false    179    179                       2606    35031    pk_r_arsip_status 
   CONSTRAINT     W   ALTER TABLE ONLY r_arsip_status
    ADD CONSTRAINT pk_r_arsip_status PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.r_arsip_status DROP CONSTRAINT pk_r_arsip_status;
       public         earsip    false    180    180                       2606    35042    pk_r_berkas_klas 
   CONSTRAINT     U   ALTER TABLE ONLY r_berkas_klas
    ADD CONSTRAINT pk_r_berkas_klas PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.r_berkas_klas DROP CONSTRAINT pk_r_berkas_klas;
       public         earsip    false    182    182                       2606    35052    pk_r_berkas_tipe 
   CONSTRAINT     U   ALTER TABLE ONLY r_berkas_tipe
    ADD CONSTRAINT pk_r_berkas_tipe PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.r_berkas_tipe DROP CONSTRAINT pk_r_berkas_tipe;
       public         earsip    false    184    184            !           2606    35061    pk_r_ir 
   CONSTRAINT     C   ALTER TABLE ONLY r_ir
    ADD CONSTRAINT pk_r_ir PRIMARY KEY (id);
 6   ALTER TABLE ONLY public.r_ir DROP CONSTRAINT pk_r_ir;
       public         earsip    false    186    186            %           2606    35072    pk_r_jabatan 
   CONSTRAINT     M   ALTER TABLE ONLY r_jabatan
    ADD CONSTRAINT pk_r_jabatan PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.r_jabatan DROP CONSTRAINT pk_r_jabatan;
       public         earsip    false    188    188            (           2606    35081    pk_r_pemusnahan_metoda 
   CONSTRAINT     a   ALTER TABLE ONLY r_pemusnahan_metoda
    ADD CONSTRAINT pk_r_pemusnahan_metoda PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.r_pemusnahan_metoda DROP CONSTRAINT pk_r_pemusnahan_metoda;
       public         earsip    false    190    190            +           2606    35093    pk_t_pemindahan 
   CONSTRAINT     S   ALTER TABLE ONLY t_pemindahan
    ADD CONSTRAINT pk_t_pemindahan PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.t_pemindahan DROP CONSTRAINT pk_t_pemindahan;
       public         earsip    false    192    192            /           2606    35100    pk_t_pemindahan_rinci 
   CONSTRAINT     u   ALTER TABLE ONLY t_pemindahan_rinci
    ADD CONSTRAINT pk_t_pemindahan_rinci PRIMARY KEY (pemindahan_id, berkas_id);
 R   ALTER TABLE ONLY public.t_pemindahan_rinci DROP CONSTRAINT pk_t_pemindahan_rinci;
       public         earsip    false    193    193    193            4           2606    35114    pk_t_peminjaman 
   CONSTRAINT     S   ALTER TABLE ONLY t_peminjaman
    ADD CONSTRAINT pk_t_peminjaman PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.t_peminjaman DROP CONSTRAINT pk_t_peminjaman;
       public         earsip    false    195    195            8           2606    35124    pk_t_pemusnahan 
   CONSTRAINT     S   ALTER TABLE ONLY t_pemusnahan
    ADD CONSTRAINT pk_t_pemusnahan PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.t_pemusnahan DROP CONSTRAINT pk_t_pemusnahan;
       public         earsip    false    197    197            <           2606    35131    pk_t_pemusnahan_rinci 
   CONSTRAINT     u   ALTER TABLE ONLY t_pemusnahan_rinci
    ADD CONSTRAINT pk_t_pemusnahan_rinci PRIMARY KEY (pemusnahan_id, berkas_id);
 R   ALTER TABLE ONLY public.t_pemusnahan_rinci DROP CONSTRAINT pk_t_pemusnahan_rinci;
       public         earsip    false    198    198    198            A           2606    35139    pk_t_tim_pemusnahan 
   CONSTRAINT     m   ALTER TABLE ONLY t_tim_pemusnahan
    ADD CONSTRAINT pk_t_tim_pemusnahan PRIMARY KEY (pemusnahan_id, nomor);
 N   ALTER TABLE ONLY public.t_tim_pemusnahan DROP CONSTRAINT pk_t_tim_pemusnahan;
       public         earsip    false    199    199    199            �           1259    34892    log_pk    INDEX     4   CREATE UNIQUE INDEX log_pk ON log USING btree (id);
    DROP INDEX public.log_pk;
       public         earsip    false    161            �           1259    34913 
   m_arsip_pk    INDEX     C   CREATE UNIQUE INDEX m_arsip_pk ON m_arsip USING btree (berkas_id);
    DROP INDEX public.m_arsip_pk;
       public         earsip    false    163            �           1259    34949    m_berkas_berbagi_pk    INDEX     i   CREATE UNIQUE INDEX m_berkas_berbagi_pk ON m_berkas_berbagi USING btree (bagi_ke_peg_id, berkas_id, id);
 '   DROP INDEX public.m_berkas_berbagi_pk;
       public         earsip    false    167    167    167            �           1259    34934    m_berkas_pk    INDEX     >   CREATE UNIQUE INDEX m_berkas_pk ON m_berkas USING btree (id);
    DROP INDEX public.m_berkas_pk;
       public         earsip    false    165            �           1259    34960 	   m_grup_pk    INDEX     :   CREATE UNIQUE INDEX m_grup_pk ON m_grup USING btree (id);
    DROP INDEX public.m_grup_pk;
       public         earsip    false    169            �           1259    34969 	   m_menu_pk    INDEX     :   CREATE UNIQUE INDEX m_menu_pk ON m_menu USING btree (id);
    DROP INDEX public.m_menu_pk;
       public         earsip    false    171                       1259    34982    m_pegawai_pk    INDEX     @   CREATE UNIQUE INDEX m_pegawai_pk ON m_pegawai USING btree (id);
     DROP INDEX public.m_pegawai_pk;
       public         earsip    false    173            	           1259    35007    m_unit_kerja_pk    INDEX     F   CREATE UNIQUE INDEX m_unit_kerja_pk ON m_unit_kerja USING btree (id);
 #   DROP INDEX public.m_unit_kerja_pk;
       public         earsip    false    176            �           1259    34901    menu_akses_pk    INDEX     P   CREATE UNIQUE INDEX menu_akses_pk ON menu_akses USING btree (menu_id, grup_id);
 !   DROP INDEX public.menu_akses_pk;
       public         earsip    false    162    162                       1259    35013    peminjaman_rinci_pk    INDEX     d   CREATE UNIQUE INDEX peminjaman_rinci_pk ON peminjaman_rinci USING btree (peminjaman_id, berkas_id);
 '   DROP INDEX public.peminjaman_rinci_pk;
       public         earsip    false    177    177                       1259    35020    r_akses_berbagi_pk    INDEX     L   CREATE UNIQUE INDEX r_akses_berbagi_pk ON r_akses_berbagi USING btree (id);
 &   DROP INDEX public.r_akses_berbagi_pk;
       public         earsip    false    178                       1259    35026    r_akses_menu_pk    INDEX     F   CREATE UNIQUE INDEX r_akses_menu_pk ON r_akses_menu USING btree (id);
 #   DROP INDEX public.r_akses_menu_pk;
       public         earsip    false    179                       1259    35032    r_arsip_status_pk    INDEX     J   CREATE UNIQUE INDEX r_arsip_status_pk ON r_arsip_status USING btree (id);
 %   DROP INDEX public.r_arsip_status_pk;
       public         earsip    false    180                       1259    35043    r_berkas_klas_pk    INDEX     H   CREATE UNIQUE INDEX r_berkas_klas_pk ON r_berkas_klas USING btree (id);
 $   DROP INDEX public.r_berkas_klas_pk;
       public         earsip    false    182                       1259    35053    r_berkas_tipe_pk    INDEX     H   CREATE UNIQUE INDEX r_berkas_tipe_pk ON r_berkas_tipe USING btree (id);
 $   DROP INDEX public.r_berkas_tipe_pk;
       public         earsip    false    184            "           1259    35062    r_ir_pk    INDEX     6   CREATE UNIQUE INDEX r_ir_pk ON r_ir USING btree (id);
    DROP INDEX public.r_ir_pk;
       public         earsip    false    186            &           1259    35073    r_jabatan_pk    INDEX     @   CREATE UNIQUE INDEX r_jabatan_pk ON r_jabatan USING btree (id);
     DROP INDEX public.r_jabatan_pk;
       public         earsip    false    188            )           1259    35082    r_pemusnahan_metoda_pk    INDEX     T   CREATE UNIQUE INDEX r_pemusnahan_metoda_pk ON r_pemusnahan_metoda USING btree (id);
 *   DROP INDEX public.r_pemusnahan_metoda_pk;
       public         earsip    false    190            �           1259    34904    ref__akses_akses_fk    INDEX     K   CREATE INDEX ref__akses_akses_fk ON menu_akses USING btree (hak_akses_id);
 '   DROP INDEX public.ref__akses_akses_fk;
       public         earsip    false    162            �           1259    34939    ref__akses_berkas_fk    INDEX     N   CREATE INDEX ref__akses_berkas_fk ON m_berkas USING btree (akses_berbagi_id);
 (   DROP INDEX public.ref__akses_berkas_fk;
       public         earsip    false    165            �           1259    34940    ref__arsip_status_fk    INDEX     M   CREATE INDEX ref__arsip_status_fk ON m_berkas USING btree (arsip_status_id);
 (   DROP INDEX public.ref__arsip_status_fk;
       public         earsip    false    165            �           1259    34951    ref__berkas__berbagi_fk    INDEX     R   CREATE INDEX ref__berkas__berbagi_fk ON m_berkas_berbagi USING btree (berkas_id);
 +   DROP INDEX public.ref__berkas__berbagi_fk;
       public         earsip    false    167                       1259    35014    ref__berkas__pin_rin_fk    INDEX     R   CREATE INDEX ref__berkas__pin_rin_fk ON peminjaman_rinci USING btree (berkas_id);
 +   DROP INDEX public.ref__berkas__pin_rin_fk;
       public         earsip    false    177            =           1259    35134    ref__berkas_rinci_fk    INDEX     Q   CREATE INDEX ref__berkas_rinci_fk ON t_pemusnahan_rinci USING btree (berkas_id);
 (   DROP INDEX public.ref__berkas_rinci_fk;
       public         earsip    false    198            �           1259    34903    ref__group__mnu_acs_fk    INDEX     I   CREATE INDEX ref__group__mnu_acs_fk ON menu_akses USING btree (grup_id);
 *   DROP INDEX public.ref__group__mnu_acs_fk;
       public         earsip    false    162                       1259    34983    ref__group__user_fk    INDEX     E   CREATE INDEX ref__group__user_fk ON m_pegawai USING btree (grup_id);
 '   DROP INDEX public.ref__group__user_fk;
       public         earsip    false    173                       1259    34984    ref__jab__pegawai_fk    INDEX     I   CREATE INDEX ref__jab__pegawai_fk ON m_pegawai USING btree (jabatan_id);
 (   DROP INDEX public.ref__jab__pegawai_fk;
       public         earsip    false    173            �           1259    34936    ref__klas__arsip_fk    INDEX     K   CREATE INDEX ref__klas__arsip_fk ON m_berkas USING btree (berkas_klas_id);
 '   DROP INDEX public.ref__klas__arsip_fk;
       public         earsip    false    165            #           1259    35063    ref__klas__ir_fk    INDEX     D   CREATE INDEX ref__klas__ir_fk ON r_ir USING btree (berkas_klas_id);
 $   DROP INDEX public.ref__klas__ir_fk;
       public         earsip    false    186            �           1259    34894    ref__menu__log_fk    INDEX     =   CREATE INDEX ref__menu__log_fk ON log USING btree (menu_id);
 %   DROP INDEX public.ref__menu__log_fk;
       public         earsip    false    161            9           1259    35126    ref__metoda___pemusnahan_fk    INDEX     R   CREATE INDEX ref__metoda___pemusnahan_fk ON t_pemusnahan USING btree (metoda_id);
 /   DROP INDEX public.ref__metoda___pemusnahan_fk;
       public         earsip    false    197            B           1259    35141    ref__musnah__team_fk    INDEX     S   CREATE INDEX ref__musnah__team_fk ON t_tim_pemusnahan USING btree (pemusnahan_id);
 (   DROP INDEX public.ref__musnah__team_fk;
       public         earsip    false    199            �           1259    34938    ref__pegawai__berkas_fk    INDEX     K   CREATE INDEX ref__pegawai__berkas_fk ON m_berkas USING btree (pegawai_id);
 +   DROP INDEX public.ref__pegawai__berkas_fk;
       public         earsip    false    165            �           1259    34937    ref__unit__berkas_fk    INDEX     K   CREATE INDEX ref__unit__berkas_fk ON m_berkas USING btree (unit_kerja_id);
 (   DROP INDEX public.ref__unit__berkas_fk;
       public         earsip    false    165                       1259    35044    ref__unit__klas_fk    INDEX     N   CREATE INDEX ref__unit__klas_fk ON r_berkas_klas USING btree (unit_kerja_id);
 &   DROP INDEX public.ref__unit__klas_fk;
       public         earsip    false    182            5           1259    35116    ref__unit__pinjam_fk    INDEX     X   CREATE INDEX ref__unit__pinjam_fk ON t_peminjaman USING btree (unit_kerja_peminjam_id);
 (   DROP INDEX public.ref__unit__pinjam_fk;
       public         earsip    false    195                       1259    34985    ref__unit_peg_fk    INDEX     H   CREATE INDEX ref__unit_peg_fk ON m_pegawai USING btree (unit_kerja_id);
 $   DROP INDEX public.ref__unit_peg_fk;
       public         earsip    false    173            ,           1259    35095    ref__unit_pindah_fk    INDEX     N   CREATE INDEX ref__unit_pindah_fk ON t_pemindahan USING btree (unit_kerja_id);
 '   DROP INDEX public.ref__unit_pindah_fk;
       public         earsip    false    192            0           1259    35103    ref_berkas__pindah_fk    INDEX     R   CREATE INDEX ref_berkas__pindah_fk ON t_pemindahan_rinci USING btree (berkas_id);
 )   DROP INDEX public.ref_berkas__pindah_fk;
       public         earsip    false    193            �           1259    34902    ref_mnu__mnu_acs_fk    INDEX     F   CREATE INDEX ref_mnu__mnu_acs_fk ON menu_akses USING btree (menu_id);
 '   DROP INDEX public.ref_mnu__mnu_acs_fk;
       public         earsip    false    162            >           1259    35133    ref_musnah__musnah_rinci_fk    INDEX     \   CREATE INDEX ref_musnah__musnah_rinci_fk ON t_pemusnahan_rinci USING btree (pemusnahan_id);
 /   DROP INDEX public.ref_musnah__musnah_rinci_fk;
       public         earsip    false    198            �           1259    34950    ref_pegawai__berbagi_fk    INDEX     W   CREATE INDEX ref_pegawai__berbagi_fk ON m_berkas_berbagi USING btree (bagi_ke_peg_id);
 +   DROP INDEX public.ref_pegawai__berbagi_fk;
       public         earsip    false    167            1           1259    35102    ref_pindah___rinci_fk    INDEX     V   CREATE INDEX ref_pindah___rinci_fk ON t_pemindahan_rinci USING btree (pemindahan_id);
 )   DROP INDEX public.ref_pindah___rinci_fk;
       public         earsip    false    193            �           1259    34935    ref_tipe_arsip_fk    INDEX     I   CREATE INDEX ref_tipe_arsip_fk ON m_berkas USING btree (berkas_tipe_id);
 %   DROP INDEX public.ref_tipe_arsip_fk;
       public         earsip    false    165            �           1259    34893    ref_user__log_fk    INDEX     ?   CREATE INDEX ref_user__log_fk ON log USING btree (pegawai_id);
 $   DROP INDEX public.ref_user__log_fk;
       public         earsip    false    161            -           1259    35094    t_pemindahan_pk    INDEX     F   CREATE UNIQUE INDEX t_pemindahan_pk ON t_pemindahan USING btree (id);
 #   DROP INDEX public.t_pemindahan_pk;
       public         earsip    false    192            2           1259    35101    t_pemindahan_rinci_pk    INDEX     h   CREATE UNIQUE INDEX t_pemindahan_rinci_pk ON t_pemindahan_rinci USING btree (pemindahan_id, berkas_id);
 )   DROP INDEX public.t_pemindahan_rinci_pk;
       public         earsip    false    193    193            6           1259    35115    t_peminjaman_pk    INDEX     F   CREATE UNIQUE INDEX t_peminjaman_pk ON t_peminjaman USING btree (id);
 #   DROP INDEX public.t_peminjaman_pk;
       public         earsip    false    195            :           1259    35125    t_pemusnahan_pk    INDEX     F   CREATE UNIQUE INDEX t_pemusnahan_pk ON t_pemusnahan USING btree (id);
 #   DROP INDEX public.t_pemusnahan_pk;
       public         earsip    false    197            ?           1259    35132    t_pemusnahan_rinci_pk    INDEX     h   CREATE UNIQUE INDEX t_pemusnahan_rinci_pk ON t_pemusnahan_rinci USING btree (pemusnahan_id, berkas_id);
 )   DROP INDEX public.t_pemusnahan_rinci_pk;
       public         earsip    false    198    198            C           1259    35140    t_tim_pemusnahan_pk    INDEX     `   CREATE UNIQUE INDEX t_tim_pemusnahan_pk ON t_tim_pemusnahan USING btree (pemusnahan_id, nomor);
 '   DROP INDEX public.t_tim_pemusnahan_pk;
       public         earsip    false    199    199            E           2606    35147    fk_log_ref__menu_m_menu    FK CONSTRAINT     �   ALTER TABLE ONLY log
    ADD CONSTRAINT fk_log_ref__menu_m_menu FOREIGN KEY (menu_id) REFERENCES m_menu(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 E   ALTER TABLE ONLY public.log DROP CONSTRAINT fk_log_ref__menu_m_menu;
       public       earsip    false    161    171    2045            D           2606    35142    fk_log_ref_user__m_pegawa    FK CONSTRAINT     �   ALTER TABLE ONLY log
    ADD CONSTRAINT fk_log_ref_user__m_pegawa FOREIGN KEY (pegawai_id) REFERENCES m_pegawai(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 G   ALTER TABLE ONLY public.log DROP CONSTRAINT fk_log_ref_user__m_pegawa;
       public       earsip    false    161    2050    173            I           2606    35167    fk_m_arsip_ref__arsi_m_berkas    FK CONSTRAINT     �   ALTER TABLE ONLY m_arsip
    ADD CONSTRAINT fk_m_arsip_ref__arsi_m_berkas FOREIGN KEY (berkas_id) REFERENCES m_berkas(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 O   ALTER TABLE ONLY public.m_arsip DROP CONSTRAINT fk_m_arsip_ref__arsi_m_berkas;
       public       earsip    false    165    2028    163            K           2606    35177    fk_m_berkas_ref__akse_r_akses_    FK CONSTRAINT     �   ALTER TABLE ONLY m_berkas
    ADD CONSTRAINT fk_m_berkas_ref__akse_r_akses_ FOREIGN KEY (akses_berbagi_id) REFERENCES r_akses_berbagi(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 Q   ALTER TABLE ONLY public.m_berkas DROP CONSTRAINT fk_m_berkas_ref__akse_r_akses_;
       public       earsip    false    165    2064    178            L           2606    35182    fk_m_berkas_ref__arsi_r_arsip_    FK CONSTRAINT     �   ALTER TABLE ONLY m_berkas
    ADD CONSTRAINT fk_m_berkas_ref__arsi_r_arsip_ FOREIGN KEY (arsip_status_id) REFERENCES r_arsip_status(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 Q   ALTER TABLE ONLY public.m_berkas DROP CONSTRAINT fk_m_berkas_ref__arsi_r_arsip_;
       public       earsip    false    165    180    2070            Q           2606    35207    fk_m_berkas_ref__berk_m_berkas    FK CONSTRAINT     �   ALTER TABLE ONLY m_berkas_berbagi
    ADD CONSTRAINT fk_m_berkas_ref__berk_m_berkas FOREIGN KEY (berkas_id) REFERENCES m_berkas(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 Y   ALTER TABLE ONLY public.m_berkas_berbagi DROP CONSTRAINT fk_m_berkas_ref__berk_m_berkas;
       public       earsip    false    165    167    2028            M           2606    35187    fk_m_berkas_ref__klas_r_berkas    FK CONSTRAINT     �   ALTER TABLE ONLY m_berkas
    ADD CONSTRAINT fk_m_berkas_ref__klas_r_berkas FOREIGN KEY (berkas_klas_id) REFERENCES r_berkas_klas(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 Q   ALTER TABLE ONLY public.m_berkas DROP CONSTRAINT fk_m_berkas_ref__klas_r_berkas;
       public       earsip    false    165    182    2073            N           2606    35192    fk_m_berkas_ref__pega_m_pegawa    FK CONSTRAINT     �   ALTER TABLE ONLY m_berkas
    ADD CONSTRAINT fk_m_berkas_ref__pega_m_pegawa FOREIGN KEY (pegawai_id) REFERENCES m_pegawai(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 Q   ALTER TABLE ONLY public.m_berkas DROP CONSTRAINT fk_m_berkas_ref__pega_m_pegawa;
       public       earsip    false    2050    165    173            O           2606    35197    fk_m_berkas_ref__unit_m_unit_k    FK CONSTRAINT     �   ALTER TABLE ONLY m_berkas
    ADD CONSTRAINT fk_m_berkas_ref__unit_m_unit_k FOREIGN KEY (unit_kerja_id) REFERENCES m_unit_kerja(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 Q   ALTER TABLE ONLY public.m_berkas DROP CONSTRAINT fk_m_berkas_ref__unit_m_unit_k;
       public       earsip    false    176    2058    165            P           2606    35202    fk_m_berkas_ref_pegaw_m_pegawa    FK CONSTRAINT     �   ALTER TABLE ONLY m_berkas_berbagi
    ADD CONSTRAINT fk_m_berkas_ref_pegaw_m_pegawa FOREIGN KEY (bagi_ke_peg_id) REFERENCES m_pegawai(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 Y   ALTER TABLE ONLY public.m_berkas_berbagi DROP CONSTRAINT fk_m_berkas_ref_pegaw_m_pegawa;
       public       earsip    false    167    173    2050            J           2606    35172    fk_m_berkas_ref_tipe__r_berkas    FK CONSTRAINT     �   ALTER TABLE ONLY m_berkas
    ADD CONSTRAINT fk_m_berkas_ref_tipe__r_berkas FOREIGN KEY (berkas_tipe_id) REFERENCES r_berkas_tipe(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 Q   ALTER TABLE ONLY public.m_berkas DROP CONSTRAINT fk_m_berkas_ref_tipe__r_berkas;
       public       earsip    false    165    184    2077            R           2606    35212    fk_m_pegawa_ref__grou_m_grup    FK CONSTRAINT     �   ALTER TABLE ONLY m_pegawai
    ADD CONSTRAINT fk_m_pegawa_ref__grou_m_grup FOREIGN KEY (grup_id) REFERENCES m_grup(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 P   ALTER TABLE ONLY public.m_pegawai DROP CONSTRAINT fk_m_pegawa_ref__grou_m_grup;
       public       earsip    false    2042    169    173            S           2606    35217    fk_m_pegawa_ref__jab__r_jabata    FK CONSTRAINT     �   ALTER TABLE ONLY m_pegawai
    ADD CONSTRAINT fk_m_pegawa_ref__jab__r_jabata FOREIGN KEY (jabatan_id) REFERENCES r_jabatan(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 R   ALTER TABLE ONLY public.m_pegawai DROP CONSTRAINT fk_m_pegawa_ref__jab__r_jabata;
       public       earsip    false    173    188    2084            T           2606    35222    fk_m_pegawa_ref__unit_m_unit_k    FK CONSTRAINT     �   ALTER TABLE ONLY m_pegawai
    ADD CONSTRAINT fk_m_pegawa_ref__unit_m_unit_k FOREIGN KEY (unit_kerja_id) REFERENCES m_unit_kerja(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 R   ALTER TABLE ONLY public.m_pegawai DROP CONSTRAINT fk_m_pegawa_ref__unit_m_unit_k;
       public       earsip    false    173    2058    176            G           2606    35157    fk_menu_aks_ref__akse_r_akses_    FK CONSTRAINT     �   ALTER TABLE ONLY menu_akses
    ADD CONSTRAINT fk_menu_aks_ref__akse_r_akses_ FOREIGN KEY (hak_akses_id) REFERENCES r_akses_menu(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 S   ALTER TABLE ONLY public.menu_akses DROP CONSTRAINT fk_menu_aks_ref__akse_r_akses_;
       public       earsip    false    2067    162    179            H           2606    35162    fk_menu_aks_ref__grou_m_grup    FK CONSTRAINT     �   ALTER TABLE ONLY menu_akses
    ADD CONSTRAINT fk_menu_aks_ref__grou_m_grup FOREIGN KEY (grup_id) REFERENCES m_grup(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 Q   ALTER TABLE ONLY public.menu_akses DROP CONSTRAINT fk_menu_aks_ref__grou_m_grup;
       public       earsip    false    169    2042    162            F           2606    35152    fk_menu_aks_ref_mnu___m_menu    FK CONSTRAINT     �   ALTER TABLE ONLY menu_akses
    ADD CONSTRAINT fk_menu_aks_ref_mnu___m_menu FOREIGN KEY (menu_id) REFERENCES m_menu(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 Q   ALTER TABLE ONLY public.menu_akses DROP CONSTRAINT fk_menu_aks_ref_mnu___m_menu;
       public       earsip    false    171    162    2045            V           2606    35232    fk_peminjam_ref__berk_m_berkas    FK CONSTRAINT     �   ALTER TABLE ONLY peminjaman_rinci
    ADD CONSTRAINT fk_peminjam_ref__berk_m_berkas FOREIGN KEY (berkas_id) REFERENCES m_berkas(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 Y   ALTER TABLE ONLY public.peminjaman_rinci DROP CONSTRAINT fk_peminjam_ref__berk_m_berkas;
       public       earsip    false    177    2028    165            U           2606    35227    fk_peminjam_ref_pmj_a_t_peminj    FK CONSTRAINT     �   ALTER TABLE ONLY peminjaman_rinci
    ADD CONSTRAINT fk_peminjam_ref_pmj_a_t_peminj FOREIGN KEY (peminjaman_id) REFERENCES t_peminjaman(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 Y   ALTER TABLE ONLY public.peminjaman_rinci DROP CONSTRAINT fk_peminjam_ref_pmj_a_t_peminj;
       public       earsip    false    195    2099    177            W           2606    35237    fk_r_berkas_ref__unit_m_unit_k    FK CONSTRAINT     �   ALTER TABLE ONLY r_berkas_klas
    ADD CONSTRAINT fk_r_berkas_ref__unit_m_unit_k FOREIGN KEY (unit_kerja_id) REFERENCES m_unit_kerja(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 V   ALTER TABLE ONLY public.r_berkas_klas DROP CONSTRAINT fk_r_berkas_ref__unit_m_unit_k;
       public       earsip    false    182    176    2058            X           2606    35242    fk_r_ir_ref__klas_r_berkas    FK CONSTRAINT     �   ALTER TABLE ONLY r_ir
    ADD CONSTRAINT fk_r_ir_ref__klas_r_berkas FOREIGN KEY (berkas_klas_id) REFERENCES r_berkas_klas(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 I   ALTER TABLE ONLY public.r_ir DROP CONSTRAINT fk_r_ir_ref__klas_r_berkas;
       public       earsip    false    2073    182    186            Y           2606    35247    fk_t_pemind_ref__unit_m_unit_k    FK CONSTRAINT     �   ALTER TABLE ONLY t_pemindahan
    ADD CONSTRAINT fk_t_pemind_ref__unit_m_unit_k FOREIGN KEY (unit_kerja_id) REFERENCES m_unit_kerja(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 U   ALTER TABLE ONLY public.t_pemindahan DROP CONSTRAINT fk_t_pemind_ref__unit_m_unit_k;
       public       earsip    false    176    2058    192            Z           2606    35252    fk_t_pemind_ref_berka_m_berkas    FK CONSTRAINT     �   ALTER TABLE ONLY t_pemindahan_rinci
    ADD CONSTRAINT fk_t_pemind_ref_berka_m_berkas FOREIGN KEY (berkas_id) REFERENCES m_berkas(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 [   ALTER TABLE ONLY public.t_pemindahan_rinci DROP CONSTRAINT fk_t_pemind_ref_berka_m_berkas;
       public       earsip    false    193    2028    165            [           2606    35257    fk_t_pemind_ref_pinda_t_pemind    FK CONSTRAINT     �   ALTER TABLE ONLY t_pemindahan_rinci
    ADD CONSTRAINT fk_t_pemind_ref_pinda_t_pemind FOREIGN KEY (pemindahan_id) REFERENCES t_pemindahan(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 [   ALTER TABLE ONLY public.t_pemindahan_rinci DROP CONSTRAINT fk_t_pemind_ref_pinda_t_pemind;
       public       earsip    false    192    2090    193            \           2606    35262    fk_t_peminj_ref__unit_m_unit_k    FK CONSTRAINT     �   ALTER TABLE ONLY t_peminjaman
    ADD CONSTRAINT fk_t_peminj_ref__unit_m_unit_k FOREIGN KEY (unit_kerja_peminjam_id) REFERENCES m_unit_kerja(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 U   ALTER TABLE ONLY public.t_peminjaman DROP CONSTRAINT fk_t_peminj_ref__unit_m_unit_k;
       public       earsip    false    195    2058    176            _           2606    35277    fk_t_pemusn_ref__berk_m_berkas    FK CONSTRAINT     �   ALTER TABLE ONLY t_pemusnahan_rinci
    ADD CONSTRAINT fk_t_pemusn_ref__berk_m_berkas FOREIGN KEY (berkas_id) REFERENCES m_berkas(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 [   ALTER TABLE ONLY public.t_pemusnahan_rinci DROP CONSTRAINT fk_t_pemusn_ref__berk_m_berkas;
       public       earsip    false    2028    165    198            ]           2606    35267    fk_t_pemusn_ref__meto_r_pemusn    FK CONSTRAINT     �   ALTER TABLE ONLY t_pemusnahan
    ADD CONSTRAINT fk_t_pemusn_ref__meto_r_pemusn FOREIGN KEY (metoda_id) REFERENCES r_pemusnahan_metoda(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 U   ALTER TABLE ONLY public.t_pemusnahan DROP CONSTRAINT fk_t_pemusn_ref__meto_r_pemusn;
       public       earsip    false    197    2087    190            ^           2606    35272    fk_t_pemusn_ref_musna_t_pemusn    FK CONSTRAINT     �   ALTER TABLE ONLY t_pemusnahan_rinci
    ADD CONSTRAINT fk_t_pemusn_ref_musna_t_pemusn FOREIGN KEY (pemusnahan_id) REFERENCES t_pemusnahan(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 [   ALTER TABLE ONLY public.t_pemusnahan_rinci DROP CONSTRAINT fk_t_pemusn_ref_musna_t_pemusn;
       public       earsip    false    197    2103    198            `           2606    35282    fk_t_tim_pe_ref__musn_t_pemusn    FK CONSTRAINT     �   ALTER TABLE ONLY t_tim_pemusnahan
    ADD CONSTRAINT fk_t_tim_pe_ref__musn_t_pemusn FOREIGN KEY (pemusnahan_id) REFERENCES t_pemusnahan(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 Y   ALTER TABLE ONLY public.t_tim_pemusnahan DROP CONSTRAINT fk_t_tim_pe_ref__musn_t_pemusn;
       public       earsip    false    199    2103    197            a      x������ � �      c   V   x�-���0B�0L���d��?GIdq��	c$��"�8} sc1J�Td��e]��NY�<B��h�5US��ƫ��M~�8I�      d      x�̽[wZI��,����U��-���6H�6FPy<���@��}<�~"6 .{Ödw�tu�����}���ѣ��\��,�ۊ����q6u��������\��.�!����jc׏iZ��nV���{|~�T�#{D���_,�Z�}vuѺ,��ΗV>��'�ַ||k�;���^�{*7?�'����P����h������5���6�(�W[���Q�u��8y�ly9Y�s���=<܍���&�1%i�c�r �{j�
��\�.��I���W��7.��v~�ƅ�>��n����̍]����1��4J������?�Q����a�ma�m�����D��RH�uL����Dq�#q���3��ާ�����o������W38R{}c�w�*2��8c�{QΒ��d�Pg<*` ���/W|w������3�i���MG�Z�Lӎ �Z�jeM��F+jt�*8!]��yǜ��2�D�^Pqt2r0���qt7��Ǣ7����[ܪ�ê��w�a:�~9Xě��"�$5���7�7���w2e����':;C��ɦ���7�h7u��+	�����p��pk#O�x6�f������[ܜ|.f���h�[��s|6��1�,�3Z*���Sw_�ŏ(��q4.�d6	��_���������7��K��T�z���݀�w`C/��7�r,��1�|���T�����}��l��$�(�.�C�Y��R��Ro�Ѱ5l��k�������q����jpur��u�=h�������D��0�P�[?}��}���y|���-������͏�R�q,E�RU.۬5T2*��6
�-�Tť�>1G!�ơ<v�G�������֋(h)����o�Kĉ��T�pj3�$�)$��@���W�+��7Уw�Gݝ�߿�1ٴF2�����I�%Lc\�DY�����Q�݁��5q�]1��'�i������n԰jU;^5���9Ht�D��H�$F��N*�����zW}��ϭA�4�������x	�J�-3vc��=a���S�.���9]��??�z} �x:��bѻ�m]��W�蹊|�i���	L�`d�jH鄛�S���9FG%?�����Ys�S|휵>�]��`�Yt��e�o�j�f;Zw!���֕��1�ѽ��>� ?�\8�F�ĉs	�Р��8�B3N��?�ov�tLu���ۥ�@��X=¤�A�g�:𓃳�Ɔ+2!K�"���U�B�s�O,��sra[�]ٖ���4��$b4e$��Ls"�S��p2qJc<\�L�q��q{�Qҵ1�4Z�*�V�FU'7�ٙV�@2�Oݚ������h�l
"u����Y`�d`0�°��1�Y0Z��[wS{ np`6���tnә/lC��#sRc���F�֊�~�[�nS��h2�`��^s��f�����Xk�3~��s��l�
`= �o��x�˥�#�(M9��-����F�8;`z�?}!�om��Be�xf��p��`�ў1��VK��4�&z�;�\��z��O �;���GT'���Gg��!vFr6��ܤ�lTr�Tn����g7>~jp�ŉ7|����E�F.��p<��*�H�O>gǁ%��	l5�6P����M������ݕĞ�м�~�4���LƋ]��NlӐ�mҐ�{ j���\��'M[*�Dj���I+���	��0�He5�/�w�'����/�.(%��m �s��b�0���B���@��y�]������I�M��?rG�>BƩ��i�F�lAS4^�Q���U�P�[ǌ#�+�4�%rR�z��ʤ���G���;8�c�࣪�_J��]�DK�*�23���2iT0�F'aV���	���V��<s���_nDe ���э���G�͏��[yMˍ\������͗���3ܬZ��q*�hڤ/�r1jQɂ}'"Z�B%�tR����9�x7�Y������N%��'@�N{��NEB�ew���vY��'�/��Ҁ���`\��On�t����c��;`��ë�};��w�i�k2�l��èk[�"�)g��P���ɔa	o#�0�cv[0B-�8���MEM��dL��l��/�J��{:J��$�<�6���ir~�ٲŽ�����l�-:�uu9s8`9O^���Ӈ�B�i2h#�IP�y�I<;兑"�$p��ּ�?��Mq�@���T�_1Mf�0��2[��o�3\����hݠ���U����<zӷ�KSP�.WC�z˷���ˏ��T����cG�t��F�7�{������
���T�`��=L@r��t���a=af�J�Ζ�A6\}�,�q��p��G���}m��M���=����~kX��Z���ΊA��L��A��y���y��\��N������#z=�7{����fE~���ٺ��^wa�f�&�0K����ir�GQ�@rd�Ҝ��`�H���Dt�Ĕ�����/.x.�����ݻ����4d�����*�R ��&���]�o���X���_��9`�b�ܯb��=ݑ�ӛn���ǻ� ���?����$��z&�*י�n���Ip��#����g��	@�E�ߟ�v�������^�T�x���UZҤ��@̜\�@���M�* b<���� �k�v���A+��JQ��-߽g���&R�H��(.��k�z(��~��㹝��ᤘ����h iD�ZJ嵉�����@BR��s���� �����$pM�cz�@f�$	?�
ar<��'C�YtA�¼.�(eS��"VݐF-H�w΂��AAHb�4�%+���#�YQ�|楠lS��{yp��_�bx)ߘF�l�k��@#X��l��@����6V9��-�u��B>\�&#�u�� ��ǽ�uqq���ܺ���+.��ne�M�Ke�G���Y%��Y�=�(S���}S��n�s ��/z''�Y�0ESS F�x�~�m������O/#���j��ߘ��w�Y`3�m��S��DpC�2��9w��z7B�s1�M�;��-ˉ,��h"���幧~��}��ê��Dӄb�^:�o�3I���h'�3%d&����n@�������s�{]���V���|s85�i��Ƥ#�QJ����S������l��k���s���r�o��oL�u�sN,�J���RY�H��e3Ԅ�}.�&��9J���q��=w�m<l��3vz�����%`�`^Y/�O�"�?�0���ĉe9/��m]G��d"[-V,�i�x����)�0.~]lMs�o��#�E[���+K�R�i���I#c�Q#���G����T ��-��D���'fO?Uj�����?���bڴ�?��LO�1��EzJT�4g���d�Ǔa��@�Ia��+ƿF���\xJ|�yd�l4M��9�7��1�55X9o��X"BL�D����J��,hͅ�.d���"��;81��>�Vgc��X�E���MR&-"c0���x*��Sǰr�Y��sSu���F�������N�.-����+�5"����?��<����4ݮ��K�[�X�GD��ꤵ�R uJ{�$L�R%̓��񼾽]7G�� ���v�������h�Lb���r7"�$�V%�w��0F@�b���?���2�ް�C�?VK��ycq���ۇ�����[��B�N �	�������8�XQ�����ݢԀ����-����R��-U��m���RPSn(�j� �f�=@p '2x�(:=��y,��"��-��n�c���Ҹ����?S��-΍��d������l�t��ʄ)��ҍ�&�s&�GbL����� �RpR$3��������?�oҟ�F��k�z��W��nK�֭L��j�	iT��+�<(�g�6�)�)hV��Q %ڭ�> �6v��=ש��d�����2G)n��3��7�ᵛ�?n4_93�4r\��`$xU`�5P@nA*�$A� UD9��������f�P����    dc2��d����[�p�Fc��V�zVq=%���7#v_������V�h<�F���&S w�	X�H��VZ�` sXv�����:<��Mq�O�-�*xi^�}pf��u?]ڔj�5S]ZJ��Kv���`@t3˒Fr%�1L�M2	�,gOS���)�>6��m����#��nt7z���!��U�V�&��D:[m�B�VȎ`�'�F�����P`�6:����%!�Ο��x��⅞�gY�F��cT�ҐL�c�)� -�6
�Sp����[��?V�~�����s@����8K��=��;����q��p+ ZaR�42��Dƒd�&0����!=%���Yʍ� �HX�l�M�݂� }�Э��-��S4�+����!�Sf��Wy�nƓ�����v�r;ǰ���R���/;��:�9��1:���1��qP%�!���`�2��������'1{�2��Ҡ��jH��- ���S�߮�G���G�
�_
�f`}2�@��'���E��C4`s:'筢"��ǀ�.����U\ݒ�/�76��#Ta��"��0�y2$�-c|��#�4����%��-�suqjh&�	����pJ�o���_��E�q\�uo'7RE@
v#����3�*�e��a� ő{[��f�\�WZ�a��u����O I���~Ǚ-���%|�-N?^^g���h:�2�n���^~q�9�����������F��GXaR�Ĩ����:��@â���R���\��MB���rOr� \����%������v�&�q�Ԋ��Y?.�������w`[1r��
9Uo�����>�w�S]��p*:��]�Z�@���1g��\@( lY*!�g9����X&a�f���p�`"w��("�����#�	����'v����n�o>���@��R�����y�v>����D��.,E��>������e�uѹ���ۃN����u�i9��Б{�,����<�l�{	hF���@��Q��?*! v2vͬ�`}�aq�n:s��2�]ѽC��Pʯ�ކP�u$�\Dr�<�}e�����EM,�l����d16Z)�	ˀF̀-3%���7��4�5(�i#�
���tarw�[a��uU5ҍ�z8Q@�IN�1L�R�2ϒ7pl���R+�;���HȰo����6�f���jl�:�F�NhH��삑\� �
(�V �[�T0\e���{�i�{%�A+�P��o|1��٨܇��htp�3ϙ����]�|Nr Ӭ���-�x� OC ^j�%X���_�uO�OZ�_Z����V���������bh$@�%�I�{���8zt+e���5l�u��t��.����t���l�������]z|,���N�������{�纯Jx�k�iˑ�� V5J�4��(BJ�zi�����X��L�9 �p����&���; ���Y�(���������*q�,����W��уo��RH4{Rʱ�4����`�U1n����cњ�Q�<�sh�R:�mV�U�^SA�(�0:i�NS���o>L@�m�OW�O�� ��A�'�h/�}��$/����Ȟ����o4��t;}���g�n�\�g�wf4�����U�K�|���&����ݾqm��d<y����ÁbW�c<�6Zyy���7��,�U�Ri1FɋD��&d�)|�/A6䰛��"���~:0[���5���Ϊ�l���&b襈N%��?%����7�b��@8�j�C����_�d̦���X��B����Q�b���
�ؿ2O~���3��U���͞Y%�!r�I��ƣc I�D�A�sp�ܗ��U�N_���i�_���kg��nH�3x~����-����LP��@�nj*�����LId���1�.�5�����bK�p�x��P�ۯ����M��@@��,�� B�������1��������0�":���s�������W�^�'��q˹v�#]AUZgx��Ė9P�BN:����a�2��j�Z�Ln�����$@`�WF�iBd���b��w� �qA{�3����Xԇu��l\���%}�V�F�xN�1����`��	���L3��}��VG�by��S�˓�������F*��l���ð��S��|��2������u��:�O�,�6��
��x��Ļ0�p"���i��̛�P����=�m$�E����ڝ57zm|~�vgܾ<m]bv���(�S�xާ��ˇ@�wl��i���:���3�PJL�,Z����1��:0�3�a�f��zG	WDa���Ϭ��AԬJs�m1� ��Z+�39It����u��+����R����,��Ѭx\�X��l��l��g4_%5������-�n|�|�2�q�jL�%q��̖ЩL@��h���E��:ə����N̔��'i�.���W#cDc�> �9EO�L&[��ꨵYج��Ҁ���>j<��*Ǭ�뭞u�����S`oj�������zNUL)�[)'���I�Q (x�@�1[��$$�/w5�F�m��-Z�w=�BUE�cTs�	��.Ii�
�?��D�(� �Z�E�Gi�>�����-���ޕ��ؽ�X`cô�v�5��]HVf��`Z#��y 	!&C}
,R�q\�,^ύ�H�e$������-��N�m=BT���t��ڭT��Z� �2��� �g.z0��H��N��~1�q��.b��8?�`�y���i�f"���<Q����;�%��2���0ƸI�	��|�ô�Q�P�8��8�0�����){yG53o�DQq0m�{�w�0�y ��UT$��t�3~Cq�-)��Va�Y	XO�p�U�-�_���-�4'C�Qx�I`��h�\ے�ە�y�8ť��[3)�s_�5�j��.�$�rT@��% ��K�M���Zk`W��Zs����v��ɸ|�<�U�BV�ae�����L��X��^
З$�̍K��ML��S;cY���!=���@gAQ������φ٫�ٿ���r�� ��F+f1���:MQ\K��l\{y #�*s(yh�d�n�k';��Z0��(bo�n��A�6=�L�>R��e6�x�}Yy%�$���#[���PVl�%v#_s���}���@I6%�1�Q.��N8R9�tT�'ϵ(��>�)��d��P����QE޲�$�9��B� Q�p���R:eC�Ӻ���`Tzi�� ���E����,��8y�e�i���z�yy����N�L�� �ŗ�'��E�N4"�<>��"3�4��.p"�
Q�[�M���|��n]�5Fcw��m߯x�[�9.��'2FY�.�S�'��p����~��l��W���m��9���w���˓���~qkxu�+��ί�E���>?.�9�UY��r	ğ�Ϣ�J\���G[N ��,AE����N	 ��d�Z
a����:�'�����fk�Ոyd�$q�`$5�LMh@n�#��!.�G�?F����!��e��Ǉ�v��l�K� ��F��<�]AU�A%�J��,���� �g��<�-/��_'���'��cҚ�jL�m2Eܚz�E@��%�m�Y�$�A��$(�����};x�p�Fb�v�U�C���,^��WS�U���Hy���DR��V
��w:�B�.�N��Cz;N�&Ӄf����h�4�i�*g�9|)!&K֓<� y�L �6NJ�%�vQD�ټ?�i�+Z���`>�5i �j7�p������U͏�X@]��w���L�X�v"S&1���p,��/Z�(�;�T]�Ճ��q����k�F�qC��u*g���d��
8� _����҅T.��|�/�H7�T��g����o���r�Ӝ����LѢ"�d��^�M����ч%+����+���0��s�L��tT-�0@�Ÿc����n���L�~4+�eP���%�~y�?=���X�    ������*|vQL�������g0��N��-K<'_��� i�Y{����{*6?��M��3Yҗ��VM׭�.������O_mcM�d���X%���� UT�"���6p �������~oXV�h}n��t�e�#�?�X�}��
�S#0*P|uM[�\ �¿�Xc ac�]��h����Ӣ��u��U��9����z��s�W��i�u��6�Q�������Lkй�l��F���84з���j�O%�j%�"���f��
4$���`�c�9'S�������a�߹hual���/�>_a@�E���`���0��z��oI6+-k���O5��+��O�Yh��-��s�0;a�H,s�"�'�2�2	��1���y�{�9����{���E������i�/P
d��_���Yyg֑b�GН���/ץv.���e�ܞ��`�*E
���r���_�:� �Ki��y�l��m6��������f�!���1�SH	�8�p�7�+i-�����<����^����V�쾺@���K�Mt�qel6�Q�Y�,(�U =0$��b���n�?����z5K��	�� ;"�:L�I��6[�E��zR�I��7�}y�:�/
S����%Ҏ	|vc��Vm�v*�@��qOd�����@+t�{+Tv_�@�i��������.��N`�`�����F��Zg�����jJ4-T�k(e�)�SԌ�($��MxO��`��K�ɷ��I;��vu�:�[!وg��@Os|)o��9��cZ[j3�V*j_������[�>��5��B4	o���LT�JУ����	9?�=������ jK7-V��q�Ӯ$j��BύJX��K��o�sp���,�t@��e*��Y�F��v��$�̓���貏�R*F.x�x������Tk�Q6�`�Q2��!jk$� �ĝLhc��#�/=���iР���F�M�@�����cz�::Q8�2���k�ݗ
����h}j�W��5;���s�1����DI�Q��M^�a����/����U��v��E��hї5�djqջx��ǇzY�_V��L�`E�3%�Ь"J`�F�d%�[���1 �=*������Frvu�.��Ǽ'_
����q�a�KȺ[���_����~��w�4��v*�1�U �J����1|�	l�Á�.>�ʡ|Ĳ��ak�θ��c��t�U�A����ޗ��g��y*-|�+&��ӣ TV����]��f���Fub�(ʔ��.�ż�{#�c��듲�qk8 9�]1��8�������7<����J��렅�◭���V3��<z�����_�۵?:���l��:&�v���2���-F��,����}r�o��{�n���4?�r���[Ub޹��w�����λ������4���r �۔���86ϊ�9#$	n%�B`���%t�)-����V�~>n��:�"���yM7etly�7������j��tx��[%s,�{�(�2�`�s`H���\�Z:�O�����Xa�E���O���5x�*
%jVqUZ�����Y��CMv"�,�XS�k�C��n�0�iD�(�E�~��'.�?�>�%]�L�Q�J_F&p��g뜅Ǡ\Y^WP� ,�R�.P��X�)�a��� �'x/־�҂QuO{����U��g��?;��7߿1��D��,<A1�)>j >H 2.��Y�) {#���8�4����q�Z��>=.YD��W� \�W�@�K���O�~�;ԗ�f_�]��ziCԘ^Bay����J㌣JP�U{�.�����š~Rq�:H�~��V�K���%��8��Ѐ�����G-0���ڿP��x�=
�����0!�F�\#D���R"��s`t<8.�Qx�2X���Ao�kr�&CG���ы~1�~;;.8���#���l~į����z%H�5''�������,^���2Z����R� <�@�4^����f+Ab���;��F�gf$)]��/^�ce����a�*G�B�N��)��Dd1�BKn�����d6Y��\�,zw��u[3�t�c}	GF�/X�H�%�4�`RE�e���l1���T[R
�O���my

��8�/��k�^0��Z4'��,���w�b�s���&r�Cv�W����3�H��I�?���<7�
$��SInABu](�s�W��3���i�M����A|����Δc�e�V�-:'Űu^�xq}ѿ���ry����׵�3|4���7��j�h��J�BEn(�p|������w�a�s��b�.a��zނ}k��%y�^]~<�t�s�
8�y��J��U��5��pV/�8���[������8���
�����,֜�6i��+}FR�E�*k�^&���b�.+M���|� ���j۩���	A���&�H����'0�{NX]R��y�z�o e��\u�W8���K5~`5mztv����S��So��"�9k�GYŢ)L����FÄu�p�1��LX6�}~�"���p�H�h�*�'��kC�5�9����8��?2,��ƴ�,I�AO%����Fc���6�7�6�N�a9��ĵ%�u�Uű9<ݞ�I�q�ա9f��6Qɓ:E0\,=�<�vZ��a'0��G�O^��V*q��6�$��:dXr|��5�#HQ&XA3�6]\�v�/�av��Jr��k�<�b�	!j���j|�B$,+���.���+P]֕�̟J�y7�-�f�r�n�5�2�dz��so����W3��F�u��91�/^�Y�� ���Y�f����f�z����*��kכ���xȵ��9�S�`��%%�N�e�	��;�u5�t|����]�U��n}�>����Xf�b��47a�&�^&�s���2Q�"��l6/������Z�'��=>�?���č��w���Tr {�^��f�5���� s&�H��'�r`~H|N��T{�{�5�jJ�ȵ�QP�,�x�)f7ǻU�gn�mu��N�T�-&Gu��2d�hs <�eJ�^Ֆ�ϕJ�q9IS���f�L{���ʾ�=��R�I�X7nUv	L�5g�B��td��!8e�� {�9`�g���8��Ej�F��_����|vu��|�*z#L�R���]��3i�xL��(�e:  U�K�)�(',�$�z ��k�`��AT ����ls"��~O;Xe�(^��=�Ƚ�H�<�b�q4�C`p2�Ʋ�|�|��]ЀUk-0� �.f�"�$sڠ��(8[��{����.��n�9�������ƀ��f'߰9��e.;���X7R�KT�D�Ur=��|6=nW+�����˭>�Qs��+��p"�ȉ��Ƅ�1����G�׽@�$���0���ƍ�#>4},���v���)�=Y=�Z�4��I��
�y�ރ��� `�@�	W`��T��ϋU:����^fG����-����lz|1Iea%���ab�S`ӆ��ů_�����T�b�Oc�K�  /�у � �����H��t�|�8P�w�����~��rj�t#\���E�a����Q4g �C�ܖ�ӏ���������������� I1��)�ߍ��_��m]��i�l�]V�h���"x`��D�l ��vX�'��Vtm��H�l����|�/Wl�N�ӽ�/�����2׭� ��փ �ߜ4y�i��.4����2?G������߲ҡ�TW��*�T�iY2eAn{�IN�*I�8_��j��j�X���(nz�F�V����r��;�<��S�"��: �9e�6F�y�/�`��/wz�Ƣ����3L��+K�d�v`����oQ1�6��TRi:��mY�zY��C|8�\������b'����;ŗE��g�R坫��T�O����:M}b��$=��&���on˳܃ь0�?��t�5c��zX��f��"�$g�>��V�ÿ���l���Kگ��F�)�JN���������H���u+H����x��,�\��L���ǝԎ�&  �ՎH�A    ���)F��0��X�E�/�	X��9,�ǃIz��<$�a�n����q0�z�J�ӫ�z����>�� ���	�/ZT�
ta�Yh�-&��^3��ޥ�
|~Y��J�������=�ݸh=LGwH'�[(B�A�M'���~���9-���,�X�,�ep�@X�*W�w�Eg������X�ѿ���ᨍc�њ�[8s8�3Ъc�6?��뽗ï�FP��ރ�2
����h|��Y �Y��e041�c[jM�gt�ʈg-0�8�Cb�_�rc�5�jġ�f�)ql ܅� 5�I)�
�&,P�L�:-���Zxq�R,Z`~a�C�ڜ�C���3��_3���.�iŽr9�^$D�Pd� �I)"��[�ϓ1���B�%7������iZ�/��z�������*~oΐk��^lu�&x�,X*hp��5<+Ȧ�4Vи�����Xݧ��K�}:�s�=��9���}	�~�Ϛ�h�!Q� �$�A���R�9'BS�E�K��c�dgpkޱ�:�*��d���k�s�/O(��1_��T#��9�@�D����Z{`��{i�nU�	���L�Qش2��Ff����x��L�f&�6&@g�d��u����5��rt�O1�8�${1�N�5���h��␆$��8�c9w)-3�h`/����uJ�^��XAN+������Dy�A!g;! �&��ק��c#��gs���\�<��*�4���ݐ5�^���-d0w#i���1],-���f�bݐwyX�j�D�����7�M�g��sI|����=��p �-�4�xк��Fb����&u��H*^��.��f�zG�;F�Q���w�����|�?����c���� �!G�9�3�Q���H ���d	t� *���D`x�->_�/ZÅ��5�Hpg�_�ƸA������y^�U;Ӝ[9�
:J{m�
@�,8�u�z�:ˬ���|�ͯR��W}r��-��q#��AF0k�Μ�B�EL>)X�B�ȍ���/w7_�ꜹ��=��|tP^��bo������^87��Q��ĂB6�j�.p?� 3;z�m�v}�~��G���ܻ�bp�i�j��{�=-�\��PA���;J�LO)�v̡��*ֶ�?.���SI5��]\_^v��-L��;�iM��~y�U?Us��  8n��M�r� A���0椀!��sj��g��{w#��v�}�i���6�쀺g�� �Kk ��0�r
 0���Č6�
�gL|Leɽ�b+o�,��R]�C���5K�Ԙ�Fė<pd����X�
&�!�%�ְZ�c.g%���mux�5��h���Ⱥn��ӜL�Y�s(m��'�A/:�1	{D���ܚ z������^��ׯ���f}᝱��&�b�{� *��'0 	NZ��K�-����9��F��M�c���m?=L����,��t^<�)//n�>]�~�,/?NίNZ��E����phP����?1����
9E��S��I%P��[
���4�<(��uT�_s=՜��a�=e�&��A@�B	
P=����  �[�	��Q#���%���O����c��J�?��8�}o���].�
ׄ�@�����t��������TcZ<�4֪��gM����Y9�Q��ݝ���-�VYݥҰu�V7�N�a�iK�F��S��Usƚ-��Ȟbb�{E��!�)��4��h����M�۽���nN>|NK��D ���j���&T�\�*��ī�)(!d�?����[������Rl%!jlpw>&��\${�� ��HQrZeg�$Ua83[���yhmݡ}��q�Sw<����_h ����d�2��![�ڶ̑�A�X���'�P��%U2~�rŤ� �x4N
���g*B<�N�y�F�
��{�qk�1�oA79���/i�x4�0�������8ꁧā�xC������]ѝ�̗v����/b��Q�n���ب�Up��=�z'#S� �v���nփ"�(%1ڨS�p����2N[�B_�n0��ܸ�	M^�G�e��ah~w#�O�;��Yv��3�f��k����=�S��_w2{ųXը/|��'��wB�Q��YfrV�E �ۏ¼h��e�U_q��o��t��:�.����}����� �_`�.��4f'�@��~�\���6��������g��sl��vO	���t�'�r�,�m��_d�*��!��*��<���v�S������o��י��2���ٖ\4�{�VgW���ñ���!}?Rx���#����$3P�1Eʂ֬�z=���L'�7X����=��I��7RSb��A��� �0Is42�b�D_^Ԟ{���x�
��aΑ���z9X'G��Z�	�5s,Vf���������iJE�����4]GO|�`9��f)�����>M�"7\��xI��g�6�����ѿ����g��u:������.�8������K�)��l����9�`9B�����lK�W�`$���ک���Aq1�c�O�uz����ר�ѥl�倳H`N2@z���9@^ֳ�Em҅�)�^1�F|΍d���9�L�!^3/��$�Q�&�Q��:m������Yѹ�Xޗ #-���EѺ�����Π�w�e����Do~į���K{��F�띴�{�kb�M �HF���)�Qv�+8��&��V�aH���nVV`[�����ϴt3}��fB�;�`v���@�ۃ���Y�۽�������O�[��A�\P߭/��2ql�>ow����N��ځ0lw���?`��l��_nua�A�:��]e�����9r�\
�����uF{���& H�,  �w��BxX#��B�]���e�`>]%�P�%���HZ��pAՋ,��J��z.��
����h�
 y��r��ax���r��q�ⷍ� �%�'m�pyƙ>f�0�+]�p��5¦#X̛����n����sЮ��|�s2M?^�)���\QWrZ�RR�:	̑8+�x�E�n�4�Jŕ�� ��q��0r�xE�h��H u&HB�8�ͼ��)�U�kx�u��,霂��9�(� 4֦3 x�a ���*�H��a5s����DV
��d����������R+�j����^�F��c�,YJ4���,H�Yƀd�$TT@�%��~d��Rз�%�`ޑ����|� �� �&| �D�3�E!ge����W�������Q)��\��Sa�Ae�% 4%���Z��'�h��jT�!*�E����s�hc,'�B�K�Ө�ƨ����z���Y��� aO���~�,&H�t��B���%�*�3�SL�@l�%#��Yj/#H>�3��E��uy�4B
�o��vW��b+`k+`o�E
ρ	^^�+����_�` H�ȯ|������TsKӘS68kJQM�8��6�V�v�mE�Y<�Ӵ�[L^�9*?R���ӫ��!������ur�ƺ����+��%i,��1bQN,Jn�l2>�&g-�0���.���Wt[睯��ջ������ὕ�zA���T`�=y41)R1l[��7G��/��e�m�$��a�N���˧�&��+,��W#m|`%�U���@�
hNY�#�j
s�c�uY�g��I� =&���e�|��>��>֌���Xc�|��l5�
��EP��}��H$i�4�_��ı�CY��sy��2�-�á!�t[8�C�~��r5k󧽀�����;��p�s�tT��-f�ld%����Z������n檥{�`c�!��l�ě�I�#��J��`�P�� Ķ���7:^Ue9k��e�Oߜ��.`����5 �1S�������Em�f�e��y���2�.*��T��ga�� ,y�^�>��������N����������[a���}V�{��&�X.��^��5]]R݈r"�^ˬH;i5W�ęƓ&������,З��k4�O���e    ��.&O��h-�-�h�5F%g�-��~��Z�/G�٦�:a�V繈�G"����1d���SGi{˚"�C��������1�V�]�*)>w{�pR�`�����X_�Su��)v,?���t��+�� �(&2��',�6��M\�BjMG��Qt��dkV�l~<��9���T�b3�|���H"�� 0H8�Θc�GO��� \��|}q�*N>��Э��6?�w�mT���ZM����Ɖ0��4g_G����͂kJ"\D�G����2�?`�N�+��-B�?��C�ｓ�5��V�z^�ƫwo��g��MJF�9�yC����KXJ�0�K쨋X�ǧ֗��>X�s����{�k7�}cf�hv�_i}Z�+,�`A��B�]�,M��撅�'��E�����wۑ��fy��[����#|6�ǰ�;�=���$��!��/0��Y��qX��,���V���1�/�s2뿺���P�A	 ���!$F�̳��7�F�q�ʒH7��^�u�]]�?�&�S��J+�׍�����V%7 �^�a�TG����>Q�I2!mt�v����8y���إv��-���pn�V%�:z'R�֜�d��TfCR
Y��ʼL�;��S����{u6�~�Z��������6΅S��	<&#V� �5"8��.۪���nl�����A}�ޫA�����}P���*�$H�4�W^2C�dɞ{��S|x�1�	�q������`���v�6��� =��g�c�����k%�p��LԺ�^��L�����ہ��`{�N���2|e�`��j��N� �%�+�)c��H&@���5����N�t7c��D��{Ra���GVJ�(�Z��
�Xi�_2b�(&��\�J�Ci�+��E�=,Zט�i�Y������?����/�gomL��u�N�(IRB
;��&�ӆ1ꥌX��KG��~kQ�8��*]�O�_zp}Y�E򗭿�m�������D������:g0$$ͨ �TB�����\_��jjm�7dUtc��}����'�f �i6�"eE`�Y��MK�����Ӥ3�JVjV��=۾K�6���
��P�sy��H��?cv\����!��\��+����P�es.�@;It D�1�n@��x��$U*� �`:yLq>ŀ��㸌�p;���SFO��ܯ����U���ʺ�"b�#���=�.%���)=2�	.K�]���Nr,�S�H���fn���C�ޤ�L�s�J����Ϡ��ek[���5מ��
/����s�gwx�=V�� �ek)�dk��޷�`9d�Fp��9���}5� ��~���e$ԧvY-�38�{Z����	�� ��w�c֒?���Z7?�X8�%� ޱt?I�d@z�R��L;�������Mg��n_#�e���tW�,}c�F\��QM�ps����BU��CP��]�D1 ��:�Pݽ� ��cD]���~Ѿhu�8�`��i��J	�{$��5�Tg�I�~kճM�6���;'A�0�(R�Ef�r�����.��&����9��J�?�qH} cW������a��붇����C=�,��;�;�Y���",� B:��8�tҘ� 3<1�?�e`ɤZ����i�_�J����U�Ǉ����٫u+mza�[�����鮵�fᛋk@ k���ʄǐ��S,k8�I� �q��S�������������:�	x�����%��\�&)����n?5�܈�ҪH�xeKW�2�%M�{�J�_F���V��� �R��~q��*��,z��u�c��e�a1i����,M���S
�R _�����y�Gqqu���E�2��۾.9�+�^��Q��$�2J���"���ż��@�d\�pƲ�1|�t5ċ��K+	|iPǄ_1n�{ڣ�� ���U���^�9].nNK��!G �oԒ�> ��S��q*ser��8���`���=������i���ӗ��>��gzƯ_p���*�j�?�`ڽ�Yk���ͨnQK��_3(i9֝ 멈DeL"&���/
��D�-"��˳���z}YZ~�SF��G	P�r�?������l|���@��Y)6ho2���/�y�l$	NIP7�L����C,��)�`��ۃ�����m#H��GE��|Rw������4��wv�0��XB�֧V�zq�����bOP�N�c{��w��o2��'�-�Qbu�����,��\G�5���Ű�u.a��<a�q{�2���H	Y׈dq���n��M�黛��o�3|W<����_Xe�X�J���]'�h���,֖�$�0yKs��W*��跕�
G��}1t���2���U@#\\��c�3qE�1e2��Rl�4]�� �ݪڐ/��>��J�tsQ �,����&ha j(b��`���H0KU~R��Z�H����[��i}����x`�	,���%��+�,�ƖV�:�qUI��T	`��  �1�?I��D �d̳Ɉ
<<u����;��q��84Uf�ZR�$�e^������̞jfK�f�3�xH�)
����pxk����dR@bh7���{w��A�on�:������jNҟ�+<��Ҁq��)�	�3'3X:�$�ejǭ��������ٴe�
~Qĳi�}Ў$�8H{	�T�Q�X �O��A$m��b�8�Y��3X�C��n��m��V%�A4;�AiҘM�iJ��`:�/�� �a90_Z@�^kX�9�./�`�o`/�(X��H�n7�/�����_�#, ۶ �)��c)����L�-a��p�@�u.�(�0�lx	uz�O���г��e����;�~�p;+u�7o�7[?��|������X"0�>z������\�*��/�XRă��R����V[�X\�̏ց7k��=^F��S��^�}!+.󢮊��p�r�i��kFݵ�L��qѻ.�5v��ۃ��+=�ߺ+b0��yY�D��K�^� zR/ż�p�� � }����5�����I^��~:��5,�.Q>�atK1��t@{]��[ts�0����)z��'�ӱ���1�R�H3,�9U�Ԝ#w�ǬX����/��ݲ��`����+�|�FPs�����3N�F���4�ˎK�'.Sn�^ʚ��u�m���@�L];x�{}�)���c%V�����7d�H=J�tA�$�Ϙ�[���v�������Zl��d�ڼ��C�!lw����V�N1��Ueע9���(2f�v<2#�}�X�Uc>�d\
�i}Ce6�s�O{Pna���b�/vt^���f$�p�ϥ3�\�	� .!���@J�1�F�%t�N@\�����<lO�/8�s��8��f+�O6}�ĳ6�Y`�8'�6fc (˝��4���˄X�"&`��o���I�x_�{'�j��M�9�T"�ds$h�ƙ(@rX(v�rvpg�b-�,�`����0w�� x[�-C�1�	�*Ht�?�g��ޅ��B�������n�P-w'�Ħ�#U��*`�{�c8���`>0�K�Z�����׮^U��k�:��ЛH����Ak-��OYL���1��0_���;ǐ��3��L_it[�������7?���|Zy��V�U��:�����h�o��S�Ze�#���.BA�SX�0������#�U wX��}��Jv16���B�O���#�=k�����x��Ո��
�K0 Y5�y(��;#�K̣c5���kWU6��>����/B���5��^�c%ܶ�~Bdpz��1�����"�e�;!�k���I�ذ�o�=�pƋ�`PA��{��� ����waľ0��\��1�ʃ�U�w�j���7ƚ���<I,8���3��@y8zt��(j`����Q�w�p3���)��cJ%bbN+#)�B�I&ȁ�0c���X���fƬŭ�9��CW|�n`�#v�ʣ���tP3��0�Q,km%q({`��6p�cL��    樎Х:,N��L����=�����о]o��v���F�1�e)ITii��2�f%�$�Ur~�� ���=#�m:Zi�W�cj|���?��l��$Y��<E^i$3-�/=c �A�K�p�nb��D�i9��ۏ{$��U�����D,��G�.�?[$&��<dd܏�c�X��1d���@w\͘�MSUKl����Ǣ�!�3$3���o�h)(�C��6�r���/�D]lSZ?�'o�$����|��B��^!���iY��/o-�؃/��W;y���+�cy���v�g���\����F0x�G0Mݕ(���i�[��]����y�	��7��|��e�P�=-���C�	��r[��2�������9;���~wbY���LA�p��Zq,+��^� ��.I�\�Pظ^����Gu���\��Ӷ+�e-���)�����t��4�\^�4��~��>N��)��P�P	^��p<*M�w�(`.���v:��\��G0%�g4�ķ]V���|�_� �9Չ1��Q��,��!�FǓ���Qd�wp��^�l���圏0C�G�21�4��I�E:^,��l�ͻq�s�,�J��l8X8d�Z�)+���f��Âp脩>e��p#��hu��kz^��`�g�M׹�L�Ñ��x�Q3T�s����&��#��b|h�C��L����cJ>F���@!����dP"����	c�Te{�JU���n����L�-8��5YQ�(R�P��ֽ����
���t1������,��~�I�c�~q���r������殬�m'oK'x����*�%~�E�a!8��MG޲�A :��Zn�(�S������ (wB�*��l:�0�;���6����GV/*X^`�Ɠb� �.�/��m%��_���
�R�k�ÊC���"�_im�� ���xXԌm�4������h|>X�2\y�Hl�hs\�yJ�[��	Bxb����՘)ғ:�E� P��1p���<ǋ�͠���Z"��5F�j��=�D�'�q`��ET�n��sȵ�ҨP��Z�	|�$g�7���!�~�Y^�]\M�v�o���A΢{������%��FH��DIX�uD�ZX�k)Z�ʲ�͐�1���`x�lѥX�tD]o��Lz�����!1��J� &4ԙy�� �a�v	��@UPY���f������:�Ok�#�z���9%�(@�U��H�>�����T���]t���Ax�?G?m<_ ��Cn�C�N�ŷ���"���hd�B{��M�*Km���6�!�@�����zu�8�x�qr_̷__�gݯ��J-�_G;f��qz�w�-��z7��=xB��{W�e�_.ѽ�:�i�1��]`��LX
�$��1�HT3�dS�U��������T��Zh��:�b1�����ӨD��ޜn����Mr�'"�X'�*/�2�f~�P�#����Bd`(gC)E>u�)�΂b0X�;e���ه�ɉ�����֮�����MD�Sp�]��*�R�E�?'.��'����a�с��8��g���`d)	9(ų���a��'x57�|p3����p9�~K�������AV�7���2�T����s�����.�� ߒ��q������6>�E�RGJ�kaU��!l���w�||@e��"�N�y������	�>��F��c��>)b�X���:-go��'^Y4�����z�5��bY-����|8��:����4�b��q��fX�]F�!i¬�>5;�a/6�N�Fv�w�m~�u���l����z5��^��칚�k�f���3��w�kD���	3xU�E#2V�����ї��0���!LCa�}�2���k��&;9N.Ɨ�cm�s��{'?���?�L�0�T��%�3ԃٵ��ȝ�ґ�����e�7QΟ���K%������	!{�~�U¾�ގ�c�4�Z�ֽb8s�/�ǭt˲���������3���9�ZZPȌ@i�So��!epr#�ml���s��ܳ��ڄҵl��	��GZo�^�a�Z3I�H6h�Y��+ѧ%4q��&�v���}�,������]��0�=�b��o�a��&�Ir�ecp%����d��T{ ��:fk39�=�#ǛuE������r�������j0]W�����u5���%������d�#�9!E�X>�ՠ�g�r�I��QX10�(Ƴ������h�^|{����5���F��91��H�T-ok���g��v��!��Hg�;���D@�k'�!Jy���]R��3E����������KM�&�q�F�v�5]fN"h�h�M�i{�ڞ�$�mܘ�Y8m�Ѭ�Ze��{z��o�|�s=Z��tw'&�@�İ���b�h�%,�_�����%^WǷ��|uv�5޿],ƿ5���l/ W�;AJЄ�q"(�K�,C�t-걂\I7ے����c����ܽ�c�堺WK_8ܯ��>��/��Dʌ�{5�ރ��E"/��:p2Yڍ�C��A˷�A����%�<��c���I=[�x������������S��*x�NVI�%�<��
��4-���ܛ��|0[R_��_�����ޣju#,a���O���_%R�|Y
v�`?^k��AK��`x�S�Pn��
��b�~�o��~��i�W@4�{�FAd��-�$�,E+��H�����v��׽��F�rww=�w `ڈN	�_���<#j[���!x&6�O�� ������+�b��,S(�6QVws�Q`O��w��ϱ*w�q1�_uɇˮ�'us`���ˬE2$�����r�� pI�	�z�����ٍ��������kI��ㆺ�9+ܟ���Ѽ��/�sԌ��~������j���@4��#\sF�*d�.fm#ʢ�`U�M�P��佝�����_{��vb��(�Py>����:	���J�0R^L'xJ;L������
q�`q��Es�'�Q�cf��$yn�[0�[�n�?�FC�Ρ�^b�4����a�;`���l��jS�ͱ"�9������}Of��䩙�O�}�'��0�������m�ف��9�Xjr!�%� uOр�W����zZ}}ߕ�O �=s�`9�Ú�  �@��ɶHzQ�@e�J#�aV%kIX�Z��δ7�b�,4�"O��8�������.�%W�(�hf4N����#Uxșj퉲\�$B�I`" )�� �{�6������f��r��B�����k��K[f�����r�a\�W7���Ow����/��� ��"���)��*G���!�FN�-�G��l�ͪ7�j�u�Cc�O�z��x/D�.bR�X�=k�yP�`q��6�b0+��Gxa`|�	0�	����ay�A�,Ө�ґ�ߟkfL@;�@[��v�G���X��� ���6{t0D�:_��h�U$�۹|kS5�!z)�z::0�^<,�2��e��l����$���1�6:���;��@�6�����I��P���1��E��l���U���%��1�ݭ!X(A[)�Cjx�U6@�9����D�UHO�:��^La��|@�L/ $������H�1�<�����8���t�HV��y��q�|��`��L:��uF�գ:��L�dV���xr_]������>����x�Z�pX75��ћ���.�wB�Yx�����;��H�	Ƣ��'+���](z�!&�"�y�$f���ǧ�J�WKT�����d0�	�#�|Ɓ�w��~�	5�I��lb#R��j06Җ��=��!�7�RD7�3�*�g��=͗�����=��I�gdcS,G#(�hD�$kИ�E�񄒫D�!�4�UqY7w��iQ��*�?�9���Ç��Y���+ҹ嗟_Ζ�ˑ�Mz������ǯ�>U�~�s{�v�ǟ�Ѓ��gu��������U`�������O��K��P]}��>W�����X����_����|e���U���ᓫn�B    �n��=Ɵ����#��X�O����O��qS	�r�~<d�ã��qߵ�g��k&jV��@_��c�����rFrvh,�������
��Ď��>x�l���&���|��|x೺y[ݎ�@j������x���������v�\i���#��^*Z�|?�7�
��?���V-^W0�7'�	QN���f���jPM���Oo��jV������d<�����m�at��V6�)�X���:�v(���K�G��F�S���
��Ul EH��YVȶ	��
!��S�
��tۆ�kd�]]w�Nl���\hܜ��a�^�a3��N��I��(���5#�9fz\^V��O��V?�T.ߗW/�2$ma�Ǭh�`EpT���U�A�N���X0p�Hk�Ḏ5���6��\z[�+��'כ�������cEV&e���|����:���N��2��+xU�@F$�5΄d�w2s�!�Rz�*�:H�1�T3J�ݍj<.�uY�Fkg`sa�"�˻��r��C�Q\|���%e�B��o~<�bʈ���)_��/��/���1�� �N��ђb ����B����6��O2Y��ȨV�����<J~iyn������ȭ_���%����8�==,�\��_���V����c���[W![��K��MH���:@�N�{i2��IHʛ�B�ֺPH:�d��gu��?��>C>�j�����J1o�}[�<Z���^�]�(9_�����2�������b���G��A��s��5����;#J�̾��-��c���A�������? <��U��/�;�E��ʸLAOH�ٱ�r��G�o��`�5 ��0�������r�3�����n�W�IK.�~�Af3/x�4��9q�q����s#X�̲ݿ�޽T»�k��u��v�ouw�����߭+߸5 Rٻ7/�읐���f�ĩ$���<(�Bf�e%��1�x,�v��䡺�u$F�!�ޜ��ww׃a�Y�p�8;'$�R�|�<��p��؜*�9�YH�=r�P�X�Ŋ�bE����~��E�z��I]�oĮ���� k"x�@Ѽn��M;���������6��MZ[��L��bcA c\/��?Pe�?Q����v������9�\+hm�S�@����@-Zg@�sl��zN�৊�u49pV��y��.i��י��,mH�bzs7��sq�QK�ǓQ�{�*M��*(��/K�{����	����������$����?LWo�	�r��&� �2����?����pҒc��
Z���Ixm����,�>J��y"ep\J]&%Jl��/g�������B�7N��ضU������a��_������I�a	�LS�UL&+�(�-׀���0R�m֯�8p�@�TjN���G|�u����
�7^X�*)\Mg7�.��}��u ��\��[��Npݫv�]��ws�SX=�D��.�zW$=�4�W����Y�릍$���Z*�6̶]lu��W�
���E:s���|A���h6�������l�X���U�*�N�R���
&��#x�e"����t���9x�����9x�o�i���Ao\N��Fa���oȠr{1:�K��/'�� �3������`��_��5o.��lg�M��Qu�5������+��DXz^[�)Kt�]��X�2܀B�w<3�b����df������5A-"mͻ� �hᔦ��@�SX�꽧�m"�(����nr�*�e���;�f�Y�i�7�JG{C����(l8��`�>�.
p�'�K�`(DEnX�)k��b�� ?�:�\a-��B3�����������G̢�GG��z�q�8 S`�#��3�Gfl���V\�$���lؕ���惻r���Yy �ʎj�]-��l,w�'̔Q�kp��#�t��&�
<� ��b7�*�YvO�d�ԃ��[�K��/��E�h?��L�d���g�0F��	��!�W���]� v0��Ƕ�oR�IGXN���5v�%�g"�`�3,�)^�{f�d�cvH`�����}o,I� ��v����n����.Eꈢ(ܡqw��v|s7)�.�����`�i��vw�}{]�a$��=W�����)��z�X��^`��?����$0�֑����K��â�RsV��o�W=�UuX����M�&�'����J4\����n�`�^T��0'@-��(#������q�3��AL����A��������ƃ���'7r(i��KXC !�Ö�ן	��vxu"-�g�-���'$F����x`H_�S_`�g��-�aϸ& ����$�<쁅�ʮX.�7-Slz�㑈 �`L�$��CV�Z"Y�6)�)v�<;�i<Vڴϲ��umX]�c� `���vs����Qj$azO�5 uP�,X �c����B�Y�%l���/�E�g��b��^,gu��-�p�@W=�o2���ǽ��;!�3
���9x��/G�+�S&g����s����q	9X�O�[=kt��٫�����ׇ����aл�� �q�@o�s\gi�w� �R:�x�9�B1��o��@S����͏����/jE� ��"��m���KE����� ��[lou8S�Q�,q�=�j�5TbJ$
�;aJ��ҹ���DL��]���ޭs����0�%y�J�g����LO@h6���%i\P�ǜ#Հ����`m&���?߄�#�a6@�y�-�>>�����O�իU��Ћ�@���LC�h�Q�yv,(�mA�H�)W��q���#���v�]85::O�hU���@/`�12�2�
�u�tc�<�`�L���q��k��9����	��ǿ�&2;�91�����+��sAe}<� N���<z!��E$�f�s/�`��L�(�KH�y��>���᢫(��Q�U�h��P��n�zr%0JK���<�A�F�F
�/���_\3ts�wCѸc-��뜇�U�*��Н+���Ap=e�`g��1K*"�md�ꤙ�ޘ���.ۡ9�2��K���I�Xp����,V5F��0g��n�ɓ(�%�Isc����t9�k�"�b�o�`'�8\���b�P��ހW�����w���O�#2`>�ǈE�-U� -�k�%L����W��)`�ݮ��w{VB�W���l�R�a�D7ʹdx���w���yf`zt��ekh�F6�o�-�V]7�p�e]���"��k��w۫��~�$+��zd 	h�Kx\���q�}{ҍ�6���c�=�C�r_�V�-�H�{���*P�x�I���Ya3�SVI���{�U$�*�fk6Y��/��Ͳz�1�7�\�61�K�������Կ*��X���j����>p�b�r������ǝ�]���H�l9��o!ș ���ا�V<.gXŦ*�G[��}��*j�9h#O<�@N��AGGH��Ȅ���L��Y�V�W;������EX��(B���M�v	�v�!b�TP'I�($7��1"�f�Xp���0�����R+��4�0UC��Է�S�,r��T��nx��a�,���q��=����#�B����g�Yk�#�	���I��) Vn\(��bT�}�2]�����F���뼳�ʥ���[���x�B�g�����`�	�H4�ƕ�#7<+��`8�ޏ˵g�?����&p�i��.o��%�fu��%+eIg�9l}�u���yw�&�z�!��I�$���a�oT�Ig�v�D -��M�%�)�j�݌#���AW�����fS�d~_J�.f�����Ϧ���������<�0�l��nG�|yr?��_�^�k�-/W���`� h�f��u�ؒ�5�X�cw����N�&��h�0�{"��F�^�A/{m�4����H(.����|�9G�8���r�\���͏o�l�Z��>NGu��Z4�SD�F�Ǧ`��4��
Y��De�<%��, ²���^!������uu>�c)�fP#X��`8��wT���xu��,׵������������c}�T���?�    N���`q����Rj��"��/7����(_=�Dږ�{�eNN9�Y26*�8����<�p�J^|�:�rīI�no��~��Y��p�^�������������G�I[���@j�*1օD�A ��,�{�	^�1�� +����4��rd�_M��ܹ����-8F;��w���w=�Vv{��""B���7�)N﬽)�3	>�m��hi�ɉ�T:HMɜDE0�bt1�C��bX��o �V�8XylN9�GLRv��H��Y3�w��]�k�����-��|���1 �?.�����cK,nƃ�r?�@ҕ"��zG�Up�|�9:<W��N���	��!�rv=�}�I]�����|<�d�ʺPe�w����.��w- �&`u`B��f�l7�Jj��Hz��O �l� h�>1�"Q��?�P˃�4 MY�%>��+��$�������1�[��dF��(L�� �fx�4hyVWW.L&8������7���:�	��"�������T�͟��٠�L�s��C�Q��� كҹ���N�zδ�Y%�Al����$dp7���v4X��}ښ�d�Q
����LD�G|��ox�"����3�� �W}��� >a��`W��r����� A��~Dv�a������?��beU,��m&����~�~�=H����/����:J�R�/������l��O�n1��%��X�kd��q,�ʙ���FY6����T��
�`.�ʦ��!�}�2��������{��Ar�������W��[�����-�Ēq\��`��[:�H!O�Ρ�w���A�d2��ĉc���͊E�"��6I�2p7�`s,����R9���D̏7=�DX�Q�%�m�]��ш�@�H�rP��O�(��dCk3�qѽ�D��:�)�l8�L�+����Kg���Ϡ�	ܼA	�"ƥ�<SBO�'�B4��v�vR�� qX�%���]�`_������͠��p�:�#��'���m��,�[�I����m�[���4���"ƌc�I��c;)��a�Lخ-��O�jt�Dk^�T5.w��.�Z���1��9��IS��*�,,,#����,(�� �_iܴ���~U�-o��KweX�q���Q�W�v`��3�:�2�uL1:�u:k/=2��J���p�`%�U*4�Ѿ\��7��n���>R�����+X/�
��x%2^����b�[a`�g�N����?�WXX�e}��(��%���q��v�����q��9��=X`�0?�u(�����(ʟ]No���ܙ�� �i��W�Z路ЗH�j0�΃-�wG yj��?�Q�$cu�b�ת��]\v�.||����`=X��0\R�`iF����J)�3��e�GS��9���gV�LWݸ���I}<�@#��*��P�+F1�S�#|�H�̽@�T��� �tt7��"N߻poI��_��n�l��t���Zs�Ut�f�eԞ��s�Fg�$!"��k��ey�%�b[�g�w7���Bv�mn��퀅 �wH�_<$�u�����FX&�|���G��ᢆ�N&����Bs�x�k )Z�\""�ݘ5���8���1V��6	7]��v�CM��E�Ht!���"�5��$p�g4g�����H�͖�����V(�C���=���d��_n�QN�k��n�[Z��Bw���`�cIX� �;S T T��N��T����n6������2��o�ٶ˛����:`D1/��=�D1�'�m��G⦠��\� �+Fa�)Xx�I���*�c�͚�3$,w&(�nŬ���Hn�4��g� ~��D1m�w3�0���FM��]�X�^���#b�n�C�4I���s�<�*�|s���Pt�[t]�v ��kn���ˬ�ڻW�ԓ=��Qp��q�G�L�:�'b���z'�I��dy+�����e�FZI�4��_۲��<�����.��5�,�-�9q-�*ks�:��g��IC���a2�����>�:V,k_r�}�����x�.��/�my`|��z�ர4wԧ�Td���Z e2�\��iS�-���uH���Fw0^w[�m'+��K��󛉣�ʯ�>�b�@���'��Ը ޏ���HExfX@d�M���T���ͺPɪ��]m����.��������{���F$,��d��c��,K9�/�\pk�
�I��iWž���>�Y���N9���Fk��2�u�P$&���&P�d�Zi���A�d1t��@wd4�ݬ��}E�;�(z���7�����͢�U�Kɾ����s�*\�:J֖$E��@�'9���������gƝ�&��t�Z��S���1_��I�~:C)\T��t2G�ltqu;���h��>Bc'� ��z�� f<����g����U������{��ao���(�c���ƽ��Aˉ�|y;�ކ?i�ݹ��>�MQ)���s�|T!d���0c��ܵ"`袙�<��|g���y�q�&1ޓ*�pZb̑��jz����lz��z-E?S�cRk+�t2I�	p��%B%
޴�a}�3��e��/��:���M5+�9�J`u��3�����j�����ɧ�����������8�dn3�`oI���8�R,+�A�y�p\s-��\Ea�k6	t{�/���F5��p<�ҹ��P�7�]+���|��x���wo�+~��%��
HXV"��]�H�B�U�� �h�t��)@'������G���=|��W'O�@_ލJ�]�C�K�W]��z'�|����:0I���0�۶:�z?��%�~�dg|�6�(�<6Q��hb�)=��'����
cq��������m�넏�}�_���;��Wߋ��g1c���k�&�I��� ���'F�u�E�������!�s�+�]Q
\�����`�e�N)�&cUA4�	G.��`%a[��;�m����N2����^������Z0Q���Z�����QْU�gk1������G�Yz�I�ِE�K�JVv'����,����Jkm���5��m>w���)�O�כ�k�����a]��l�nɰ���UP�/Q��OX�Aƀ�1\h��Q�xV24[����c�����>'uKF]�����]5���kZ�ټ!�mB	���~=�-�Z �
�Q@f�S#a�iN�2YE�����Dn*��J2M$|�6p�����o_�9ZыѰ�_ ��̆�2���'v�HQm��w$îJ4	�x�R�2��`M \Qί��)Z�yO�A��]�D��m����w׾��/���);繗��(eJ-�:�d�����kv1nD����8zy���_����7իb�:����8�����;��"� D�@m B$$�����Y���q\�&�^G�.���b�t1^��^^Կ�(~f������_�3���u�Y73�$9�{Fv@�k�4e*�@�x�1�zT�RYNQ�G3�B�D�ٖ��u�yZ3#O�%ql5�N��r:�8�����F�I-�[/*g��ē$Qj���_����A��,rY�Kǲ���o���Z<�#��7�)߻{:S��F��ҟ�j����s�`o��<M�8J�Z�ruc��ˍ��u0����|��81��P��_����g�����g/���� ���r�*Ѱ��y3.篫!�_��H��ݛ���$�Xl ���C[��3<O !j�|�E�:�1d�b6ҁ�L���	'�4#��֩Z��5w�5�~`�'�	�[E��]��I��,��\9�ۊ�M5��zC{x~7�-��- Į�6l�{����e�@��Ś��hAj}�y#�l��r�)VU%�j߽]k.e<ҫ�T�; C������� -���^Ȥ�3ɵ�L��Cp��x�!�C
nIId�����m�傇n�0��=�ޖO��P���_���O�=�S��� ʚ�l��8�ܸda���%�Fxg�5���i���������m]���%<�ߍ��W��%��G�վd�_��4zagb`�O��@�`&˔�����(�|���7�Z    C���&7�[�t��m�őv�Ka���|<)����{������L���3,���NYS�o���s��ĩd����US�7I◀~��͑}��y��S�=�܁�V��|¸ex�!��)��hX�DyY��R.��1��\�\7�
��I��� �B}-��	�l9ra���|���X-��Vg��N����Q�[�����r���k#��d�pZ�ka6���ѳ�
�1��b1�mTΠ/ ���V��^�N�}#/�N3��X����u@��uώig�X�@b�d�����|��>8)'#u�ᆌ���ߗ���f��u�+X��z��j_�<����ŃQ3�ˉ6X��!y�H6Z- aޫW�)��lfp}5��栞7l-�+L�,Uc�+���P�I�=����ˁ���H�	�15{Ƣ��H�@�k���ަ#iF�L�{���̮?�K�p�����	��V	�� yƏ��~0~�WqHJ3�wMq����yԺ\�) ��>����!rt}<:�թ��i����3�/�^�̴gD(�<VJf�1���1��W�ѵ��ֶ.����{'����R�ӇҎ�诬���J��QP `�	�ܥ�O̫�ѫ�ݼ��}��)�wg�_9�rr����j7a��l
A��(���|z<�vn��f�Y���`��U�W�/���>|?�͖�Us��W0��j1F
s	�NvK
�d/>$<�k��N�d���
y{@�Ҁ"�Ic���\�-{��<M���2��k�}�vA��v,�~��$�4q)��^{K��Z.�F�k�f��������� �ԫy6��W</�+x�Z��ӂd-�S,��Jy��X?ton�O&���@�*c�[B]'����S'�k*U�ƈ�ʖ*=&&����w-����O��akAX��;�]�q��<�p>���G�/�˰{B$�:����/)x!�+�j)d��?��b���9�D��;����ED��s9Y������1��m�Ę�9+�5�)a	,J����mzN��pVJ��0��P�m��7�^�Pǃ!��R	�ӭd� �y�|�A�Ҝ)!�$O>qd"I�ZFgT��<�x.j&�ɳ�����G�O�X=~��O�{�~"Fm� �"�p�����L�e�г立��.�?��> }z�9��M BG�,s����j31fe8c���}.�X�ϗ��])�.F��Y<�?��z�?o0�I�ie��$��y��A-ɐ3���%�����+����6�~uw�y̻LJG�^a �����3 WE�D�B)& �1��̴6�Y��(�h�4,N�|��tJ�����.�ʠ��6 ��,�df5f)む׮��G��x���W�����˵����J%�5Q���]Η�H	�+��WSow6������Z�;#ٓ���~/t�'_��9�)������0�8�벂��mb�*�x~#�`�9 u��3�.�%c��|>�D�/�u�8�{X���G���5���&g�����tg4e�s���<�]��%���D=�k���`���$a��Б�tb'm�_�C�OB�`�#h���A�-F}�1Ef@S��ȶFP}�����+����qwd�Ѧ�s�/(����U((��i�AGF�]d�j����qD���Z58~���5�/4�u�J�:��S�t��S�?�'�
��Q�Ld���A�VyP��Je��aTI͑8P^F����z��.y�����l�����58o�"�_���3���FiA�4:P&�l�����˛I�$?^^�n:�!�N-��j��?|�t��WGs@D���ds�*d�T�:I��uJB$Uʁ)�W�
p�xrX�V�0����v
��v�,9bzӲ���ݯ��п��d�~a�Ht�R`!Z1p)�;�$1��v�s�����U����W7@>��|9[^��k���۠���eF��L�R�5F�\� ����z��^��C[Y(?;�>��Ϯ[�r6=�^����������>ǐڸ��x&V.�`��eԀ���am����ɪNd����̟U~*��������==+��=��ـ��`������%(��Ǻ=XbT��{�bk;|�r�L�a��Y��9��v�����>_4����G�7������g`��d~Ey�A���x'����"�{����S��n��H;�putB�3M8K�R+RL -sTX�9j `R�Jʓ���J�Bp���e�����Ƶ�U��t��������[���r���x\��H;g��U��z�{O�,u�S,�32�((14g
(Zs�c:�6^��^.G��l�+��w/%��zy=AN=�%��>��S?��}��۠���xb��LQrd�
�2���:1�x��!��7�~Z��X�� g\ �l���n�/�,�a��4ol�^6};�������� ���W��R(�3F5I�%&ݘ���2�|��|����u�Z�~�sR�8�v��G:8��z@�G�n�o��E�y
�dj-���$�nO��	���>`c�eO�5q�_Lj�rp����T�3ƅ�L�,�F%͌U��������t�h�^��z^��5F;�m�@:󬞥�3�`^�����Dl��׸�E�C��v�2���@;dx�ȋU��sI�Ko�'��祳Rhe��R��yAKa���I���F4�VP��-�	 ���ĸ7����% ���w�+��[�w���=v������H�� ����]<���ۺ�$�f����|@�	����b�49K��E�=�R���?��dp�p�k�8m~�ǧ��ͷ`�"��9�sB�;��"�����p�e�5px5����8��x9Z=cy?�_t��M=�v<?]��/ "�e?'�z9Xܼ*��5Gx{ӏ�C�����;�E�N��=��?3Ж���j����xD�|�ms���F�x���6[ ym���
��q��#��B!F6�A�"��18Mk�뺤�h��yB�-�kN	�3�G�a1+,kZGɜ��LX���B����7�����Gu���Kz�Q}������R�����_���7�#��W�nVa��3;��gÇ�}[���b�p�������$�����V{��}�@������cu��x����C5O_ݷ��}������/0��j���OvU�}�����<gD�.���cR��om9�A*��ͮ��d��ĩFRV����@_�(?~����?��Y^����1�k������}�G�������&����X]�7�e���~����y����%)��1 ��^;�#X@;�Cp0F�a������]�_�(�����X~Ƈ�޻6���z޶&~�і�5'��Y�lP�"Q�޵!`.��Ai���4�%,���gX��o���������_����?ӏ�����:w�����q�0�j�������)ٹ0?�c	�[Ƴ'DB��V�;��D�(��rʥ��g�Y�1����A?�:�e����Tw0��C�V��=+��]ҁǝ�yRG�B��w
T  �j��	<0�Y$Vp6u��`m��]��Əo������$���+�`K?�w��6,��-?aI��KF�~[9���Z3�Iv��g��G$*ku��(���c�=|���ٟ?�����'���������u
����$�M!�͏������f�,����[�����\r��`RAW �����3�K[a𬖠?��,=���E� ~~�!�������աI3傶�5�C����[cٳ��=&���uIH�V��؁z �y\)
M�K��l-1��kg=����)u���T�� V�Y�AG<��|O?~���z&?��?��w�|�VX�;� �&C��+���g\-[f�]�lA	%X���-��Fj�r�aH���+��$|c���~� ����3�G����n��_yXT�o���qM��ť�w���1*�i��2�����x�^�]���0�O�A�>}}���z�����-`]*�(�}H@|�l�����J��h    E�d�,�I�(�N��� oy�.Q5�����?�"�\�k�TM`��-���f���Vsx?����/����j����o����Q�n1�VtCR���	w� {=ՁkB�rV*����1$SQ)
���(ƍ5�`��??w���������%���S�X����Ï�e\��܀��˟0��)�z�R@��o?�Ya�z�LI�L�3<`
��� �bF��2a�GG%����}����`��/��v�qut�=����\���A��C�	��d�����(r�+6��o���2�~ǻ��%u�as���j�����
�����?� ��}~�V�g�#��?�+��s�$ݏ7>��>�pZ�f����p�RH�Ӥ��R�,��)�a��G�u����mu��3 κ߿���4�����G|�ʸDw���_�7:��X�4�
6&� � eLF	<�^ַ���(���_ �V�j�5x�ng.��q����i�K��Ir��۾�ddu��YE������ ��`�C���7Һ-؜Vm��6���d��@Jf�(ɹ)3aI"`����.b��������3�o�.�f[F�}�#�
T2�ؐ"K�n!�[J�S��7z|�����_�w��vO���~�<0�~iA�`I*
�� c�pb\ж�[&�Hێ�ҷ=����Fֽ�Z	����\{�̤I .	TPb��| 
��k��~P�Dh�g��au��j�;@�� y�?����Q��i�$��n�e͏��ض���������p�5$��v�P�a)��`�@<�:�rm��}�����o���?ӧ�
�����[�?`�?F7X�?#��_�������W�C?��	����eLU�#o�
>�{���������jf�K\I�o4)j�ct�� K#��bJ��*���^����$���*�2�D `���r�\Q>7��`���'�q֕>OكLn��A<���x�/��mRݟ?�IBN�M�I�7��< E���֙sѬG~�.��ܽ�͏�x_4�[��p�ֽ�L	���<2�3��z����N�R"x�B֗����x�p3�]Jq(Xp�k*��=� \��i�'���.Z��?��g�c �VRژ�H�U�=�`�,Y�\`o�m���v2Ƃ�Y6���*hq5�./��ƅw��I��
f��͏�hKiȄ|Jw�eڟ¥s������
�1�(@`��N<#x�#I�%�|
/a2�c̋j��`�ď�w�΃{�-U/'W��W��V;$�k�E/�2\�s��&ض�PBIEغ�x���Z�V��h6͑OtYs�/��*�D*��c8"F��������N!���
�=�~?I�0���Օ3w��1�R�d}�B��odĬ�2}"a%|�_ �.�?\f��t�[X��Mxv���) h�k<��"�/��qO/����� Eh���E z��t%�&�}1������2���a�����9ӎ9����I�'�x˰P�!q���R)�$��Y�M�o��X���b�d����7��dr`��|��t�`G�7EpB��Y;�?��Ƶ�K*H�6� 2��H#8������g����c�����d�qp�M�N9
��r|�Ȳ�<2,�m��g5u��x��{-q
7_R�D���?4��M���=P��[����7��wL?11�nIt�9����Lfj��x��w5��|\��՞�цӲ��_W�:���J��Z���"�6i�T,(o��^f���F�I��`�@�SƱ��U� :���VW)~W �g#��`q7�A�n�N����2��x.�젪8�"��}R��)�M�EK44�����z���<n��؆[��C>�fw�5�R+.c�&SC4�X�H�us?�w2���
�B]�P��L��/}K\�C�xo5�"^��߯~o�����a���u*�pzS|��q�E�Wg���_��Q��;#M����,*�=K>;��/P�^e��3�o�%�eYgk�;E��>�����m�E��OHSLkef ��M�ͥ�c�J4b2I��P=���bi?�����[���	Ի���K���}�`{5qȊd�x,��fF���rn�`��`�2�hEw��P�L˛��vI�����Pd'�y����2������q��`�%DnO��ᠺ����̖<�!�vj������M���p'$^�{B0�/�Br��	g���V��`w��J���^M}%**e�v�ǵ��o)k��`�� ���+�t�`lc��0���c��� �R��	�I4�=�C�G��V�k��۱|r_�d��I8�H�4:� f0FG��`�������N�U�f팁Y������0���\+DBM���c2[d�S*&��֝�+�������0�5{���е$��́��s���0_� ��-�:ð'�$dJ���j�)͖��]lh��4sa�lǆ�v=�t;t��3�y�yPS�u��҉�d��c9+nH,�pL�Yn�ff�!>�œ��b>�"�7�EQ<;A˔�|���vO�N���D{���YP��:��N�}g�P7@o$���E���f� �m2��^W����X�9x;oV�.x�e�u�����}��Ī��ѫ����<z��y�Z�Q��Р5��s�>�t2��˼'!j4g6%~�N�b{�_%u�����w�Ç�����\+x�����z`�3�� ��eY��-�.TN� v�%Xa�y���-	nƖ_`�X��H�\cP,�5���4E���q�.�q�J��ۚa��=���m?�p��� ��5�8�#5����X��&���|��\6��R�b�l���,pC\�bv"[�������;pԋALJ�rG��Bx� �Q+X�<���	H��x:S�$_��{x3ݹV��qW�@{�D��u)�s�%L-u^ʘ=�
���Hк\��ͩ��4����p��CdSX���b����a[�� �R]�TO���(�%�lM��B�&'���Z\VA̻�&�tS'�܁�����'�t��B��q;�hgt��/���_�q�f
��e/���k�<�-[a�FY�R%�� 씯Bs^,;ۀ����u�î��_��6����6|r2��0�%ƍGf�@_e$���⦔p����/%'c��������F[�w��*����t2����偹��EmN�X�i��+m���i�3p��Pu�?��Y}�Ut�Vb4�m|1��k	X�w�Ƕd~�D�I]@ ��؂�ÂA)!�ј�H�f �"�"���*�.������f�؟T�ڴ��h�Y�����nR{�kku>�ߎ�Ȗ��	_�f�U�J\���\T�����U	=�G��{̧��@�uI�}ߣ�t�H.9�HR�}FO�	��/�rXU�[�ꂞ����#�C#6�e�!��9�p���T�Lf�1\��:� ]b�d�`�W��6�?\�^��.J����YN=��>H돧x9�9��K {��,��$#�\�,Z^�h���q�l|��#֥ ��sn�/|�0zG0K�ٶ���N� �&�A����>),AN���ri0�5�agLT��s��Rnl0_,���t��ޖ��2��Z���%�4LSc�@��ـ4�$�`ͯ�W�,�:_���;�y� �:�?�����Η�Q�A@;�� ��<�\{��P�c�%8cX�'�5
�dD:/`gjX`�lY׻y��Fv�ڎ���mx���YPJ�`�8�����))0P�y��^��t�;Z���Ug�Gx��t��<n �'�S���-�UU��o���B��j=��J��s!b؊v<seXe�L��{x���:����&!�����������F#�"�����O�~�6U7�I��~��"ڴZ��Gѥ)��x�)�u��<� ���#�ј�K��:-�������__?��H��;$��{3�_��}�`����,a�!�J�sО:X/<�J��B�'&%�e4�	jb�u������L�b�t�?Q.O��    ���1���Y0�X(��	D=�,���)(�S2د��|�Y/��Q�L�<����Q��#��ߎA�ZR/Sc^e^d�4�A$r6q~�ׅ��W��L����X\�g��1���^��]�/dUu�J�+��6 ��+����u�ބ��� b�y��	�;� :�A\�r�\�m>����sBo�k��デ����~���bsO���z�{M"�%b��LϬ��3I����z���bV����q�|�>��_�XBu�$��a�a4�����\�U��>HL1,mg8&n���)"��D\�oa�~p8��7uѢX�Q�j��C��K����a
�;rj��̃j����b`ƿ�L�3|�>r�2Ɍ��I0Ev�f�����M��C�@��F�6���R��j� Mo?�A
\*岤� *ӂ;����I 2�	G�����;B������l�*�4�'xڃ�`��t���.�'>~7��mR���#X���Ԟ�7J��� c�|f'��Ǥ4KNM�܃H/�=e>��t�ut�|�����.�B�b��k_��'�)���r��{!2K2
��y��/�A��1KY�ʦ��`�6���t댌�b�\�e�m�L���C\���ꓺ:pG���E���@"FcZ !��،���c���.��,��K���J�H񬗳�h�<���XJ�=��%�a9v�ƴ�@�8W�&�� �(�Z�h9�g7�^U��~ 2-�����g�#��jկ�=�+;>�{�6́R�։��u+=L���]Ī���(�}H�1/o�/�K5���u��i[���bPx>�U`x;Ν
�(��fxҠ'��B8YG�YƛM����h>����	���򼎙��ś.U*�sX�;AI�;����3��B�?W������+�R���L#�w���h��px��G׋�N���@~�lN��竛#�/���Ya9<�ޠ��%7@z�c&8O��g<��f]cfr���wK�W�����"���N+�=�{-��\Gam�>i礠~.!��zL��c�M��bp>���_,�h�v�V���'�p�[�<.$�׮E}�a�Y��'qW�b��H&R��j�<��4��vTb)$��^@��A�����<��5�4Ls=��Z��۬=�R����o�
��qr?�[�o���������`����GÓ餔Fƻ�)b�%!�v�mg��:�	[@��L�
����b'%��� ���k#>p��t]'��G��D�����8�3��~V��Z0��K.ICr�� "����$�2Т�&��7#4���b�˲w�� &�w�A�ع�]����ܹ�����g�վ����PX�e9
�ŵ ���� �����'�~C���J���4�+�
���:���	���t9o�x��j�,��w���X�i�V��"9`�$x��L����8�1�,�e�+s[�sz����@ǿ��X#X���g�͖�8�5�k���+�d&��/6c�D���"6�ob%!� ˴���=����Df��uK( ����s��y�P��S�;��f�5%V�מi�3�*�(�l3-G�l%yE�@�W��*҇�������Yy�*�AC�"�h̔����l�F�}����v�Nӱ ���p���쩾C~z�gk�f�0̞�l@�٩,��qtP���p�}��\*R�ށjv�@��\����P1鐳x��L�A(��ȭ��d�V?�S��w>\|BN�w��h1�N�g'է��C����YSxwz P5��:>h��Sa�L�;	OE+r��+$Ad�v�:D�VK�W��'���֣>��mݧ���1�AsQ�N�R�D��.k�1�L L�`W�lcw�g�Бw�ʻ������F�Y�22��o�cԃ&�b #9	!@��;LƁ� ���+��^0�ˣ�N���tv�n|�d=�Q2[���H`ٽ��V�	�=L�iT��3,��DU����I�@ny�)��ʫ�VƧ��1 �?���m���w��C뭶c@k �w�5І�^�lz�:���x��S2(��J�t���=�0�o1[�,���c:!J��=s�j~���ߞN'oW�HūSԥJz��
����i>yj�1>�{����:�A�7�d�)&B��Y��I ʃ��Q�ul}Ř�=��/h}@:�iP71&
R;z��7sVB��4f���KL�2-z��-�$9A�Vˏ=?B������a���y��������s�ɣ{��n~��>
��D;���Q��㕸f�:*��1I�����#w�J��������p�^��h�w �ǳ�ף�w�5p*]��?R��l�o����Ʃ�=��3��,%ʉ�[!��C�31s�i���M�PG�,A���&�����zz�hZMz�V�����ZQ���p�<���cо�\O>"�C��H�s8<bM/�W��t����g )�W���%ڷ���T����UG.���j��,yZn���y5�h��Tɧ�
������@�q����Z���cTÑ�ۖ/2Qn#&��	�5�(��xj��eA�5�Α����<��������Yu|ZR�M�Zg���l��hOj �s���gA'7�oz��Rï,�
w6�ޛ(E0�pGRH�|v�r|_ۑ�k�����N��F�௘��dt�	O����g`�ӳ˿X�:n�8����L�����ͅ%���.H�Z�^m�pPΕ資��Yj*h��d�F�Ca����5�]���g)�x���|�ƻ	b��~��m�%��͜Q��L�Ђk�rȜh¨�ީ:�&]��$`����Lm�a���=s�}�m�'z�q$�N�!���9,;�#)+��1��|�<Gxl:IU5p���>��zб+�-��h�<�_+%�<I�\���Pf���;6���q�=Q���Mwo��}��}���sC혮Y7�@��mw��0�:�נ�
絏�{��,R�W���R�4u���������ϖ%I0,�r�(IM����;a\�z[`�k��'�Ԃ]H7?dzB7/�"�J:{2�b�7R;:�.�DVE����e@��w����Ň�9�ǜ�����4�������V:zvv��C9,,e��?A�"C��S�{�xZ�W�3%{��z���hy�$���^�mu��ʹ 2`��t�
�g-<堗eI�a/r�xn>B8<���pQ&��OL+c���w��\�����´	CviC1T4��E0
�df"�tdL��j.���	F�VpH��B\���U����c5���a��
WG���A�s'(ǌ'$��V:�u���|S?�� �r���~,A�!˽��˞�a��"P%���4de&��@�TJNf����X`����vǠ�� �N/B��pe�z2�ۆL‌A����ED�HI���� TS��s~�P�7�lxe^3#����3X	T���r6>+���ɚ���>����;{�g����͗hZ(������(Dt��օ��l��4���D�ʄLT�6���*X�@���͹\,O�L��0�M�P��C�J=��C��ԋ���ׅdP�̌xJ}B��=	�����GDlx�]���YI�P_O�PT����^c/y?��Lm�j��KZe�o�(E���������_K�Z�v��A�a�Y�y0z[h����f�X71���R��ژ���L�~�d#m#9�����ټ��>,��?�	����1�j�d7��{/��&��U�D�}��~gҠ��vJ`�ѿhyR�D�ω��9i���IiS1�^*?�>!=�d�&h��#Y�^h׸& �
�+Zh��7}o.X�|b����q���x�`G$M��/�>	�y�5I����"���s�����?G�o(�s�k8\�����!�<��W�����E����S1}��Ζ�u0�z����b>9��6:��D������Y��a�-���^!M�l5��k��_�N�?�@l����+�/0w�iu�'�t��w�E�ku��]�ۛ�0��KVem��!    �H�Eo^�G~C��q�Y`L�#��7�;Q�R�ŧbq1���̃�k���L���@��_;����"�N��(+x��Axs��P�M+�{K��G,~��:j^�ͦ^Nz!�t@�������w�3a% �1RG0�D������>�b�'�{�5�nU�0��ʦA�����%�-�"�����w�qY��%e�&Ut���>0ߋ�'v�y��UϚbq�f����X�̦�b������k�a�@DR�A�FϜ54�v#'`�S��o�����}!_X��b�Lz�����S�ì�G7�S�؆DQIP� �S�c������mx���E� 0<�4�kCuI���>v5�t�4�=��1��&셺�qh[����4h?�C���o�xY�j�ؚ����˫7�3_"��~���B�o>8�F���������\�[������	�A��#s^�n�nl�1c�^� � k� (6������82o�p�<xq�	��@��F`�w#0�����x�ת�)�v�_�6� �G�S�A�, �̭U��+j�@�r>�W�9��09Y.�i�l1>����3�����WD�X~^��l�6V?s�[��d�p�O�q|pS���h�u3=����|y5����-������t)�:I��{؛Ľ�ZZ)d@(ح�7\�Vck<��?Ev��5`�� _�kS��N'=3������);O_��߲7��ƽ�xn�8]u�C�)�%��h� �R���ߡ�Kز�L?J����P����X��I_�R��}谑��Gb=%k/��!&,>�)�]gK�3H�d����� UK��O�p�ǅ�Z�dRF�������z96��G���H��˗�xPC�]i�i�lvVs��TA���y�O*����\���n���v���G���&V�nn�g�	������]��^�}<+X�����}h[-|e���5	pkp�4gI�fD�.��%��_J�J4���˒�:6�w�wx*f�����!���_�rN`Q�n�,�se���q��n.���o�K}�b@K��,�4�l�t��PLɜ`�[ej)�%Q�t3�L��^c$�
��3}����m��"z�^aob�._#��񦞟�CKh���z��hւcZ��K�A=�h�$Bf2Y�
�ܷ;\;�G�^^��T����z@���Wt�dxr�7�mk����	M�����~I�x�df��ڳ�)>h~~�Rm��Щ����{! "�+�ۡΛA�*������ܻ"� �9z����c�6ܲVq�s0�mn{䃻�1:�_���em��Ua�8 ����q�c�h�.Jb}Vins�H e��^B��`��m��
l���� 6��F�SB�zRЊ@;�����C��5�麿�.���;��C[�o����A�Ƴ�D*E$�L�h�A�$e ^��-��K�1]W�{��������Wl������^�v�c|�49j�B��Y�*�he�L8����y�p�����A��aZ�h���þ�h��`3���̄�}�\I	��0)�4���޹���-֢1���=��o�Fz���8J-r���j5�N2ᵡ�#`�!�A�~Yl�p�]�ֻM��:��^��+��FwpFW}�v_qE�F����� ��Y�k���D�7"Q�U�3N-4f���$$�R�p�������}�>��ˢ���&MN���j0���Wu��Z�M?�3��iî�1kdb6���l���F����\��{�֢�hq�.B��.|������U�nN��"_U�XO�A�ݬ#�!�;[����	�_��A0�t�e+�$L�����
�R�����Q64Xҿ��R/���7_n�w�ϥ+Q���̗�.����T3XP�U�_� "��\�������ɠ���K��cQ��+�&&���$�	ӅS;΃�5n��w�+א��q���[D�h������?������3�n%��b8��0+&�E�':Ec��&MJ� b��v�����^�K��P�h�wO���m_�ٝ���&�~�;m?�a4!"��+  ����҄<�>K��Z��rq�[�
ۍ�YGl��K~=y7��K;�t�/P<��̦�6�a��E��y������3�B����S�D�Xs���ȇ��}1�N�w5���gAl�d�A/�V����x�d���8w��)|D[��g�v�[����|��q�+NV�����#"Њ}q��X%&o�Y5��8.�8�I�D��y�T�$hx1k'W�k��[�U34w�v�,Fz�2�j2�ޔ���7�y��᭵ͧrQ18{6E���#@��ī�l��d�s����[D�5��Mj�$�g\>��n�g��c�@������#��xP)%CuB���3��-ۅR�Kٸz:�Og�����x���OZ�$��%�t�������7|�[ 	�:�P�f��|e/ߗv|��ݖ�}�x��?�X�Y/��p�@����N�G�-�ߑ�]�Ϭ~�>;��n�j�v<9[��GN�������5}�X��W�{^��z��`dC l�,h���p�	�#0A\B��Z_՚W��|<�ƴ�7�F�x�`��ѐ����t��:F��-��9&/ى2�A��D�L�͠�d����i��h
�F��c�gw9��+"/�k������2�����)�����r�փ�u�#�1�dc6�FR"�P�����&迺��7��G�c8� ����pԝMŵh�<B�׿��$����8e�ꆥf D/s�px��Q���p��]T&jE#a��x�4�m/����`��A¼&jo��t�7�yZ���j���}�"@1v07�[��C�N����=Z͂!h�������e?eE'��t��k�$a�?�c�)�8Z�6w+�'��7�h�&8� �$��o�z#��3��^Tǟ&uָ��1���ﱞ����7>G��:ljE/�VE���l �aʐ�(cY�,ࢊz�����(@ǅfk>)�U���h[�;��S�&W��D��ũ���9Zt���\�0"	�BP�YK�]�[Ύ�L�@��|X+���S���K4�{��h��\G��4@�Ke�:�'�~8D�y������#m0��KH���*e8O����g�	� bn{���� ��[�����][�'�A�����fQ�i��<���� `�'�=O�HU�I6wh�ǟ ��6�(�Q�#!Nu=:�tx6Z���Н��1> ���d���C�_�Cm�fi�����s�*�sL9��Q��A�`�?s�龶ʂ��{�?�=��C$�* l��;��D��^+c#�"7Lb��a+V��]:�>V�>���McԻY�%
��Ň�����t���rsd����"G0�ˊ�0�&4�i��%%�����4Sl��1*h߮���?ѭ�C�0[���;-�&&
W5��%8~���+< ]\��"������>�c�z��� ŏ=�T����n~1��N��FK����EH�g�w� ���b���������}�����}���;B���_i��Ӡ�b"�� $P	w,�*�;Pڈ7 e)0GMǿ���u��BM��;e���Q�R .T�C�И�װ� #���G٫@���ww��t�b����YWG��2��G�f��D������T�D������6�7Z�:�^_�;t�����>6�j�ٰe��p/e�2�q�`���O�+���F�m��_��~Y��c��������a�\-��ָ��5*J�0�?����3K�!1���s�b>.��J���K�(�E���0���S��r�n�������B�I5 �75�f#�p�Y ��#�V�N��^�D�>ob�1Z�6�G�Y��&�ڸ����&r�4܉�`�������_��3�S6hM\���g�����)*O���+S������q�#|];������ w<9-!t��6uq:F��9(���/5�e1X����W�����6xt8�ܕ�D�D4�"����#���&7�+�    p��N{&+9�������_��`�@�\�ܲ2����8ä��siن�ۏ�!�����"��Շ��o���=c��cx�8�X��:1�2�d1q�U���J�(���P��ǀ�aBW���鸐�ϫO�WoV�w�b���q�Dǈ-Qȉ�(RMK� G=
�g4&�J�t�;�0��N�m~�B��M3-�xu�%#,+c'���;�a�4ل$H�T'���p���Q�P�pƅw"���:e՟��c䭀�zw�<�=�[���s;7�&66?��a�o��L�a�UC1�u /�F�u6F�a�D[D�d�0ZaY����u����y���x���y��I����z���`{}� l�Y����e�8%�&��=*"(��j�h�����x�G�̇3$/yS�		�Oq�`��z��h�cѭ'�[ǲ����I:��h��JAYs��T����j��K�%�H�ѿ��v�o��v�~E�w��ۤ\A�� _4 F��(֨���)�F���.�ܶ�śf ����G�u��o�����M���a��	�^��'\�d4"67�v,�0*K<b�[�\��R1�i�`mP
݈�L2�pH?�}�rG�N�&�^�aO #���~�9�S ���YA*�#�~�Nvl�A�LQR���3nC���KT�&sj)ꩂ5�N
�R ̗'��ǋڟ�S����oAq7�?��������1)w�f��5��׀z��M#hC��6X�}8=:����R��aa�&2)6�.I�:Fw�m����V�s��K�!�5J4���`�#
��c|H��Iu���GG�8�p���-�xў^�F����� ���B������<�!r$��sՃ���#RrP��1��l:��9��=��"YoT�M�Y�◘���!v!��Z��cpP���	.�M����2G�{{�f�BҭO�T�O ��~1�������f���	у�F��#� ��:Hp)ɔ��*Xo5Ѭ�3{9J���j��#Qj�wgn(m~����`��%����S�hK%=!���S:B2 9��Ixc�����L!¶�n��h6~_��wFgS�<+OJǣ)^�c�=h����+8	��EH�L��
]�Ԧ�߅:���EG��_���ӭ	|�>G��C*jA=U0�4S�4��U�V�\���0�?eX�Of|��Y�BY�5�g�@�,�'�҃�£f.8�ū�1����g4������%��?::^~�}��<��o��;jX�
��n����1�� �9�^.�̈<i�x,3ƕqTnm�/fK��q��������B"�Ι�Z�_�ǣ��F��y:�T�CT��=�AH؉L9���4I4գ�J��l}:F��է���c�,�h����T�c8���CV^q�Hu�a��I��h��3h�$�cB'�I� Y�4�*�{b�I^dA��7��@g/@M/�0�9��X�czꬳ�ܯ�+����p+��}�p��p�A���+��I��Jz}�389ZbN6�~cw���Ǆ�+cR�hi�P� �e�6؜���0X�X��e6{�\L���F֔��|:>��'�)�f�ϩ��쎘7?b��]w��:���j�R"�EZ$]�a�I�䣔���j�qr��pmWg��&�^L>�e�V@�*l���b\��*�oA,��Z����&;� d�
swF���A� �5�����A'�:5�S/����M�Ȍ��7�&Z�[!�+��@��V�|�~�g�im�����H{�̠VJ��p��@$&�����9�@�?���j�>MΎj%�f�ߥ\[E��ө=�nn7T���;��#��M��So_�������G�~���_�,������g��b��+2[�%p��]�48�aO�/�ǋ���R��j���g����c�Y�AsS*H��� ��(�9�)���"d���˳�J�k�ib���;x~Q_$�A��C�����i��3;�6��(��JЊ���j����S�`�J�P�c�<�kMC����ew[3�����F��n_?��X��b���/�ώy��u�r�	�`&�`9��E��F���\�����@f�\��f��#8��Q#c(���(�����:�� l'��7�P�f���$l��A��R���Y$�>�MK����0�'K��V��7�ϯ��ӓ�pH�$�����ϵ�1%��]fb�i�U����ɀ�\�0#��f5z'�ܼ�y�+��^mJ��p9år::]b��b<;/z ���.~;��;��A%@pd�VYy&Mfs �-3�8�L�4���\�΄iH �@���u�?�C#v������}ӁSƝ�F[�=�S�A�f��66�����=w�UR���U�{����'������[��'�`~����qÄUPOY�l��DK�4ic������Xi��ʐݰJ��O�2��2=��/eWJ��J���s� r*�.�=�\rY%���a�rO�[ڷ���jѮ�-��0��eRj�3� �s[[�`���U��[9�x��M59:_V�G��t�A�?f�����c79�@�3��������/ƋѴBǌ��0�����ul�a_[�@YJʄ�/bu ��sL=b�J��}pOC9j��@'~�������fX)�6��ث�Wm!4�!�Zs!Q\	*\$�
I�T��$ƀ�Q똿ڃrݛNx��T5�ݡ��w!�D{�9�k�cJ���Ҕ r
��Θ�և �r��dŤ��1��I���]y��.��t:E4N���t�	΂��<b�?�6�.vL�~�Lfn�q��7�P���xN����YK�"K>�)9�)�j���6Gu��^�P��u�,ɱ��ч�+�Ԩ�ch�蔂����a���Y1D�(4:A�!@�������`6����k#�|rܷ��G��ީ�ClBK��Y�J($Y�q�j�r �KDr�
̶B�-�DQ�<#�m"秳��e�&]<�����`R&��Z Sտ޻�8��TW:��a�`<�0�;��'
�y�t!ʤQ[żO���������&��� �>\�_�Ƴ�I
M�c�&J@�|<-�6��bͬ�:��=��.��T�Nf]�c�S�i<�)���s�g��Q�̜V�މ��gm��������Ѳ��0l5N��`s�.��U`,j�4�1i�u)h�}^yI�v]��������rT�F�p�|�^�/C�p>9��v�>�G�E�����&g�EIzf���a�^�'Lګ�Sv�.�}�k����Z�w��1���uq��E�I{?�ˌ��(gTA7}�`ݹ�H)�0������U��~_�����*�����l�{�(�!R���:&a�:+��.QP��c1�O���L�T
b��H�$H"��g�����x9���[����|�����h�h5��t-�t��L3[e+�Lp��m��lOc�͏X|����z8`03oc1)�w>���T���p�������Sm,-j)��ԟᦙ����]5z��by��Ҿe�P�>F���ֱ%�A��0~�P
�f6ʡ�<�%*2�T�R��A6n�M��m�xT�G�g�;��A���~�JQJ��NH<x�j	'�pN,�� [�|5*�����d>>A��atR-0&���~����Y� �L�9�]�����F��5���1��KvR�_�T��DT����t�vz���K�Y�??����������<���9h.��Le4���A��"q�%���N<��?'\ھi���K�Fom3o��Ƚ�V:�� zd�s�.��k-�xy��	��;f_�����v�/�p}<���ذ�p�F�F����{o��L6O%���ƃ�z��Z�h�W��e��grRR��>� ��<�M�g�FR�=�=�&b�f�ZpȊbг'$R�1"��$�W�ž[^�{�/��eU��L�0N�y��O�L�cM�?=���o�'�����[�ȓ���3�l�:HK���eaLtQ���@��Р�A�ӊ ��c�kg���h<���;:    P�v>}K���?�����Y
8�Gf���0R���X �+��"�&�Y#���b<�-x����rU⨰��c �P/F%����Z4p�F�a�4��+�q\5|-ΐ��a�?�������յ�vY� F�Sdj=�V�196ƶL���������)H��)Z�z0�f�+0��p�DD�"Ajpma5B� ��	p�8�X�s��.�R�C�#TjW�1�Ah�:��%�d������(2��d���i�'��T��􏠇M��Ǝ1�8E�x��{$��a����T>��W$.<.��H����q�׺ΎaS�C�T��Bd����εr�S!(e)���Pu��|vX�9������^?o��"���-�����"�w΂kN������b~�c�$�����Y{�T��a��-nQ�Hp�� ��TeIE�R&H8�:�[SS���n��O-�<�3W�c��}�7���Z6��l�]9DP$�@�]�u � &��3&(�0=x^�<`f�%��qucO�d�?lo��%�����(��0�icR��}rN�,���Y8�w��ĝ=��5�p�B��w�����H:E)Q�,yr߻��
@ v禞(c�
?(��g����VMxrq�?��> ���p�f�7���muL���`��$����R6Y��d��{�̊$�-S`I��Ż�z?�X��9�o�%�@9��ܽ��>��@��~Ǵr�C�; ��Ѫ�oyk\2h�̸��s�T֓�Yߕ�t�ŶY]�@�s)�'�7�� Ƃa� �Du �+���k"��[4q|Q!��u{mP��'���f���0�M"Y=I���
%�r �t��|�ޤ�%����f��7��w���`<_���ׯzŷam'9����9^���$����+�l�c��� �D�i���V��N �,&�%3j���s�l}����a� IIϐ���i����%@��5Ǿg9������A1��{�<`l��^2��]����ʆ,��%z����^��O������^%��G�x.K�J&5�w���	��'�ky>A��[&#��?U����v�:fk8�"%�]D��L|$8��T甕��(0{������2�aY>�7_P���
u�c�jf�;����(d
�FƲr�0'R�Lx�j�-�G\�'�*s�����Y��f�l4��Z!����P*(P����$؟.(��WGL�JA�������rx^^6ֿ49��l�쟃GlJ+/�g4��f��3�l�,��DrOX��)�
�do"�a�;^L��j\�V�>e�E�O����A�}�w,� ���ܝ�(H�!����'Xa��(�Wk_'�p�Ѓ��$���0�C��J,�[���Թ��4���c{�-�n�"��I�0�wpFE��**�yP�?�]����ͽ��������Cr�jYH�u#
��A�w�NQ�ĭ���T��XA;�^�37 f�	�:���N���^$M���L�2��w���c�V�X���������g�8��رN`�Np�P��$����>B$�O��C��0��II$�sF�=T�CHZ*ǃ�R"��z��]��Iw6'��:{��s��A�?,�=�{��6�M���Q�����V%hY �p��t{Ys���n� W�����C�T��6�<ÿfW"��c��?�jK�0v�����(��䒳��� �b)��h{u�~�����wi���$w{w��d��v����ߺ/�wI_�,^���1�J���x~˭cd��zi�x�� i�Ѡ�����%�(�(k��;;u�~s|y��?\t�������z�dd�@�59�q��i��yزr�~�L�LH�W����I1`^d���<ߑb�l�����˶�h?�w�㗛o��UR E���ֳҬa���I���~;q$�H�D	;7X�iV#�P���&W��������(@'����n����������t_�x�TpdN�������<��^��wOl�%:��kS4�@YR��CȒÉd�3�x4�Y�L#��(~���92��n����H��;L(L��]k;�����18�:F�����i)!	����m��0����L�˿W�d���#����ch�����NDJILN�t���1x��f<f41n۟?����*C���\���:2B� Z^&�$G��p�H��1���5��6�׹Az��нl0�������p�=�Y*�a�'���pb ��l)q��6#��aֳ���G�uw��ٞu�o�fn?�����5�[��<��u��G�'�Ԗ���H}�ۜI�9$���b7�X��	�����MS��OD���rBU�#�륎��lG�A�_��VK�É��L^"fp�Z��wA%n���s�p����byWt)^��o�����P�/����zN��6�`4���Z��p�rE^!M�ɇ(�6��J�@_���<��ޙ4}����d~y�J���;�����u���e'� 1B��(�a�;�Y�?�ɎS4l�)O���Z���O�ls�e��
5�ً/W����>�7x�;�{
���@̫K������E�!k�X#��{���/w{�� jy�.uLݠ�0�D0��KT��e�K�X�}
1q!�������s%����vW���w��
�T�M�_V'�X_��H�IN��@�(l�� &X���̲l���U҆�&?Z�Z\~���К�ŷ�C<>k^���_���cX�/{$.�!��d�=W2�n�� @�'�vW������[��������7��:���#��++����&�DP�܏j�g�-%}����/ܧ����e�Mc���`��,Ę�AJb|��I8
��qL8?���7��_�}_���R_ަo���6Q���t�G��`<��C�0���t]%}ҙw����v�c'��#���	�fu�F�#�R�>�2\pA�O7��������2�U_1���]�� ]��@�Kuvyu�Q�/�a�Lѷw?ҷ��\��|�_����-���y{��tL� �h��&� 5�V^�A��D:�Ab!Ǖa��5D���rB�&�(���=�k����#����!{��=��D0�Y��Et)M0�`�4�a?����U�C��Nz���͡�p���o;�6C���@�J�ê䄀utH�嬂�OHpi�}���/_3����GW�:���ŋ���>�u0�: �AP���ȸf��D!���h1�D(���DI�#����%�$�sE�[ݫ���BNƛ@������|�O��;d�b�TNcĸ�a��gN�*�UN*$^�[�6�F�:��Ѹ~����{G�s����L�����h�:Ӳ��dPmQ���@u�@��1ӤaÃL2�2��m���l����oo����7�c�șO�{���[�"jxZ��gT1�c$/��5���� �H��`�eNQ���5�ɚ�}/�f��]�G�odW9�[#8�_K@9ݚ|��!�/u<�����R `'	c��$㋉wp,�'��z����H�қ��:�.��]utt�����Ǜʻ/���{_s��@��^Bg����������h��&�=�m�8\g2���uL�I�%CU�V9��v����b|���:�o�������7���\����%��!Q�ʝ.+ٷ?�x�6_���@':�� C�ll�w"�@�`�!5�QψǬ��l��4B��83̓av�*�#U���Ű���Ed�J_3l�F�6�=���x�A"��!�gL�>_Ng%G��X��!�b�;��ΰ_0�tAK�.O^�d2,N	�f=��=�w��Rv-ὋGx�
������tL�������	K4Fإ.dot���.)�:C$ �W�-���,onY�w�,�ʙ_]�U���A�K��2������-�b��a��z��N��:���#K�.���u"���u���n��vo
��������A�k�qLe�"w���)�1��!�-Uc���d=�����,�v�_�TG����P�Kz&���n�eA�    �!��� ܹI����?3����,L�����f]d���h�z�T�ǫd����/�}{jmi����V���m@�F&r����_VR*P�P�Z�a�P8�ɽϗ��x�z"�����d�0󫎑]dgGSA�����Quvq��K��O���o�z�ov�a�+����T����3<�HĨ0���/|6��k%pei�-�nc��F��G�g��.� U��yq2Z��%ڷ����� �T�;��2\J���h(��X���I����Vt�amM9W�.��¤=:[�J���ԥ���ZU�+��o���1�Aa�,���pq��" �(��:�:d,��)-�jR������Z�U���m�j���1�A(���<x�� = oٌ���V�,[ЀA?2��հ�3b�_�������A�����1%�O'���^���lc���$�*B�!��J�j]ߛ�_*���
�(�i�)�"�n�'͏X�tT񬮴�����[G42drR��ٝ��8L2�%/,�F��M��5CG�h��	��ǽ������&n��PRNQ��@s����� X��������O롨���;�<R����A�����u��9� �����>r��'�βS�B������\���y߈�����}���҃hO��|��XlǼ	R[B3 ���:f�(�ͽw�� ��!ٽ�-ϰ΍�������QT�E@d�(�<�xK@R�O�vT�,k�Q��rtZ"���~�nBސ�AqLmx2�4���?����v�f�Q>�\�`�t$q����M�N��X��P;��7���Ÿ�}zq;���	1��S��4ջ|L�}����j��#��\{k����s ܰ��9Pw�Ŕ/�� ��Q�`a�����#���+�i-�#K9X�w�����?w�_��3=�����G���Y���#Y	�@4����?��� �����vx~����z�1����(c�Qʓ�#U��ippr@"#��Y�Tow-$�n��F'0�{f���e�E6���c��YE��E���B�@�ӌd�LF#wQ�`��3��n�$�8׽W��N�&�2�>��脣FP�2%��Sd�Q�o��c��������c��uU�7�{qwT��h��H>,n�[�e������
���R[-R�ȟE8�� knx�RD@n�,����e�]�/��ݖ}cC�����&l5:?�&�����B=[���l�-�){�şj�51fX%����Ž� \�%P$��J3�W�ՙ�{@��y��nqS�+�����o'�c|�UA��Υ���AY�	M��$�O �DC�9��.Y��ڮ䇋O&���A�U��8U�տ�f�hi���&��ֿ~mO���{Bc�6(6�J1Rf�%��$)¢��1��%DxN�#��q�n�]L����^_����ե��8��g	�x��푚;�6(S�0�!����N�D�����f�'��^V��5`<~�k�f[ƙ�+�5Y=����'����Z����g�4Gޚ@�U^0�=1�.Q��s�Gly|T-�7�g9�}��P�)��ǳ���I�'7ձ����ك��)l��3=$��Z��?eíq���q��m�"�/������]������W�n�ȳٱѱxg�������m�8=�'@�$'�1��&,zrh�\�R���r�kL���ښ5�5Paf���C���I���ڻ[��
oi�Lp�NQ
f�A��)����x��;d'3�/�zF��7���:�`�t�o���3݂��v:���D#� ���	,[ΉV	�#��b�e�˵{�<}����qz\6�O𶄺��\��c�,���#E�`��nlN:$�ڛ��mv�6����
pUk�e�B�U�>c�1�0&�Мvh:�1!��-;��<�?�J��pP]`���T��C��%Hyh�W�r��/�<������g�򱓸fG4?b��B3���9��3��
 S��蜍����Ȟ�$q@F�fON` ��O����7�����1 ڡ�����cZR
��;[֣���5Ii��L^ܺ��4��G�W��/�=\���W�+�N��~��%��~��z�M~����V�|\{�X �q p��e�p�x��0k5M�F��n���W	#:��)T��?��#H8rw�
��c�&��L�79P�!�_�H�3hͥ2xйrb���r�rj�:��N!�fI����t��g��e�^na��>�ތ�^]�x!]Y��:��Û����bq�vy~��1(�]�� �3�FW; /�v霎0K^�n�ӳQ5�nW�/�~T�ۯʝ�c�Ҏ�J� ��T����I:����D�P�a`g0�p1�	&�3ȕ��8��亜�+�Q�� ��9{BcXmP	yH5m�)����*�"<r �>&�M�ɮ-U�t��A�k�	K����S��.|h�_`��$�Qտ�Ψ]z�?ե�m4h�p��%2�8�H�湎#H��[`���xNO6�o�0���7�"8�����}�	��f����M�O�ŰeMyN�;��@�������T4�*�Dz5?9����h�/���5�Ѷ��f�ݵ�A�5s8oB��`b�'�k�)�H~a�h$��Jt��E���L�����5q�%�ӈ!�i�5�`�t�:�^���j�="v�؈l~��Gy:vjjG�,�e
z��2s � �י	o@���VJ�$qڷ;����o�,t�p���:8���mBĄLT;���>"H+��vM��T��'�K����2k�c��DO�q�D�T8٫:]�?L],��ׇK��g��.�Q1O��{�H�V�*�:��vH�0�$&qwML� q"�kL ��(�b�^������N�D��Q�<����jr�on��lp�a@��c��>�-WF�šB���b����U�f�6[^c�7��?۹�yĩN{8,��i�Cʀ��H5��A�g��uH���r�ޥ���
��ە��zգk�k�9xwy����M�͋��f�u65��mV�]�z�����$S�j̿�c0w)b|#AP������4;��:{s������� �ō@N�n^ ���|u���U݂"��� R ��D�^d��r¤���M9�6ώ�wGh����]��wm�NJ��&�p^y/(@�#2�`���i�V�Dm�i���}�}OeZȞ�bq����H�\�����5���9���2�c�$lE�i��	[��)D�ӫ�[�ᇍ���
t���Ѯbן�f'Im��A��`2㣵S)0�A]K:@w#M��1���:���n=�s��l��g{�]�o+��G����k\��q�dG5�{>hH &E�p�<+n4)��kǁ-	�mʷ��k���MR=�uY}��|�<��-s�����kREg�Õ����z���`���Imm��#w�k���ܯ������5�d���R��̝�<R�U@�Μ���W
�>���{4��T��+���՝{���oR��w�69����?���k@=]��֏�����f��}���_�P�τ��_�O8�i�鮶a�M-I3�e���(�Z���x,m���q�����_��n��p$�y������ؓ�]�?L�x�$	2$$��L�ˆ�m2"+=�"`��mڔ��|�~T�!����$h�f88��;��;�x�9�?�f����䴤L@ϟ����q�x[��Ԇ����O��X��I�� }���+	`.d'�w�頲P�
���>�җ�q�nA�t�����\��ɶ����dt��XiN�f�o��s�����s�Q���mi��G邂s >��ui�p�%��F����[U3@!̅S������M�oni���������X�hևo�ﮐ������^��ķ��[8/w��VwW�n�������g�c��0���)�R9G9�����8i���d�M$j��]j�bB�Տ����������*�� ��9��Z}����r	�N+� �;�Pwx    PW�_�?��q0L����gRAJ��\�3�h���Y9�ל���kQ��k宐.:�\�����զ�L֟��V�7;iWX0��X*x;���?Y/-0�4F�T�&G���%�r��ڞ�Y���&O �lI (�� �`bf�7�^w$Y��6�_O"\�{������H���+x�滦g+q�4%&�T�#I$�P+RCP$�ݚM��3�O�<$��=���Ɲ�kz���pҹ�Ip�O�n �%h2�;���=�����������u�څ�Y�֤��X�kĮꪶ\��#r-�˘���Kv?���W�H0��,�x�)�A�K��yB�bz��\�fүk\��}��y�}u�O�泪�'��������K�~�o���-�g%�N�\�U��G,~����;�5��3� � ������Y8i�ay�D�?������p >�θ�A7�d����G,n�o%�V�5��']�ɤ\����O�0 �yH)$�DIww����i֙����PI�n�#f�`���Pb���D�ƒ��'�H�`��}�Q��P�Gb�a#��������,q�e�C*#2�	��܃��s"�C6���>N���ie�i <Iw�����Ļ���MLW����ꓠL���]f�fU���5(�1��7v�K�<$!af]�I�jǍǠ��a���s��Ku��o���p�����g��`�C���D�`��E2	�yjM�I��9Ѩ��8;8G���9wm�{��zK����������o"��hW��5�� �7�+��7����*GS1P�	�Tַ�F�F'ׯG��������ceH�Fl>�tƼ��A�34d�)g�}mό�xۛ�Mw���w����W9��r���]��j֓�였��a�Jn����i؊*��M�$�L�B�W��9�7%��J=���J�lglc��<����1�A|�bJs�� }Gssp0�g���]� ,>�0���Ip|1]?	�^"^(m��F{�N�W�s혈���I]�nH9!($�Z�>�8u ��V���2Fm�J���X�\uڜ����x	{��:O��:О�MxˣW\[�M&69�%�k��3�<$�Ϗ/S�=���^�++�x�����d��d4R[<�Ŷ �����JP�������C�I����������/�}5���>��e�vu��&	��5v��p���	�y@e%Vy8��K�8aE�N�����~� ���7)@{qg�C4�x���1� 1+��K�p���<�Y|�����YFq�'�������[��0�*U �,�C�x���sH�#{��Jf�W}���u���;�pT�{����j����"��:����DJ�3Y����� ��j�۴�}�����	^�����/w���'u�v��2�z����;��H��L�l����x
8��p��� ZV���2a���3p��f�Z�1�7P����Ę�nCq�#�?r�5j|�~u��0��i�(�9i����&�5�H��5΄a��nze(�P�uй��#y�;��аC���o�@�� T� 1SN=!�X|��?MC�@�i���yuu�{�תֳ��Ç)V(�Q;i��2(��׀�B���������v����g^���Km���A#e�p�e�9P���
�dL�� �
�tx�{��#+�7:�X�����;�4�������]�j|�r1��9���I��UzWg૤�j��>�rC��B�8�Y��!_I�u S<�#D0QEP@�K6Z��)('}���k��)7�	{�ngy5�pL��F������cvTg�-��f���%{Ǧ�]M�)n�AMt,�0�)�+�^$"��6�
X̎�.C.���+��<�J���*?S��4�1�a
� g)M�ʉأ�
m�,JgA!�S
�����olHE�餋)T�^�}uwj.Q@��PZ��R2�u�C��ñD�(^=beཷ=�lxH���1�AcSPwp08w*kk�@)���J����-��R�k�����!����0�t��h�q�k�x�^%"��b�	��`?
�|S-:f�db}�MA�����0�h��Ƈ}�4x����X�"�鹍��=C��<��}5���C��;d'�����(fŀ]|1(b���G�
��i��=?��:q~�]q��ʪ����r�S�j�[;�3��Jk�JN1� �re�I�e��<_��a^����N;u�Qw%�ڞ9�����ꀊۙ��p�_�"V� ���Q"�̺� �'J-3�h�yL����ǜ�l߈�7(��'�k|�Ҏ�!K���4F"@��p2�d��ā��4蝼y���?,���b8�DmI� ����u��ݎw��q�D�����@E��$�YBRƃt��9�|G���%L��_y_�Ǒ����e� �fd+����<$B)u���a�� �0uH����YGVU 3A���ޖ�L"
��{�1����]�����W���a��c�x�	����F����Lx��ѻ���wۖ�sl��J"X�S�V��(����(}W�:�t�6��ԆoF�N��g�^8� FFF T:#���� 
����rf ;�����z
ou2^\��ʻ7�a��r�{�،R��脑DfO�1 ����m.h8��wZXH����H��(!]�a8�(�=o|_�{�	mG8�a���^��3XP����М�Q�	`)�h�ז�YS��p�Q��9���H����}�Kd��:i++��}��6B���@���H<%9�ǭRL��Z�Y�E8�5@�D3���J��W�z@�{���v�3:X�n��پ�V��z$��уH�,��1�Nu� �(S�,n���6�౬k��1�}�>�&t7��i�./[��w��)�v2MA���#���������1�5���Z%!�X�XTI����=�����)Q]���w�vv��m�������)\^[4O�a�Ut�;a��4�9�ؕ.�v#��M���@�d���u���^�����n�����b9���K[�h��@�`��پsѭڇ���~��|@�>�f�+ `��$
�m���j�RH�_�9G�����}J_ya	�IF�Y��30ZX �o�sY�gD>���Mm]��w�ߎ
� ��QF�ό�r�Ki�[�ᝊ�z�Ў�xZ�p�ZR+VR�=����m��ۄ�rӵ��s}����!HN���1��0J��DGB�0���-���e+x(���eG��}h�T�u�p�LJX[ �B�JD����<1A��#��%��M~����!`���V����$wm��Ig2��&����a�miQ\$�~�O�F��ׇ�,"f:���T,!L��ת�Rh�z�9�k8i����0+�1Õ��_d�+�{C�"�"���]_�NN�떉�(�kT�ͽɑ����h?��G�]�Q�ՄՒ�{w��c �'�R�-$�-0�(��&8���f+�Zr��/_��0}��o��U�}1A5~��(x��$zu!*{+7&$,-�
0�E%n���t����9���9 #���ʟ�Ʒ��%w������`�=�ڏ8����������3:8� )37�±ȲU����	CA&+	�w���J!Jڏ8�`��ﯭ�׭,�s�(>��lmF�,p�'���{O��j��r�VV�^��b�w�\� 9���LFs@3����E(�5������1�$|
���)- �!�,�r�Q�A/���D�k��$,��BR��):,�p��FN�U��<�r34�\P���c`Nh�"��֯�]M[�����K-������//F?�?=�8�{�vU���&]�)0�+�����fӻ1�|�ES����"�~�ᾍ�'RZ;�Ʊ�Z8������$i|�3���(&���ߦ�����n��ww�tX�f��w�j1�=M0A
���l�������ߑ\�� ��b��u�>��$8K�(�X�rSKpC��"~�>\M�7����    X+�����I(���vZv������Q�Z����p*P�y�_����=�tH�:I��4b���?��R��
��b�F�]��mg��Bo�26�ai����������u�G��1KI4�^p�4��J�3��Dg��B�	v���Pb�w�~:^���|����~[*ů~�����ͼ��k�
;���Z�k�?�M��6�ǘtVf@SZ㝥�x��Q��uy��+�0i)��sUgw���]��[�tgpxSB������T�e��$��2�����X����
��6����)��4�>����g#"L�!��Cp�U�U���~s2�3����4��ă���`�9+��|�Ŧ������>ECx@+�d�9zM�����S�YK�B`x'���;q����м��By�I���6����=%�%*�����Л�G�Wf��7ɱ�y#Y���^k��eR,�\�4~���8���i�����~9��ϖ���kF�l�+������&���5K*�G��e���d�n�D��htJc#��������>��x i|�n�r��?WX��)+���c�I�S8z�F��@!��l8 {-����7�|0�~�0R�������f����ѯg�g�rH��4���Uc���?4Mw���G~�O߆��9��D ��Ye��2�"1R�UtBJ���������k4_������֕���J��զ`��q�\ҭ���
m��K�����b�9e3�h��U�� �����!� @�b,�d�Aw�S4�@S�8}�yQm�w�҄U��98� t^�;OFA�U���<2�0#��2�)C"�$�h$�Wmm %��mz�X�L��ց����a��^�cG�ª�y��K��3�ڟ�ƔM�>���k�2D$�Q�#/�Ҷ�r9^�g�.���w��t9Z$���ƺ��F,,��<���9OXh��hqU\'��SSė��l�B��;�d���㝗�+8���w�s�g6��u�$�u#,@���AG��ȩ�7z�Na=�Mר���gW1[y�ёT���8���OJd��0M�T�Dd�VX�T1��2*ว�/��m�-$jG#W�Y�ԯ��������[��m��j���Ǝ�<�;�~RBk��Er��h�#����)���%�a����h�n�7�����~�� �%�M�(6���3^P=�χ!�ߊ�
�������B�ƢVy��w�r`Q00��$�0�e���K�E�Ki�lڽ�1��1�}szk��˯��p��� ��ф0w-S��x�p+>[����`���v��Wk.�5r�����|<�+N��"6k�
`�t�i2�0D�k��H�زy'b��	��_�j\�6	���V!q��V����8��'��GR�@J���X��IM�**�(�U<�}��_�"EC�'ޫ�A7I��Ί$=4ykH�^��;k����3����ݮc���/�A9k���o_��^��op5a;m3��>�<���%���7'��{�W��:�9� ��F�YI�-c��3�����)m�	V��i���//_��Ώ���65���&�rz2k�q@%,ͽ�j��i�YO�0��"���;������d���d9�����腾�ޭ��ү���9���������p��h�p3�T�qx���0�o!�&���sX��%��A6p���0�Ոq5��/`s)v�a>Oyy��\�r�et�n�|t1���S�%	f�l��/��Ͻ���[�����]tl'�q�?��[WapeE�w��Q�dy�Ja�z�8�!`9���Ћ��F'��a����d�#��L�p������{�.72z;g�[)�N��Q�S^F��T2��XG�P����V��d���^Ubt�H陡v�z�g3����L�y���
D}�d�(g��f�z|�rҋt�AU��j<k�P=�]4o�<��eXu��{|9^����O��q��|�엋�ٯ�
q��%6���9�Z�*�0bm-�a\���;ѵ@�c�k�PPrv%���}v׍ j"y���H�8-�:N4w��Y�T6Ӏ�32S*3�KI��ɖ� �#�"�$J�Ȳ}n���-�D�~H~��+�B)5�����;�5�������ko+���<sj�Gc@Lg@� АN�|���l�j�(�Ш	ws�=�y4�߸�q(���#x�M�3~��a�~�l���h�����	:d$%�zKb�
PX`IX��TA*�(�R"�K��7�Y���v�x�p��7$X/v�t��+=ֶ@�w�s�;fD���1X�������'���E�4�{�/�6��|1�N�onFo�������N}	ٛ�����ѝ8�趿_����'ߎ��&9���}����L��S댅jhP>dϰ��ܥ$���c��Q����X0Z��>i�fy�3���T��]�V��G�M8A%c��h̕LƖ�A)�ћBN.3&���b�A�+�x�'+��嵼�x�P/�V��u�T9���Iצ��c�r�̓r��	�^�Q��%ϭ4��m�&,-�3����C=�v<�^�=�,����F6��,�d�̯*�Q�U)Z�.������H�1�W(��,��
k<H�-I ���&%qR$E�ϡZm?�zL���׻b� ���yCV,�cǩ2t^����e��_5=}�:�i��3z��<Z�n'}�?i{Bլ�Q�{����;	���\a�M��|=�����W�!��#�!�x#��x�X�ܨ���b0�;�o�d���t9OMl��g����4Q�h�X�����Pw��;x����_0�E!���0���	��J舴� �V+�m��MM��:�w�	X,�d�uz��z����	��k���Jt�j0|���É'���B�/L���&0�Ӛ'l���Þ�L$_�t�m����r�v����9��4���]�-�����p�3ՄD��)!�QX�L{@[	 
uY%A����t%����I8���>�l�Zt}���ƈ�&b��I߹.���5�2&c&����������z�n�p��YYq��^�=*��[�\y�E?X�Y��
�'�'{�� ���18�����un�+�P�L"։<o9�O1e��c��Dh��N.G��%�b�Cz=����;8`�L��&f�3X삅ls�>6b^�.JE�ܺ�x.·�����Q�|Ja�{�ݯU���Oo^�"-7j�ʦ$��W#NF��P�5Z�
B:��:+��O�	����^_	��T�	j�	�
�E�tr�$���X�h`ʷ�/l��u�O��d�(��4�ހ%�E�~������)k���xV��"'�	f,M�zM�
�K�j^B�ζ�7��ۛ3xD�z��B�[D����]>��!6�Ǘ�VcA(x��*�"&rlGC@�aq{���X��[0�Y��4{��5��pw��
+,�KO��)��������l���t�r!�w�d+��b� �U��[e��a	�X�L��^� �|EMa�[��F���� ����x�7 �i�d���7��g�U��B&+��[��"b���ݷ�%�R�R��6AB�q��RI�X4�1��wD3c��I��C��%��)�u/ϗww�٢����� "�)b����ϣ߁f��,�6�1�do��@s���z�0<����1��R��Gʓ͔j "1J�ޫ1�3�ɦ���.}��`�]�ƍ��\V������ȭa�o��v����>A��j���^�~��~����
�����_�Y� ��������
3JyGm�:���P�E��f�rݷ��߃NwWϑ��%=��z�7S3UmݽF��`W�����i
�I�6�;M<�1i���x�>���4�������p�.��MP�h	�ز�,r7�0>`��1���"L���5�z���#���$/�K\K��˵�.�A�ʵT����r�hn=Q��i8<�2�7���x���F��2��d֎xbخV��m�>0���@ux����&�v���>�t,}��K{Q�V�)��Ȗ0���d9Uޠ�H�9j�fZ�)�q]����
�+@+�#��    X��,�ccZ_��b�9I��&�QHy�gn�A{��%�>�/j���W�"p��q�]����vQ��j�u�II�m����+0����j̹�,gNh�`+�llJ��=O�T�b͗���hu�Zګ��<"\���[�~��B�OIʡ���*}�X=��-��W��!h�hh��7?���,^�8�k�BiA��n�����t�l,!����G��ҩ�$Fxt�e�s� &�&)�v�O7I��v���\wE��f��l��/x�\5!y �/�� C��vX�,c3)�� p09�y�E�$�p�ԎWЂ���mfۏ8^�x\�B<-�-HP�!�< $�����w�7��4� ��A�g{�g����W�i���w/����; �^Kl��SRQ��d�H�ն�8��Q���2�t���Ly�ж�����e�@���n��QF;���x�,UJ�ܜ�͗<�X�Th�2��Pf�+ㄍQ&���3�-���u�m�d�(���ܞ����d�O��ǣO���R:��8v�,W�[_��)��� ����td��!&˵�҄�g��, �� x�&������.��~8����������ZY�/b�PVc��:d�t��l�
_�2�X�\�$���
]9>;��xi�=�ͦ�3w�T7�ʀ��X'��>�[�bb�?o�ͱ�bp�}�Cg�-��
�p�I���Z��ÛU�"F�U_bB�� D�V���[2��`��k�!��`m�U}��"n�|�Q�?��ٶߎ�7��ͥV��1��N�9�H�n��c��Z���կ�_�!W�;$Y�X�9���ɪ��s$�u6`~CW�#W�W1� ����J��|՝`6��`A����� 30�fY<�eo�]|8:Z����Ǐ'/�(Т�=����w�5V���f��Z[�9��F�$� �K�ki�uM����n��)|2��d~X�a-A�Vkx[�pv����J��p.=q5^��&ط+$j��*'0�D�I���[F��ϺK��]���S�x��1k�����U[� �"V�3)����@���8�M�p�4%a�#���A2;�렪Wq��� �LO�/�?6�	4��>� ��@]`6('�I4Q�E<b��u�/��&�7��0[��r~7^LG����z�3��I��~�t&V�?d�g�s�����ش���������g�K��踤ٴZ$�M���Ň��p�vᔼ"���j�1����ol&w�����3��: ���9I�&&�ɔD���*�x4Κ��W���b������p���ѧ�__��K� ���Ng(eU;%�g8�U�.��E�^� `��ޅ���$A�Y�y&$9oSN�a�䝦��#��˦� ^;!�������t�h�vھe��|�������Hk���cNf���lyP9��ͤ1:N�(�U��J��L��.k[΋[�4��,���9�D�l�%�O� :���h�ѧ��Ʋgu�1I@b�H�1b9F�?69	[Usl��\ޒ��$��x�%����v��a�fx�7%����l���6����U0޵������5��ZI��pf�'.x�cPb$S)�Ib��nc�n���Tf�~��-`���&?��ч)�X��q���/����4��U�9�]����S�%�K�z��W��#t��Ne&�9�U��&��H�a�W��J�Lߵ3�:��mQR����|#�0$�ӷ�g��>���8n �w�N^M����'���!��>E��Ar����M2%�����g�V���J����RZ���F�����W �.��j?�����V�� �-y3�Q�%��a�+C��c�6��Y{�`� ���t��;m����۲�ʯ�}:G
,�N��xG�=.6]��Q	0IH5B�*��e�]�B�E��U�R�&�;|�tb�s�����Օi���ɕ[�66+�������_�!�ޙ0��ۓO���V��V�l.d�E�{[��C�����ʥ��ft����1��ïo�aϘ×$�I��P�$C���d����k^?�TTj.���C(��\m����ҰL�& �5ؿ����ߧ��]�ǋO���,>��m���!���^hjBd���8�R�z��T�;��V�Lck����*�|cm)��<rP�`P�g�`4f��"�`��	n�Fl��ĝgǟh)	I���O ��'L$I�b�
�YX���{��f���9P=7 �r3_�=Ǔ��t������\N>�\�8?�X�g���|{m�Ć �w7�b"J+�٫@�)���F�F�D���u]��;Ïo��b��\L;Yi*��M:Am�@}NL� �'�yJi�eL �c�o�t�����bo��x�G�^�o�-e �����`�Rm�v��HY�� U�D���顉u�R���Ru6�;���`��BRaX0$X8n�+��Fg��S�i~5�t����D�J;���h�����e ,�ѥ�9�+��H=�Br�(920"1��E�J<�ڼ�iks9.��`���`�ǗW@\�pd������.��s�@� �GM��z�VM̂���{��#�u;�Uq������lZ`��Z�c,�u!M�����5��Yk�qD0`�	<����9&�q�U�����Ңh���u��w���b��1$;�)���<�������< -D�o�)�䴡&q��hRYX,%j�S��.Z��d\�*��'�ѳ莫��NT[��<�6�=���^1��PL�� 	��:8D�2��[L���;P��m��:D�t�G��<�иp�0�L]ܔ�[�ٵS��bt~=��j������޵]���A���Z�� ��%q^Q'�K�0LNj,�Εg�efi'�~K��6�������,���t�㼉�X�ѕ����XN"����	s�p���]ސ?�����;�dN�ت��B��䚅��n��P��6���a���k�a<���e�
�ۣ��'oޜ�h�~��l�\�n�
��<�����i�qs $"�Z-�Q,)�͜��P/3`�RDZ�Ule�n\�?��K$/h��l^Z����u´q��o���K�})'ϟ�����?����OJE�e�W&2:!0h8������sH��(X��3&�Z~�s�|UnɁ�A�X�\@@�����-�u�w�
,�/�d�������J8>�?L�ד����s9�zT)*j���(�6� �^G��=)Yʢ�+m>s}��<�q�iw�vz໾����� �Ȍkg�Œ.�o�rЄ;kaCi�[��R���IE+1�v�G7+�jt�a��c�ֲ�`xs��А�]:����o�ceϣ g�(^��x�xg��e,M�Ôոq`�^tף?�g��.����?�����o#���Y���)���_`��]2�}����/^d�-(�&j��$�9%қH�����o%�r���?��/V6��8;�>(i��k|��Id���a�L��h�Tv_
=��o���4݇Ɵ'�5�1H�^��B#9��@�j�.a�\,�ow+go��:!��N[�U
�^sv���,'���C>N�ؐE+6���0�Z���I�Jk� ���bȞ����L0W@�$�#��Q�<�iy��>��=x��JW�i^�����b�*�S�;������_��u��5���;8�6�v�#K�@��$�����Åm��ojC�]��{�k�_���+�ٍg�Q���`Ыg�X5���I��J�����F�R�'�D�"k00f�)����6h񬕳�y?N�!�tt��ӛ92_��� ��g�>��}�v�*;�3��< ��TYtFgl�E�M�/�g�n�u*��a�G��kw���ƭS�W��g�r�W{�l�Ɏ�P��i8��j�sh�����k%��и����$S�iT��"�9�#�e�5UM�Œ#rt��Ũ{+�w�d�oKa��۽r��Ik�`x�b $J*8�Q
-����a���6b�������6E\'W�B/�����V����`6��k0p`��ヌ���Ł�    ?���#��C�fڷ��8�[���˫��5��]�������D�C�Q�b��"x��cPf�ӫ�dŅ�u&�@n4��xD��5ہ���mo^J�N�ls�1J�3�n��_HB�1����? A'���U�YP8�;~���{5-�� ��<i�H�CHw�r�f6ƒV�8���i?�x5�vS�K'��c 6V�2�����PZ��;� >�mc��bc�)�ؔp���	ڤ?���%Up2J``ş�8�u����I'Ŵ~�f+��L��n������f�'/,���<�c�����϶���p���,�d�	��ls/U�tK��5�U׎�����ʩ�>i�⎃O��F될s�Q0�����e;���S?۟��� l���Pt�sd��9	*�� ��'rԤ�<�p��l��\MaYZam����1�@�廻�ԅ���R���Dw]�����[�W�� tˬ��dIF�sO �2�KG����`J�;[a�co1G?��ڼ������ҟQ{\�&�pӐ��(�Qbۏ8>0r���p���l�G˕�$y�
����&,(C�T��kY���t�������r���5d�/��_���౯��x�7@T��#�	+�(tl%�C��Yf�X0����z�/������w�_?/�Z���aήm�Fe��L�u����g>IF��bCgNu�)�\����w�R7E�K�L��+8kZ�e�I�_�0w�#���` B3��d`�[�'��
"�I��YP֚$wj�o/8ѿUn2����.���uqd4�w�_����K휪��h�olV�9�e9Z��)���?���Q�tW���,k���N*d|�Ou��S�����S0�g�%o�p����:(]�Jk�R2 y�$�l�6�RAF�U�l&�iR��j��k��0}�(�nׅ�G�B�����qx�/�I�B�v�"p�����\�z�U b����g���'� �Ǘh5������=2::9>���������ћ���#��)ܥ�G�lާ���"��\	i�*z�Aǂ��Î�NR�6H��Ŷ�º��^e�ZQ����6x��h?�x����[�z���Ia�H�U|�Ǯ�F ,����<pD[���;M`�J{��e��J���-��^"�^<��u>b�S	!���O˟���.L��鯥&��%Nsv!�z8���������>�z�������EC�J)f� �Fa�瘘�f���-� ���F�ΰ���N=2v?@d����W�-AH�o:�&AR3:�,��q�*a�����D�خ�^5�R�i�nJ��_�h�i����.K;Y�_�%���7��~œL��9AN��G�m���2NK��m�Ԗ������ŏ�E��zc��N6��VL��y�l��j�����Ӟq:)	Y�X���@�t���"��v:I����������M[�� k�'���C�L�C&	�MI�`gReL~�h�z0@��a{�8,��O!���NU� ��pT�46&0!s؞���v���^�����ft��q�-w� V��N�GM�h��t1�1��>�ݻ���+�5�h
��,U�D2��1��&:`��r3=v]�M.�E����_~:E*��f��_���:��h|f��D�&��x�#�c�L���M�pX(8�3��D�p�d����_�����[�����23;{��}��>��=�"*�5�0[2��X[k�)x�"(�켅��kA�*I��b�5�"���京�b~�������)�Jl0�>�P���t!V��S�++�\e���Y�{��{�͏�ϋB���a�3��'nq�^�7,��R��G=�f#�g�eAV$��1j�d^�l�uA�u���+�����vNB{���	t���I�����Ѽ$i��F�o�Y�v����4��S��fI�C�M�p 
��N�_Q�n�UQ�5�'�-7���	�q���߄�;��z .iøΉ�	��Uv��yvK ��$�/�D:~(���.c�^�~ın���)�pw��"�v��p�ÎOREʔ� �w*k��~v����в���n�]�|��[�w�7�ɱYu92fws0ƿ?�����VY�&h�w���CXB
t��Na�`�� X������.�yTU�w��pst̬����,�6@��`�0�	j�yہ��QqG�\u�q�����Ȫ�t�%EK�''"@j��JV���GO$!a��^P#7���2}�UVƭ<����_
M��5w�;�ႢYQn�H�b�{�JXn�)a�"%K�z�����ou�n�#j����㏼g��P[��Д9'�w�NX�¦F��1�-��-��.�M9C�
M!���Nn��^b/��R���+/Y@ߕ��t+��~��g9��%H�g�%�����4bk�R��F̝�;.f��Y���F��V���o���l.��Mw�]xLf�<)A5>��Dr�[ .����`�560�� �A�FG��ɾG�е�T=��K?n����Ć��m$�0!SLJ�`�'����%bH����b�^���Y�BgS.���#^=�hlV|�g`кFcm�؋4��_��z97)4���8K�E�"���Gl8ҟE��;a��+� -� P���
��O��Jr\�D��2��/,;�UR�S�i��r��rf��a��a�7����!���Qe��	-MrQH��� 0�
NHW�p�sz��>éōu6E�az����8���yY��l���i�qw��b�����n��M�#�.���ܑ$k�u��a9�/�N�J�������
�����gJ��Jٷ+�j�gX ���L�d�4F�d4��	-�$�<a�U�ڏ3ww5W�V}|9A�&��f{t���,�ij+�Up�h�%K�Z�A�I�%,&�箊��f�y�������S�n��z|C�Хz�?x<f�'�9�~>*ev��YN:P���H���Ka�ԦO�����e�4����.&������p����/��ƇH�(X��iC4�W����Aǆ�>�_��5Ӥ�h����>��X4 �:ʵp � �`B�9m	gFXP��ԁ���$�B
M(��Iɯ(l^�oz����������R8�h:XOc���#��!9�i�{j0���)���//Յ���W����-��s�=$�)�������y����0,@@<FN��ʤ�L[�E�� ������
�t�S�S0�$�B�)�]�%�<ϥF�'c�/�}�/�BaS6�}*�m4���8_�[}"FGx v�@m��{��_OA�U�(���O�D�HgAZ@�,�<�(T49:�߸��dso��9o�j�V9�:[z��=z���� ���2�j��EB�̑, �Hr��'�@�Ж5][&�?�i�hfC��a��f��y/r�%T9'�H
������%�׾���!E)$h���DD��pt}N,x��Z!`eA>P�YX۽�G�����lP�:���Vh#�u�����򑨘$����k���/�ѥ{��zِ�p`HbaoQǰ�� �D���^��>�^_em��	�o,�V�1���k�8>X�Tg�L���Ɠ I+�1���HQr�B� &��k����ϫ�Z좶(��r��hڱ9��&���<a�'7ϋR��Rp��_\[ސ�l�)vB^pj�%rvu�V3��V�]6����vU({����Ƙb�vz�D�ᙻN�/X�W�Yaʐ6m�KF	�O���H��=��U�yH>�8�X��r��8��F5H׺�?6�}}�N<��������~mNNYvF�@%�� np�{�uN������I|�Kk�7!*G�p���w�!��l>7����S晍ɿ'�\�ʵ�����!�vf�l�| Z1&UDKuv��	�OB��|Hkv#'����!ʸ)"�a}C*;
�HоV98�*c�ݐ�Y�ߎn�K�}�;�Y�<��Iվ]�X��K��h �  �GĎ]���/��Ɠ�$�� g.��2���L5��{���i׼(�kˀm�X��?�� ��Tb:AW=`M��$����0�4z��j|�x,{�h?�y4���@�^��T�ق�@=��q_a$��c�cNzI*��@�sW��A@ϗז7 � �A��s%]4g	`((x�"*Pkl�XN>��Ya��{!��,Ԭ۞���y̔���9��Y����w8O��Ι��a�KF���ƺ8��ڇ��ͮWJ�u��������ؖ�g˙wX?��}��5�@F����	](K�&��<�\���5���o��K(������t����#+j�8���=n��*k���Y�I�)�$����  �0¬U�"Q�S������}��zR�D��_8>0�W��t��4I`V�@�R�s�ш�$�d��ĐO)ϰ)���k�x�z�E�ɷ���o�w�Q����Gd��)���>�у�9��x��yP�
�5ҊIX�/I���T8�d�iؐ�P�t�t�e �0ga1�;X��h���	埽�Z'�Ew5z��mfʽ�a����#�7o]?XT�w�V7$�G���P�L��qK�y�WV�k� v�3x>M'q��Mj_Qc�wКw�����7.%<�6�d�.���9q:�\�Lo��l�Ĕ��u;�#��J�0�Բ�dEH�7�_{G���j�����5֖��w,1s���J���G6��w�K�=5���<�F.J���eZO�Q��G�X��t��������SN����d9x����v�Ó���?;��[�7H���#b-���?�6F_4]�CZm�2�3Q`�]��ʢ��qבfKc���59�"Xi��q��LN_\M�龼�c��|�����cm?��  ��T�86$k�H���A#sB�"� &]D3��sy�L��u٣����6��}v��p�-o��	�`�/�&~�E�A-�� v� y���5�F�fӜV��*�oR�����û�}�H��3���&�4s����)Fu`h��Q���ܢ����X�7љ��8�d�6E[v^���ùs��_Q�~��n���5�4(����l-}Zf,���d�T����F8YD����銩��.b��w�a�k��o�[�{�%�3D�8�+��*`������{�j�h�߸U��)l�����C�����7�gW�>�����W����yy1�gOؾ=��;�1������ڻ      e   -   x�3�4�4�24�4����4��44��@�(m����� ��      f   ^   x�3�tL����,.)J,�/��r2��3��8J�K�R��|N�Լ�Ē�"��ԜҢ��Ģ������4.c�ZG�.��y�1z\\\ �+�      g   Y  x�m��R�0�ϻO�8���I[;ө��Lf+�`:�ooH
*���߆�!��F6�����N�ђ�(���eȦ�r:�/A���<S��q������,�R�\A���r�Ͳ�4�ԨVd�����mC�\����]U�����D�*���]ɍS�[uO�M��,_�5�h�6Qcv��}Ij`sq�=��d�DP̓r�#�0�b[���tzTۚ�՛�v2Q�6�}��}�(�
��(&�2��������(����4��N�a��(�m�&3��D)o��V~�C��� ��N�l�O�'��<���c�4�3��c����ĵXՖ �?�
��m,�3�����"~�3�      h   �  x���M��0���б=�̌��mٰ,����^F�L�n�Ŏ)��+�q�chm!�@���@-h~���e�j������E��1FcRmv6�3�(EZA��U+X�@�����F|� w��g���3�Bcp�3&+O��m���Q4V9��gj�*43O����ؿ���az�M���w��O�{a�R���
�Q��z�Y����5�E*��
�}��>��NqJ�]����%���V�ay��<�i"��!���M]���Y���nBA�E��z�Kp��0�r;�|�酏\�/����`�[���#84�H�XJ�8G���n5~�d?x(Inf�wTl�l����U#>=��n�q�x�kk���)�I�q�l[�l�$y+�ͅ�UWam��5�p�V4�g������ IQG��)��V>h���v��1�Aˌ�����_��֥X��J[Ƹy����������%]�z-e:Q����-��Qe֜���Ϡ���?J�~      i      x��/J-�/�,�/��44 �=... \v<      j   D  x�uS�n�0</�������(WꪂQB���MDش-ʠ���.��v�Ԁ`���ݙ�	DY��gY ��ě|�����ck�x���MBGLkxx�2)A�P��]�δ<�η�G��dl�\�����:Jv��D���{�儮2����/%��6S7������x������FL��L�,k_C�������z��21%%�M�ڐ���m���A��
]�Tw*�6�h^�4�; �|e:���v�Cslx������z�B21�����F_��?�FlI�S�������ݛEb�� _��ֽ-�_a��Di	��y��v��C���PK&��Ge<�lg��C_�� ���a�9[B����t�-:ZaFF76�����(����MeW��!m���Hs6�,�v��}EK��=��;ݫ�u������;+&B/�Ɩ���^H�>��Z09��3&B��▬��A��#C� �S6�Q�*$*��`jL����7��N�1�K
N���s>�!���֖�5du�19�pY��B�&0�?�b�.���ԟ.�n�� ��"}��1�����$8�      b   �   x�-���0�v17�n��a�A#�F̚���?}�<]fXcF�_��� �g<���I	H@2K�����G�}Dѧ���n!�4�I�=����d����c��>ݰ�za�"��̀��h<�Yl�#% ���{�37"      k   1   x�ȹ  ���������@d�)�`��TM��s�O[�p��x���      l   P   x�3��LI�VHJ-JJL��2����H,Q�(-N-R(I-*I�+)��2��M-*MJ���1��H��OJ���2A(�	��qqq V(!�      m   ;   x�3�I�+HTp�.N-�2��L-�2���+N-*�2�-HI,I�2�tI�I2b���� �:�      n   0   x�3�tLI�2�t�,���J��2����I�K�2��--�K������� �S
�      o      x��]Ks�Ȯ^{~�,RN����Ή3g<NfT�S�.fӲ��D�������@�IQ2e3WfG��<���➸������K�P�R��U�i|��"�:��� �9� �T��3��-��B��s�A���%W?�E�lÕ���h:�T9��Z���/C�?$��6I��;d�V�������Jm�m�f�ڪ��]�(S���0^.|��*��f��J���V��
ha�6(��BY���H��4�����M�����Z��k-߈��J���,�y�v���ֻ`>.��r��F<9�N`8�g��;���|H��A:6*Si������Z�Lm��`���: �T}G�4�)B�h�yH���K�g���'P�VI�֭�Ȋ��bEL�@�II��K-�[��ى�8H�J�~�g y�rg���w�(̀��� t��`�rn�+�����0�R�!X���IЍ�D���i�;��Y�p��p����R�vp�q-���hsu6"ޅ%����[�P�K��c�D̞|��(�u�s@�¹��DH6!�3�_��6g�"�q����eHv�(��߲��B�l�
��u�= �ݫ[�s����³P�����Շ���wq�KR�ֈa5���Cdu��O��]��G̟�z��)6U��SF�NaP�N��";��F0/�
�a1���-�ܫ��	�ׅ�������)�g��N�ɵ� =��x}���?$�M���E9��=�n�U�!�9�����>�~��y��{X=��o l��ou��8���L;�/�\����0'�1�� %��ވ�l(�6N���7>�J��|A�I{�ބ���:��H#�ʮzSD^7O�X�g۬���.�*3ZύQ��®����U0{`K�8Y'����$4<h�}�k���|���?6~�+��p���(����k����!��a+�����{c��+�6q�3�m�^�Uɇ���DZ��Q�X�`���aW��F8/V�z���z�����6�%�&�y��B�<��*�^�-@�1����O�qP���zmn��Xn�Y�]��C��x8\^>]L�=�[����q���g�V��<Pw��_�ҹ�]�,�@�X�-���A����1Њ��#��/�Ffw��?��a����v�|e��)*�=�%�=D�=\"�K�8D� xw���Ȯ;��̹cwh��C��9C��f�Amzt�2�%���w��kTX������L7;�?>��]��wa�
r^982�QNO+�~/�8��v�`oN>%�b���f�ۯ�Vd!�	��7�Ve��R!Sd,�&�a��LGb��#󘕱)l-
�[�����0b����0�i�("ju?'�>��3:�l�+���5"EnG�����Hy��C)C�y�������͋��|�2@�60ݜYʩ�\�~�9i�N"Ń ����Z�9m�e�`���e��띟�V"�p>�,{�0���Ӌ�ޚ����&o�V1Y+V{0�R��0w���d�$�E��'88��E���A/'��C�5��{�]�a�^�Ir��6QDSoO�S4t_�С;��h���Zr딑��p��=\�����%̈u�F6o�u��*'�skjBW-���a�5���]�6���.�֖����h2�Y9CՕy>
U�ZG��غ����e�!���n\''c1�0tY��4�5|r��uN�,��5N0qI)"e �Է��sz�S^���_L�P:n�Р��9�����F��,�0E�G�����E���>�	+�V"I� D��䀆]�r���4�f���,ّyxO����Z�J�mْ��w���J�
]M��(!���/�fA�s��G�H�F[L����/��)+�\��겨>y)�QYT�����W�L���x��3��͜��
��{�15�½�e���.(A��d����NX��țe8)���#�Ab�=zsr���Mk{��,:r|0�(	��e�	�I�$��@�Eb/V
e�U2�X7�d,��GI���M6]�nw�t�AL��P�6ꏒ632c�\5�z��c��Ee�zh�f=b��YUX#^L��(R��TF6�\�u�і�����x�듺����돏�St�f�ܢ��������)�*�+3e��ϻ�!��*�9�&:�;��g��Fc����-���^�PYxL��i����9������������O�M�2J��(Da�)T\�&ϛ}cN"=!�Vz�Л��σÖ�4�&q���*܂�U�G|��?�Cm���y�kI;FٵW�2U|�+kSg�g��z�M\+��K��8�3{,Ӌ�ǃs��#r����n'�W�Q�s
#�LB;�쟘c$4W-�z���=i�*�ǈ���R{e��t"�S��8v�ý7fʞ��&��'���|C04�	���.-	�^��OO�i��"�P@���wx�$�ӌ��L:᝺��?�~mO�nA�\��՝�iI�|�(yL	p��\���ORkZC��hC}Ĉr��3-�5m�%ӚpSk.�2�)PX!�YE���l��&.#���Gp�Ǔ�iFti-��&���=|���ps���O�Z�s��F�6��MǪ�6ʹ�:5��*w����[�g��L'S��Q�[�\�..�(x��D*���v�6jP��>IQ�<��v��g00��1�KR�Y�n7�T�Ȃ�4p2�ř�����]ӌ)��2(�w�K�J�C�S��Hf �������mV��@_�����Lǌw
 �������j��}D-s܁P#��E�q 	��"I���%�;{
v �9SxY����W��F��f
��Z��^�=G(3k������Ғ�5e0��QV֙�)w�k)��#��w��]f�!jI�V��g̚i9��ʪ$�X��&�����n�H�2Ϩ�	wC�C�T��9�T��hU��.���������͎����w|�r��NX�v}Q�u������E|����/�;��󛚇�3S���F({��s"p���G:[��b��:~P�z�~��G�� WQρ��Xa����I�G�٠��5�;�� ,X��*{K�0��g@]���?=#�U��e��r������[��%��r���Ƌ@�N��Ck���QK��Ư����܏�3�'�UyP8/xW|S�&��0r�|�����y��Y^�"q�\��^#�#;�\��D�Z�) ��қ��Eˤ;1�$�$��J����ɿv�f����`i[/��ϫ�Aɕ�o��=ҹ���Jr[!g2�c��1����OUٟ��EG�k��N�e����k�����^K��$��Hmio�o���^�vX2x�l�� /��'�e� �{�%U&��D�z	8�������p ��i*I���"�o�=�ܜL{X94�}6��A�z��)5"�Xġ�c�9> ��d6!oa*�[����+�����M���=�
w"8� �=M=�r�zv@=�a�+����(>���kBhWrȿ*Z��!�f�"*ʩ�iӢ7�.RLf M��"�j_Ե�"b[Rk|��J���Lt��Zs/}�w�Yg��8�=�l0S��+)��C����x]�+�y"�V����R��D�J�-��Ia�V�G��k�
�x��W��_u�!t�޶��2���ڜls!�82r�l�2�0��Q�"�y�³dA�-�lu���Z���v��:p]���bP
� �m>o8�	�xt~�L�9�"�<��Be�֔I�7KpMH����!�~�A
@n!� U�ӳ,����9�1v!�g�JI�ͬa��Io��7��*�K戺U'�����m�j��<1��GI��**��=��^T��'"���,HA	M�`9eB�s,0}�m��iČa��6_�U�������boN�Q�e�5�oq��|������̷9�=�}j��I��@�
L'-���D��b��o�q�a2)�aWm��F�Ub%�iA�X�����F�P͍]�f^���kf�<�ai�Be��L�2����`��&�p���r�7� V  �c��t4�9奷óK�������Zӣ���t��+����W�çSưB���f�\H��u�s���h�c|��Mlg�:&ӡ��FF}1��扛<M"�fQ�'D^4�ל����o�{�c����ϣ� �t|�|���7�z[(�2� ���z͐�& �L���YFxO��A�v.ؖ_�ge����G�h���=�V���!%2�+���`bX_8�9�3�C�K�@�;�]�� �A�{Z{�5L>��>_���RƐ�e��D����Ho�W9�� �'ٶ$�GK�����YE�PZ�������/`Q׫{�ɹz��e���rFF�t�]��\�q<�y]�ܫ��l��p����ozf�+O�6�3a��	�D%���T����3(�P���=[Ƌ���F�T)\�t��U��7�F�����G�4��"%%|�S������Xv�O)j�����G��a�2��dMS�4�ea�r��ڄ��A�p,b�1{`3/څkjհVD@[�2e)ukA349��'%���ʃ�E_�����1d�L��X�̷��/�@D��HS\$�d����";��3��_[IvO�����b_s��C{k��Mi#����_n0�3b�_.k�s�슲��h�#R���ռS_�W�IQ�%%�W731�.�_%���Z�f�d��iTYf�7�C(oX�K{���Moxh��#���B������Y�g�M�)VC)<$DR�a�V9=W>�����R/e�l���P�8,^�s�"����I����^��Xd��������&�6�!�|{X3�����q"�{m���qˣ@mJYN�ɒ)�*]� �Ӄ�X�n�oP0����2&��I���,��f�vf�&W�@���γ�`ZeD�>��67�~(/���Ν4�KR�'�
c��ޣP,2���o\����2�
X�T-"���c��ەg޲B��!@���q.`�`1W��we�v�z��vS��]���W%4@qp�#���C�ڍv@�T���Oeg׳
X
W�ʏG"@<��`G�����\�^g:���⪥��¹��]֒������L�DƗ��2�"����*#����nS^��>��lu��P�W�pB'�a�k�p��X��`�>��l!�B���/�u��I�t�lѴ/�Р�-�/Y�B|���T�����ڮ$}<���7�G,z��Տ�P���=�o�R�b]������}h|�3��Ƕ+�
�!����BlC��,�-��4�9�#ɦ���i�~�&��o:���>��w>��ԁUM�<��۬-��������T\���U���w�~�x;�Qp304�~ӆ%C��9s�X��;w�oo� �)�ii�F�`�4]� �j��hH~j�4��/�6����٦�D0�t�4�
�o��}���m���?�m{$��f���B��4��?e��CB�Sۦ�Hd|��i���FX��n�L7��~٩���A�lzr����N'��7�W��yx�(6��l�� �[�3玹g��R�r�w/4$SB�Y���D���F���F�\�bݹB�"d ���IQt�-n���ӗ��a���FYD�D䗹V'`=��eϪ��[8��3J?TK'C��A�enf1�U2N�D�9�w�`N&£C�S��?M�뗜��_9Zť� �hzf=���U�����#<��Ȃ\���~����+@-�3��*�j_q&G�I���>�(lȇ����d@iJĢA�3>�ԣ`���y�
������8�ҵW�-V8�CK�2%=�^{�NG"�˴S 7=��=�4�B�b&��{l�'��
��j41�"�n�%�>��T�v�z��`�&�:��g�.1�yk^��_�z����_]o&�\�#������� S��NB{��F���r	.hˢ
�Q����-���{ �M&�Ӻ�ʬNL؎��o�dފ&zcvX�A�	M	�(V_xp� �g�-H�~����
� ��E���kJ<���a=��J/��7ZƉ���k��n[��'w<5���-;���n^���]��RE�U���W�[�����}	oǭ���7�{��v���h�������������܆������v��Z��}��nߦֲ~S(���#y`���V��yѼ�oxw�˫������LR�qo��ܱ {���\�?�� 6�G'�g��6Jxo�0_Ow�m�EZ�)6�YaL�3��o�E���ͬ��%;��*��Jj��^8�����_Dg����E��5��i�ڭ������pn�N3Ԯ��&��"*ڿ��\֠o����DB.Ψ�Wr4����Z��+xp�_�_#Z(]���l����~�y7�u2�ç����B��o@|��s]����������V_쀫����/y��R�R  }�/b*�us>��UY����{j���Vt���r�)�k�H��A�w����@C�w� ��p���!4�A��)���8�<�
|G�W��d޻��aZ���>��KL��h��9�|�3��ߡ!G�R+���>x{����Dr�]FS�|f���+y�|/�ڹ�T�h,H�r���?􍑭����u;�	sK�cwZrɯ��Xd��d�}����M�zU���y�m�>xG�7M�Ii�b�*�r.ʹ=o�^��.�<[���IS`��������<�`���U9����kL^�9}�)zNqGY�Y��`�I���s�-�s�����V�0t�yV��&8���@7��O,��D��v�J쪼�,1�v.��y�.��T_n
��v��y��7�8j�dqLv�6��S��7o��@��E�S`�$�����^zIfyS�1���G���d��V9�7�h�[�g��X����B;o����
J�$c_#�:�Ȥ�պ��T5P��#�>��gȉ�#N�)�3cpf].F���5���*ݕ�4]?���JGu%�c�zd�?���7��t/s?�c4(/?m8R~l�T���������&̱�Oa(خ$��]���uhO�p����=a��O��S�� ׮t�1v�(��a�S�-A%� ��M�����f�k�����,�CF�����.m���EX�x��A���y�Ohk[�OG�9�[����.:m��t!�����o������a�도��i��A��c$�aq����-��?�]U'���:%����qo��_b�7��w�A/f_��U���� �¼h~�7����_`.���� t8@̝-@{��u7�O��¼�E#����x��R*�#�E�`�;��l�N�5�H��sq�oN|[��iRM	���Я��~�$�ɋT���~���/����`x�      p   v   x�m�1�0�W� �@
$�Tiq2� 3��K�ܝ�v+��({��>����q�	����~;`:���I=����XG�Ų�4ӂ��.�l�FJV�������`�?W�A�      q      x������ � �      r   \   x�3�t�,J�.)-R-I�M��JLJ,I�S(�`��F\F�!��y�řpڐ˘3 5'1�81/�e�e��Z������T��1����� �&.      s   V   x�3�H�MJ�N,J�1K��3���3RR�ҁ�d��BJ&X�P]^rb2HDn`e\�@e9�I�E�5��q��qqq ��5�      t      x���OK�0�ϓO��{h;��{ؓl[�E�^�RD�&����N�j#�+	����{�	!�FPH:�4"���v��C7��q��5�߿��#��!���
�R�d�I��0�%��)1��i	o]oespf/K� 5���k/�F�̛�H1���X�˳	�:����~��#����5�Rf�ߓ���d��R��S>��N�/T�YU�:���ۊg ������̷���QH���D�P����esU^�o��f�����;��      u   V   x�%ͻ�0�Z&��gg��?G�ݜ�@f�M4b¼�&��D�E$5�:���R_�ݹ���݅��-xM�}�Q�n��C�**      v     x���OK�0��O��*M���؁�eXe��#u�]��4�}{Ӊ�-�Kx�Ǜ�7Cf%�H�{a�ͬ�5�����K����F��Y�#�t1������2tm���h/($���F:�G���9��_�Dz�@�{������|8�����/~�E4��06u�7���D)U7er����9x���؎��14;||�>��ܵ�%*�+l���Z&��B������PL�,Ƿ�?������w/����RT��P�n�I��!�|o��[      w   �   x���1�0�9�u��rmӵ����K�"E0�v��[�������%Ǒaӎ�;}w�	���eA����n:ϏtK���˵4�H�S�R�jU+�Z�kU5��V?]����[}��۸v����~�(M&�	hD��2P���< f�3��'�0A],!h�@k�@��c�@ĀxL܀cB�ig�}\��t      x   �   x�M��j�0Dϣ����v�c�O	�@��,��U����@���]h�3�ff��W�$E��g�����CD�It�gY���":�3�� ��c܂~�$Cf%�q�c����%
rɰ��ca�AR_���E�U��ݷ�
��Z�)��YKy1�6ܠ!�Qa�V�hS\��7|7�O%\:[p��u���z������1�
�BP      y   {   x�36�4�t,�LSp*M��T(J,N-���H�I�.N�K�26�4�t�,U�H,*��C�1DҜ�����*i�	WJ�H,�B�3j�QF`��!��y�ř\��@	�=
@+�(�
�p�=... W�:�     