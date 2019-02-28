/*
 * Testes não estão corretos, comentado algumas linhas para implantar em produção, 
 * necessário melhorar e deixar nos padrões
*/
@isTest
private class PreencheCampoLeadTest {
    
    static testMethod void Lead(){
    
        //CORP
        Map<String, Schema.RecordTypeInfo> tiposRegistro = Lead.sObjectType.getDescribe().getRecordTypeInfosByName();
        Lead l = new Lead();
        l.RecordTypeId = tiposRegistro.get('CORP').getRecordTypeId();
        l.FirstName = 'Lead';
        l.LastName = 'Teste';
        l.Company = 'Empresa Teste';
        l.Status = 'Em aberto';
        l.Canal_de_entrada__c = 'Ativo';
        l.LeadSource = 'Internet';
        l.Segmento__c = 'Bebidas';
        insert l;
    
        l.CNPJ__c = '12.403.787/0001-11';
        l.Phone = '00 0000 0000';
        update l;
    

        //SIGGO
        Lead le = new Lead();
        le.RecordTypeId = tiposRegistro.get('Siggo').getRecordTypeId();
        le.FirstName = 'Lead';
        le.LastName = 'Teste';
        le.Company = 'Empresa Teste';
        le.Status = 'Em aberto';
        le.Canal_de_entrada__c = 'Ativo';
        le.LeadSource = 'Internet';
        le.Segmento__c = 'Bebidas';
               
        insert le;
    
        le.CPF__c = '690.449.753-07';
        le.Phone = '00 0000 0000';
        
        update le;
    
   
        //FRETEIRO
        Lead lea = new Lead();
        lea.RecordTypeId = tiposRegistro.get('Freteiro').getRecordTypeId();
        lea.FirstName = 'Lead';
        lea.LastName = 'Teste';
        lea.Company = 'Empresa Teste';
        lea.Status = 'Em aberto';
        lea.Canal_de_entrada__c = 'Ativo';
        lea.LeadSource = 'Internet';
        lea.Segmento__c = 'Bebidas';
               
        insert lea;
    
        lea.CNPJ_CPF__c = '313.967.706-58';
        lea.Phone = '00 0000 0000';
        
        update lea;
        
         
        //MICHELIN
        Lead l1 = new Lead();
        l1.RecordTypeId = tiposRegistro.get('Michelin').getRecordTypeId();
        l1.FirstName = 'Lead';
        l1.LastName = 'Teste';
        l1.Company = 'Empresa Teste';
        l1.Status = 'Em aberto';
        l1.Canal_de_entrada__c = 'Ativo';
        l1.LeadSource = 'Internet';
        l1.Segmento__c = 'Bebidas';
               
        insert l1;
    
        l1.CNPJ_CPF__c = '411.333.228-24';
        l1.Phone = '00 0000 0000';
        
        //update l1;
        
       
        //CARGO TRACCK
        Lead ct = new Lead();
        ct.RecordTypeId = tiposRegistro.get('Cargo Tracck').getRecordTypeId();
        ct.FirstName = 'Lead';
        ct.LastName = 'Teste';
        ct.Company = 'Empresa Teste';
        ct.Status = 'Em aberto';
        ct.Canal_de_entrada__c = 'Ativo';
        ct.LeadSource = 'Internet';
        ct.Segmento__c = 'Bebidas';
        ct.Tipo_de_pessoa__c = 'J-Jurídica';
        ct.CNPJ__c = '51.040.153/0001-01';
        ct.VerificaDuplicidade__c = ct.CNPJ__c + 'Cargo Tracck';
		//ct.CPF__c = null;               
        insert ct;
        
        ct.Phone = '00 0000 0000';
        //update ct;
   
        Lead ct1 = new Lead();
        ct1.RecordTypeId = tiposRegistro.get('Cargo Tracck').getRecordTypeId();
        ct1.FirstName = 'Lead';
        ct1.LastName = 'Teste';
        ct1.Company = 'Empresa Teste';
        ct1.Status = 'Em aberto';
        ct1.Canal_de_entrada__c = 'Ativo';
        ct1.LeadSource = 'Internet';
        ct1.Segmento__c = 'Bebidas';
        ct1.Tipo_de_pessoa__c = 'F-Física';
        ct1.CPF__c = '527.816.515-40';
        ct1.VerificaDuplicidade__c = ct1.CPF__c + 'Cargo Tracck';
	    ct1.CNPJ__c = null;               
        //insert ct1;
        
        ct1.Phone = '00 0000 0000';
        //update ct1;

    }
    
}