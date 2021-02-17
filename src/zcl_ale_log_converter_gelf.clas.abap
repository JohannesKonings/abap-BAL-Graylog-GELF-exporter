CLASS zcl_ale_log_converter_gelf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_ale_log_converter.

    CONSTANTS:
      "! GELF log levels https://www.rubydoc.info/github/graylog-labs/gelf-rb/GELF/Levels
      BEGIN OF con_gelf_level,
        debug         TYPE i VALUE 0,
        info          TYPE i VALUE 1,
        warn          TYPE i VALUE 2,
        error         TYPE i VALUE 3,
        fatal         TYPE i VALUE 4,
        unknown       TYPE i VALUE 5,
        emergency     TYPE i VALUE 10,
        alert         TYPE i VALUE 11,
        critical      TYPE i VALUE 12,
        warning       TYPE i VALUE 14,
        notice        TYPE i VALUE 15,
        informational TYPE i VALUE 16,
      END OF con_gelf_level.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ale_log_converter_gelf IMPLEMENTATION.

  METHOD zif_ale_log_converter~convert.

    LOOP AT logs ASSIGNING FIELD-SYMBOL(<log>).

      DATA(level) = SWITCH integer( <log>-level
                                      WHEN zif_ale_log_reader=>con_log_level-info THEN con_gelf_level-info
                                      WHEN zif_ale_log_reader=>con_log_level-warning THEN con_gelf_level-warning
                                      WHEN zif_ale_log_reader=>con_log_level-error THEN con_gelf_level-error
                                      ELSE con_gelf_level-informational ).

      DATA(additional_fields_section) = REDUCE string( INIT json_field  = ||
                                                       FOR additional_field IN <log>-additional_fields
                                                       NEXT json_field = |{ json_field }"_{ additional_field-field }": "{ additional_field-value }",| ).

      DATA(gelf_json) = |\{| &&
                        |"version": "1.1",| &&
                        |"host": "{ sy-host }",| &&
                        |"short_message": "{ <log>-header_text }",| &&
                        |"full_message": "{ <log>-item_text }",| &&
                        |"level": { level },| &&
                        |{ additional_fields_section }| &&
                        |\}|.

      converted_logs = VALUE #( BASE converted_logs ( json = gelf_json ) ).

    ENDLOOP.


  ENDMETHOD.

ENDCLASS.
