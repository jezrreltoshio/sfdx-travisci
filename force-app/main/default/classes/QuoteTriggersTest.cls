@isTest(SeeAllData=true)
public class QuoteTriggersTest{
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
   opp.StageName = 'Abordagem inicial';
   opp.RecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Opportunity' AND Name = 'CORP'].Id;
   insert opp;
    
   OpportunityLineItem oppli = new OpportunityLineItem(PricebookEntryId = pbe.Id, OpportunityId = opp.Id, Quantity = 10, TotalPrice = 10);
   try{ insert oppli; }catch(Exception e){ e.getMessage(); }
   
   Quote cotacao = new Quote(Name = 'Teste', OpportunityId = opp.Id, Pricebook2Id = pb2.Id);
   try{ insert cotacao; }catch(Exception e){ e.getMessage(); }
   
   opp.Aprova_o__c = 'Aprovado';
   update opp;
   
   try{ insert cotacao; }catch(Exception e){ e.getMessage(); }
   
   try{ delete cotacao; }catch(Exception e){ e.getMessage(); }
   
  }
}