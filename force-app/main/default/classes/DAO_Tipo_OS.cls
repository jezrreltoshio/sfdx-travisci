/*
	@testClass Teste_DAO_Tipo_OS
	
	@description Classe para o Objeto: Tipo_OS__c
	
	@author Renan Rocha
	@date 07/01/2019
	@JIRA KCA-59
*/

public class DAO_Tipo_OS{
	private static String CLASS_NAME = 'DAO_Tipo_OS';
	
	// Método que retorna todos os Tipos de OS Ativos
    public static List<Tipo_OS__c> getListaTipoOS(){
        String METHOD_NAME = 'getListaTipoOS';

        return
            [SELECT Id
                  , Ativo__c
                  , Name
            FROM Tipo_OS__c 
            WHERE Ativo__c = true 
            AND Pais_referencia__c = 'BRA'
            AND Codigo_externo__c <> '3'
            ORDER BY Name];
    } // Fim método getListaTipoOS
}