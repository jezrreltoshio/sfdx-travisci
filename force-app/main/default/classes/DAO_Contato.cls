/*
	Classe de teste: Teste_DAO_Contato
	Criado por: Mario Reis
	Data de criação: 17/11/2017
	Descrição: Classe DAO para o objeto Contato
	---------------------------------
	@author Renan Rocha
	@date 28/01/2019
	@description:
		- Classe refatorada
		- Novos debugs inseridos
		- Inserido método getContatoByListId
	@JIRA KCA-482
*/
public class DAO_Contato {

	private static String CLASS_NAME = 'DAO_Contato';

    // Método que retorna o contato pelo ID da Conta
	public static Contact getContatoPorId(String idContato){
		String METHOD_NAME = 'getContatoPorId';

		System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - idContato: '+ idContato);

		return 
			[SELECT Id
				  , AccountId
				  , Bairro_endereco__c
				  , Codigo_municipio__c
				  , Complemento_endereco__c
				  , MailingCity
				  , MailingCountry
				  , MailingPostalCode
				  , MailingState
				  , MailingStreet
				  , Name
				  , Numero_endereco__c
			FROM Contact
			WHERE Id =: idContato];
	} // Fim método getContatoPorContaId

	/*
		@description Retorna uma lista de contato conforme os Ids informados
		@param List<Id> pListaId
		@return List<Contact>
		
		@author Renan Rocha
		@date 28/01/2019
		@JIRA KCA-482
	*/
	public static List<Contact> getContatoByListId(List<Id> pListaId){
		String METHOD_NAME = 'getContatoByListId';

		System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - pListaId: '+ pListaId);
		
		return
			[SELECT Id
				  , MailingPostalCode 
			FROM Contact 
			WHERE Id IN : pListaId];
	}
}