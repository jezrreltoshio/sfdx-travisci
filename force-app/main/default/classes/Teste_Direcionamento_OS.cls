/*
	@testClass Direcionamento_OS
	
	@author Renan Rocha
	@date 21/12/2018
*/

@isTest
public class Teste_Direcionamento_OS{
	
	/*
		@author Renan Rocha
		@date 21/12/2018
	*/
	static testMethod void getDirecionamentoOS(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();

		System.assertEquals(1, Direcionamento_OS.getDirecionamentoOS().size());
	}

	/*
		@author Renan Rocha
		@date 21/12/2018
	*/
	static testMethod void getConfigDirecionamentoOS(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();
		Direcionamento_os__c dirOS = (Direcionamento_os__c) mapBase.get('Direcionamento_os__c');

		System.assertEquals(dirOS.Id, Direcionamento_OS.getConfigDirecionamentoOS(dirOS.Id).Id);
	}

	/*
		@author Renan Rocha
		@date 21/12/2018
	*/
	static testMethod void getUsuariosDirecionamentoOS(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();
		Direcionamento_os__c dirOS = (Direcionamento_os__c) mapBase.get('Direcionamento_os__c');

		System.assertEquals(1, Direcionamento_OS.getUsuariosDirecionamentoOS(dirOS.Id).size());
	}

	/*
		@author Renan Rocha
		@date 21/12/2018
	*/
	static testMethod void salvarConfiguracao(){
		User usuario = Teste_Util.newUserAtendimento();

		String resultado = Direcionamento_OS.salvarConfiguracao('{Name: \'Teste\', OS_sem_servico__c: false}', usuario.Id);
	}

	/*
		@author Renan Rocha
		@date 21/12/2018
	*/
	static testMethod void pesquisarOS(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();

		System.assertEquals(0, Direcionamento_OS.pesquisarOS('{Name: \'Tratativa Frotas\'}').size());
	}

	/*
		@author Renan Rocha
		@date 21/12/2018
	*/
	static testMethod void removerConfiguracao(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();
		Direcionamento_os__c dirOS = (Direcionamento_os__c) mapBase.get('Direcionamento_os__c');

		System.assertEquals(true, Direcionamento_OS.removerConfiguracao(dirOS.Id));
	}
}