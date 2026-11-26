*&---------------------------------------------------------------------*
*& Report ZINTERACTIVE_REPORT_TASK_3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZINTERACTIVE_REPORT_TASK_3.

DATA: BEGIN OF INER_MARA,
        MATNR TYPE MARA-MATNR,
        ERNAM TYPE MARA-ERNAM,
        LAEDA TYPE MARA-LAEDA,
        MTART TYPE MARA-MTART,
        GROES TYPE MARA-GROES,
      END OF INER_MARA.

DATA: IT_MARA TYPE TABLE OF INER_MARA,
      WA_MARA TYPE INER_MARA.

*DATA: IT_EMP LIKE TABLE OF INER_MARA.