/*
	@testClass Teste_DAO_GroupMember
	
	@description Classe para o Objeto: GroupMember
	
	@author Renan Rocha
	@date 28/12/2018
	@JIRA KCA-384
*/

public class DAO_GroupMember{
	private static String CLASS_NAME = 'DAO_GroupMember';
	
	/*
		@description Retorna uma lista de membros do grupo conforme o Id
		@param String pGrupoId
		@return List<GroupMember>
		
		@author Renan Rocha
		@date 28/12/2018
		@JIRA KCA-384
	*/
	public static List<GroupMember> getMembroGrupoByGrupoId(String pGrupoId){
		String METHOD_NAME = 'getMembroGrupoByGrupoId';
		
		return
			[SELECT Id
				  , UserOrGroupId
			FROM GroupMember
			WHERE GroupId =: pGrupoId];
	}
}