codeunit 90000 "CRF Freight Tests"
{
    // [FEATURE] [Cronus Fragt] [Shipment]
    Subtype = Test;
    TestPermissions = Disabled;

    // var
    //     Assert: Codeunit "Library Assert";

    [Test]
    [TransactionModel(TransactionModel::AutoRollback)]
    procedure CarrierStatusInTransitMapsToInTransit()
    var
        CarrierA: Codeunit "CRF Carrier A";
        NewStatus: Enum "CRF Shipment Status";
    begin
        // [SCENARIO] The status text in_transit from Carrier A becomes In Transit
        // [GIVEN] The status text that the carrier service sends for a parcel on its way
        // [WHEN] Cronus Fragt maps the text
        NewStatus := CarrierA.StatusFromText('in_transit');
        // [THEN] The shipment status is In Transit
        // Assert.AreEqual("CRF Shipment Status"::"In Transit", NewStatus, 'in_transit must map to In Transit');
        if enum::"CRF Shipment Status"::"In Transit" <> NewStatus then
            Error('in_transit must map to In Transit');
    end;


    [Test]
    [TransactionModel(TransactionModel::AutoRollback)]
    procedure CarrierStatusDeliveredMapsToDelivered()
    var
        CarrierA: Codeunit "CRF Carrier A";
        NewStatus: Enum "CRF Shipment Status";
    begin
        // [SCENARIO] The status text in_transit from Carrier A becomes Delivered
        // [GIVEN] The status text that the carrier service sends for a parcel on its way
        // [WHEN] Cronus Fragt maps the text
        NewStatus := CarrierA.StatusFromText('delivered');
        // [THEN] The shipment status is Delivered
        // Assert.AreEqual("CRF Shipment Status"::"Delivered", NewStatus, 'in_transit must map to Delivered');
        if enum::"CRF Shipment Status"::Delivered <> NewStatus then
            Error('in_transit must map to Delivered');
    end;

    [Test]
    [TransactionModel(TransactionModel::AutoRollback)]
    procedure CarrierStatusBookedMapsToBooked()
    var
        CarrierA: Codeunit "CRF Carrier A";
        NewStatus: Enum "CRF Shipment Status";
    begin
        // [SCENARIO] The status text in_transit from Carrier A becomes Booked
        // [GIVEN] The status text that the carrier service sends for a parcel on its way
        // [WHEN] Cronus Fragt maps the text
        NewStatus := CarrierA.StatusFromText('booked');
        // [THEN] The shipment status is Booked
        // Assert.AreEqual("CRF Shipment Status"::"Booked", NewStatus, 'in_transit must map to Booked');
        if enum::"CRF Shipment Status"::Booked <> NewStatus then
            Error('in_transit must map to Booked');
    end;

    [Test]
    [TransactionModel(TransactionModel::AutoRollback)]
    procedure PackageWeightMustBePositive()
    var
        ShipmentLine: Record "CRF Shipment Line";
    begin
        // [SCENARIO] A package can't weigh zero
        // [GIVEN] A new shipment line
        ShipmentLine.Init();
        // [WHEN] The weight is set to 0
        asserterror ShipmentLine.Validate(Weight, 0);
        // [THEN] The error from module 3b is raised
        // Assert.AreEqual('The weight of a package must be greater than zero.', GetLastErrorText(), 'Unexpected error message');
        if 'The weight of a package must be greater than zero.' <> GetLastErrorText() then
            Error('Unexpected error message');
    end;
}
