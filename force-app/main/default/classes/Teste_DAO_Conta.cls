/*
    Classe de testes para a Classe "DAO_Conta"

    Criado por: Mario Reis
    Data: 01/09/2017

*/
@isTest
public class Teste_DAO_Conta {

    // Metodo que cria os objetos necessários para o teste
    @testSetup     
    static void setup() {

        Util_Conta.carregarTipoRegistro();
    } // Fim método setup()

    // Verifica o método que retorna a conta pelo ID
    static testmethod void testeGetContaPorId() {

        setup();

        Test.startTest();

        Account conta = Teste_Util_Conta.criaContaBluetecF(Util_Conta.bluetec, '843.163.290-90');

        Account contaRetorno = DAO_Conta.getContaPorId(conta.Id);
        System.assertEquals(contaRetorno.Id, conta.Id);
        System.assertNotEquals(contaRetorno, null);

        // Verifica erro
        try {

          Account contaRetorno2 = DAO_Conta.getContaPorId(null);
        } catch (Exception e) {

          System.Assert(e.getMessage().contains(Label.MSG_ERRO_0002));
        }

        Test.stopTest();

    } // Fim testeGetContaPorId

  // Verifica o método que retorna a verificação da duplicidade de conta
    static testmethod void testeGetContaVerificaoDuplicidadePorId() {

        setup();

        Test.startTest();

        Account conta = Teste_Util_Conta.criaContaBluetecF(Util_Conta.bluetec, '843.163.290-90');
        Account conta2 = Teste_Util_Conta.criaContaSIGGOF(Util_Conta.SIGGO, '843.163.290-90');

        List<Account> listaContaRetorno = DAO_Conta.getContaVerificaoDuplicidadePorId(new Set<Id>{conta.Id}, new Set<String>{conta2.Id});
        
        
        // Verifica erro
        try {

          List<Account> listaContaRetorno2 = DAO_Conta.getContaVerificaoDuplicidadePorId(null, null);
        } catch (Exception e) {

          System.Assert(e.getMessage().contains(Label.MSG_ERRO_0002));
        }
        
        Test.stopTest();

    } // Fim testeGetContaVerificaoDuplicidadePorId
    
     // Verifica o método que retorna a conta pelo AccountId do Lead
    static testmethod void testeGetContaPorLeadContaId() {

        setup();

        Test.startTest();
        
        Util_Conta.carregarTipoRegistro();
        Util_Lead.carregarTipoRegistro();

        Lead lead = Teste_Util_Lead.criaLeadMercosulCUIT(Util_Lead.mercosul, '20-39627937-2');

        database.leadConvert lc = new database.leadConvert();
        lc.setLeadId(lead.id);
        
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];

    lc.setConvertedStatus(convertStatus.MasterLabel);
       Database.LeadConvertResult lcr = Database.convertLead(lc);

        lead = [SELECT Id, Name, ConvertedAccountId FROM Lead WHERE Id =: lead.Id];

    DAO_Conta.getContaPorLeadContaId(lead.ConvertedAccountId);

        // Verifica erro
        try {
          DAO_Conta.getContaPorLeadContaId(null);
        } catch (Exception e) {
          System.Assert(e.getMessage().contains(Label.MSG_ERRO_0022));
        }
        
        Test.stopTest();

    } // Fim testeGetContaPorLeadContaId

    /*
        @author Renan Rocha
        @date 20/11/2018
    */
    static testMethod void getContaPorListaId(){
        setup();

        Util_Conta.carregarTipoRegistro();
        Account conta = Teste_Util_Conta.criaContaBluetecF(Util_Conta.bluetec, '843.163.290-90');

        System.assertEquals(1, DAO_Conta.getContaPorListaId(new List<Id>{conta.Id}).size());
    }    

    /*
        @author Renan Rocha
        @date 21/11/2018
    */
    static testMethod void getContasBySetId(){
        setup();

        Util_Conta.carregarTipoRegistro();
        Account conta = Teste_Util_Conta.criaContaBluetecF(Util_Conta.bluetec, '843.163.290-90');

        System.assertEquals(1, DAO_Conta.getContasBySetId(new Set<Id>{conta.Id}).size());
    }

    /*
        @author Renan Rocha
        @date 11/01/2019
    */
    static testMethod void getContasByCNPJERecordTypeId(){
        Map<String, sObject> mapBase = Teste_Util.createMapBase();
        Account conta = (Account) mapBase.get('Account');
        conta.CNPJ__c = '30.022.945/0001-75';
        conta.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CORP').getRecordTypeId();
        update conta;

        Account contaDup = Teste_Util.newAccount();
        contaDup.CNPJ__c = '30.022.945/0001-75';
        contaDup.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CORP').getRecordTypeId();
        update contaDup;

        System.assertEquals(contaDup.Id, DAO_Conta.getContasByCNPJERecordTypeId(conta.CNPJ__c, conta.RecordTypeId, conta.Id).Id);
    }
}