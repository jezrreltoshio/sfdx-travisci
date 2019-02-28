/*
	@testClass Teste_DAO_Conjunto_Permissao
	
	@description Classe para o Objeto: PermissionSetAssignment
	
	@author Renan Rocha
	@date 09/01/2019
	@JIRA KCA-59
*/

public class DAO_Conjunto_Permissao{
	private static String CLASS_NAME = 'DAO_Conjunto_Permissao';
	
	/*
		@description Retorna uma lista de conjuntos de permissão conforme o Id do usuário informado e o nome do conjunto
		@param String pIdUser, String pName
		@return List<PermissionSetAssignment>
		
		@author Renan Rocha
		@date 09/01/2019
		@JIRA KCA-59
	*/
	public static List<PermissionSetAssignment> getConjPermissaoByUserAssignedIdAndName(String pIdUser, String pName){
		String METHOD_NAME = 'getConjPermissaoByUserAssignedIdAndName';
		
		return
			[SELECT PermissionSetId 
			FROM PermissionSetAssignment 
			WHERE AssigneeId =: pIdUser 
			AND PermissionSet.Name =: pName];
	}
}