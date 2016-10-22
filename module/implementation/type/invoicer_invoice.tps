create or replace type invoicer_invoice as object (
    id           integer,
    beneficiary  invoicer_contact,
    benefactor   invoicer_contact,
    items        invoicer_invoice_items,
    due          date,
    created      date,
    paid         date,
    total_amount number,
    due_amount   number,
    status       varchar2(30),

    -- constructor used in invoicer.create_invoice
    constructor function invoicer_invoice (
        beneficiary  invoicer_contact,
        benefactor   invoicer_contact,
        items        invoicer_invoice_items,
        due          date
    ) return self as result
);
/
