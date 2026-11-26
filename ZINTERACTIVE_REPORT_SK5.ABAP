*&---------------------------------------------------------------------*
*& Report ZINTERACTIVE_REPORT_TASK_5
*&---------------------------------------------------------------------*
REPORT ZINTERACTIVE_REPORT_TASK_5.

TABLES:EKKO,LFA1,ADRC,T001,LFBK.

TYPES: BEGIN OF STR_EKKO,
        EBELN      TYPE EKKO-EBELN,
        BUKRS      TYPE EKKO-BUKRS,
        BSTYP      TYPE EKKO-BSTYP,
        BSART      TYPE EKKO-BSART,
        BSAKZ      TYPE EKKO-BSAKZ,

*
        LIFNR      TYPE LFA1-LIFNR,
        NAME1      TYPE LFA1-NAME1,
        ORT01      TYPE LFA1-ORT01,
        ADRNR      TYPE LFA1-ADRNR,
        ERNAM      TYPE LFA1-ERNAM,

        ADDRNUMBER TYPE ADRC-ADDRNUMBER,
        DATE_FROM  TYPE ADRC-DATE_FROM,
        TITLE      TYPE ADRC-TITLE,
        HOME_CITY  TYPE ADRC-HOME_CITY,
        PO_BOX     TYPE ADRC-PO_BOX,

        RCOMP     TYPE T001-RCOMP,
        BUTXT      TYPE T001-BUTXT,
        STCEG      TYPE T001-STCEG,
        LAND1      TYPE T001-LAND1,
        KOKFI     TYPE T001-KOKFI,

        XEZER     TYPE LFBK-XEZER,
        BANKS      TYPE LFBK-BANKS,
        BANKL      TYPE LFBK-BANKL,
        BKONT      TYPE LFBK-BKONT,
        BKREF      TYPE LFBK-BKREF,
      END OF STR_EKKO.


DATA: IT_EKKO TYPE TABLE OF STR_EKKO,
      WA_EKKO TYPE STR_EKKO.