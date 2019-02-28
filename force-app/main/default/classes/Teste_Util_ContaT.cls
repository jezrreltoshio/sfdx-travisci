/*
    Classe de testes para a Classe "Util_Conta"

    Criado por: Mario Reis
    Data: 05/09/2017

*/
@isTest
public class Teste_Util_ContaT {

    // Método para testar o carregamento do tipo de registro
    static testmethod void testeCarregarTipoRegistro() {
        Util_Conta.carregarTipoRegistro();
    }



    // Método para copiar os campos do Lead para a Conta
    static testmethod void testeCopiarCamposLeadConta() {

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

		Util_Conta.copiarCamposLeadConta(lead.ConvertedAccountId);

        Test.stopTest();

    } // Fim testeCarregarTipoRegistro

}