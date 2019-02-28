/* Trigger for ItemPropostaSiggo__c (also known as veiculos)
 * 
 * v1.0 - 23/09/2014 - eZly@Fernando Trevisan
 * 		Created the file with method vehicleBlocker.
 * 
 * Methods:
 * 		vehicleBlocker: created to comply with GI 2019,
 * 			change request to allow products to have bloqueadores, and to 
 * 			allow veículos in Opportunity to have bloqueadores installed.
 * 			Used only in Siggo registry type.
 */
public class itemPropostaSiggoTriggers {
    public static void vehicleBlocker(List<ItemPropostaSiggo__c> itemList, String Operacao,List<ItemPropostaSiggo__c> oldItemList){
        
        Set<Id> oppIds = new Set<Id>();
        Set<Id> veiculoIds = new Set<Id>();
        Map<Id,Boolean> produtos = new Map<Id,Boolean>();
        Map<Id,Boolean> veiculos = new Map<Id,Boolean>();
        Map<Id,Boolean> erroBloqueador = new Map<Id,Boolean>();
        Map<Id,Boolean> veiculosTrigger = new Map<Id,Boolean>();
        
        // Verifies the record type
        Map<Id,RecordType> tipoRegistro = new Map<Id,RecordType>();
        for(ItemPropostaSiggo__c veiculo: itemList) {
            tipoRegistro.put(veiculo.Oportunidade__r.RecordTypeId,null);
        }
        for (RecordType rt : [select Id, Name from RecordType where Id in :tipoRegistro.keySet()]) {
            tipoRegistro.put(rt.Id, rt);
        }
        
        // Creates a set with the Opportunity ids for later use
        for (ItemPropostaSiggo__c veiculo : itemList){
            oppIds.add(veiculo.Oportunidade__c);
            // If in an update, we have to remove the updated items from the veiculos added prior to the Opportunity
            if (operacao == 'upd') {
                veiculoIds.add(veiculo.id);
            }
        }
        
        // Creates a map of the products so later we can see if they accept bloqueador
        for (OpportunityLineItem prodAtual : [SELECT OpportunityId, Aceita_bloqueador__c FROM OpportunityLineItem WHERE OpportunityId IN :oppIds]){
            produtos.put(prodAtual.OpportunityId, prodAtual.Aceita_bloqueador__c);
        }
        
        // Iterates through the veiculos already added to the Opportunity, so we can check if they have bloqueadores or not
        for (ItemPropostaSiggo__c veiculo : [SELECT Oportunidade__c, Instalar_bloqueador__c FROM ItemPropostaSiggo__c WHERE Oportunidade__c IN :oppIds AND Id NOT IN :veiculoIds ORDER BY Oportunidade__c ASC]){
            if (veiculos.containsKey(veiculo.Oportunidade__c)) {
                if (veiculos.get(veiculo.Oportunidade__c) != veiculo.Instalar_bloqueador__c) {
                	erroBloqueador.put(veiculo.Oportunidade__c, true);
                }
            } else {
                veiculos.put(veiculo.Oportunidade__c, veiculo.Instalar_bloqueador__c);
                erroBloqueador.put(veiculo.Oportunidade__c, false);
            }
        }
        
        // Loop through the records to check the required rules
        for (ItemPropostaSiggo__c veiculo : itemList){
            
            // Verifies if this opp/veiculo has prior error
            if (erroBloqueador.size() > 0 && erroBloqueador.get(veiculo.Oportunidade__c)){
                veiculo.addError('Existem veículos com e sem bloqueador na oportunidade. Por favor, corrija para que existam apenas veículos com bloqueador, ou apenas veículos sem bloqueador.');
            } else {
                
                // Again we have to check for incorrect values, 'cause it can be wrong in the mass insert
                if (veiculosTrigger.containsKey(veiculo.Oportunidade__c)) {
                    if (veiculosTrigger.get(veiculo.Oportunidade__c) != veiculo.Instalar_bloqueador__c) {
                        veiculo.addError('Existem veículos com e sem bloqueador nesta atualização. Por favor, corrija para que existam apenas veículos com bloqueador, ou apenas veículos sem bloqueador.');
                    }
                } else {
                    veiculosTrigger.put(veiculo.Oportunidade__c, veiculo.Instalar_bloqueador__c);
                }
                
                // Rule 1: if veiculo has bloqueador, check if product accepts bloqueador
                // If there is no product then we don't have to check anything
                if (produtos.size() > 0){
                    if (veiculo.Instalar_bloqueador__c){
                        if (!produtos.get(veiculo.Oportunidade__c)){
                            veiculo.addError('O produto selecionado na oportunidade não aceita a instalação de bloqueador. Por favor, corrija e tente novamente.');
                        }
                    }
                }
                
                // Rule 2: check bloqueador's state in Opportunity's previously added veiculos
               	// If there is no prior vehicle, then we don't have to check anything
                if (veiculos.size() > 0){
                    if (veiculos.get(veiculo.Oportunidade__c) != veiculo.Instalar_bloqueador__c){
                        veiculo.addError('Já existem veículos adicionados com estado diferente de bloqueador. Por favor, corrija para que todos os veículos tenham ou não bloqueador.');
                    }
                }
            }
        }
    }
}