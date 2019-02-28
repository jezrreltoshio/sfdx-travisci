@isTest (SeeAllData=true)
global class OpportunityLineItemTriggersTest {
 
 public static Opportunity createOppty() {
  Opportunity opp = new Opportunity();
        
  //opp.CartaoCredito_Numero__c = 5555;// - Desabilitado para uso do campo Criptografado - Carlos Prates 05/02/2014 18:00
  opp.CartaoCredito_Numero_Cript__c = '1111444477778884';
  //opp.CartaoCredito_CodigoSeguranca__c = 123; //- Desabilitado para uso do campo Criptografado - Carlos Prates 06/02/2014 15:00
  opp.CartaoCredito_CodigoSeguranca_Cript__c = '123';
  opp.CartaoCredito_Vencimento__c = '1012';
        
  opp.name = 'Opp 1';
  opp.StageName = 'Abordagem inicial';
  opp.CloseDate = Date.today();
  opp.Description = 'Teste';
        
  return opp;
 }
 
 static testMethod void TestBloquear() {
  Product2 p = new Product2(Name = 'Produto_Teste');
  insert p;
  
  Pricebook2 pb2 = [SELECT Id FROM Pricebook2 WHERE isStandard = true];
  
  PricebookEntry pbe = new PricebookEntry(Product2Id = p.Id, Pricebook2Id = pb2.Id, UnitPrice = 1, isActive = true);
  insert pbe;
  
  Opportunity opp = CreateOppty();
  opp.Pricebook2Id = pb2.Id;
  opp.RecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Opportunity' AND Name = 'CORP'].Id;
  insert opp;
    
  OpportunityLineItem oppli = new OpportunityLineItem(PricebookEntryId = pbe.Id, OpportunityId = opp.Id, Quantity = 10, TotalPrice = 10);
  insert oppli;
  
  Opportunity opp2 = [SELECT Id FROM Opportunity WHERE Id =:opp.Id];
  opp2.Aprova_o__c = 'Aprovado';
  update opp2;
  //try{ insert oppli; }catch(Exception e){ e.getMessage();}
 }
 
 static testMethod void TestSyncOliAux() {
  Product2 p = new Product2(Name = 'Produto_Teste');
  insert p;
  
  Pricebook2 pb2 = [SELECT Id FROM Pricebook2 WHERE isStandard = true];
  
  PricebookEntry pbe = new PricebookEntry(Product2Id = p.Id, Pricebook2Id = pb2.Id, UnitPrice = 1, isActive = true);
  insert pbe;
  
  Opportunity opp = CreateOppty();
  opp.Pricebook2Id = pb2.Id;
  opp.RecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Opportunity' AND Name = 'CORP'].Id;
  opp.StageName = 'Abordagem inicial';
  insert opp;
    
  OpportunityLineItem oppli = new OpportunityLineItem(PricebookEntryId = pbe.Id, OpportunityId = opp.Id, Quantity = 10, TotalPrice = 10);
  insert oppli; 
  update oppli;
  delete oppli;
  
  Opportunity opp2 = [SELECT Id FROM Opportunity WHERE Id =:opp.Id];
  opp2.Aprova_o__c = 'Aprovado';
  update opp2;
  //try{ insert oppli; }catch(Exception e){ e.getMessage();}
 }
 
/*
 static testMethod void TestUpdateTipoProduto() {
  Product2 p1 = new Product2(Name = 'Produto_Teste_1', CT_Tipo_Produto__c = 'R-Retornável');
  insert p1;
  
  Product2 p2 = new Product2(Name = 'Produto_Teste_2', CT_Tipo_Produto__c = 'D-Descartável');
  insert p2;
  
  Pricebook2 pb2 = [SELECT Id FROM Pricebook2 WHERE isStandard = true];
  
  PricebookEntry pbe1 = new PricebookEntry(Product2Id = p1.Id, Pricebook2Id = pb2.Id, UnitPrice = 1, isActive = true);
  insert pbe1;
  
  PricebookEntry pbe2 = new PricebookEntry(Product2Id = p2.Id, Pricebook2Id = pb2.Id, UnitPrice = 1, isActive = true);
  insert pbe2;
  
  Opportunity opp = CreateOppty();
  opp.Produto_VigenciaContrato__c = 36;
  opp.Aprova_o__c = 'Aprovado';
  opp.Pricebook2Id = pb2.Id;
  opp.RecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Opportunity' AND DeveloperName = 'Cargo_Tracck'].Id;
  insert opp;
    
  OpportunityLineItem oli1 = new OpportunityLineItem(PricebookEntryId = pbe1.Id, OpportunityId = opp.Id, Quantity = 10, TotalPrice = 10);
  insert oli1;
  //update oli1;
  
  OpportunityLineItem oli2 = new OpportunityLineItem(PricebookEntryId = pbe1.Id, OpportunityId = opp.Id, Quantity = 20, TotalPrice = 10);
  insert oli2;
  
  OpportunityLineItem oli3 = new OpportunityLineItem(PricebookEntryId = pbe2.Id, OpportunityId = opp.Id, Quantity = 10, TotalPrice = 10);
     try{insert oli3;}catch(Exception e){}
         
  //try{ insert oppli; }catch(Exception e){ e.getMessage();}
 }
*/
}