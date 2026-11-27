codeunit 50108 "CRF Upgrade"
{
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    begin
        CarrierOnCustomer();
    end;

    local procedure CarrierOnCustomer()
    var
        UpgradeTag: Codeunit "Upgrade Tag";
    begin
        if UpgradeTag.HasUpgradeTag(CarrierOnCustomerLbl) then
            exit;

        SelectCarrierOnCustomer();

        UpgradeTag.SetUpgradeTag(CarrierOnCustomerLbl);
    end;

    local procedure SelectCarrierOnCustomer()
    var
        CRFShipmentHeader: Record "CRF Shipment Header";
        Customer: Record Customer;
    begin
        if Customer.FindSet() then
            repeat
                CRFShipmentHeader.Reset();
                CRFShipmentHeader.SetRange("Customer No.", Customer."No.");
                CRFShipmentHeader.SetFilter(Carrier, '<>%1', CRFShipmentHeader.Carrier::" ");
                if CRFShipmentHeader.FindLast() then begin
                    Customer."CRF Default Carrier" := CRFShipmentHeader.Carrier;
                    Customer.Modify();
                end;
            until Customer.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Upgrade Tag", 'OnGetPerCompanyUpgradeTags', '', false, false)]
    local procedure OnGetPerCompanyUpgradeTags(var PerCompanyUpgradeTags: List of [Code[250]])
    begin
        PerCompanyUpgradeTags.Add(CarrierOnCustomerLbl);
    end;


    var
        CarrierOnCustomerLbl: Label 'Cronus-CarrierOnCustomer-ID-20261127', Locked = true;
}