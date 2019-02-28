/*
	@testClass DAO_Item_Ordem_Servico
	
	@author Renan Rocha
	@date 19/12/2018
*/

@isTest
public class Teste_DAO_Item_Ordem_Servico{
	
	/*
		@author Renan Rocha
		@date 19/12/2018
	*/
	static testMethod void getListaItemOSRecente(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();
		System.assertEquals(1, DAO_Item_Ordem_Servico.getListaItemOSRecente().size());
	}

	/*
		@author Renan Rocha
		@date 03/01/2019
	*/
	static testMethod void getQueryItemOSRecente(){
		System.assertNotEquals(null, DAO_Item_Ordem_Servico.getQueryItemOSRecente());
	}
}