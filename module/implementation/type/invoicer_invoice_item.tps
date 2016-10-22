create or replace type invoicer_invoice_item as object (
    name   varchar2(255),
    amount number,
    price  number,
    tax    number
);
/
