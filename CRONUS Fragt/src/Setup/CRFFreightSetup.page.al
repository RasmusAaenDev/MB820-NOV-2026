page 50100 "CRF Freight Setup"
{
    PageType = Card;
    SourceTable = "CRF Freight Setup";
    Caption = 'CRONUS Freight Setup';
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Administration;

    ApplicationArea = All;
    AdditionalSearchTerms = 'carrier, freight, shipment';

    layout
    {
        area(content)
        {
            group(General)
            {

                field("Default Carrier"; Rec."Default Carrier")
                {
                    ToolTip = 'Specifies the Default Carrier, that is used on shipment documents.', Comment = '%';
                }
                field("API Base URL"; Rec."API Base URL")
                {
                    ToolTip = 'Specifies the value of the API Base URL field.', Comment = '%';
                }
                field(ApiKey; ApiKeyText)
                {
                    Caption = 'API Key';
                    ExtendedDatatype = Masked;
                    ToolTip = 'Specifies the key that the carrier service gave Cronus. The key is stored in isolated storage, not in this table.';

                    trigger OnValidate()
                    begin
                        Rec.SetApiKey(ApiKeyText);
                        ShowApiKeyPlaceholder();
                    end;
                }

            }
            group(NoSeries)
            {
                Caption = 'No. Series';

                field("Shipment Nos."; Rec."Shipment Nos.")
                {
                    ToolTip = 'Specifies the value of the Shipment Nos. field.', Comment = '%';
                }
            }
        }
    }
    var
        ApiKeyText: Text;

    trigger OnOpenPage()
    begin
        Rec.InsertIfNotExists();
    end;

    trigger OnAfterGetRecord()
    begin
        ShowApiKeyPlaceholder();
    end;

    local procedure ShowApiKeyPlaceholder()
    begin
        if Rec.HasApiKey() then
            ApiKeyText := '********'
        else
            ApiKeyText := '';
    end;

}
