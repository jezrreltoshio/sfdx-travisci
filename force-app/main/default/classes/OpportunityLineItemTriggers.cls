public class OpportunityLineItemTriggers{
 
 public static void Bloquear(List<OpportunityLineItem> lstOli){
  Set<Id> oppIds = new Set<Id>();
  for(OpportunityLineItem oli :lstOli){
   oppIds.add(oli.OpportunityId);
  }
  	Map<Id,Opportunity> mapOpp = new Map<Id,Opportunity>([SELECT Id, Aprova_o__c FROM Opportunity WHERE Id IN :oppIds AND Aprova_o__c = 'Aprovado']);
  	for(OpportunityLineItem oli :lstOli){
		if(mapOpp.containsKey(oli.OpportunityId)){
    		if(mapOpp.get(oli.OpportunityId).Aprova_o__c == 'Aprovado'){
				oli.addError(Label.MSG_ERRO_0042);
    		} else if (mapOpp.get(oli.OpportunityId).Aprova_o__c == 'Solicitação enviada'){
				oli.addError(Label.MSG_ERRO_0043);
    		}
   		}
  	}
 }
 
 /*public static void SyncOliAux(List<OpportunityLineItem> lstOli, Set<Id> setIds , Boolean isInsert, Boolean isUpdate, Boolean isDelete){
  lstOli.clear();
  lstOli = [SELECT id, PricebookEntry.Product2.Name, OpportunityId, PricebookEntry.Product2Id, Fam_lia__c, ListPrice, UnitPrice, TotalPrice, Fam_lia_de_produtos__c, Quantity, Valor_mensal__c, Prazo_do_contrato2__c FROM OpportunityLineItem WHERE Id IN :SetIds];
  
  Map<Id,Produto_da_Oportunidade_Aux__c> mapOliAux = new Map<Id,Produto_da_Oportunidade_Aux__c>();
  for(Produto_da_Oportunidade_Aux__c oliAux :[SELECT Id,OpportunityLineItem__c,Oportunidade__c,
                                       Produto__c,Codigo_do_Produto__c,Preco_de_Lista__c,
                                       Preco_de_Venda__c,Preco_Total__c,Name,
                                       Familia_de_Produtos__c,Quantidade__c,Familia__c,
                                       Valor_Mensal__c,Prazo_do_Contrato__c
                                  FROM Produto_da_Oportunidade_Aux__c
                                 WHERE OpportunityLineItem__c IN :setIds]){
   mapOliAux.put(oliAux.OpportunityLineItem__c, oliaux);
  }
  
  List<Produto_da_Oportunidade_Aux__c> insertOliAux;
  List<Produto_da_Oportunidade_Aux__c> deleteOliAux;
  
  if(isInsert){
   for(OpportunityLineItem oli :lstOli){
    Produto_da_Oportunidade_Aux__c OliAux = new Produto_da_Oportunidade_Aux__c();
    OliAux.OpportunityLineItem__c = oli.id;
    OliAux.Name = oli.PricebookEntry.Product2.Name;
    OliAux.Oportunidade__c = oli.OpportunityId;
    OliAux.Produto__c = oli.PricebookEntry.Product2Id;
    OliAux.Codigo_do_Produto__c = oli.Fam_lia__c;
    OliAux.Preco_de_Lista__c = oli.ListPrice;
    OliAux.Preco_de_Venda__c = oli.UnitPrice;
    OliAux.Preco_Total__c = oli.TotalPrice;
    OliAux.Familia_de_Produtos__c = oli.Fam_lia_de_produtos__c;
    OliAux.Quantidade__c = oli.Quantity;
    OliAux.Familia__c = oli.Fam_lia__c;
    OliAux.Valor_Mensal__c = oli.Valor_mensal__c;
    OliAux.Prazo_do_Contrato__c = oli.Prazo_do_contrato2__c;
    insert OliAux;
   }
  }
  
  if(isUpdate){
   for(OpportunityLineItem oli :lstOli){
    if(mapOliAux.containsKey(oli.Id)){
     mapOliAux.get(oli.Id).Oportunidade__c = oli.OpportunityId;
     mapOliAux.get(oli.Id).Name = oli.PricebookEntry.Product2.Name;
     mapOliAux.get(oli.Id).Produto__c = oli.PricebookEntry.Product2Id;
     mapOliAux.get(oli.Id).Codigo_do_Produto__c = oli.Fam_lia__c;
     mapOliAux.get(oli.Id).Preco_de_Lista__c = oli.ListPrice;
     mapOliAux.get(oli.Id).Preco_de_Venda__c = oli.UnitPrice;
     mapOliAux.get(oli.Id).Preco_Total__c = oli.TotalPrice;
     mapOliAux.get(oli.Id).Familia_de_Produtos__c = oli.Fam_lia_de_produtos__c;
     mapOliAux.get(oli.Id).Quantidade__c = oli.Quantity;
     mapOliAux.get(oli.Id).Familia__c = oli.Fam_lia__c;
     mapOliAux.get(oli.Id).Valor_Mensal__c = oli.Valor_mensal__c;
     mapOliAux.get(oli.Id).Prazo_do_Contrato__c = oli.Prazo_do_contrato2__c;     
    }
   }
   update mapOliAux.values();
  }
  
  if(isDelete){
   //deleteOliAux = [SELECT Id FROM Produto_da_Oportunidade_Aux__c WHERE OpportunityLineItem__c IN :setIds];
   //if(deleteOliAux.size() > 0) delete deleteOliAux;
   for(OpportunityLineItem oli :lstOli){
    if(mapOliAux.containsKey(oli.Id)){
     oli.addError('Este item está adicionado a um Lote. Para deletá-lo, é necessário removê-lo do Lote');
    }
   } 
  }
 }
 */
 /*
 public static void UpdateTipoProduto(List<OpportunityLineItem> TriggerNew){
 	List<OpportunityLineItem> lstOli = new List<OpportunityLineItem>();
    Set<Id> oppIds = new Set<Id>();    
    Map<String, Opportunity> mapOpp = new Map<String, Opportunity>();
    
    for(OpportunityLineItem oli :TriggerNew){
    	oppIds.add(oli.OpportunityId);
	}
     
    for(Opportunity opp :[SELECT Id, RecordType.DeveloperName, Tipo_de_Produto__c
                            FROM Opportunity WHERE Id IN :oppIds]){
    	mapOpp.put(opp.Id, opp);
    }
     
    for(OpportunityLineItem oli :TriggerNew){
    	if(mapOpp.get(oli.OpportunityId).RecordType.DeveloperName == 'Cargo_Tracck'){
            lstOli.add(oli);
        }
    }
     
    Set<Id> pbeIds = new Set<Id>();
    for(OpportunityLineItem oli :lstOli){
    	pbeIds.add(oli.PricebookEntryId);
    }
    Map<Id,String> mapPbe = new Map<Id,String>();
    for(PricebookEntry pbe :[SELECT Id, Product2.CT_Tipo_Produto__c FROM PricebookEntry WHERE Id IN :pbeIds]){
    	mapPbe.put(pbe.Id,pbe.Product2.CT_Tipo_Produto__c);
    }
     
    for(OpportunityLineItem oli :lstOli){
    	if(mapOpp.get(oli.OpportunityId).Tipo_de_Produto__c == 'Não definido'){
        	mapOpp.get(oli.OpportunityId).Tipo_de_Produto__c = mapPbe.get(oli.PricebookEntryId);
        } else {
            if(mapPbe.get(oli.PricebookEntryId) != mapOpp.get(oli.OpportunityId).Tipo_de_Produto__c){
            	oli.addError('Erro: Produto de Tipo diferente da Oportunidade.');
            }
        }
        //update mapOpp.values();
        system.debug('CP Opportunity Map TP: ' + mapOpp.get(oli.OpportunityId).Tipo_de_Produto__c);
    }
    update mapOpp.values();
 }
 */
    
 /*
 public static void AddProductToLote(List<OpportunityLineItem> lstOli, Set<Id> oppIds){
     Set<Id> pbIds = new Set<Id>();
     for(OpportunityLineItem oli: lstOli){
         pbIds.add(oli.PricebookEntryId);
     }
     Map<Id,PricebookEntry> PbXProduto = new Map<Id,PricebookEntry>([SELECT Id,Product2Id, Product2.Name FROM PricebookEntry WHERE Id IN :pbIds]);
     
     Set<Id> loteIds = new set<Id>();
     List<Lote__c> lstLote = [SELECT Id FROM Lote__c WHERE Oportunidade__c IN :oppIds];
     for(Lote__c l :lstLote){
         loteIds.add(l.Id);
     }
     Map<Id,List<Item_do_Lote__c>> mapIL = new Map<Id,List<Item_do_Lote__c>>();
     for(Item_do_Lote__c il :[SELECT Id, Lote__c, Quantidade__c, Produto__c FROM Item_do_Lote__c WHERE Lote__c IN :loteIds]){
         String keyMap = String.valueOf(il.Lote__c);
         if(!mapIL.containsKey(keyMap)){
             mapIL.put(keyMap, new List<Item_do_Lote__c>());
         }
         mapIL.get(keyMap).add(il);
     }
     List<Item_do_Lote__c> itensToInsert = new List<Item_do_Lote__c>();
     for(OpportunityLineItem oli: lstOli){
         for(Lote__c l :lstLote){
             Boolean InsereProduto = true;
             if(mapIL.containsKey(l.Id)){
                 for(Item_do_Lote__c il :mapIL.get(l.Id)){
                     if(il.Produto__c == PbXProduto.get(oli.PricebookEntryId).Product2Id){
                         InsereProduto = false;
                     }
                 }
             }
             if(InsereProduto){
                 Item_do_Lote__c newIL = new Item_do_Lote__c();
                 newIL.Lote__c = l.Id;
                 newIL.Quantidade__c = 0;
                 newIL.Produto__c = PbXProduto.get(oli.PricebookEntryId).Product2Id;
                 itensToInsert.add(newIL);
             }
         }
     }
     if(itensToInsert.size() > 0) insert itensToInsert;    
 }
 */
    
/*
 public static void DelProductToLote(List<OpportunityLineItem> lstOli, Set<Id> oppIds){
     Set<Id> pbIds = new Set<Id>();
     for(OpportunityLineItem oli: lstOli){
         pbIds.add(oli.PricebookEntryId);
     }
     Map<Id,PricebookEntry> PbXProduto = new Map<Id,PricebookEntry>([SELECT Id,Product2Id, Product2.Name FROM PricebookEntry WHERE Id IN :pbIds]);
     
     Set<Id> loteIds = new set<Id>();
     --List<Lote__c> lstLote = [SELECT Id FROM Lote__c WHERE Oportunidade__c IN :oppIds];
     --for(Lote__c l :lstLote){
     --    loteIds.add(l.Id);
     --}
     
     Map<Id,List<Lote__c>> mapLote = new Map<Id,List<Lote__c>>();
     for(Lote__c l :[SELECT Id, Oportunidade__c FROM Lote__c WHERE Oportunidade__c IN :oppIds]){
         String keyMap = String.valueOf(l.Oportunidade__c);
         if(!mapLote.containsKey(keyMap)){
             mapLote.put(keyMap, new List<Lote__c>());
         }
         mapLote.get(keyMap).add(l);
         loteIds.add(l.Id);
     }
     
     Map<Id,List<Item_do_Lote__c>> mapIL = new Map<Id,List<Item_do_Lote__c>>();
     for(Item_do_Lote__c il :[SELECT Id, Lote__c, Quantidade__c, Produto__c FROM Item_do_Lote__c WHERE Lote__c IN :loteIds]){
         String keyMap = String.valueOf(il.Lote__c);
         if(!mapIL.containsKey(keyMap)){
             mapIL.put(keyMap, new List<Item_do_Lote__c>());
         }
         mapIL.get(keyMap).add(il);
     }
     for(OpportunityLineItem oli: lstOli){
         List<Item_do_Lote__c> itensToDelete = new List<Item_do_Lote__c>();
         //for(Lote__c l :lstLote)
         if(mapLote.containsKey(oli.OpportunityId)){
             for(Lote__c l :mapLote.get(oli.OpportunityId)){
                 for(Item_do_Lote__c il :mapIL.get(l.Id)){
                     if(il.Produto__c == PbXProduto.get(oli.PricebookEntryId).Product2Id){
                         if(il.Quantidade__c > 0){
                             itensToDelete.clear();
                             break;
                         } else {
                             itensToDelete.add(il);
                         }
                     }
                 }
             }
             if(itensToDelete.size() > 0 ){
              delete itensToDelete;
             } else {
              oli.addError('O produto ' + ' possui quantidade superior a zero em um ou mais Lotes desta Oportunidade. Para excluir este produto, certifique-se que a quantidade dele em todos os lotes é igual a zero.');
             }
         }
     }     
 }
*/

/*
 public static void doRequestTaxas(List<OpportunityLineItem> lstOli){
     Set<Id> oppIds = new Set<Id>();
     List<Opportunity> lstOpp = new List<Opportunity>();
     for(OpportunityLineItem oli :lstOli){
         oppIds.add(oli.OpportunityId);
         system.debug('CP CT_Consulta_Taxa_OK__c: ' + oli.Opportunity.CT_Consulta_Taxa_OK__c);
     }
     for(Opportunity opp :[SELECT RecordType.DeveloperName, CT_Consulta_Taxa_OK__c FROM Opportunity WHERE Id IN :oppIds AND CT_Consulta_Taxa_OK__c = true]){
         if(opp.RecordType.DeveloperName == 'Cargo_Tracck'){
             opp.CT_Consulta_Taxa_OK__c = false;
             lstOpp.add(opp);
         }
     }
     update lstOpp;
 }
*/
    
}