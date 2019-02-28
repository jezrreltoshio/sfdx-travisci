/*
    Classe de testes para a Trigger "Trigger_Historico_OS"
    Criado por: Juliano Szlachta
    Data: 26/06/2018
*/
@isTest
public class Teste_Trigger_Historico_OS {

    public static Triggers__c confTriggers;

	static testmethod void testeTriggerHistoricoOS()  {

    	Test.startTest();

		Triggers__c confTriggers = Teste_Util_Configuracao.criarConfiguracaoTriggers();

        confTriggers.Trigger_historico_os__c = true;
    	update confTriggers;

        Status_OS__c statusPendente = Teste_Util_Status_OS.criarStatusAutorizadoPendente();
        WorkOrder OS = Teste_Util_OS.criarOSPadrao(statusPendente.Id);
        Historico_OS__c ho = Teste_Util_Historico_OS.criarHistoricoEfetivo(OS.Id);
        ho.Observacao__c = 'Teste';
        update ho;

		Test.stopTest();

	}	
	
}