/*
	@testClass Teste_DAO_Papel_Usuario

	@description DAO para o objeto: UserRole

	@author Renan Rocha
	@date 20/11/2018
	@JIRA KCA-9
*/

public class DAO_Papel_Usuario{

	private static String CLASS_NAME = 'DAO_Papel_Usuario';
	
	/*
		@description Retorna uma lista de papéis de usuário conforme o Id informado
		@param String pId
		@return List<UserRole>
		
		@author Renan Rocha
	*/
	public static List<UserRole> getPapeisUsuarioById(String pId){
		String METHOD_NAME = 'getPapeisUsuarioById';
	
		return
			[SELECT Id
				  , Name 
			FROM UserRole 
			WHERE Id =: pId];	
	}
}