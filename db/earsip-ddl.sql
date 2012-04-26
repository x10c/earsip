/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     04/18/2012 23:22:58                          */
/*==============================================================*/


/*==============================================================*/
/* Table: ARSIP_ACCESS                                          */
/*==============================================================*/
create table ARSIP_ACCESS (
   USER_ID              INT4                 not null,
   DIR_ID               INT4                 not null,
   ACCESS_LEVEL         CHAR(1)              not null,
   constraint PK_ARSIP_ACCESS primary key (USER_ID, DIR_ID)
);

comment on column ARSIP_ACCESS.ACCESS_LEVEL is
'0 = NO VIEW; 1 = VIEW; 2 = INSERT; 3 = UPDATE; 4 = DELETE';

/*==============================================================*/
/* Index: ARSIP_ACCESS_PK                                       */
/*==============================================================*/
create unique index ARSIP_ACCESS_PK on ARSIP_ACCESS (
USER_ID,
DIR_ID
);

/*==============================================================*/
/* Index: REF_USER__ACCESS_FK                                   */
/*==============================================================*/
create  index REF_USER__ACCESS_FK on ARSIP_ACCESS (
USER_ID
);

/*==============================================================*/
/* Index: REF_DIR__ARSP_ACS_FK                                  */
/*==============================================================*/
create  index REF_DIR__ARSP_ACS_FK on ARSIP_ACCESS (
DIR_ID
);

/*==============================================================*/
/* Table: BERITA_ACARA_RINCIAN                                  */
/*==============================================================*/
create table BERITA_ACARA_RINCIAN (
   BERITA_ACARA_ID      INT4                 not null,
   ARSIP_ID             INT4                 not null,
   CHECK_STATUS         CHAR(1)              null,
   constraint PK_BERITA_ACARA_RINCIAN primary key (BERITA_ACARA_ID, ARSIP_ID)
);

comment on column BERITA_ACARA_RINCIAN.CHECK_STATUS is
'0 = NOT OK; 1 = OK';

/*==============================================================*/
/* Index: BERITA_ACARA_RINCIAN_PK                               */
/*==============================================================*/
create unique index BERITA_ACARA_RINCIAN_PK on BERITA_ACARA_RINCIAN (
BERITA_ACARA_ID,
ARSIP_ID
);

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
/* Table: MENU_ACCESS                                           */
/*==============================================================*/
create table MENU_ACCESS (
   USER_ID              INT4                 not null,
   MENU_ID              INT4                 not null,
   ACCESS_LEVEL         INT                  null,
   constraint PK_MENU_ACCESS primary key (USER_ID, MENU_ID)
);

comment on column MENU_ACCESS.ACCESS_LEVEL is
'0 = NO VIEW; 1 = VIEW; 2 = INSERT; 3 = UPDATE; 4 = DELETE';

/*==============================================================*/
/* Index: MENU_ACCESS_PK                                        */
/*==============================================================*/
create unique index MENU_ACCESS_PK on MENU_ACCESS (
USER_ID,
MENU_ID
);

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
/* Table: M_ARSIP                                               */
/*==============================================================*/
create table M_ARSIP (
   ARSIP_ID             SERIAL               not null,
   DIR_ID               INT4                 null,
   ARSIP_TIPE_ID        INT4                 null,
   ARSIP_NAME           VARCHAR(255)         null,
   ARSIP_AUTHOR         VARCHAR(255)         null,
   ARSIP_DATE_CREATED   DATE                 not null,
   ARSIP_STATUS         CHAR(1)              not null,
   ARSIP_JRA            INT2                 null,
   ARSIP_DEL_STATUS     BOOL                 null,
   constraint PK_M_ARSIP primary key (ARSIP_ID)
);

comment on column M_ARSIP.ARSIP_STATUS is
'1 = Ada - Aktif 
2 = Ada - Inaktif, tapi arsip masih ada di unit/cabang.
3 = Ada - Inaktif, arsip telah berada di unit arsip.
4 = Ada - Dipinjam/keluar
5 = Tidak ada - Musnah
6 = Tidak ada - Hilang';

comment on column M_ARSIP.ARSIP_JRA is
'Masa JRA dalam tahun';

/*==============================================================*/
/* Index: M_ARSIP_PK                                            */
/*==============================================================*/
create unique index M_ARSIP_PK on M_ARSIP (
ARSIP_ID
);

/*==============================================================*/
/* Index: REF_TIPE_ARSIP_FK                                     */
/*==============================================================*/
create  index REF_TIPE_ARSIP_FK on M_ARSIP (
ARSIP_TIPE_ID
);

/*==============================================================*/
/* Index: REF_DIREKTORI_ARSIP_FK                                */
/*==============================================================*/
create  index REF_DIREKTORI_ARSIP_FK on M_ARSIP (
DIR_ID
);

/*==============================================================*/
/* Table: M_BERITA_ACARA                                        */
/*==============================================================*/
create table M_BERITA_ACARA (
   BERITA_ACARA_ID      SERIAL               not null,
   SUBDIV_ID            INT4                 null,
   BERITA_ACARA_SK      CHAR(255)            null,
   constraint PK_M_BERITA_ACARA primary key (BERITA_ACARA_ID)
);

/*==============================================================*/
/* Index: M_BERITA_ACARA_PK                                     */
/*==============================================================*/
create unique index M_BERITA_ACARA_PK on M_BERITA_ACARA (
BERITA_ACARA_ID
);

/*==============================================================*/
/* Index: REF_SUBDIV__ACARA_FK                                  */
/*==============================================================*/
create  index REF_SUBDIV__ACARA_FK on M_BERITA_ACARA (
SUBDIV_ID
);

/*==============================================================*/
/* Table: M_DIREKTORI                                           */
/*==============================================================*/
create table M_DIREKTORI (
   DIR_ID               SERIAL               not null,
   PARENT_DIR_ID        INT4                 null,
   CREATOR_USER_ID      INT4                 null,
   DIR_NAME             VARCHAR(255)         null,
   DIR_DATE_CREATED     DATE                 null,
   DIR_DEL_STATUS       BOOL                 null,
   RAK_NO               INT4                 null,
   BOX_NO               INT4                 null,
   constraint PK_M_DIREKTORI primary key (DIR_ID)
);

/*==============================================================*/
/* Index: M_DIREKTORI_PK                                        */
/*==============================================================*/
create unique index M_DIREKTORI_PK on M_DIREKTORI (
DIR_ID
);

/*==============================================================*/
/* Index: REF_DIR__DIR_FK                                       */
/*==============================================================*/
create  index REF_DIR__DIR_FK on M_DIREKTORI (
PARENT_DIR_ID
);

/*==============================================================*/
/* Index: REF_USER__DIR_FK                                      */
/*==============================================================*/
create  index REF_USER__DIR_FK on M_DIREKTORI (
CREATOR_USER_ID
);

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
/* Index: M_DIVISI_PK                                           */
/*==============================================================*/
create unique index M_DIVISI_PK on M_DIVISI (
DIV_ID
);

/*==============================================================*/
/* Table: M_LOG                                                 */
/*==============================================================*/
create table M_LOG (
   LOG_ID               DATE                 not null,
   USER_ID              INT4                 null,
   MENU_NAME            VARCHAR(255)         null,
   ACCESS_LEVEL         CHAR(1)              null,
   constraint PK_M_LOG primary key (LOG_ID)
);

/*==============================================================*/
/* Index: M_LOG_PK                                              */
/*==============================================================*/
create unique index M_LOG_PK on M_LOG (
LOG_ID
);

/*==============================================================*/
/* Index: REF_USER__LOG_FK                                      */
/*==============================================================*/
create  index REF_USER__LOG_FK on M_LOG (
USER_ID
);

/*==============================================================*/
/* Table: M_MENU                                                */
/*==============================================================*/
create table M_MENU (
   MENU_ID              SERIAL               not null,
   MENU_PARENT_ID       INT                  null,
   MENU_NAME            VARCHAR(255)         null,
   MENU_INDEX           VARCHAR(64)          null,
   constraint PK_M_MENU primary key (MENU_ID)
);

/*==============================================================*/
/* Index: M_MENU_PK                                             */
/*==============================================================*/
create unique index M_MENU_PK on M_MENU (
MENU_ID
);

/*==============================================================*/
/* Table: M_SUBDIV                                              */
/*==============================================================*/
create table M_SUBDIV (
   SUBDIV_ID            SERIAL               not null,
   DIV_ID               INT4                 not null,
   SUBDIV_CODE          VARCHAR(8)           not null,
   SUBDIV_NAME          VARCHAR(255)         null,
   SUBDIV_LEADER        VARCHAR(255)         null,
   constraint PK_M_SUBDIV primary key (SUBDIV_ID),
   constraint AK_KEY_2_M_SUBDIV unique (SUBDIV_CODE)
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
   REPOSITORY_ROOT		VARCHAR(1024)        not null
);

/*==============================================================*/
/* Table: M_USER                                                */
/*==============================================================*/
create table M_USER (
   USER_ID              SERIAL               not null,
   SUBDIV_ID            INT4                 null,
   USER_NIP             VARCHAR(255)         not null,
   USER_NAME            VARCHAR(255)         not null,
   USER_PSW             VARCHAR(255)         null,
   constraint PK_M_USER primary key (USER_ID),
   constraint AK_KEY_2_M_USER unique (USER_NIP)
);

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
   PEMINJAM_USER_ID     INT4                 not null,
   TGL_PINJAM           DATE                 null,
   TGL_KEMBALI          DATE                 null,
   TGL_HARUS_KEMBALI    DATE                 null,
   PETUGAS_UNIT_ARSIP   VARCHAR(255)         null,
   PIMPINAN_UNIT_ARSIP  VARCHAR(255)         null,
   constraint PK_PEMINJAMAN_ARSIP primary key (PEMINJAM_USER_ID)
);

/*==============================================================*/
/* Index: PEMINJAMAN_ARSIP_PK                                   */
/*==============================================================*/
create unique index PEMINJAMAN_ARSIP_PK on PEMINJAMAN_ARSIP (
PEMINJAM_USER_ID
);

/*==============================================================*/
/* Table: PEMINJAMAN_RINCI                                      */
/*==============================================================*/
create table PEMINJAMAN_RINCI (
   PEMINJAM_USER_ID     INT4                 not null,
   ARSIP_ID             INT4                 not null,
   KETERANGAN           VARCHAR(255)         null,
   constraint PK_PEMINJAMAN_RINCI primary key (PEMINJAM_USER_ID, ARSIP_ID)
);

/*==============================================================*/
/* Index: PEMINJAMAN_RINCI_PK                                   */
/*==============================================================*/
create unique index PEMINJAMAN_RINCI_PK on PEMINJAMAN_RINCI (
PEMINJAM_USER_ID,
ARSIP_ID
);

/*==============================================================*/
/* Index: REF_PMJ_ARSIP__PMJ_RINCI_FK                           */
/*==============================================================*/
create  index REF_PMJ_ARSIP__PMJ_RINCI_FK on PEMINJAMAN_RINCI (
PEMINJAM_USER_ID
);

/*==============================================================*/
/* Index: REF_ARSIP__PMJ_RINCI_FK                               */
/*==============================================================*/
create  index REF_ARSIP__PMJ_RINCI_FK on PEMINJAMAN_RINCI (
ARSIP_ID
);

/*==============================================================*/
/* Table: PENYUSUTAN                                            */
/*==============================================================*/
create table PENYUSUTAN (
   PENYUSUTAN_ID        SERIAL               not null,
   PENYUSUTAN_TGL       DATE                 null,
   PENYUSUTAN_PJ        VARCHAR(255)         null,
   constraint PK_PENYUSUTAN primary key (PENYUSUTAN_ID)
);

/*==============================================================*/
/* Index: PENYUSUTAN_PK                                         */
/*==============================================================*/
create unique index PENYUSUTAN_PK on PENYUSUTAN (
PENYUSUTAN_ID
);

/*==============================================================*/
/* Table: PENYUSUTAN_RINCI                                      */
/*==============================================================*/
create table PENYUSUTAN_RINCI (
   ARSIP_ID             INT4                 not null,
   PENYUSUTAN_ID        INT4                 not null,
   KETERANGAN           VARCHAR(255)         null,
   constraint PK_PENYUSUTAN_RINCI primary key (ARSIP_ID, PENYUSUTAN_ID)
);

/*==============================================================*/
/* Index: PENYUSUTAN_RINCI_PK                                   */
/*==============================================================*/
create unique index PENYUSUTAN_RINCI_PK on PENYUSUTAN_RINCI (
ARSIP_ID,
PENYUSUTAN_ID
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
/* Table: R_ARSIP_TIPE                                          */
/*==============================================================*/
create table R_ARSIP_TIPE (
   ARSIP_TIPE_ID        SERIAL               not null,
   ARSIP_TIPE_NAME      VARCHAR(255)         null,
   ARSIP_TIPE_COM       VARCHAR(255)         null,
   constraint PK_R_ARSIP_TIPE primary key (ARSIP_TIPE_ID)
);

/*==============================================================*/
/* Index: R_ARSIP_TIPE_PK                                       */
/*==============================================================*/
create unique index R_ARSIP_TIPE_PK on R_ARSIP_TIPE (
ARSIP_TIPE_ID
);

alter table ARSIP_ACCESS
   add constraint FK_ARSIP_AC_REF_DIR___M_DIREKT foreign key (DIR_ID)
      references M_DIREKTORI (DIR_ID)
      on delete restrict on update restrict;

alter table ARSIP_ACCESS
   add constraint FK_ARSIP_AC_REF_USER__M_USER foreign key (USER_ID)
      references M_USER (USER_ID)
      on delete restrict on update restrict;

alter table BERITA_ACARA_RINCIAN
   add constraint FK_BERITA_A_REF_ARSIP_M_ARSIP foreign key (ARSIP_ID)
      references M_ARSIP (ARSIP_ID)
      on delete restrict on update restrict;

alter table BERITA_ACARA_RINCIAN
   add constraint FK_BERITA_A_REF_BRT_A_M_BERITA foreign key (BERITA_ACARA_ID)
      references M_BERITA_ACARA (BERITA_ACARA_ID)
      on delete restrict on update restrict;

alter table MENU_ACCESS
   add constraint FK_MENU_ACC_REF_MNU___M_MENU foreign key (MENU_ID)
      references M_MENU (MENU_ID)
      on delete restrict on update restrict;

alter table MENU_ACCESS
   add constraint FK_MENU_ACC_REF_USER__M_USER foreign key (USER_ID)
      references M_USER (USER_ID)
      on delete restrict on update restrict;

alter table M_ARSIP
   add constraint FK_M_ARSIP_REF_DIREK_M_DIREKT foreign key (DIR_ID)
      references M_DIREKTORI (DIR_ID)
      on delete restrict on update restrict;

alter table M_ARSIP
   add constraint FK_M_ARSIP_REF_TIPE__R_ARSIP_ foreign key (ARSIP_TIPE_ID)
      references R_ARSIP_TIPE (ARSIP_TIPE_ID)
      on delete restrict on update restrict;

alter table M_BERITA_ACARA
   add constraint FK_M_BERITA_REF_SUBDI_M_SUBDIV foreign key (SUBDIV_ID)
      references M_SUBDIV (SUBDIV_ID)
      on delete restrict on update restrict;

alter table M_DIREKTORI
   add constraint FK_M_DIREKT_REF_DIR___M_DIREKT foreign key (PARENT_DIR_ID)
      references M_DIREKTORI (DIR_ID)
      on delete restrict on update restrict;

alter table M_DIREKTORI
   add constraint FK_M_DIREKT_REF_USER__M_USER foreign key (CREATOR_USER_ID)
      references M_USER (USER_ID)
      on delete restrict on update restrict;

alter table M_LOG
   add constraint FK_M_LOG_REF_USER__M_USER foreign key (USER_ID)
      references M_USER (USER_ID)
      on delete restrict on update restrict;

alter table M_SUBDIV
   add constraint FK_M_SUBDIV_REF_DIV___M_DIVISI foreign key (DIV_ID)
      references M_DIVISI (DIV_ID)
      on delete restrict on update restrict;

alter table M_USER
   add constraint FK_M_USER_REF_SUBDI_M_SUBDIV foreign key (SUBDIV_ID)
      references M_SUBDIV (SUBDIV_ID)
      on delete restrict on update restrict;

alter table PEMINJAMAN_ARSIP
   add constraint FK_PEMINJAM_REF_USER__M_USER foreign key (PEMINJAM_USER_ID)
      references M_USER (USER_ID)
      on delete restrict on update restrict;

alter table PEMINJAMAN_RINCI
   add constraint FK_PEMINJAM_REF_ARSIP_M_ARSIP foreign key (ARSIP_ID)
      references M_ARSIP (ARSIP_ID)
      on delete restrict on update restrict;

alter table PEMINJAMAN_RINCI
   add constraint FK_PEMINJAM_REF_PMJ_A_PEMINJAM foreign key (PEMINJAM_USER_ID)
      references PEMINJAMAN_ARSIP (PEMINJAM_USER_ID)
      on delete restrict on update restrict;

alter table PENYUSUTAN_RINCI
   add constraint FK_PENYUSUT_REF_ARSIP_M_ARSIP foreign key (ARSIP_ID)
      references M_ARSIP (ARSIP_ID)
      on delete restrict on update restrict;

alter table PENYUSUTAN_RINCI
   add constraint FK_PENYUSUT_REF_SUSUT_PENYUSUT foreign key (PENYUSUTAN_ID)
      references PENYUSUTAN (PENYUSUTAN_ID)
      on delete restrict on update restrict;
