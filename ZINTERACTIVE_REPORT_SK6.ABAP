*&---------------------------------------------------------------------*
*& Report ZINTERACTIVE_REPORT_SK6
*&---------------------------------------------------------------------*
REPORT ZINTERACTIVE_REPORT_SK6.
TABLES: EKKO.

TYPES: BEGIN OF TY_EKKO,        " po header"
         EBELN TYPE EKKO-EBELN,
         BUKRS TYPE EKKO-BUKRS,
         BSART TYPE EKKO-BSART,
         AEDAT TYPE EKKO-AEDAT,
         LIFNR TYPE EKKO-LIFNR,
       END OF TY_EKKO.

TYPES: BEGIN OF TY_LFA1,         " vendor information"
         LIFNR TYPE LFA1-LIFNR,
         NAME1 TYPE LFA1-NAME1,
         LAND1 TYPE LFA1-LAND1,
         ORT01 TYPE LFA1-ORT01,
         KTOKK TYPE LFA1-KTOKK,
       END OF TY_LFA1.

TYPES: BEGIN OF TY_ADDR,            " vendor add"
         LIFNR      TYPE LFA1-LIFNR,
         ADRNR      TYPE  LFA1-ADRNR,
         ADDRNUMBER TYPE  ADRC-ADDRNUMBER,
         STREET     TYPE ADRC-STREET,
         CITY1      TYPE ADRC-CITY1,
         POST_CODE1 TYPE ADRC-POST_CODE1,
         TEL_NUMBER TYPE ADRC-TEL_NUMBER,
         SMTP_ADDR  TYPE ADR6-SMTP_ADDR,
*         ADDRNUMBER TYPE  ADR6-ADDRNUMBER,
       END OF TY_ADDR.


TYPES: BEGIN OF TY_LFB1,             " conpany code + add"
         LIFNR TYPE LFB1-LIFNR,
         BUKRS TYPE LFB1-BUKRS,
         BUTXT TYPE T001-BUTXT,
         ORT01 TYPE T001-ORT01,
         LAND1 TYPE T001-LAND1,
       END OF TY_LFB1.


TYPES: BEGIN OF TY_LFBK,               " bank details "
         LIFNR TYPE LFBK-LIFNR,
         BANKS TYPE LFBK-BANKS,
         BANKL TYPE LFBK-BANKL,
         BANKN TYPE LFBK-BANKN,
         KOINH TYPE LFBK-KOINH,
       END OF TY_LFBK.

DATA: IT_EKKO TYPE TABLE OF TY_EKKO,
      WA_EKKO TYPE TY_EKKO.

DATA: IT_LFA1 TYPE TABLE OF TY_LFA1,
      WA_LFA1 TYPE TY_LFA1.

DATA: IT_ADDR TYPE TABLE OF TY_ADDR,
      WA_ADDR TYPE TY_ADDR.

DATA: IT_LFB1 TYPE TABLE OF TY_LFB1,
      WA_LFB1 TYPE TY_LFB1.

DATA: IT_LFBK TYPE TABLE OF TY_LFBK,
      WA_LFBK TYPE TY_LFBK.


PARAMETERS: P_EBELN TYPE EKKO-EBELN .


TOP-OF-PAGE.

  WRITE: / '                               PO HEADER DETAILS'.

  ULINE.

  WRITE: / 'PO NUMBER',
           20 'COMP. CODE',
           35 'PO TYPE',
           50 'DATE',
           65 'VENDOR'.

  ULINE.


TOP-OF-PAGE DURING LINE-SELECTION.

  CASE SY-LSIND.
* page 1 - VENDOR GENERAL information

    WHEN 1.


      WRITE: / '                  VENDOR GENERAL INFORMATION'.

      ULINE.

      WRITE: / 'VENDOR',
               20 'NAME',
               50 'COUNTRY',
               65 'CITY',
               80 'ACCOUNT GROUP'.

      ULINE.

* page 2 - VENDOR ADDRESS


    WHEN 2.


      WRITE: / '                    VENDOR ADDRESS'.

      ULINE.

      WRITE: / 'VENDOR',
               15 'STREET',
               45 'CITY',
               60 'POST CODE',
               72 'TELEPHONE',
               88 'EMAIL ID'.

      ULINE.


*page 3 - VENDOR COMPANY CODE


    WHEN 3.

      WRITE: / '                  VENDOR COMPANY CODE + ADDRESS'.

      ULINE.

      WRITE: / 'VENDOR',
               15 'COMP. CODE',
               30 'COMPANY NAME',
               55 'CITY',
               70 'COUNTRY'.

      ULINE.

*page 4 - VENDOR BANK

    WHEN 4.

      WRITE: / '                     VENDOR BANK DETAILS'.

      ULINE.

      WRITE: / 'VENDOR',
               15 'BANK COUNTRY',
               30 'BANK KEY',
               50 'BANK ACCOUNT',
               70 'ACCOUNT HOLDER'.

      ULINE.

  ENDCASE.

START-OF-SELECTION.

*  PO HEADER

  SELECT EBELN
         BUKRS
         BSART
         AEDAT
         LIFNR
    FROM EKKO
    INTO TABLE IT_EKKO
    WHERE EBELN = P_EBELN.

  IF IT_EKKO IS INITIAL.

    MESSAGE 'PO Number Not Found' TYPE 'I'.
    EXIT.

  ENDIF.

  LOOP AT IT_EKKO INTO WA_EKKO.

    WRITE: / WA_EKKO-EBELN,
             20 WA_EKKO-BUKRS,
             35 WA_EKKO-BSART,
             50 WA_EKKO-AEDAT,
             65 WA_EKKO-LIFNR.

    HIDE: WA_EKKO-EBELN,
          WA_EKKO-LIFNR,
          WA_EKKO-BUKRS.

  ENDLOOP.


AT LINE-SELECTION.

  CASE SY-LSIND.

* page 1 - DISPLAY VENDOR GENERAL

    WHEN 1.

      SELECT LFA1~LIFNR
             LFA1~NAME1
             LFA1~LAND1
             LFA1~ORT01
             LFA1~KTOKK

        FROM LFA1

        INTO TABLE IT_LFA1

        WHERE LFA1~LIFNR = WA_EKKO-LIFNR.

      LOOP AT IT_LFA1 INTO WA_LFA1.

        WRITE: / WA_LFA1-LIFNR,
                 20 WA_LFA1-NAME1,
                 50 WA_LFA1-LAND1,
                 65 WA_LFA1-ORT01,
                 80 WA_LFA1-KTOKK.

        HIDE: WA_LFA1-LIFNR.

      ENDLOOP.


* page 2 - DISPLAY ADDRESS

    WHEN 2.


      SELECT LFA1~LIFNR
             LFA1~ADRNR
             ADRC~ADDRNUMBER
             ADRC~STREET
             ADRC~CITY1
             ADRC~POST_CODE1
             ADRC~TEL_NUMBER
             ADR6~SMTP_ADDR

        FROM LFA1 INNER JOIN ADRC
          ON LFA1~ADRNR = ADRC~ADDRNUMBER

        INNER JOIN ADR6
          ON ADRC~ADDRNUMBER = ADR6~ADDRNUMBER

        INTO TABLE IT_ADDR

        WHERE LFA1~LIFNR = WA_LFA1-LIFNR.

      LOOP AT IT_ADDR INTO WA_ADDR.

        WRITE: / WA_ADDR-LIFNR,
                 15 WA_ADDR-STREET,
                 45 WA_ADDR-CITY1,
                 60 WA_ADDR-POST_CODE1,
                 72 WA_ADDR-TEL_NUMBER,
                 88 WA_ADDR-SMTP_ADDR.

        HIDE: WA_ADDR-LIFNR.

      ENDLOOP.

* page 3 - DISPLAY COMPANY CODE + ADDRESS

    WHEN 3.


      SELECT LFB1~LIFNR
             LFB1~BUKRS
             T001~BUTXT
             T001~ORT01
             T001~LAND1

        FROM LFB1 INNER JOIN T001
          ON LFB1~BUKRS = T001~BUKRS

        INTO TABLE IT_LFB1

        WHERE LFB1~LIFNR = WA_ADDR-LIFNR.

      LOOP AT IT_LFB1 INTO WA_LFB1.

        WRITE: / WA_LFB1-LIFNR,
                 15 WA_LFB1-BUKRS,
                 30 WA_LFB1-BUTXT,
                 55 WA_LFB1-ORT01,
                 70 WA_LFB1-LAND1.

        HIDE: WA_LFB1-LIFNR,
              WA_LFB1-BUKRS.

      ENDLOOP.


* page 4- DISPLAY BANK DETAILS



    WHEN 4.


      SELECT LFBK~LIFNR
             LFBK~BANKS
             LFBK~BANKL
             LFBK~BANKN
             LFBK~KOINH

        FROM LFBK

        INTO TABLE IT_LFBK

        WHERE LFBK~LIFNR = WA_LFB1-LIFNR.

      LOOP AT IT_LFBK INTO WA_LFBK.

        WRITE: / WA_LFBK-LIFNR,
                 15 WA_LFBK-BANKS,
                 30 WA_LFBK-BANKL,
                 50 WA_LFBK-BANKN,
                 70 WA_LFBK-KOINH.

      ENDLOOP.

  ENDCASE.