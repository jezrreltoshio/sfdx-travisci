/*
	@testClass Util_OS_Atualizar_Informacoes
	
	@author Renan Rocha
	@date 05/12/2018
*/

@isTest
public class Teste_Util_OS_Atualizar_Informacoes{
	
	/*
		@author Renan Rocha
		@date 05/12/2018
	*/
	static testMethod void atualizarInformacoesOS(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();

		Parametrizacao_faixa_aging__c paramAging = (Parametrizacao_faixa_aging__c) mapBase.get('Parametrizacao_faixa_aging__c');
		paramAging.Tipo_macro_OS__c = 'Instalação';
		paramAging.Tipo_micro_OS__c = 'Instalação';
		paramAging.Aging_de__c = 2;
		paramAging.Aging_ate__c = null;
		update paramAging;

		WorkOrder OS = (WorkOrder) mapBase.get('WorkOrder');
		OS.Tipo_macro_OS__c = 'Instalação';
		OS.Tipo_micro_OS__c = 'Instalação';
		OS.Aging__c = 4;
		OS.StartDate = System.today().addDays(-4);
		update OS;

		Status_OS__c statusOS = (Status_OS__c) mapBase.get('Status_OS__c');
		statusOS.Tipo__c = 'Pendente';
		update statusOS;

		System.assertEquals(1, Util_OS_Atualizar_informacoes.atualizarInformacoesOS(new List<WorkOrder>{OS}).size());

		statusOS.Tipo__c = 'Finalizado';
		update statusOS;

		OS.Data_atualizacao_status_OS__c  = System.today();
		update OS;

		System.assertEquals(1, Util_OS_Atualizar_informacoes.atualizarInformacoesOS(new List<WorkOrder>{OS}).size());
	}
}