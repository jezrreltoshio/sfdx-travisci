/*
    Classe de testes para a Classe "DAO_Lead"

    Criado por: Mario Reis
    Data: 02/10/2017

*/
@isTest
public class Teste_DAO_Lead {

    // Verifica o método que retorna o map de tipo de registro
    static testmethod void testeGetMapTipoRegistro() {

        Test.startTest();

		DAO_Lead.getMapTipoRegistro();

        Test.stopTest();

    } // Fim testeGetContaPorId

    
    
    // Verifica o método que retorna o Lead pelo Id da Conta
    static testmethod void testeGetLeadPorContaId() {

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

		DAO_Lead.getLeadPorContaId(lead.ConvertedAccountId);

        // Verifica erro
        try {

        	DAO_Lead.getLeadPorContaId(null);
        } catch (Exception e) {

        	System.Assert(e.getMessage().contains(Label.MSG_ERRO_0024));
        }
        
        Test.stopTest();

    } // Fim testeGetLeadPorContaId



    // Verifica o método que retorna a verificação de duplicidade de Lead
    static testmethod void testeGetLeadVerificaoDuplicidadePorId() {

        Test.startTest();
        
        Util_Lead.carregarTipoRegistro();

        Lead lead = Teste_Util_Lead.criaLeadBluetecF(Util_Lead.bluetec, '843.163.290-90');
        Lead lead2 = Teste_Util_Lead.criaLeadSiggo(Util_Lead.siggo, '843.163.290-90');

        DAO_Lead.getLeadVerificaoDuplicidadePorId(new Set<Id>{lead.Id}, new Set<String>{lead2.Id});
        
        // Verifica erro
        try {

        	DAO_Lead.getLeadVerificaoDuplicidadePorId(null, null);
        } catch (Exception e) {

        	System.Assert(e.getMessage().contains(Label.MSG_ERRO_0018));
        }
        
        Test.stopTest();

    } // Fim testeGetLeadVerificaoDuplicidadePorId

}