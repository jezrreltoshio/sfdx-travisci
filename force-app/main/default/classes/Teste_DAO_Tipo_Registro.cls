/*
	@testClass DAO_Tipo_Registro

	@author Renan Rocha
	@date 20/11/2018
*/

@isTest
public class Teste_DAO_Tipo_Registro{

	/*
		@author Renan Rocha
		@date 06/12/2018
	*/
	static testMethod void getTiposRegistroBySetId(){
		RecordType rt = [SELECT id FROM RecordType WHERE SobjectType='Contact' LIMIT 1];

		System.assertEquals(1, DAO_Tipo_Registro.getTiposRegistroBySetId(new Set<Id>{rt.Id}).size());
	}
}