@isTest
private class PreencheCampoContaTest {
    
    static testMethod void Account(){
    
        //CORP
        Map<String, Schema.RecordTypeInfo> tiposRegistro = Account.sObjectType.getDescribe().getRecordTypeInfosByName();
        Account l = new Account();
        l.RecordTypeId = tiposRegistro.get('CORP').getRecordTypeId();
        l.Name = 'Lead';
        l.Phone = '00 0000 0000';
        L.Regional__c = 'Teste';
        insert l;
    
        l.CNPJ__c = '12.403.787/0001-11';
        update l;
    
    
        //SIGGO
        Account le = new Account();
        le.RecordTypeId = tiposRegistro.get('SIGGO').getRecordTypeId();
        le.Name = 'Teste';
        le.Regional__c = 'Teste';
        le.Phone = '00 0000 0000'; 
        le.Tipo_de_pessoa__c = 'F-Física';      
        le.FormaCobranca__c = 'Teste';
        insert le;
    
        le.CPF__c = '690.449.753-07';
        update le;
    
    
        //FRETEIRO
        Account lea = new Account();
        lea.RecordTypeId = tiposRegistro.get('FRETEIRO').getRecordTypeId();
        lea.Name = 'Teste';
        lea.Regional__c = 'Teste';
        lea.Phone = '00 0000 0000';
        lea.Optante_Simples__c = 'Sim';
        lea.Tipo_de_pessoa__c = 'F-Física';
        insert lea;
    
        lea.CNPJ_CPF__c = '313.967.706-58';
        update lea;
        
        
        //MICHELIN
        Account l1 = new Account();
        l1.RecordTypeId = tiposRegistro.get('Michelin').getRecordTypeId();
        l1.Name = 'Teste';
        l1.Regional__c = 'Teste';
        l1.Phone = '00 0000 0000';
        l1.Type = 'Teste';
        insert l1;
    
        l1.CNPJ_CPF__c = '411.333.228-24';
        update l1;
        
        //CARGO TRACCK
        Account ct = new Account();
        ct.RecordTypeId = tiposRegistro.get('Cargo Tracck').getRecordTypeId();
        ct.Name = 'Teste';
        ct.Regional__c = 'Teste';
        ct.Phone = '00 0000 0000';
        ct.Type = 'Teste';
        ct.Tipo_de_pessoa__c = 'J-Jurídica';
        ct.CNPJ__c = '51.040.153/0001-01';
        ct.VerificaDuplicidade_3__c = ct.CNPJ__c + 'Cargo Tracck';
        //ct.CPF__c = null;
        insert ct;
        
        Account ct1 = new Account();
        ct1.RecordTypeId = tiposRegistro.get('Cargo Tracck').getRecordTypeId();
        ct1.Name = 'Teste';
        ct1.Regional__c = 'Teste';
        ct1.Phone = '00 0000 0000';
        ct1.Type = 'Teste';
        ct1.Tipo_de_pessoa__c = 'F-Física';
        ct1.CPF__c = '527.816.515-40';
        ct1.VerificaDuplicidade_3__c = ct1.CPF__c + 'Cargo Tracck';
        ct1.CNPJ__c = null;        
        insert ct1;
    
    }
    
}