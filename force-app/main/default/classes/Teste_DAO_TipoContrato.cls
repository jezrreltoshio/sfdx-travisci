/*
	@testClass DAO_TipoContrato
	
	@author Renan Rocha
	@date 07/01/2019
*/

@isTest
public class Teste_DAO_TipoContrato{
	
	/*
		@author Renan Rocha
		@date 08/01/2019
	*/
	static testMethod void getListaTipoContrato(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();

		System.assertEquals(1, DAO_TipoContrato.getListaTipoContrato().size());
	}
}