@isTest
public class Teste_Exportar_Acao_Historico_OS {

    // Método para teste da classe
    static testmethod void teste() {

        Acao_historico_OS__c acao = new Acao_historico_OS__c();
        acao.Name = 'teste';
        acao.Categoria_contato__c = 'Efetivo';
		acao.Data_cadastro__c = System.now();
		acao.Ativo__c = true;
        acao.Codigo_externo__c = '1';
        insert acao;

        Test.startTest();

        new Exportar_Acao_Historico_OS();

        Test.stopTest();

    } // Fim teste

}