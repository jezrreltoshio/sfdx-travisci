/*
    Classe de testes para a Classe "Lead_Converter_Mexico"

    Criado por: Mario Reis
    Data: 20/12/2017

*/
@isTest
public class Teste_Lead_Converter_Mexico {

    // Método para testar o carregamento do tipo de registro
    static testmethod void testeCarregarTipoRegistro() {
        Util_Conta.carregarTipoRegistro();
    }



    // Método para testar a conversão do Lead
    static testmethod void testeConvertLead() {

        Test.startTest();

        Util_Conta.carregarTipoRegistro();
        Util_Lead.carregarTipoRegistro();

        Lead lead = Teste_Util_Lead.criaLeadMercosulCUIT(Util_Lead.mercosul, '20-39627937-2');

        Lead_Converter_Mexico.convertLead(lead.Id);

        try {
        	Lead_Converter_Mexico.convertLead(null);    
        } catch (Exception e){}

        Test.stopTest();

    } // Fim testeConvertLead

}