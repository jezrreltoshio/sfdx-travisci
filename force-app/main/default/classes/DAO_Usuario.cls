/*
	@testClass Teste_DAO_Usuario

	@description DAO para o objeto: User

	@author Renan Rocha
	@date 19/11/2018
	@JIRA KCA-9
	---------------------------------
	@author Renan Rocha
	@date 07/01/2019
	@description:
		- Trazido métodos getListaUserDisponivel e getListaUser que estavam na classe DAO_Direcionamento_OS
	@JIRA KCA-59
*/

public class DAO_Usuario{

	private static String CLASS_NAME = 'DAO_Usuario';
	
	/*
		@description Retorna uma lista de usuários conforme o Set
		@param Set<Id> pSetUserId
		@return List<User>
		
		@author Renan Rocha
	*/
	public static List<User> getUsuariosBySetId(Set<Id> pSetUserId){
		String METHOD_NAME = 'getUsuariosBySetId';
	
		return
			[SELECT Id
				  , Name
				  , UserRole.Name 
		    FROM User 
		    WHERE Id IN: pSetUserId];	
	}

	// Método que retorna lista de Usuarios selecionados
    public static List<User> getListaUserDisponivel(List<String> idUsuariosSelecionados){
        String METHOD_NAME = 'getListaUserDisponivel';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - idUsuariosSelecionados: '+ idUsuariosSelecionados);

        return
            [SELECT Id
                  , Name
            FROM User
            WHERE isActive = true 
            AND Profile.Name = 'Atendimento' 
            AND Id NOT IN: idUsuariosSelecionados];
    } // Fim método getListaUserDisponivel

	// Método que retorna a lista de todos os usuários
    public static List<User> getListaUser(){
        String METHOD_NAME = 'getListaUser';

        return
            [SELECT Id
                  , IsActive
                  , Name
                  , Profile.Name
            FROM User 
            WHERE isActive = true 
            AND Profile.Name = 'Atendimento'
            ORDER BY Name];
    } // Fim método getListaUser
}