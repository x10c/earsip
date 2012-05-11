/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     05/02/2012 05:54:39                          */
/*==============================================================*/



/*==============================================================*/
/* Table: LOG                                                   */
/*==============================================================*/
create table LOG (
   ID                   DATE                 not null,
   MENU_ID              INT4                 null,
   PEGAWAI_ID           INT4                 null,
   NAMA                 VARCHAR(128)         null,
   AKSI                 VARCHAR(32)          null,
   constraint PK_LOG primary key (ID)
);

comment on table LOG is
'LOG';

/*==============================================================*/
/* Index: LOG_PK                                                */
/*==============================================================*/
create unique index LOG_PK on LOG (
ID
);

/*==============================================================*/
/* Index: REF_USER__LOG_FK                                      */
/*==============================================================*/
create  index REF_USER__LOG_FK on LOG (
PEGAWAI_ID
);

/*==============================================================*/
/* Index: REF__MENU__LOG_FK                                     */
/*==============================================================*/
create  index REF__MENU__LOG_FK on LOG (
MENU_ID
);

/*==============================================================*/
/* Table: MENU_AKSES                                            */
/*==============================================================*/
create table MENU_AKSES (
   MENU_ID              INT4                 not null,
   GRUP_ID              INT4                 not null,
   HAK_AKSES_ID         INT2                 null default 0,
   constraint PK_MENU_AKSES primary key (MENU_ID, GRUP_ID)
);

comment on table MENU_AKSES is
'HAK AKSES TERHADAP MENU';

/*==============================================================*/
/* Index: MENU_AKSES_PK                                         */
/*==============================================================*/
create unique index MENU_AKSES_PK on MENU_AKSES (
MENU_ID,
GRUP_ID
);

/*==============================================================*/
/* Index: REF_MNU__MNU_ACS_FK                                   */
/*==============================================================*/
create  index REF_MNU__MNU_ACS_FK on MENU_AKSES (
MENU_ID
);

/*==============================================================*/
/* Index: REF__GROUP__MNU_ACS_FK                                */
/*==============================================================*/
create  index REF__GROUP__MNU_ACS_FK on MENU_AKSES (
GRUP_ID
);

/*==============================================================*/
/* Index: REF__AKSES_AKSES_FK                                   */
/*==============================================================*/
create  index REF__AKSES_AKSES_FK on MENU_AKSES (
HAK_AKSES_ID
);

/*==============================================================*/
/* Table: M_ARSIP                                               */
/*==============================================================*/
create table M_ARSIP (
   BERKAS_ID            INT4                 not null,
   ID                   INT2                 not null,
   KODE_FOLDER          VARCHAR(255)         null,
   KODE_RAK             VARCHAR(255)         null,
   KODE_BOX             VARCHAR(255)         null,
   constraint PK_M_ARSIP primary key (BERKAS_ID, ID)
);

comment on table M_ARSIP is
'MASTER ARSIP';

/*==============================================================*/
/* Index: M_ARSIP_PK                                            */
/*==============================================================*/
create unique index M_ARSIP_PK on M_ARSIP (
BERKAS_ID,
ID
);

/*==============================================================*/
/* Index: REF__ARSIP__BERKAS_FK                                 */
/*==============================================================*/
create  index REF__ARSIP__BERKAS_FK on M_ARSIP (
BERKAS_ID
);

/*==============================================================*/
/* Index: REF__STATUS_BERKAS_FK                                 */
/*==============================================================*/
create  index REF__STATUS_BERKAS_FK on M_ARSIP (
ID
);

/*==============================================================*/
/* Table: M_BERKAS                                              */
/*==============================================================*/
create table M_BERKAS (
   ID                   SERIAL               not null,
   PID                  INT4                 null,
   PEGAWAI_ID           INT4                 null,
   BERKAS_KLAS_ID       INT4                 null,
   UNIT_KERJA_ID        INT4                 null,
   BERKAS_TIPE_ID       INT4                 null,
   TIPE_FILE            INT2                 null default 0,
   SHA                  VARCHAR(255)         null,
   NAMA                 VARCHAR(255)         null,
   TGL_UNGGAH           DATE                 not null default current_date,
   TGL_DIBUAT           DATE                 null,
   NOMOR                VARCHAR(64)          null,
   PEMBUAT              VARCHAR(255)         null,
   JUDUL                VARCHAR(255)         null,
   MASALAH              VARCHAR(255)         null,
   JRA                  INT2                 null,
   STATUS               INT2                 null default 1,
   STATUS_HAPUS         INT2                 null default 1,
   AKSES_BERBAGI_ID     INT4                 null default 0,
   constraint PK_M_BERKAS primary key (ID)
);

comment on table M_BERKAS is
'MASTER BERKAS';

comment on column M_BERKAS.JRA is
'Masa JRA dalam tahun';

comment on column M_BERKAS.STATUS is
'1 = AKTIF; 2 : INAKTIF';

/*==============================================================*/
/* Index: M_BERKAS_PK                                           */
/*==============================================================*/
create unique index M_BERKAS_PK on M_BERKAS (
ID
);

/*==============================================================*/
/* Index: REF_TIPE_ARSIP_FK                                     */
/*==============================================================*/
create  index REF_TIPE_ARSIP_FK on M_BERKAS (
BERKAS_TIPE_ID
);

/*==============================================================*/
/* Index: REF__KLAS__ARSIP_FK                                   */
/*==============================================================*/
create  index REF__KLAS__ARSIP_FK on M_BERKAS (
BERKAS_KLAS_ID
);

/*==============================================================*/
/* Index: REF__UNIT__BERKAS_FK                                  */
/*==============================================================*/
create  index REF__UNIT__BERKAS_FK on M_BERKAS (
UNIT_KERJA_ID
);

/*==============================================================*/
/* Index: REF__PEGAWAI__BERKAS_FK                               */
/*==============================================================*/
create  index REF__PEGAWAI__BERKAS_FK on M_BERKAS (
PEGAWAI_ID
);

/*==============================================================*/
/* Table: M_BERKAS_BERBAGI                                      */
/*==============================================================*/
create table M_BERKAS_BERBAGI (
   BAGI_KE_PEG_ID       INT4                 not null,
   BERKAS_ID            INT4                 not null,
   ID                   SERIAL               not null,
   constraint PK_M_BERKAS_BERBAGI primary key (BAGI_KE_PEG_ID, BERKAS_ID, ID)
);

comment on table M_BERKAS_BERBAGI is
'MASTER UNTUK BERBAGI BERKAS';

/*==============================================================*/
/* Index: M_BERKAS_BERBAGI_PK                                   */
/*==============================================================*/
create unique index M_BERKAS_BERBAGI_PK on M_BERKAS_BERBAGI (
BAGI_KE_PEG_ID,
BERKAS_ID,
ID
);

/*==============================================================*/
/* Index: REF_PEGAWAI__BERBAGI_FK                               */
/*==============================================================*/
create  index REF_PEGAWAI__BERBAGI_FK on M_BERKAS_BERBAGI (
BAGI_KE_PEG_ID
);

/*==============================================================*/
/* Index: REF__BERKAS__BERBAGI_FK                               */
/*==============================================================*/
create  index REF__BERKAS__BERBAGI_FK on M_BERKAS_BERBAGI (
BERKAS_ID
);

/*==============================================================*/
/* Table: M_GRUP                                                */
/*==============================================================*/
create table M_GRUP (
   ID                   SERIAL               not null,
   NAMA                 VARCHAR(64)          null,
   KETERANGAN           VARCHAR(255)         null,
   constraint PK_M_GRUP primary key (ID)
);

comment on table M_GRUP is
'GRUP PEGAWAI';

/*==============================================================*/
/* Index: M_GRUP_PK                                             */
/*==============================================================*/
create unique index M_GRUP_PK on M_GRUP (
ID
);

/*==============================================================*/
/* Table: M_MENU                                                */
/*==============================================================*/
create table M_MENU (
   ID                   SERIAL               not null,
   PID                  INT8                 null,
   ICON                 VARCHAR(16)          null,
   NAMA_REF             VARCHAR(128)         null,
   NAMA                 VARCHAR(128)         null,
   constraint PK_M_MENU primary key (ID)
);

comment on table M_MENU is
'MASTER MENU';

/*==============================================================*/
/* Index: M_MENU_PK                                             */
/*==============================================================*/
create unique index M_MENU_PK on M_MENU (
ID
);

/*==============================================================*/
/* Table: M_PEGAWAI                                             */
/*==============================================================*/
create table M_PEGAWAI (
   ID                   SERIAL               not null,
   UNIT_KERJA_ID        INT4                 null,
   GRUP_ID              INT4                 null,
   JABATAN_ID           INT4                 null,
   NIP                  VARCHAR(64)          null,
   NAMA                 VARCHAR(128)         null,
   PSW                  VARCHAR(255)         null,
   STATUS               INT2                 null default 1,
   constraint PK_M_PEGAWAI primary key (ID),
   constraint AK_KEY_2_M_PEGAWA unique (NIP)
);

comment on table M_PEGAWAI is
'MASTER USER/PEGAWAI';

comment on column M_PEGAWAI.STATUS is
'0 = NON AKTIF; 1 = AKTIF ';

/*==============================================================*/
/* Index: M_PEGAWAI_PK                                          */
/*==============================================================*/
create unique index M_PEGAWAI_PK on M_PEGAWAI (
ID
);

/*==============================================================*/
/* Index: REF__GROUP__USER_FK                                   */
/*==============================================================*/
create  index REF__GROUP__USER_FK on M_PEGAWAI (
GRUP_ID
);

/*==============================================================*/
/* Index: REF__JAB__PEGAWAI_FK                                  */
/*==============================================================*/
create  index REF__JAB__PEGAWAI_FK on M_PEGAWAI (
JABATAN_ID
);

/*==============================================================*/
/* Index: REF__UNIT_PEG_FK                                      */
/*==============================================================*/
create  index REF__UNIT_PEG_FK on M_PEGAWAI (
UNIT_KERJA_ID
);

/*==============================================================*/
/* Table: M_SYSCONFIG                                           */
/*==============================================================*/
create table M_SYSCONFIG (
   REPOSITORY_ROOT      VARCHAR(1024)        not null
);

comment on table M_SYSCONFIG is
'MASTER KONFIGURASI SYSTEM';

/*==============================================================*/
/* Table: M_UNIT_KERJA                                          */
/*==============================================================*/
create table M_UNIT_KERJA (
   ID                   SERIAL               not null,
   KODE                 VARCHAR(32)          not null,
   NAMA                 VARCHAR(128)         null,
   NAMA_PIMPINAN        VARCHAR(128)         null,
   KETERANGAN           VARCHAR(255)         null,
   constraint PK_M_UNIT_KERJA primary key (ID),
   constraint AK_KEY_2_M_UNIT_K unique (KODE)
);

comment on table M_UNIT_KERJA is
'MASTER UNIT KERJA';

/*==============================================================*/
/* Index: M_UNIT_KERJA_PK                                       */
/*==============================================================*/
create unique index M_UNIT_KERJA_PK on M_UNIT_KERJA (
ID
);

/*==============================================================*/
/* Table: PEMINJAMAN_RINCI                                      */
/*==============================================================*/
create table PEMINJAMAN_RINCI (
   ID                   INT4                 not null,
   BERKAS_ID            INT4                 null,
   constraint PK_PEMINJAMAN_RINCI primary key (ID)
);

comment on table PEMINJAMAN_RINCI is
'PEMINJAMAN DETAIL';

/*==============================================================*/
/* Index: PEMINJAMAN_RINCI_PK                                   */
/*==============================================================*/
create unique index PEMINJAMAN_RINCI_PK on PEMINJAMAN_RINCI (
ID
);

/*==============================================================*/
/* Index: REF__BERKAS__PIN_RIN_FK                               */
/*==============================================================*/
create  index REF__BERKAS__PIN_RIN_FK on PEMINJAMAN_RINCI (
BERKAS_ID
);

/*==============================================================*/
/* Table: R_AKSES_BERBAGI                                       */
/*==============================================================*/
create table R_AKSES_BERBAGI (
   ID                   INT2                 not null,
   KETERANGAN           VARCHAR(255)         null,
   constraint PK_R_AKSES_BERBAGI primary key (ID)
);

comment on table R_AKSES_BERBAGI is
'REFERENSI UNTUK BERBAGI AKSES';

/*==============================================================*/
/* Index: R_AKSES_BERBAGI_PK                                    */
/*==============================================================*/
create unique index R_AKSES_BERBAGI_PK on R_AKSES_BERBAGI (
ID
);

/*==============================================================*/
/* Table: R_AKSES_MENU                                          */
/*==============================================================*/
create table R_AKSES_MENU (
   ID                   INT2                 not null,
   KETERANGAN           VARCHAR(255)         null,
   constraint PK_R_AKSES_MENU primary key (ID)
);

comment on table R_AKSES_MENU is
'REFERENSI AKSES MENU
';

/*==============================================================*/
/* Index: R_AKSES_MENU_PK                                       */
/*==============================================================*/
create unique index R_AKSES_MENU_PK on R_AKSES_MENU (
ID
);

/*==============================================================*/
/* Table: R_ARSIP_STATUS                                        */
/*==============================================================*/
create table R_ARSIP_STATUS (
   ID                   INT2                 not null,
   KETERANGAN           VARCHAR(255)         null,
   constraint PK_R_ARSIP_STATUS primary key (ID)
);

comment on table R_ARSIP_STATUS is
'REFERENSI ARSIP STATUS';

/*==============================================================*/
/* Index: R_ARSIP_STATUS_PK                                     */
/*==============================================================*/
create unique index R_ARSIP_STATUS_PK on R_ARSIP_STATUS (
ID
);

/*==============================================================*/
/* Table: R_BERKAS_KLAS                                         */
/*==============================================================*/
create table R_BERKAS_KLAS (
   ID                   SERIAL               not null,
   UNIT_KERJA_ID        INT4                 null,
   KODE                 VARCHAR(6)           not null,
   NAMA                 VARCHAR(64)          not null,
   KETERANGAN           VARCHAR(255)         not null,
   constraint PK_R_BERKAS_KLAS primary key (ID)
);

comment on table R_BERKAS_KLAS is
'REFERENSI KLASIFIKASI BERKAS';

/*==============================================================*/
/* Index: R_BERKAS_KLAS_PK                                      */
/*==============================================================*/
create unique index R_BERKAS_KLAS_PK on R_BERKAS_KLAS (
ID
);

/*==============================================================*/
/* Index: REF__UNIT__KLAS_FK                                    */
/*==============================================================*/
create  index REF__UNIT__KLAS_FK on R_BERKAS_KLAS (
UNIT_KERJA_ID
);

/*==============================================================*/
/* Table: R_BERKAS_TIPE                                         */
/*==============================================================*/
create table R_BERKAS_TIPE (
   ID                   SERIAL               not null,
   NAMA                 VARCHAR(64)          null,
   KETERANGAN           VARCHAR(255)         null,
   constraint PK_R_BERKAS_TIPE primary key (ID)
);

comment on table R_BERKAS_TIPE is
'REFERENSI TIPE ARSIP';

/*==============================================================*/
/* Index: R_BERKAS_TIPE_PK                                      */
/*==============================================================*/
create unique index R_BERKAS_TIPE_PK on R_BERKAS_TIPE (
ID
);

/*==============================================================*/
/* Table: R_IR                                                  */
/*==============================================================*/
create table R_IR (
   ID                   SERIAL               not null,
   BERKAS_KLAS_ID       INT4                 null,
   KETERANGAN           VARCHAR(64)          null,
   constraint PK_R_IR primary key (ID)
);

comment on table R_IR is
'REFERNSI INDEKS RELATIF';

/*==============================================================*/
/* Index: R_IR_PK                                               */
/*==============================================================*/
create unique index R_IR_PK on R_IR (
ID
);

/*==============================================================*/
/* Index: REF__KLAS__IR_FK                                      */
/*==============================================================*/
create  index REF__KLAS__IR_FK on R_IR (
BERKAS_KLAS_ID
);

/*==============================================================*/
/* Table: R_JABATAN                                             */
/*==============================================================*/
create table R_JABATAN (
   ID                   SERIAL               not null,
   NAMA                 VARCHAR(128)         null,
   KETERANGAN           VARCHAR(255)         null,
   constraint PK_R_JABATAN primary key (ID)
);

comment on table R_JABATAN is
'REFERENSI JABATAN';

/*==============================================================*/
/* Index: R_JABATAN_PK                                          */
/*==============================================================*/
create unique index R_JABATAN_PK on R_JABATAN (
ID
);

/*==============================================================*/
/* Table: R_PEMUSNAHAN_METODA                                   */
/*==============================================================*/
create table R_PEMUSNAHAN_METODA (
   ID                   SERIAL               not null,
   NAMA                 VARCHAR(128)         null,
   KETERANGAN           VARCHAR(255)         null,
   constraint PK_R_PEMUSNAHAN_METODA primary key (ID)
);

comment on table R_PEMUSNAHAN_METODA is
'REFERENSI METODA PEMUSNAHAN';

/*==============================================================*/
/* Index: R_PEMUSNAHAN_METODA_PK                                */
/*==============================================================*/
create unique index R_PEMUSNAHAN_METODA_PK on R_PEMUSNAHAN_METODA (
ID
);

/*==============================================================*/
/* Table: T_PEMINDAHAN                                          */
/*==============================================================*/
create table T_PEMINDAHAN (
   ID                   SERIAL               not null,
   UNIT_KERJA_ID        INT4                 null,
   KODE                 VARCHAR(255)         null,
   TGL                  DATE                 null,
   STATUS               INT2                 null,
   NAMA_PETUGAS         VARCHAR(128)         null,
   PJ_UNIT_KERJA        VARCHAR(128)         null,
   PJ_UNIT_ARSIP        VARCHAR(128)         null,
   constraint PK_T_PEMINDAHAN primary key (ID)
);

comment on table T_PEMINDAHAN is
'TRANSAKSI PEMINDAHAN';

comment on column T_PEMINDAHAN.STATUS is
'0 = TIDAK LENGKAP; 1 LENGKAP';

/*==============================================================*/
/* Index: T_PEMINDAHAN_PK                                       */
/*==============================================================*/
create unique index T_PEMINDAHAN_PK on T_PEMINDAHAN (
ID
);

/*==============================================================*/
/* Index: REF__UNIT_PINDAH_FK                                   */
/*==============================================================*/
create  index REF__UNIT_PINDAH_FK on T_PEMINDAHAN (
UNIT_KERJA_ID
);

/*==============================================================*/
/* Table: T_PEMINDAHAN_RINCI                                    */
/*==============================================================*/
create table T_PEMINDAHAN_RINCI (
   ID                   INT4                 not null,
   BERKAS_ID            INT4                 not null,
   constraint PK_T_PEMINDAHAN_RINCI primary key (ID, BERKAS_ID)
);

comment on table T_PEMINDAHAN_RINCI is
'RINCIAN PEMINDAHAN';

/*==============================================================*/
/* Index: T_PEMINDAHAN_RINCI_PK                                 */
/*==============================================================*/
create unique index T_PEMINDAHAN_RINCI_PK on T_PEMINDAHAN_RINCI (
ID,
BERKAS_ID
);

/*==============================================================*/
/* Index: REF_PINDAH___RINCI_FK                                 */
/*==============================================================*/
create  index REF_PINDAH___RINCI_FK on T_PEMINDAHAN_RINCI (
ID
);

/*==============================================================*/
/* Index: REF_BERKAS__PINDAH_FK                                 */
/*==============================================================*/
create  index REF_BERKAS__PINDAH_FK on T_PEMINDAHAN_RINCI (
BERKAS_ID
);

/*==============================================================*/
/* Table: T_PEMINJAMAN                                          */
/*==============================================================*/
create table T_PEMINJAMAN (
   ID                   SERIAL               not null,
   UNIT_KERJA_ID        INT4                 null,
   NAMA_PETUGAS         VARCHAR(128)         null,
   NAMA_PIMPINAN_PETUGAS VARCHAR(128)         null,
   NAMA_PEMINJAM        VARCHAR(128)         null,
   NAMA_PIMPINAN_PEMINJAM VARCHAR(128)         null,
   TGL_PINJAM           DATE                 null,
   TGL_BATAS_KEMBALI    DATE                 null,
   TGL_KEMBALI          DATE                 null,
   KETERANGAN           VARCHAR(255)         null,
   constraint PK_T_PEMINJAMAN primary key (ID)
);

comment on table T_PEMINJAMAN is
'TRANSAKSI PEMINJAMAN';

/*==============================================================*/
/* Index: T_PEMINJAMAN_PK                                       */
/*==============================================================*/
create unique index T_PEMINJAMAN_PK on T_PEMINJAMAN (
ID
);

/*==============================================================*/
/* Index: REF__UNIT__PINJAM_FK                                  */
/*==============================================================*/
create  index REF__UNIT__PINJAM_FK on T_PEMINJAMAN (
UNIT_KERJA_ID
);

/*==============================================================*/
/* Table: T_PEMUSNAHAN                                          */
/*==============================================================*/
create table T_PEMUSNAHAN (
   ID                   SERIAL               not null,
   METODA_ID            INT4                 not null,
   NAMA_PETUGAS         VARCHAR(128)         null,
   TGL                  DATE                 null,
   PJ_UNIT_KERJA        VARCHAR(128)         null,
   PJ_BERKAS_ARSIP      VARCHAR(128)         null,
   constraint PK_T_PEMUSNAHAN primary key (ID)
);

comment on table T_PEMUSNAHAN is
'TRANSAKSI PEMUSNAHAN';

/*==============================================================*/
/* Index: T_PEMUSNAHAN_PK                                       */
/*==============================================================*/
create unique index T_PEMUSNAHAN_PK on T_PEMUSNAHAN (
ID
);

/*==============================================================*/
/* Index: REF__METODA___PEMUSNAHAN_FK                           */
/*==============================================================*/
create  index REF__METODA___PEMUSNAHAN_FK on T_PEMUSNAHAN (
METODA_ID
);

/*==============================================================*/
/* Table: T_PEMUSNAHAN_RINCI                                    */
/*==============================================================*/
create table T_PEMUSNAHAN_RINCI (
   PEMUSNAHAN_ID        INT4                 not null,
   ID                   INT4                 not null,
   KETERANGAN           VARCHAR(255)         null,
   JML_LEMBAR           INT2                 null,
   JML_SET              INT2                 null,
   JML_BERKAS           INT2                 null,
   constraint PK_T_PEMUSNAHAN_RINCI primary key (PEMUSNAHAN_ID, ID)
);

comment on table T_PEMUSNAHAN_RINCI is
'PEMUSNAHAN DETAIL';

/*==============================================================*/
/* Index: T_PEMUSNAHAN_RINCI_PK                                 */
/*==============================================================*/
create unique index T_PEMUSNAHAN_RINCI_PK on T_PEMUSNAHAN_RINCI (
PEMUSNAHAN_ID,
ID
);

/*==============================================================*/
/* Index: REF_MUSNAH__MUSNAH_RINCI_FK                           */
/*==============================================================*/
create  index REF_MUSNAH__MUSNAH_RINCI_FK on T_PEMUSNAHAN_RINCI (
PEMUSNAHAN_ID
);

/*==============================================================*/
/* Index: REF__BERKAS_RINCI_FK                                  */
/*==============================================================*/
create  index REF__BERKAS_RINCI_FK on T_PEMUSNAHAN_RINCI (
ID
);

/*==============================================================*/
/* Table: T_TIM_PEMUSNAHAN                                      */
/*==============================================================*/
create table T_TIM_PEMUSNAHAN (
   ID                   INT4                 not null,
   NOMOR                INT2                 not null,
   NAMA                 VARCHAR(128)         null,
   JABATAN              VARCHAR(128)         null,
   constraint PK_T_TIM_PEMUSNAHAN primary key (ID, NOMOR)
);

comment on table T_TIM_PEMUSNAHAN is
'TIM PEMUSNAHAN';

/*==============================================================*/
/* Index: T_TIM_PEMUSNAHAN_PK                                   */
/*==============================================================*/
create unique index T_TIM_PEMUSNAHAN_PK on T_TIM_PEMUSNAHAN (
ID,
NOMOR
);

/*==============================================================*/
/* Index: REF__MUSNAH__TEAM_FK                                  */
/*==============================================================*/
create  index REF__MUSNAH__TEAM_FK on T_TIM_PEMUSNAHAN (
ID
);

alter table LOG
   add constraint FK_LOG_REF_USER__M_PEGAWA foreign key (PEGAWAI_ID)
      references M_PEGAWAI (ID)
      on delete restrict on update restrict;

alter table LOG
   add constraint FK_LOG_REF__MENU_M_MENU foreign key (MENU_ID)
      references M_MENU (ID)
      on delete restrict on update restrict;

alter table MENU_AKSES
   add constraint FK_MENU_AKS_REF_MNU___M_MENU foreign key (MENU_ID)
      references M_MENU (ID)
      on delete restrict on update restrict;

alter table MENU_AKSES
   add constraint FK_MENU_AKS_REF__AKSE_R_AKSES_ foreign key (HAK_AKSES_ID)
      references R_AKSES_MENU (ID)
      on delete restrict on update restrict;

alter table MENU_AKSES
   add constraint FK_MENU_AKS_REF__GROU_M_GRUP foreign key (GRUP_ID)
      references M_GRUP (ID)
      on delete restrict on update restrict;

alter table M_ARSIP
   add constraint FK_M_ARSIP_REF__ARSI_M_BERKAS foreign key (BERKAS_ID)
      references M_BERKAS (ID)
      on delete restrict on update restrict;

alter table M_ARSIP
   add constraint FK_M_ARSIP_REF__STAT_R_ARSIP_ foreign key (ID)
      references R_ARSIP_STATUS (ID)
      on delete restrict on update restrict;

alter table M_BERKAS
   add constraint FK_M_BERKAS_REF_TIPE__R_BERKAS foreign key (BERKAS_TIPE_ID)
      references R_BERKAS_TIPE (ID)
      on delete restrict on update restrict;

alter table M_BERKAS
   add constraint FK_M_BERKAS_REF__KLAS_R_BERKAS foreign key (BERKAS_KLAS_ID)
      references R_BERKAS_KLAS (ID)
      on delete restrict on update restrict;

alter table M_BERKAS
   add constraint FK_M_BERKAS_REF__PEGA_M_PEGAWA foreign key (PEGAWAI_ID)
      references M_PEGAWAI (ID)
      on delete restrict on update restrict;

alter table M_BERKAS
   add constraint FK_M_BERKAS_REF__UNIT_M_UNIT_K foreign key (UNIT_KERJA_ID)
      references M_UNIT_KERJA (ID)
      on delete restrict on update restrict;

alter table M_BERKAS
   add constraint FK_M_BERKAS_BERBAGI_REF__R_AKSES_BERBAGI foreign key (AKSES_BERBAGI_ID)
      references R_AKSES_BERBAGI (ID)
      on delete restrict on update restrict;

alter table M_BERKAS_BERBAGI
   add constraint FK_M_BERKAS_REF_PEGAW_M_PEGAWA foreign key (BAGI_KE_PEG_ID)
      references M_PEGAWAI (ID)
      on delete restrict on update restrict;

alter table M_BERKAS_BERBAGI
   add constraint FK_M_BERKAS_REF__BERK_M_BERKAS foreign key (BERKAS_ID)
      references M_BERKAS (ID)
      on delete restrict on update restrict;

alter table M_PEGAWAI
   add constraint FK_M_PEGAWA_REF__GROU_M_GRUP foreign key (GRUP_ID)
      references M_GRUP (ID)
      on delete restrict on update restrict;

alter table M_PEGAWAI
   add constraint FK_M_PEGAWA_REF__JAB__R_JABATA foreign key (JABATAN_ID)
      references R_JABATAN (ID)
      on delete restrict on update restrict;

alter table M_PEGAWAI
   add constraint FK_M_PEGAWA_REF__UNIT_M_UNIT_K foreign key (UNIT_KERJA_ID)
      references M_UNIT_KERJA (ID)
      on delete restrict on update restrict;

alter table PEMINJAMAN_RINCI
   add constraint FK_PEMINJAM_REF_PMJ_A_T_PEMINJ foreign key (ID)
      references T_PEMINJAMAN (ID)
      on delete restrict on update restrict;

alter table PEMINJAMAN_RINCI
   add constraint FK_PEMINJAM_REF__BERK_M_BERKAS foreign key (BERKAS_ID)
      references M_BERKAS (ID)
      on delete restrict on update restrict;

alter table R_BERKAS_KLAS
   add constraint FK_R_BERKAS_REF__UNIT_M_UNIT_K foreign key (UNIT_KERJA_ID)
      references M_UNIT_KERJA (ID)
      on delete restrict on update restrict;

alter table R_IR
   add constraint FK_R_IR_REF__KLAS_R_BERKAS foreign key (BERKAS_KLAS_ID)
      references R_BERKAS_KLAS (ID)
      on delete restrict on update restrict;

alter table T_PEMINDAHAN
   add constraint FK_T_PEMIND_REF__UNIT_M_UNIT_K foreign key (UNIT_KERJA_ID)
      references M_UNIT_KERJA (ID)
      on delete restrict on update restrict;

alter table T_PEMINDAHAN_RINCI
   add constraint FK_T_PEMIND_REF_BERKA_M_BERKAS foreign key (BERKAS_ID)
      references M_BERKAS (ID)
      on delete restrict on update restrict;

alter table T_PEMINDAHAN_RINCI
   add constraint FK_T_PEMIND_REF_PINDA_T_PEMIND foreign key (ID)
      references T_PEMINDAHAN (ID)
      on delete restrict on update restrict;

alter table T_PEMINJAMAN
   add constraint FK_T_PEMINJ_REF__UNIT_M_UNIT_K foreign key (UNIT_KERJA_ID)
      references M_UNIT_KERJA (ID)
      on delete restrict on update restrict;

alter table T_PEMUSNAHAN
   add constraint FK_T_PEMUSN_REF__METO_R_PEMUSN foreign key (METODA_ID)
      references R_PEMUSNAHAN_METODA (ID)
      on delete restrict on update restrict;

alter table T_PEMUSNAHAN_RINCI
   add constraint FK_T_PEMUSN_REF_MUSNA_T_PEMUSN foreign key (PEMUSNAHAN_ID)
      references T_PEMUSNAHAN (ID)
      on delete restrict on update restrict;

alter table T_PEMUSNAHAN_RINCI
   add constraint FK_T_PEMUSN_REF__BERK_M_BERKAS foreign key (ID)
      references M_BERKAS (ID)
      on delete restrict on update restrict;

alter table T_TIM_PEMUSNAHAN
   add constraint FK_T_TIM_PE_REF__MUSN_T_PEMUSN foreign key (ID)
      references T_PEMUSNAHAN (ID)
      on delete restrict on update restrict;
