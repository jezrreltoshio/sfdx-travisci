/*
	@testClass Teste_DAO_Atendente_Direcionamento_OS
	
	@description Classe para o Objeto: Atendente_Direcionamento_OS__c
	
	@author Renan Rocha
	@date 07/01/2019
	@JIRA KCA-59
*/

public class DAO_Atendente_Direcionamento_OS{
	private static String CLASS_NAME = 'DAO_Atendente_Direcionamento_OS';
	
	// Método que retorna lista de Usuarios selecionados na configração
    public static List<Atendente_Direcionamento_OS__c> getUsuariosSelecionados(String idRegistro){
        String METHOD_NAME = 'getUsuariosSelecionados';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - idRegistro: '+ idRegistro);

        return
            [SELECT Id
                  , Direcionamento_OS__c
                  , Name
                  , Usuario__c
                  , Usuario__r.Name
            FROM Atendente_Direcionamento_OS__c
            WHERE Direcionamento_OS__c =: idRegistro];
    } // Fim método getUsuariosSelecionados
}