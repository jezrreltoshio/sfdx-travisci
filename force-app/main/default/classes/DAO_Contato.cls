/*
	Classe de teste: Teste_DAO_Contato
	Criado por: Mario Reis
	Data de criação: 17/11/2017
	Descrição: Classe DAO para o objeto Contato
*/
public class DAO_Contato {

    // Método que retorna o contato pelo ID da Conta
	public static Contact getContatoPorId(String idContato){

		System.debug(LoggingLevel.ERROR, '__ [cls DAO_Contato - getContatoPorContaId()] - Inicio...');
		System.debug(LoggingLevel.ERROR, '__ [cls DAO_Contato - getContatoPorContaId()] - idContato: '+idContato);

		try {

			return [SELECT Id
                    		, Name
                            , AccountId
                    		//, MailingAddress
                    		, MailingCity
                    		, MailingCountry
                    		, MailingPostalCode
                    		, MailingState
                    		, MailingStreet
                    		, Numero_endereco__c
							, Complemento_endereco__c
							, Bairro_endereco__c
							, Codigo_municipio__c
                    	FROM Contact
                       	 WHERE Id =: idContato];

		} catch (Exception e){

			System.debug(LoggingLevel.ERROR, '__ [cls DAO_Contato - getContatoPorContaId()] - ERRO: '+e.getMessage());
			throw new customException(Label.MSG_ERRO_0025);

		} // Fim try/catch

	} // Fim método getContatoPorContaId

}