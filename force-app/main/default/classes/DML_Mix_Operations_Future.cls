/*
	@testClass Teste_DML_Mix_Operations_Future
	
	@description Classe genérica para inserção de objetos de configuração em classes de teste para evitar erros de DML
	
	@author Renan Rocha
	@date 28/12/2018
	@JIRA KCA-384
	---------------------------------
	@author Renan Rocha
	@date 09/01/2019
	@description Inserido método DAO_Conjunto_Permissao_getConjPermissaoByUserAssignedIdAndName
	@JIRA KCA-59
*/

public class DML_Mix_Operations_Future{
	private static String CLASS_NAME = 'DML_Mix_Operations_Future';
	
	/*
		@description Executa o método no futuro para evitar erros de DML
		@param String pIdUsuario
		@return void
		
		@author Renan Rocha
		@date 28/12/2018
		@JIRA KCA-384
	*/
	@future
	public static void Handler_Lead_vericaUsuarioCanalExclusivoHelper(String pIdUsuario){
		String METHOD_NAME = 'DMLHandler';
		
		Map<String, sObject> mapBase = Teste_Util.createMapBase();

		Lead lead = (Lead) mapBase.get('Lead');
        lead.LeadSource = 'Canal Exclusivo de Indicações';

		User usuarioDAO = [SELECT Id FROM User WHERE Id =: pIdUsuario];

        System.runAs(usuarioDAO){
            update lead;
        }

        Handler_Lead.vericaUsuarioCanalExclusivo(new List<Lead>{lead}, null, true);
	}

	/*
		@description Executa o método no futuro para evitar erros de DML
		@param String pIdUsuario
		@return void
		
		@author Renan Rocha
		@date 09/01/2019
		@JIRA KCA-59
	*/
	@future
	public static void DAO_Conjunto_Permissao_getConjPermissaoByUserAssignedIdAndName(String pIdUsuario){
		String METHOD_NAME = 'DMLHandler';
		
		PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'Acesso_criar_direcionamento'];
		insert new PermissionSetAssignment(AssigneeId = pIdUsuario, PermissionSetId = ps.Id);
	}
}