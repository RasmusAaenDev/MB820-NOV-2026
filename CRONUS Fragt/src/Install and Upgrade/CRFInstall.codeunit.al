codeunit 50107 "CRF Install"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany();
    var
        myAppInfo: ModuleInfo;
    begin
        NavApp.GetCurrentModuleInfo(myAppInfo);

        if myAppInfo.DataVersion = Version.Create(0, 0, 0, 0) then
            HandleFreshInstall()
        else
            HandleReinstall();
    end;

    local procedure HandleFreshInstall()
    var
        CRFFreightSetup: Record "CRF Freight Setup";
        UpgradeTag: Codeunit "Upgrade Tag";
    begin
        CRFFreightSetup.InsertIfNotExists();

        UpgradeTag.SetAllUpgradeTags();
    end;

    local procedure HandleReinstall()
    begin

    end;
}