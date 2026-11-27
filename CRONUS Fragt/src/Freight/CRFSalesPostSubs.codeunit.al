codeunit 50105 "CRF Sales Post Subs"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, false)]
    local procedure CreateShipmentOnAfterPostSalesDoc(var SalesHeader: Record "Sales Header"; SalesShptHdrNo: Code[20]; PreviewMode: Boolean)
    var
        FreightMgt: Codeunit "CRF Freight Mgt";
    begin
        if PreviewMode or (SalesShptHdrNo = '') then
            exit;
        FreightMgt.CreateShipmentFromSalesShipment(SalesHeader."Sell-to Customer No.", SalesShptHdrNo);
    end;
}
