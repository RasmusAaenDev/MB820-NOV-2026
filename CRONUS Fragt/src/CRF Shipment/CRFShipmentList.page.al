page 50102 "CRF Shipment List"
{
    PageType = List;
    SourceTable = "CRF Shipment Header";
    Caption = 'Shipments';
    CardPageId = "CRF Shipment Card";
    Editable = false;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Shipments)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.', Comment = '%';
                }
                field(Carrier; Rec.Carrier)
                {
                    ToolTip = 'Specifies the value of the Carrier field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Total Weight"; Rec."Total Weight")
                {
                    ToolTip = 'Specifies the value of the Total Weight (kg) field.', Comment = '%';
                }
            }
        }
    }
}
