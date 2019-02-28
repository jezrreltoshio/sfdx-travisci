/*
	@testClass DAO_Conjunto_Permissao
	
	@author Renan Rocha
	@date 09/01/2019
*/

@isTest
public class Teste_DAO_Conjunto_Permissao{
	
	/*
		@author Renan Rocha
		@date 09/01/2019
	*/
	static testMethod void getConjPermissaoByUserAssignedIdAndName(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();
		User usuario = (User) mapBase.get('User');

		DML_Mix_Operations_Future.DAO_Conjunto_Permissao_getConjPermissaoByUserAssignedIdAndName(usuario.Id);

		System.assertNotEquals(1, DAO_Conjunto_Permissao.getConjPermissaoByUserAssignedIdAndName(usuario.Id, 'Acesso_criar_direcionamento').size());
	}
}