/*
	@testClass DAO_Tipo_Item_OS
	
	@author Renan Rocha
	@date 07/01/2019
*/

@isTest
public class Teste_DAO_Tipo_Item_OS{
	
	/*
		@author Renan Rocha
		@date 08/01/2019
	*/
	static testMethod void getListaTipoItemOS(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();
		Tipo_item_OS__c tipoItemOS = (Tipo_item_OS__c) mapBase.get('Tipo_item_OS__c');

		System.assertEquals(1, DAO_Tipo_Item_OS.getListaTipoItemOS(tipoItemOS.Tipo_OS__c, tipoItemOS.Item__c).size());
	}
}