@isTest(SeeAllData=true)
public class HistoricoLead_Teste{

    public static testMethod void teste(){
        Map<String, Schema.RecordTypeInfo> recordTypeLead = Lead.SObjectType.getDescribe().getRecordTypeInfosByName();
        
        lead l = new lead();
            l.RecordTypeId = recordTypeLead.get('CORP').getRecordTypeId(); 
            l.LastName = 'teste';
            l.FirstName = 'teste';
            l.Company= 'teste';
            l.Phone = '+55 11 2222 3333';
            l.Email = 'teste@testelead.com.br';
            insert l;
            
            Historico_Lead__c n = new Historico_Lead__c ();
            n.Name = 'teste';
            n.Lead__c = l.Id;
            insert n;
            }
}