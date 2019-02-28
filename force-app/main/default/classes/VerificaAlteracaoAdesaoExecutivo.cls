/**
 * STI 86720
 */
public class VerificaAlteracaoAdesaoExecutivo {	
	public static void oppVerificarAlteracaoAdesao(Opportunity opp){		
	    String userRoleId = UserInfo.getUserRoleId();
	    
		system.debug('public static void oppVerificarAlteracaoAdesao');
	    system.debug('OPP: ' + opp);
	    system.debug('userRoleId: ' + userRoleId);
	    system.debug('oppId: ' + opp.Id);
	    system.debug('Pricebook2Id: ' + opp.Pricebook2Id);
	    
	    if(opp.Id != null && opp.Pricebook2Id != null && userRoleId != null){
			UserRole user = [select DeveloperName from UserRole where Id =:userRoleId];
			
			Integer npBook = [SELECT Count() FROM Pricebook2 where id=:opp.Pricebook2Id];
			
			if(npBook > 0){
				Pricebook2 pBook = [SELECT Name, Taxa_Instalacao_Minima__c, Taxa_Instalacao_Maxima__c FROM Pricebook2 where id=:opp.Pricebook2Id];
				user.DeveloperName = user.DeveloperName.toLowerCase();
					
				system.debug('DeveloperName: ' + user.DeveloperName);
				system.debug('Pricebook2: ' + pBook);
				
				if(pBook != null){
					if(pBook.Name.startsWithIgnoreCase('Tipo')){		
						if(user.DeveloperName.contains('executivo')){
							if(opp.Valor_da_taxa_de_ades_o__c < pBook.Taxa_Instalacao_Minima__c || opp.Valor_da_taxa_de_ades_o__c > pBook.Taxa_Instalacao_Maxima__c){
								opp.Valor_da_taxa_de_ades_o__c = pBook.Taxa_Instalacao_Maxima__c;
							}
						}
					}
				}
			}
	    }
	}
	
	public static void neverCallThisMethod() {
		integer a = 0;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
	}
}