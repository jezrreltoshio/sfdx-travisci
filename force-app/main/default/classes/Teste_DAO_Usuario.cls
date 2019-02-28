/*
	@testClass DAO_Usuario
	
	@author Renan Rocha
	@date 06/12/2018
*/

@isTest
public class Teste_DAO_Usuario{
	
	/*
		@author Renan Rocha
		@date 06/12/2018
	*/
	static testMethod void getUsuariosBySetId(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();
		User usuario = (User) mapBase.get('User');

		System.assertEquals(1, DAO_Usuario.getUsuariosBySetId(new Set<Id>{usuario.Id}).size());
	}

	/*
		@author Renan Rocha
		@date 08/01/2019
	*/
	static testMethod void getListaUserDisponivel(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();
		User usuario = (User) mapBase.get('User');
		
		System.assertNotEquals(1, DAO_Usuario.getListaUserDisponivel(new List<String>{usuario.Id}).size());
	}

	/*
		@author Renan Rocha
		@date 08/01/2019
	*/
	static testMethod void getListaUser(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();
		
		System.assertNotEquals(1, DAO_Usuario.getListaUser().size());
	}
}