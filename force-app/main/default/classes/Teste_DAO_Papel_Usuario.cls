/*
	@testClass DAO_Papel_Usuario

	@author Renan Rocha
	@date 20/11/2018
*/

@isTest
public class Teste_DAO_Papel_Usuario{

	/*
		@author Renan Rocha
		@date 06/12/2018
	*/
	static testMethod void getPapeisUsuarioById(){
		// Map<String, sObject> mapBase = Teste_Util.createMapBase();
		UserRole papel = Teste_Util.newPapelUsuario();

		System.assertEquals(1, DAO_Papel_Usuario.getPapeisUsuarioById(papel.Id).size());
	}
}