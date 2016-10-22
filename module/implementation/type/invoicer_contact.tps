create or replace type invoicer_contact as object (
    name                varchar2(255),
    address             varchar2(255),
    bank_connection     varchar2(255),
    registration_number varchar2(20),
    tax_identifier      varchar2(20)
);
/
