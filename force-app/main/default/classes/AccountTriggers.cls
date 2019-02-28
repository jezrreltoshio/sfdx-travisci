public class AccountTriggers{
    
    //Method creates record Operacao__c automatically after creating Cargotracck Account
//    public static void createStandardOperation(List<Account> lstAcc, Set<Id> accIds){
//        Map<Id, Operacao__c> mapOperacao = new Map<Id, Operacao__c>();
//        for(Operacao__c o :[SELECT Id, ContaPai__c, Conta_Entrega__c FROM Operacao__c WHERE ContaPai__c IN :accIds]){
//          if(o.ContaPai__c == o.Conta_Entrega__c) mapOperacao.put(o.ContaPai__c,o);
//        }
//        for(Account acc :lstAcc){
//            if(!mapOperacao.containsKey(acc.Id)){
//                Operacao__c o = new Operacao__c();
//                o.ContaPai__c = acc.Id;
//                o.Conta_Entrega__c = acc.Id;
//                o.Name = 'Operação Padrão';
//                
//                //Fields to be defined
//                //o.Contato_Cobranca__c = '';
//                //o.Contato_Venda__c = '';
//                
//                //Fields filled in integrating 
//                /*o.Id_ct_da_Operacao__c = '';
//                o.ID_da_Operacao__c = ''; */
//                
//                //o.Modo_Preenchimento_Endereco__c = 'com o endereço principal';
//                //Campos abaixo serão preenchidos por trigger Operacao_updateShippingAddress
//                /*o.Endereco_Bairro__c = '';
//                o.Endereco_CEP__c = 0;
//                o.Endereco_Cidade__c = '';
//                o.Endereco_Complemento__c = '';
//                o.Endereco_Logradouro__c = '';
//                o.Endereco_Numero__c = 0;
//                o.Endereco_UF__c = ''; */
//                
//                insert o;
//            }
//        }
//    
//    }
   
    public static void markLeadOrigin(List<Account> accountList) {
        Map<Id,Id> mapLead = new Map<Id,Id>();
        Set<Id> accIds = new Set<Id>();
        for(Account acc :accountList){
            accIds.add(acc.Id);
        }
        for (Lead l : [SELECT Id, ConvertedAccountId FROM Lead WHERE ConvertedAccountId IN :accIds LIMIT 99999]){
            if(l.ConvertedAccountId != null){
                mapLead.put(l.ConvertedAccountId, l.Id);
            }
        }
        for (Account acc: accountList) {
            if (mapLead.containsKey(acc.Id)) {
                acc.Criado_via_lead__c = true;
            }else{
                acc.Criado_via_Lead__c = false;
            }
        }
    }
    
    public static void updateTelefoneCelular(List<Account> accountList) {
        for (Account acc: accountList) {
            if (String.isBlank(acc.TelefoneCelular__c)) {
                acc.TelefoneCelular__c = acc.Phone;
            }
        }
    }
    
/*
    public static void formatCEP(List<Account> accList) {
        BCL_HLP_String HLP_String = new BCL_HLP_String();
        
        if (accList != null) {
            if (accList.size() > 0) {   
        
                for(Account ac :accList){
                    if (!String.isEmpty(ac.Enderecos_Cobranca_CEP__c)){
                        String str = BCL_HLP_String.getNumberFromFormatedString(ac.Enderecos_Cobranca_CEP__c);
                        System.debug('Enderecos_Cobranca_CEP__c: '+str);
                        if(str.length() < 7 || str.length() > 8){
                            ac.Enderecos_Cobranca_CEP__c.addError('CEP Inválido! Insira um valor válido.');
                        }else{
                            ac.Enderecos_Cobranca_CEP__c = BCL_HLP_String.formatCEP(ac.Enderecos_Cobranca_CEP__c);
                        }
                    }
                    if (!String.isEmpty(ac.Enderecos_Entrega_CEP__c)){
                        String str = BCL_HLP_String.getNumberFromFormatedString(ac.Enderecos_Entrega_CEP__c);
                        System.debug('Enderecos_Entrega_CEP__c: '+str);
                        if(str.length() < 7 || str.length() > 8){
                            ac.Enderecos_Entrega_CEP__c.addError('CEP Inválido! Insira um valor válido.');
                        }else{
                            ac.Enderecos_Entrega_CEP__c = BCL_HLP_String.formatCEP(ac.Enderecos_Entrega_CEP__c);
                        }
                    }
                    if (!String.isEmpty(ac.Enderecos_Principal_CEP__c)){
                        String str = BCL_HLP_String.getNumberFromFormatedString(ac.Enderecos_Principal_CEP__c);
                        System.debug('Enderecos_Principal_CEP__c: '+str);
                        if(str.length() < 7 || str.length() > 8){
                            ac.Enderecos_Principal_CEP__c.addError('CEP Inválido! Insira um valor válido.');
                        }else{
                            ac.Enderecos_Principal_CEP__c = BCL_HLP_String.formatCEP(ac.Enderecos_Principal_CEP__c);
                        }
                    }
                }
            }
        }
    }
*/
    
    public static void updateRelatedContacts(List<Account> accList) {
        Map<Id,Account> mapAcc = new Map<Id,Account>();
        for(Account acc :accList){
            if(acc.DadosPF_RG__c != null && acc.DadosPF_RG__c != '' && acc.CPF__c != null && acc.CPF__c != ''){
                mapAcc.put(acc.Id,acc);
            }
        }
        if(mapAcc.size() > 0){ 
            List<Contact> lstContact = [SELECT Id, RG__c, CPF__c, AccountId FROM Contact WHERE AccountId IN :mapAcc.keySet()];
            if(lstContact.size() > 0){
                for(Contact c :lstContact){
                    if(c.RG__c == null || c.RG__c == ''){
                        c.RG__c = mapAcc.get(c.AccountId).DadosPF_RG__c;
                    }
                    if(c.CPF__c == null || c.CPF__c == ''){
                        c.CPF__c = mapAcc.get(c.AccountId).CPF__c;
                    }
                }
                update lstContact;
            }
        }
    }
    
    public static void formatCNPJ(List<Account> accList) {
        for(Account a :accList){
          if(a.CNPJ__c != null && a.CNPJ__c != '') {
           String str = BCL_HLP_String.getNumberFromFormatedString(a.CNPJ__c);
           
           if(str.length() < 14 || str.length() > 14) a.CNPJ__c.addError('Insira um CNPJ válido');
          
           if(str.length() == 14){
            a.CNPJ__c = BCL_HLP_String.formatCNPJ(str);
           }
          }
        }
    }
    
    public static void formatCPF(List<Account> accList) {
        for(Account a :accList){
          if(a.CPF__c != null && a.CPF__c != '') {
           String str = BCL_HLP_String.getNumberFromFormatedString(a.CPF__c);
           
           if(str.length() < 11 || str.length() > 11) a.CPF__c.addError('Insira um CPF válido');
          
           if(str.length() == 11){
            if(str == '00000000000' || str == '11111111111' || str == '22222222222' || str == '33333333333' || str == '44444444444' || str == '55555555555' || str == '66666666666' || str == '77777777777' || str == '88888888888' || str == '99999999999') {
             a.CPF__c.addError('Insira um CPF válido');
            }
            a.CPF__c = BCL_HLP_String.formatCPF(str);
           }
          }
        }
    }
    
    public static void validarNomePortador(Account acc, List<Account> oldAcc, Boolean isInsert, Boolean isUpdate, String recordTypeName){
		if(recordTypeName.toUpperCase() == 'SIGGO'){
			if(isInsert){
				if(acc.FormaCobranca__c != null){
					if(acc.FormaCobranca__c == '24-Cartão Visa' || acc.FormaCobranca__c == '25-Cartão Mastercard' || acc.FormaCobranca__c == '82-Cartão Hipercard'){
						if(acc.Nome_do_portador__c == null || acc.Nome_do_portador__c == ''){
							acc.Nome_do_portador__c.addError('Informe o nome do portador conforme impresso no cartão.');
						}
					}
				}
			} else if(isUpdate){
				if(acc.FormaCobranca__c != null){
					system.debug('FormaCobranca__c: '+acc.FormaCobranca__c);
					if(acc.FormaCobranca__c == '24-Cartão Visa' || acc.FormaCobranca__c == '25-Cartão Mastercard' || acc.FormaCobranca__c == '82-Cartão Hipercard'){
						//Tratando valores vazio, o sistema sempre verifica o OLD como null
						if(acc.Cobranca_Cartao_Numero_Cript__c == ''){
							acc.Cobranca_Cartao_Numero_Cript__c = null;
						}
						
						if(acc.FormaCobranca__c != oldAcc[0].FormaCobranca__c){
							if(acc.Nome_do_portador__c == null || acc.Nome_do_portador__c == ''){
								acc.Nome_do_portador__c.addError('Informe o nome do portador conforme impresso no cartão.');
							}
						} else if(acc.Cobranca_Cartao_Numero_Cript__c != oldAcc[0].Cobranca_Cartao_Numero_Cript__c){
							system.debug('Cobranca_Cartao_Numero_Cript__c acc: '+acc.Cobranca_Cartao_Numero_Cript__c);
							system.debug('Cobranca_Cartao_Numero_Cript__c oldAcc: '+oldAcc[0].Cobranca_Cartao_Numero_Cript__c);
							if(acc.Nome_do_portador__c == null || acc.Nome_do_portador__c == ''){
								acc.Nome_do_portador__c.addError('Informe o nome do portador conforme impresso no cartão.');
							}
						} else if(acc.Nome_do_portador__c != oldAcc[0].Nome_do_portador__c){
							if(acc.Nome_do_portador__c == null || acc.Nome_do_portador__c == ''){
								acc.Nome_do_portador__c.addError('Informe o nome do portador conforme impresso no cartão.');
							}
						}
					}
				}
			}
		}
    }
    
    /**
     * before insert, before update
     */
    public static void validarCircuitoCadencia(List<Account> listAcc, String userRoleId){
    	if(userRoleId != null){
			UserRole userRole = [SELECT Name FROM UserRole WHERE Id =:userRoleId];
			system.debug('UserRole: '+userRole);
			
			if(userRole.Name.contains('Executivo')){
				for(Account acc : listAcc){
					if(acc.RecordTypeId != null){
						//Recuperando o record type name do objeto Conta
						String recordTypeName = Account.SObjectType.getDescribe().getRecordTypeInfosById().get(acc.RecordTypeId).getName();
						system.debug('recordTypeName: '+recordTypeName);
						
						if(recordTypeName == 'CORP'){
							system.debug('Circuito__c: '+acc.Circuito__c);
							system.debug('Cadencia__c: '+acc.Cadencia__c);
							
							if(acc.Circuito__c == null){
								acc.Circuito__c.addError('Informe o Circuito.');
							} else if(acc.Cadencia__c == null){
								acc.Cadencia__c.addError('Informe a Cadência.');
							}
						}
					}
				}
			}
		}
    }
}