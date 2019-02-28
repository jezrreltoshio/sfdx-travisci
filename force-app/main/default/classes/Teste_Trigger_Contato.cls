/*
    Classe de testes para a Trigger "Trigger_Contato"

    Criado por: Mario Reis
    Data: 08/12/2017

*/
@isTest
public class Teste_Trigger_Contato {

    static testmethod void testeTriggerContato() {

        Test.startTest();

        Util_Conta.carregarTipoRegistro();

        Triggers__c confTriggers = Teste_Util_Configuracao.criarConfiguracaoTriggers();
        confTriggers.Trigger_contato__c = true;
        update confTriggers;

        Account conta = Teste_Util_Conta.criaContaBluetecF(Util_Conta.bluetec, '843.163.290-90');
        Contact contato = Teste_Util_Contato.criaContato(conta.Id, '83045200', 'rua', 'estado', 'cidade', 'Brasil');

        Test.stopTest();

    } // Fim testeTriggerContato

}