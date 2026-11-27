table 50100 "CRF Freight Setup"
{
    Caption = 'CRONUS Freight Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        field(2; "Default Carrier"; Enum "CRF Carrier")
        {
            Caption = 'Default Carrier';
            DataClassification = CustomerContent;
        }
        field(3; "API Base URL"; Text[250])
        {
            Caption = 'API Base URL';
            DataClassification = CustomerContent;
        }
        field(4; "Shipment Nos."; Code[20])
        {
            Caption = 'Shipment Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }

    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    var
        RecordHasBeenRead: Boolean;
        ApiKeyStorageKeyTok: Label 'CRF-CarrierApiKey', Locked = true;

    procedure GetRecordOnce()
    begin
        if RecordHasBeenRead then
            exit;
        Get();
        RecordHasBeenRead := true;
    end;

    procedure InsertIfNotExists()
    begin
        Reset();
        if not Get() then begin
            Init();
            Insert(true);
        end;
    end;

    procedure SetApiKey(NewApiKey: SecretText)
    begin
        if NewApiKey.IsEmpty() then begin
            if IsolatedStorage.Contains(ApiKeyStorageKeyTok, DataScope::Company) then
                IsolatedStorage.Delete(ApiKeyStorageKeyTok, DataScope::Company);
            exit;
        end;
        IsolatedStorage.SetEncrypted(ApiKeyStorageKeyTok, NewApiKey, DataScope::Company);
    end;

    Internal procedure GetApiKey() ApiKey: SecretText
    begin
        if IsolatedStorage.Get(ApiKeyStorageKeyTok, DataScope::Company, ApiKey) then
            exit(ApiKey);
    end;

    procedure HasApiKey(): Boolean
    begin
        exit(IsolatedStorage.Contains(ApiKeyStorageKeyTok, DataScope::Company));
    end;

}