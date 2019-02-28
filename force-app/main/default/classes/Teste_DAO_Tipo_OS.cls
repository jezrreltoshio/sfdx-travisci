/*
	@testClass DAO_Tipo_OS
	
	@author Renan Rocha
	@date 07/01/2019
*/

@isTest
public class Teste_DAO_Tipo_OS{
	
	/*
		@author Renan Rocha
		@date 08/01/2019
	*/
	static testMethod void getListaTipoOS(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();
		Tipo_OS__c tipoOS = (Tipo_OS__c) mapBase.get('Tipo_OS__c');
		tipoOS.Ativo__c = true;
		update tipoOS;

		System.assertEquals(1, DAO_Tipo_OS.getListaTipoOS().size());
	}
}