/*
  @testClass Teste_DAO_Item_Oportunidade

  @description DAO para o Objeto: OpportunityLineItem

  @author Renan Rocha
  @date 19/11/2018
  @JIRA KCA-9
*/

public class DAO_Item_Oportunidade{

  private static String CLASS_NAME = 'DAO_Item_Oportunidade';
  
   // Método que retorna a lista de Contas para verificação da duplicidade
  public static OpportunityLineItem getItemLinhaPorFamiliaId(String idOportunidade, String familia){
    String METHOD_NAME = 'getItemLinhaPorFamiliaId';

    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - idOportunidade: '+ idOportunidade);
    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - familia: '+ familia);

    try {
      return 
        [SELECT Id
                      , Classe_do_contrato__c
                      , Discount
                      , Fam_lia_de_produtos__c
                      , Id_acessorio__c
                      , Prazo_do_contrato2__c
                      , PriceBookEntry.Product2.Id_acessorio__c
                      , PriceBookEntry.Product2Id
                      , UnitPrice
                      , Valor_mensal__c
                      , Valor_unit_rio_mensal__c
        FROM OpportunityLineItem
              WHERE Fam_lia_de_produtos__c =: familia
                AND OpportunityId =: idOportunidade];
    } catch (Exception e){
      System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());

      throw new customException(Label.MSG_ERRO_0007);
    } // Fim try/catch
  } // Fim método getItemLinhaPorFamiliaId

  /*
	  @description Retorna uma lista de item da oportunidade conforme o Id da oportunidade informado
	  @param String pOppId
	  @return List<OpportunityLineItem>
	  
	  @author Renan Rocha
	  @date 12/12/2018
	  @JIRA KCA-10
  */
  public static List<OpportunityLineItem> getOppQliByOppId(String pOppId){
	  String METHOD_NAME = 'getOppQliByOppId';
	  
	  return
		[SELECT Id
			  , Produto_com_seguro__c
		FROM OpportunityLineItem
		WHERE OpportunityId =: pOppId];  
  }
}