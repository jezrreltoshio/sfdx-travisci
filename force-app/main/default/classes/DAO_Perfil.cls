/*
	@testClass Teste_DAO_Perfil

	@description DAO para o objeto: Profile

	@author Renan Rocha
	@date 20/11/2018
	@JIRA KCA-9
*/

public class DAO_Perfil{

	private static String CLASS_NAME = 'DAO_Perfil';
	
	/*
		@description Retorna uma lista de perfis conforme o Set informado
		@param String pId
		@return List<Profile>
		
		@author Renan Rocha
	*/
	public static List<Profile> getPerfisById(String pId){
		String METHOD_NAME = 'getPerfisBySetId';
	
		return
			[SELECT Id
			      , Name 
	        FROM Profile 
	        WHERE Id =: pId];	 	
	}
}