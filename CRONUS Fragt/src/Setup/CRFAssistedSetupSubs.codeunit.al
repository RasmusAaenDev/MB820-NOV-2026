codeunit 50100 "CRF Assisted Setup Subs"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Guided Experience", 'OnRegisterAssistedSetup', '', false, false)]
    local procedure AddExtensionAssistedSetup_OnRegisterAssistedSetup()
    var
        GuidedExperience: Codeunit "Guided Experience";
        TitleLbl: Label 'Cronus Freight Assisted Setup';
        ShortTitleLbl: Label 'Cronus Freight';
        DescriptionLbl: Label 'Assisted setup, setting up the Cronus Freight Solution';
    begin
        GuidedExperience.InsertAssistedSetup(
            TitleLbl,
            ShortTitleLbl,
            DescriptionLbl,
            2,
            ObjectType::Page,
            GetPageId(),
            "Assisted Setup Group"::Extensions,
            '',
            "Video Category"::Uncategorized,
            'cronus-freight.dk');

        UpdateStatus();
    end;

    //TODO: remove the following subscriber if not necessary to run
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Guided Experience", 'OnReRunOfCompletedAssistedSetup', '', false, false)]
    local procedure OnReRunOfCompletedSetup(ExtensionID: Guid; ObjectType: ObjectType; ObjectID: Integer; var Handled: Boolean)
    var
        SetupAlreadyDoneQst: Label 'This setup is already done. Do you want to open the setup page instead?';
    begin
        if ExtensionID <> GetAppId() then exit;
        if ObjectType <> ObjectType::Page then exit;
        if ObjectID <> GetPageId() then exit;

        if Confirm(SetupAlreadyDoneQst, true) then
            Page.Run(Page::"CRF Freight Setup"); //TODO: Might have to be be a different page (like not the wizard, but the setup page instead)

        Handled := true;
    end;

    // //TODO: remove the following subscriber if not necessary to run 
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Guided Experience", 'OnAfterRunAssistedSetup', '', false, false)]
    // local procedure OnAfterRunOfSetup(ExtensionID: Guid; ObjectType: ObjectType; ObjectID: Integer)
    // begin
    //     if ExtensionID <> GetAppId() then exit;
    //     if ObjectID <> GetPageId() then exit;
    // end;

    procedure UpdateStatus()
    var
        Rec: Record "CRF Freight Setup";
        GuidedExperience: Codeunit "Guided Experience";
    begin
        if not Rec.Get() then exit;

        if Rec."Shipment Nos." <> '' then
            GuidedExperience.CompleteAssistedSetup(ObjectType::Page, GetPageId());
    end;

    local procedure GetAppId(): Guid
    var
        EmptyGuid: Guid;
        Info: ModuleInfo;
    begin
        if Info.Id() = EmptyGuid then
            NavApp.GetCurrentModuleInfo(Info);
        exit(Info.Id());
    end;

    local procedure GetPageId(): Integer
    begin
        exit(Page::"CRF Cronus Freight Wizard");
    end;

}
