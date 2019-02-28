/****************************************************************** 
 *CHANGE 24/02/2015 - Carlos Prates - DESATIVAR TRIGGER           *
 * Causa: Unificação de Triggers do Objeto Oportunidade           *
 * Motivo: Evitar que exceções causados por limites da ferramenta *
 * Alterações: Métodos enviados para trigger OpportunityTrigger   * 
 ******************************************************************/

trigger Opportunity_PgtoProdutoSeguro on Opportunity (before update) {
    
    Map<Id,RecordType> tipoRegistro = new Map<Id,RecordType>();
    Set<String> pgtosInstal = new Set<String>();
    Set<String> pgtosMonitoram = new Set<String>();
    
    // Get picklist values for payment methods
    Schema.DescribeFieldResult pgtoInstal = Opportunity.Forma_de_pagamento_instala_o__c.getDescribe();
    List<Schema.PicklistEntry> lsPgtoInstal = pgtoInstal.getPicklistValues();
    for (Schema.PicklistEntry itPgtoInstal : lsPgtoInstal) { 
        if (itPgtoInstal.getValue().contains('Boleto')){
            pgtosInstal.add(itPgtoInstal.getValue());
        }
    }
    
    Schema.DescribeFieldResult pgtoMonitoram = Opportunity.Forma_pagamento_monitoramento__c.getDescribe();
    List<Schema.PicklistEntry> lsPgtoMonitoram = pgtoMonitoram.getPicklistValues();
    for (Schema.PicklistEntry itPgtoMonitoram : lsPgtoMonitoram) { 
        if (itPgtoMonitoram.getValue().contains('Cartão') || itPgtoMonitoram.getValue().contains('Débito')) {
            pgtosMonitoram.add(itPgtoMonitoram.getValue());
        }
    }
    
    for( Opportunity opp: trigger.new ) {
        // Check the type of the record
        tipoRegistro.put(opp.RecordTypeId,null);
    }
    
    for( RecordType rt : [select Id, Name from RecordType where Id in :tipoRegistro.keySet()] ) {
        tipoRegistro.put(rt.Id, rt);
    }
    for(Opportunity opp: trigger.new) {
        
        // Verifies if it's trying to pay for a product with insurance
        if (tipoRegistro.get(opp.RecordTypeId).Name == 'Siggo' && opp.Total_Produtos_com_Seguro__c > 0){
            
            // Enforces the rule for "instalação", paying with "boleto bancário": can only do one payment
            if (!String.isEmpty(opp.Forma_de_pagamento_instala_o__c) && pgtosInstal.contains(opp.Forma_de_pagamento_instala_o__c) && 
                opp.Parcelamento_da_instala_o__c != 1) {
                opp.addError('Para produto com seguro, o pagamento com boleto bancário só pode ser realizado em uma parcela. Por favor, corrija e tente novamente.');
            }
            
            // Enforces the rule for "monitoramento": can only pay with "Cartão" or "Débito"
            if (/* Using "dados de pagamento da instalação" */ 
                (opp.Usar_dados_de_pagamento_da_instala_o__c && !String.isEmpty(opp.Forma_de_pagamento_instala_o__c) && 
                !pgtosMonitoram.contains(opp.Forma_de_pagamento_instala_o__c))
                || 
                /* NOT using "dados de pagamento da instalação" */
                (!opp.Usar_dados_de_pagamento_da_instala_o__c && !pgtosMonitoram.contains(opp.Forma_pagamento_monitoramento__c))
            ) {
                opp.addError('Para produto com seguro, selecione cartão de crédito ou débito automático como forma de pagamento do monitoramento.');
            }
        }
    }
}