/*
	@testClass DAO_Historico_OS
	
	@author Renan Rocha
	@date 18/12/2018
*/

@isTest
public class Teste_DAO_Historico_OS{
	
	/*
		@author Renan Rocha
		@date 19/12/2018
	*/
	static testMethod void getListaHistoricoOSRecente(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();
		System.assertEquals(1, DAO_Historico_OS.getListaHistoricoOSRecente().size());
	}

	/*
		@author Renan Rocha
		@date 03/01/2019
	*/
	static testMethod void getQueryHistoricoOSRecente(){
		System.assertNotEquals(null, DAO_Historico_OS.getQueryHistoricoOSRecente());
	}
}