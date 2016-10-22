create or replace type body invoicer_invoice as

    -- constructor used in invoicer.create_invoice
    constructor function invoicer_invoice (
        beneficiary  invoicer_contact,
        benefactor   invoicer_contact,
        items        invoicer_invoice_items,
        due          date
    ) return self as result is
    begin
        self.beneficiary := beneficiary;
        self.benefactor  := benefactor;
        self.items       := items;
        self.due         := due;
        --
        return;
        --
    end;

end;
/
