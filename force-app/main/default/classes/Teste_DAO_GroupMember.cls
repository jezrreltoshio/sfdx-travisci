/*
	@testClass DAO_GroupMember
	
	@author Renan Rocha
	@date 28/12/2018
*/

@isTest
public class Teste_DAO_GroupMember{
	
	/*
		@author Renan Rocha
		@date 28/12/2018
	*/
	static testMethod void getMembroGrupoByGrupoId(){
		Map<String, sObject> mapBase = Teste_Util.createMapBaseConfig();
		Group grupo = (Group) mapBase.get('Group');

		System.assertEquals(1, DAO_GroupMember.getMembroGrupoByGrupoId(grupo.Id).size());
	}
}