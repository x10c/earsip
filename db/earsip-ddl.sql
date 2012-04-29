/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     4/29/2012 10:02:12 AM                        */
/*==============================================================*/


/*==============================================================*/
/* Table: M_DIVISI                                              */
/*==============================================================*/
create table M_DIVISI (
   DIV_ID               SERIAL               not null,
   DIV_KODE             VARCHAR(8)           not null,
   DIV_NAME             VARCHAR(255)         null,
   DIV_LEADER           VARCHAR(255)         null,
   constraint PK_M_DIVISI primary key (DIV_ID),
   constraint AK_KEY_2_M_DIVISI unique (DIV_KODE)
);

/*==============================================================*/
/* Table: M_SUBDIV                                              */
/*==============================================================*/
create table M_SUBDIV (
   SUBDIV_ID            SERIAL               not null,
   DIV_ID               INT4                 not null,
   SUBDIV_KODE          VARCHAR(8)           not null,
   SUBDIV_NAME          VARCHAR(255)         null,
   SUBDIV_LEADER        VARCHAR(255)         null,
   constraint PK_M_SUBDIV primary key (SUBDIV_ID),
   constraint AK_KEY_2_M_SUBDIV unique (SUBDIV_KODE),
   constraint FK_M_SUBDIV_REF_DIV___M_DIVISI foreign key (DIV_ID)
      references M_DIVISI (DIV_ID)
      on delete restrict on update restrict
);

/*==============================================================*/
/* Table: M_USER                                                */
/*==============================================================*/
create table M_USER (
   USER_ID              SERIAL               not null,
   SUBDIV_ID            INT4                 null,
   USER_NIP             VARCHAR(255)         not null,
   USER_PSW             VARCHAR(255)         null,
   USER_NAME            VARCHAR(255)         null,
   constraint PK_M_USER primary key (USER_ID),
   constraint AK_KEY_2_M_USER unique (USER_NIP),
   constraint FK_M_USER_REF_SUBDI_M_SUBDIV foreign key (SUBDIV_ID)
      references M_SUBDIV (SUBDIV_ID)
      on delete restrict on update restrict
);

/*==============================================================*/
/* Table: R_ARSIP_TIPE                                          */
/*==============================================================*/
create table R_ARSIP_TIPE (
   ID                   SERIAL               not null,
   NAME                 VARCHAR(255)         null,
   COMMENT              VARCHAR(1024)        null,
   constraint PK_R_ARSIP_TIPE primary key (ID)
);

comment on table R_ARSIP_TIPE is
'Arsip tipe bersifat dinamis, bisa dirubah oleh user.';

/*==============================================================*/
/* Table: M_ARSIP                                               */
/*==============================================================*/
create table M_ARSIP (
   ID                   SERIAL               not null,
   PID                  INT4                 null,
   NODE_TYPE            INT2                 null default 0,
   NAME                 VARCHAR(255)         null,
   USER_ID              INT4                 null,
   DATE_CREATED         DATE                 null default CURRENT_DATE,
   ARSIP_TIPE_ID        INT4                 null,
   STATUS               INT2                 null,
   JRA                  INT2                 null,
   DEL_STATUS           BOOL                 null default false,
   KODE_RAK             VARCHAR(12)          null,
   KODE_BOX             VARCHAR(12)          null,
   constraint PK_M_ARSIP primary key (ID),
   constraint FK_M_ARSIP_REF_TIPE__R_ARSIP_ foreign key (ARSIP_TIPE_ID)
      references R_ARSIP_TIPE (ID)
      on delete restrict on update restrict,
   constraint FK_M_ARSIP_R__M_ARSI_M_USER foreign key (USER_ID)
      references M_USER (USER_ID)
      on delete restrict on update restrict
);

comment on column M_ARSIP.STATUS is
'1:Ada - Aktif
2:Ada - Inaktif, tapi arsip masih ada di unit/cabang.
3:Ada - Inaktif, arsip telah berada di unit arsip.
4:Ada - Dipinjam/keluar
5:Tidak ada - Musnah
6:Tidak ada - Hilang';

comment on column M_ARSIP.JRA is
'Masa JRA dalam tahun';

/*==============================================================*/
/* Table: ARSIP_SHARED                                          */
/*==============================================================*/
create table ARSIP_SHARED (
   USER_ID              INT4                 not null,
   ID                   INT4                 not null,
   ACCESS_LEVEL         INT2                 not null,
   constraint FK_ARSIP_SH_REF_USER__M_USER foreign key (USER_ID)
      references M_USER (USER_ID)
      on delete restrict on update restrict,
   constraint FK_ARSIP_SH_REF_DIR___M_ARSIP foreign key (ID)
      references M_ARSIP (ID)
      on delete restrict on update restrict
);

comment on table ARSIP_SHARED is
'Untuk keamanan hanya dokumen yang dapat di bagi ke user lain.';

comment on column ARSIP_SHARED.ACCESS_LEVEL is
'0 = NO ACCESS
1 = VIEW
2 = INSERT
3 = UPDATE
4 = DELETE';

/*==============================================================*/
/* Index: REF_USER__ACCESS_FK                                   */
/*==============================================================*/
create  index REF_USER__ACCESS_FK on ARSIP_SHARED (
USER_ID
);

/*==============================================================*/
/* Index: REF_DIR__ARSP_ACS_FK                                  */
/*==============================================================*/
create  index REF_DIR__ARSP_ACS_FK on ARSIP_SHARED (
ID
);

/*==============================================================*/
/* Table: BERITA_ACARA                                          */
/*==============================================================*/
create table BERITA_ACARA (
   ID                   SERIAL               not null,
   SUBDIV_ID            INT4                 not null,
   BERITA_ACARA_SK      CHAR(255)            null,
   constraint PK_BERITA_ACARA primary key (ID),
   constraint FK_BERITA_A_REF_SUBDI_M_SUBDIV foreign key (SUBDIV_ID)
      references M_SUBDIV (SUBDIV_ID)
      on delete restrict on update restrict
);

/*==============================================================*/
/* Index: M_BERITA_ACARA_PK                                     */
/*==============================================================*/
create unique index M_BERITA_ACARA_PK on BERITA_ACARA (
ID
);

/*==============================================================*/
/* Index: REF_SUBDIV__ACARA_FK                                  */
/*==============================================================*/
create  index REF_SUBDIV__ACARA_FK on BERITA_ACARA (
SUBDIV_ID
);

/*==============================================================*/
/* Table: BERITA_ACARA_RINCIAN                                  */
/*==============================================================*/
create table BERITA_ACARA_RINCIAN (
   BERITA_ACARA_ID      INT4                 not null,
   ARSIP_ID             INT4                 not null,
   CHECK_STATUS         INT2                 null,
   constraint FK_BERITA_A_REF_BRT_A_BERITA_A foreign key (BERITA_ACARA_ID)
      references BERITA_ACARA (ID)
      on delete restrict on update restrict,
   constraint FK_BERITA_A_REF_ARSIP_M_ARSIP foreign key (ARSIP_ID)
      references M_ARSIP (ID)
      on delete restrict on update restrict
);

comment on column BERITA_ACARA_RINCIAN.CHECK_STATUS is
'0:Not OK, arsip tidak ada dalam kotak saat di cek di unit arsip
1:OK, arsip ada dalam kotal saat di cek di unit arsip';

/*==============================================================*/
/* Index: REF_BRT_ACR__BRT_RINCI_FK                             */
/*==============================================================*/
create  index REF_BRT_ACR__BRT_RINCI_FK on BERITA_ACARA_RINCIAN (
BERITA_ACARA_ID
);

/*==============================================================*/
/* Index: REF_ARSIP__ACR_RINCI_FK                               */
/*==============================================================*/
create  index REF_ARSIP__ACR_RINCI_FK on BERITA_ACARA_RINCIAN (
ARSIP_ID
);

/*==============================================================*/
/* Table: M_MENU                                                */
/*==============================================================*/
create table M_MENU (
   MENU_ID              SERIAL               not null,
   MENU_PARENT_ID       INT4                 null,
   MENU_NAME            VARCHAR(255)         null,
   MENU_INDEX           VARCHAR(64)          null,
   constraint PK_M_MENU primary key (MENU_ID)
);

/*==============================================================*/
/* Table: LOG                                                   */
/*==============================================================*/
create table LOG (
   ID                   DATE                 not null,
   USER_ID              INT4                 null,
   MENU_ID              INT4                 null,
   ACTION               VARCHAR(255)         null,
   constraint PK_LOG primary key (ID),
   constraint FK_LOG_REF_USER__M_USER foreign key (USER_ID)
      references M_USER (USER_ID)
      on delete restrict on update restrict,
   constraint FK_LOG_REF_LOG___M_MENU foreign key (MENU_ID)
      references M_MENU (MENU_ID)
      on delete restrict on update restrict
);

/*==============================================================*/
/* Index: M_LOG_PK                                              */
/*==============================================================*/
create unique index M_LOG_PK on LOG (
ID
);

/*==============================================================*/
/* Index: REF_USER__LOG_FK                                      */
/*==============================================================*/
create  index REF_USER__LOG_FK on LOG (
USER_ID
);

/*==============================================================*/
/* Table: MENU_ACCESS                                           */
/*==============================================================*/
create table MENU_ACCESS (
   USER_ID              INT4                 not null,
   MENU_ID              INT4                 not null,
   ACCESS_LEVEL         INT2                 null default 0,
   constraint FK_MENU_ACC_REF_USER__M_USER foreign key (USER_ID)
      references M_USER (USER_ID)
      on delete restrict on update restrict,
   constraint FK_MENU_ACC_REF_MNU___M_MENU foreign key (MENU_ID)
      references M_MENU (MENU_ID)
      on delete restrict on update restrict
);

comment on column MENU_ACCESS.ACCESS_LEVEL is
'0 = NO ACCESS
1 = VIEW
2 = INSERT
3 = UPDATE
4 = DELETE';

/*==============================================================*/
/* Index: REF_USER__MNU_ACS_FK                                  */
/*==============================================================*/
create  index REF_USER__MNU_ACS_FK on MENU_ACCESS (
USER_ID
);

/*==============================================================*/
/* Index: REF_MNU__MNU_ACS_FK                                   */
/*==============================================================*/
create  index REF_MNU__MNU_ACS_FK on MENU_ACCESS (
MENU_ID
);

/*==============================================================*/
/* Index: M_ARSIP_PK                                            */
/*==============================================================*/
create unique index M_ARSIP_PK on M_ARSIP (
ID
);

/*==============================================================*/
/* Index: REF_TIPE_ARSIP_FK                                     */
/*==============================================================*/
create  index REF_TIPE_ARSIP_FK on M_ARSIP (
ARSIP_TIPE_ID
);

/*==============================================================*/
/* Index: M_DIVISI_PK                                           */
/*==============================================================*/
create unique index M_DIVISI_PK on M_DIVISI (
DIV_ID
);

/*==============================================================*/
/* Index: M_MENU_PK                                             */
/*==============================================================*/
create unique index M_MENU_PK on M_MENU (
MENU_ID
);

/*==============================================================*/
/* Index: M_SUBDIV_PK                                           */
/*==============================================================*/
create unique index M_SUBDIV_PK on M_SUBDIV (
SUBDIV_ID
);

/*==============================================================*/
/* Index: REF_DIV__SUBDIV_FK                                    */
/*==============================================================*/
create  index REF_DIV__SUBDIV_FK on M_SUBDIV (
DIV_ID
);

/*==============================================================*/
/* Table: M_SYSCONFIG                                           */
/*==============================================================*/
create table M_SYSCONFIG (
   REPOSITORY_ROOT      VARCHAR(512)         null default '/repository'
);

comment on table M_SYSCONFIG is
'Untuk menyimpan konfigurasi aplikasi';

/*==============================================================*/
/* Index: M_USER_PK                                             */
/*==============================================================*/
create unique index M_USER_PK on M_USER (
USER_ID
);

/*==============================================================*/
/* Index: REF_SUBDIV__USR_FK                                    */
/*==============================================================*/
create  index REF_SUBDIV__USR_FK on M_USER (
SUBDIV_ID
);

/*==============================================================*/
/* Table: PEMINJAMAN_ARSIP                                      */
/*==============================================================*/
create table PEMINJAMAN_ARSIP (
   ID                   SERIAL               not null,
   PEMINJAM_USER_ID     INT4                 not null,
   TGL_PINJAM           DATE                 null,
   TGL_KEMBALI          DATE                 null,
   TGL_HARUS_KEMBALI    DATE                 null,
   PETUGAS_UNIT_ARSIP   VARCHAR(255)         null,
   PIMPINAN_UNIT_ARSIP  VARCHAR(255)         null,
   constraint PK_PEMINJAMAN_ARSIP primary key (ID),
   constraint FK_PEMINJAM_REF_USER__M_USER foreign key (PEMINJAM_USER_ID)
      references M_USER (USER_ID)
      on delete restrict on update restrict
);

/*==============================================================*/
/* Index: PEMINJAMAN_ARSIP_PK                                   */
/*==============================================================*/
create unique index PEMINJAMAN_ARSIP_PK on PEMINJAMAN_ARSIP (
ID
);

/*==============================================================*/
/* Table: PEMINJAMAN_RINCI                                      */
/*==============================================================*/
create table PEMINJAMAN_RINCI (
   ID                   INT4                 not null,
   ARSIP_ID             INT4                 not null,
   KETERANGAN           VARCHAR(255)         null,
   constraint FK_PEMINJAM_REF_PMJ_A_PEMINJAM foreign key (ID)
      references PEMINJAMAN_ARSIP (ID)
      on delete restrict on update restrict,
   constraint FK_PEMINJAM_REF_ARSIP_M_ARSIP foreign key (ARSIP_ID)
      references M_ARSIP (ID)
      on delete restrict on update restrict
);

/*==============================================================*/
/* Index: REF_PMJ_ARSIP__PMJ_RINCI_FK                           */
/*==============================================================*/
create  index REF_PMJ_ARSIP__PMJ_RINCI_FK on PEMINJAMAN_RINCI (
ID
);

/*==============================================================*/
/* Index: REF_ARSIP__PMJ_RINCI_FK                               */
/*==============================================================*/
create  index REF_ARSIP__PMJ_RINCI_FK on PEMINJAMAN_RINCI (
ARSIP_ID
);

/*==============================================================*/
/* Table: PENYUSUTAN_ARSIP                                      */
/*==============================================================*/
create table PENYUSUTAN_ARSIP (
   ID                   SERIAL               not null,
   TGL                  DATE                 null default CURRENT_DATE,
   PENANGGUNG_JAWAB     VARCHAR(255)         null,
   constraint PK_PENYUSUTAN_ARSIP primary key (ID)
);

/*==============================================================*/
/* Index: PENYUSUTAN_PK                                         */
/*==============================================================*/
create unique index PENYUSUTAN_PK on PENYUSUTAN_ARSIP (
ID
);

/*==============================================================*/
/* Table: PENYUSUTAN_RINCI                                      */
/*==============================================================*/
create table PENYUSUTAN_RINCI (
   ARSIP_ID             INT4                 not null,
   PENYUSUTAN_ID        INT4                 not null,
   KETERANGAN           VARCHAR(255)         null,
   constraint FK_PENYUSUT_REF_ARSIP_M_ARSIP foreign key (ARSIP_ID)
      references M_ARSIP (ID)
      on delete restrict on update restrict,
   constraint FK_PENYUSUT_REF_SUSUT_PENYUSUT foreign key (PENYUSUTAN_ID)
      references PENYUSUTAN_ARSIP (ID)
      on delete restrict on update restrict
);

/*==============================================================*/
/* Index: REF_ARSIP__SUSUT_RINCI_FK                             */
/*==============================================================*/
create  index REF_ARSIP__SUSUT_RINCI_FK on PENYUSUTAN_RINCI (
ARSIP_ID
);

/*==============================================================*/
/* Index: REF_SUSUT__SUSUT_RINCI_FK                             */
/*==============================================================*/
create  index REF_SUSUT__SUSUT_RINCI_FK on PENYUSUTAN_RINCI (
PENYUSUTAN_ID
);

/*==============================================================*/
/* Index: R_ARSIP_TIPE_PK                                       */
/*==============================================================*/
create unique index R_ARSIP_TIPE_PK on R_ARSIP_TIPE (
ID
);
