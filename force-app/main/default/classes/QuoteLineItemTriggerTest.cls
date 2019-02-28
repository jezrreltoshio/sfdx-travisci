@isTest(SeeAllData=true)
private class QuoteLineItemTriggerTest {
  
 public static Account createAcc() {
   Account acc = new Account();
   acc.TelefoneCelular__c = '1198765432';
   acc.Phone = '1198765432';
   acc.Name = 'Teste';
 
   return acc;
 }
 
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
 
 static testMethod void PreenchePrazoTest() {
   Account acc = createAcc();
     acc.Circuito__c = '1';
     acc.Cadencia__c = '2';
   insert acc;
  
   Product2 produto = new Product2();
   produto.Name = 'Produto Teste';
   produto.Prazo_do_Contrato__c = 12;
   insert produto;
   
   Pricebook2 pb = [SELECT Id FROM Pricebook2 WHERE isStandard=true LIMIT 1];
   
   PricebookEntry pbe = new PricebookEntry(Product2Id = produto.Id, UnitPrice = 10, IsActive = true, Pricebook2Id = pb.Id); 
   insert pbe;
      
   Opportunity opp = createOppty();
   opp.Pricebook2Id = pb.Id;
   opp.StageName = 'Abordagem inicial';
   opp.CloseDate = Date.today().addDays(1);
   insert opp;
   
   OpportunityLineItem oppli = new OpportunityLineItem();
   oppli.OpportunityId = opp.Id;
   oppli.PricebookEntryId = pbe.Id;
   oppli.Prazo_do_contrato2__c = 18;
   oppli.Quantity = 10;
   oppli.UnitPrice = 10;
   insert oppli;
   
   opp.Aprova_o__c = 'Aprovado';
   update opp;
   
   Quote cotacao = new Quote();
   cotacao.Name = 'Teste';
   cotacao.OpportunityId = opp.Id;
   cotacao.Pricebook2Id = pb.Id;
   insert cotacao;
   
   QuoteLineItem qli = new QuoteLineItem();
   qli.QuoteId = cotacao.Id;
   qli.PricebookEntryId = pbe.Id;
   qli.Quantity = 10;
   qli.UnitPrice = 10;
   insert qli;
   
   //List<QuoteLineItem> lstQli = [SELECT Id, PricebookEntry.Product2.Name, Prazo_do_contrato__c FROM QuoteLineItem WHERE QuoteId =: cotacao.id];
   //system.debug('DEBUG TESTE ' + lstQli);
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
   try{ insert oppli; }catch(Exception e){ e.getMessage(); }
   
   Quote cotacao = new Quote(Name = 'Teste', OpportunityId = opp.Id, Pricebook2Id = pb2.Id);
   
   //Atualiza oportunidade para não permitir a criação de um item da cotação relacionado
   opp.Aprova_o__c = 'Aprovado';
   update opp;
   
   try{ insert cotacao; }catch(Exception e){ e.getMessage(); }
   
   cotacao.Name = 'Teste - Update';
   try{ update cotacao; }catch(Exception e){ e.getMessage(); }
   
   QuoteLineItem qli = new QuoteLineItem(
    QuoteId = cotacao.Id,
    PricebookEntryId = pbe.Id,
    Quantity = 10,
    UnitPrice = 10
   );
   try{ insert qli; }catch(Exception e){ e.getMessage(); }
   
   qli.Quantity = 20;
   try{ update qli; }catch(Exception e){ e.getMessage(); }
   
   try{ delete qli; }catch(Exception e){ e.getMessage(); }
  }
  
}