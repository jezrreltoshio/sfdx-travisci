/*
	Classe de teste: Teste_DAO_Lead
	Criado por: Mario Reis
	Data de criação: 02/10/2017
	Descrição: Classe DAO para o objeto Lead
*/
public class DAO_Lead {


	// Método que retorna a lista de tipos de registro do Lead
	public static Map<String, String> getMapTipoRegistro(){

		System.debug(LoggingLevel.ERROR, '__ [cls DAO_Lead - getMapTipoRegistro()] - Inicio...');

		Map<String, String> mapRetorno = new Map<String, String>();

		try {

			for(RecordType rt : [SELECT Id
										, Name
										, DeveloperName 
									FROM RecordType 
								WHERE sObjectType = 'Lead']){
				mapRetorno.put(rt.DeveloperName, String.valueOf(rt.Id).substring(0,15) );
			}

			System.debug(LoggingLevel.ERROR, '__ [cls DAO_Lead - getMapTipoRegistro()] - mapRetorno: '+mapRetorno);

			return mapRetorno;

		} catch (Exception e){

			System.debug(LoggingLevel.ERROR, '__ [cls DAO_Lead - getMapTipoRegistro()] - ERRO: '+e.getMessage());
			throw new customException(Label.MSG_ERRO_0010);

		} // Fim try/catch

	} // Fim método getMapTipoRegistro


    // Método que retorna a lista de Leads para verificação da duplicidade
	public static List<Lead> getLeadVerificaoDuplicidadePorId(Set<Id> setIdLead, Set<String> setIdVerificaDuplicidade){

		System.debug(LoggingLevel.ERROR, '__ [cls DAO_Lead - getLeadVerificaoDuplicidadePorId()] - Inicio...');
		System.debug(LoggingLevel.ERROR, '__ [cls DAO_Lead - getLeadVerificaoDuplicidadePorId()] - setIdLead: '+setIdLead);
		System.debug(LoggingLevel.ERROR, '__ [cls DAO_Lead - getLeadVerificaoDuplicidadePorId()] - setIdVerificaDuplicidade: '+setIdVerificaDuplicidade);

		try {

			return [SELECT Id, Name, VerificaDuplicidade__c, CPF__c, CNPJ__c, CNPJ_CPF__c 
                        FROM Lead 
                    WHERE VerificaDuplicidade__c != ''
                    	AND VerificaDuplicidade__c IN: setIdVerificaDuplicidade
                    	AND Id NOT IN: setIdLead];

		} catch (Exception e){

			System.debug(LoggingLevel.ERROR, '__ [cls DAO_Lead - getLeadVerificaoDuplicidadePorId()] - ERRO: '+e.getMessage());
			throw new customException(Label.MSG_ERRO_0018);

		} // Fim try/catch

	} // Fim método getLeadVerificaoDuplicidadePorId


    // Método que retorna o Lead pelo ID da conta
	public static Lead getLeadPorContaId(String contaId){

        System.debug(LoggingLevel.ERROR, '__ [cls DAO_Lead - getLeadPorContaId()] - Inicio...');
		System.debug(LoggingLevel.ERROR, '__ [cls DAO_Lead - getLeadPorContaId()] - contaId: '+contaId);

		try {

            Lead leadRetorno = new Lead();

            for(Lead lead :[SELECT Id
                    		, RecordTypeId
							, Cadencia__c
                            , MobilePhone
                            , Circuito__c
                            , CNPJ__c
                            , Consultor_indicacao__c
                            , CPF__c
                            , CUIT__c
                            , Description
                            , DNI__c
                            , Email
                            , PostalCode
                            , Street
                            , State
                            , City
                            , Country
                            , Bairro_endereco__c
                            , Gerenciador_de_risco__c
                            , Indicador__c
                            , J_utilizou_rastreador__c
                            , Marca_do_concorrente__c
                            , Nome_fantasia__c
                            , Origem_Lead_Agrupado__c
                            , Outro_GR__c
                            , Outro_Segmento__c
                            , Possui_Escolta_Armada__c
                            , Qual_a_outra_marca__c
                            , Quantidade_de_ve_culos__c
                            , Quantidade_ve_culos_leves__c
                            , Quantidade_veiculos_pesados__c
                            , Segmento__c
                            , Website
                            , Tem_ve_culos_leves__c
                            , Tem_veiculos_pesados__c
                            , Tipo_de_cliente__c
                            , Tipo_de_pessoa__c
                            , Utiliza_concorrente__c
                            , Phone
                            , Telefone_2__c
                            , Telefone_3__c
                            , Telefone_4__c
					FROM Lead
				WHERE ConvertedAccountId =: contaId
                            AND isConverted = true]){

					leadRetorno = lead; 
				}

            if(leadRetorno.Id != null) return leadRetorno;
            else return null;

		} catch (Exception e){

			System.debug(LoggingLevel.ERROR, '__ [cls DAO_Lead - getLeadPorContaId()] - ERRO: '+e.getMessage());
			throw new customException(Label.MSG_ERRO_0024);

		} // Fim try/catch

    } // Fim getLeadPorContaId


}