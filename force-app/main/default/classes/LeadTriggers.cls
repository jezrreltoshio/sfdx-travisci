/*
  @testClass LeadTriggersTest

  @description 

  @author Admin CRM Sascar
  @date 14/02/2014
  ---------------------------------
  @author Renan Rocha
  @date 19/11/2018
  @description Classe refatorada e novos debugs inseridos
  @JIRA KCA-10
*/
public class LeadTriggers{

  private static String CLASS_NAME = 'LeadTriggers';

  public static void markLeadOrigin(List<Lead> LeadList){
    String METHOD_NAME = 'markLeadOrigin';

    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - LeadList: '+ LeadList);

    Set<Id> accIds = new Set<Id>();
    
    for(Lead l :LeadList){
      if(l.ConvertedAccountId != null) accIds.add(l.ConvertedAccountId);
    }

    List<Account> lstAcc = DAO_Conta.getContasBySetId(accIds);
    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - lstAcc: '+ lstAcc);
    
    if(lstAcc.size() > 0){
      for (Account acc :lstAcc) acc.Criado_via_lead__c = true;
        
      update lstAcc;
    }
  }
    
  public static void formatCNPJ(List<Lead> leadList) {
    String METHOD_NAME = 'formatCNPJ';

    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - leadList: '+ leadList);
		
    for(Lead l :leadList){
			if(l.CNPJ__c != null) {
     		String str = BCL_HLP_String.getNumberFromFormatedString(l.CNPJ__c);
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - str: '+ str);
           
				if(str.length() < 14 || str.length() > 14) l.CNPJ__c.addError('Insira um CNPJ válido');
          
       	if(str.length() == 14) l.CNPJ__c = BCL_HLP_String.formatCNPJ(str);
			}
		}
  }
    
  public static void formatCPF(List<Lead> leadList) {
    String METHOD_NAME = 'formatCPF';

    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - leadList: '+ leadList);
    
    for(Lead l :leadList){
      if(l.CPF__c != null) {
       String str = BCL_HLP_String.getNumberFromFormatedString(l.CPF__c);
       System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - str: '+ str);
       
       if(str.length() < 11 || str.length() > 11) l.CPF__c.addError('Insira um CPF válido');
      
       if(str.length() == 11){
        if(str == '00000000000' 
          || str == '11111111111' 
          || str == '22222222222' 
          || str == '33333333333' 
          || str == '44444444444' 
          || str == '55555555555' 
          || str == '66666666666' 
          || str == '77777777777' 
          || str == '88888888888' 
          || str == '99999999999')
        {
         l.CPF__c.addError('Insira um CPF válido');
        }
        
        l.CPF__c = BCL_HLP_String.formatCPF(str);
       }
      }
    }
  }
    
  public static void AbasteceHistoricoDetalhes(List<Lead> lstLead){
    String METHOD_NAME = 'AbasteceHistoricoDetalhes';

    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - lstLead: '+ lstLead);

    List<Historico_Lead__c> lstHO = new List<Historico_Lead__c>();
      
    for(Lead l :lstLead){
      Historico_Lead__c newHO = new Historico_Lead__c(
        Lead__c = l.Id,
        Data_da_Alteracao__c = datetime.now(),
        Descricao__c = l.Description,
        Usuario__c = UserInfo.getUserId()
      );

      if(l.Description != null){
        if(l.Description.length() < 70) newHO.Name = l.Description;
        else newHO.Name = l.Description.substring(0, 70) + '...';
      }
       
      lstHO.add(newHO);
    }

    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - lstHO: '+ lstHO);
    
    if(lstHO.size() > 0) insert lstHO;
	}
}