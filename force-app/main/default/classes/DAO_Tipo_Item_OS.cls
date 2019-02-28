/*
	@testClass Teste_DAO_Tipo_Item_OS
	
	@description Classe para o Objeto: Tipo_item_os__c
	
	@author Renan Rocha
	@date 07/01/2019
	@JIRA KCA-59
*/

public class DAO_Tipo_Item_OS{
	private static String CLASS_NAME = 'DAO_Tipo_Item_OS';
	
    // Método que retorna todos os motivos conforme tipo e item
    public static List<Tipo_item_OS__c> getListaTipoItemOS(String tipo, String item){
        String METHOD_NAME = 'getListaTipoItemOS';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - tipo: '+ tipo);
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - item: '+ item);

        String[] arrTipo = tipo.split(',');
        String[] arrItem = item.split(',');

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - arrTipo: '+ arrTipo);
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - arrItem: '+ arrItem);

        return
            [SELECT Id
                  , Ativo__c
                  , Item__c
                  , Name
                  , Tipo_OS__c
            FROM Tipo_item_OS__c 
            WHERE Ativo__c = true 
            AND Tipo_OS__c IN: arrTipo 
            AND Item__c IN: arrItem
            ORDER BY Name];
    } // Fim método getListaTipoItemOS
}