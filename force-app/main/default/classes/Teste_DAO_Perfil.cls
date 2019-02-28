/*
	@testClass DAO_Perfil

	@author Renan Rocha
	@date 20/11/2018
*/

@isTest
public class Teste_DAO_Perfil{

	/*
		@author Renan Rocha
		@date 06/12/2018
	*/
	static testMethod void getPerfisById(){
		Profile perfil = [SELECT Id FROM Profile LIMIT 1];

		System.assertEquals(1, DAO_Perfil.getPerfisById(perfil.Id).size());
	}
}