using POCreationService from './po_creation_srv';  

annotate POCreationService.POHeader with{
    PCode          @title : 'Plant Code';
    CompanyCode    @title : 'Company Code';
    PO_Number      @ID : 'PO Number';  
    CreationDate   @title : 'Creation Date';
    DeliveryDate   @title : 'Delivery Date';
    Status         @title : 'Status';
    MadeBy      @title: 'Created By';
    Delete         @title: 'Delete';
    Pl_Master      @title: 'Plant Master';
    Cp_Master       @title: 'Company Master';
    S_Master        @title : 'Status Master';
    PO_Item_Master  @title: 'Purchase Order Items';
    PO_Event_Master @title: 'Purchase Order Events';   
}

annotate POCreationService.POItem with{
    PO_Item_Num      @title : 'PO Item Number';
    PO_Number      @title : 'PO Number';
    MCode       @title : 'Material Code';
    Quantity     @title : 'Quantity';
    Amount    @title : 'Amount';
    M_Master @title :'Material Master';
    PO_Header_Master @title: 'Purchase Order Header'
}

annotate POCreationService.POHeader with @(
    UI: {
        HeaderInfo: {  //header tool bar
			TypeName: 'Purchase Header',
			TypeNamePlural: 'Purchase Order Header',
			Title          : {
                $Type : 'UI.DataField',
                Value : PO_Number
            },
			Description : {
				$Type: 'UI.DataField',
				Value: MadeBy
			}
		},
        SelectionFields: [PO_Number], //filter
        LineItem:[    //table items
            {Value: PO_Number},
            {Value: PCode},
            {Value: CompanyCode},
            {Value: CreationDate},
            {Value: DeliveryDate},
            {Value: Status},
            {Value: MadeBy}
        ],
        Facets: [
            {$Type: 'UI.ReferenceFacet', Label: 'PO Header', Target: '@UI.FieldGroup#Main'},
            {$Type: 'UI.ReferenceFacet', Label: 'PO Items', Target: 'PO_Item_Master/@UI.LineItem' }
        ],
        FieldGroup#Main: {
            Data: [
                {Value: PCode},
                {Value: CompanyCode},
                {Value: DeliveryDate},
                {Value: MadeBy}
            ]
        }
    }
){};

annotate POCreationService.POItem with @(
    UI: {
        LineItem: [
            {Value: PO_Item_Num},
            {Value: MCode},
            {Value: Quantity},
            {Value: Amount},
            {Value:M_Master.Material_Image,},
        ]
    }
){};