page 50103 "CRF Shipment Card"
{
    PageType = Document;
    SourceTable = "CRF Shipment Header";
    Caption = 'Shipment';
    ApplicationArea = All;


    AboutTitle = 'Shipment';
    AboutText = 'The shipment represents a *collection of packages* that I''m shipping to a customer or vendor.';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {

                }
                field("Customer No."; Rec."Customer No.")
                {

                }
                field(Carrier; Rec.Carrier)
                {
                    ToolTip = 'Specifies the carrier which will be handling the packages';
                }
                field(Status; Rec.Status)
                {

                }
                field("Tracking No."; Rec."Tracking No.")
                {

                }
                field("Posting Date"; Rec."Posting Date")
                {

                }
                field("Total Weight"; Rec."Total Weight")
                {

                }
            }
            part(Lines; "CRF Shipment Subform")
            {
                Caption = 'Packages';
                SubPageLink = "Shipment No." = field("No.");
                UpdatePropagation = Both;

                AboutTitle = 'Packages';
                AboutText = 'In this section you will find the packages that will be included in the shipment';

            }
            group(Shipping)
            {
                AboutTitle = 'Shipping Information';
                AboutText = 'In this section you will control where the shipment is being shipped to.';

                Caption = 'Ship-to';
                field("Ship-to Name"; Rec."Ship-to Name")
                {

                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {

                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {

                }
                field("Ship-to City"; Rec."Ship-to City")
                {

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(UpdateStatus)
            {
                Caption = 'Update Status';
                Image = Refresh;

                trigger OnAction()
                var
                    FreightMgt: Codeunit "CRF Freight Mgt";
                begin
                    FreightMgt.UpdateStatus(Rec);
                    CurrPage.Update(false);
                end;
            }

        }
    }
}
