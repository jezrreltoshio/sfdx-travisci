/**
 * [STI 85949] - [PRJ - SALESFORCE] - VALIDAR CPF/CNPJ OBJETO CONTA E OPORTUNIDADE
 * @author Bruno B. Affonso <bruno.bonfim@sascar.com.br>
 * @sinze 03/09/2015
 */
public class OpportunityCheckCpfCnpjIsNotEmpty{
	
	/**
	 * Verifica se o CPF/CNPJ vinculado a Oportunidade não está em branco.
	 * @author Bruno B. Affonso <bruno.bonfim@sascar.com.br>
	 */
	public static void opportunityCheckCpfCnpjIsNotEmpty(Opportunity oppty, String recordTypeName){
		//Fase
		String fase = oppty.StageName.touppercase();
		
		//Verifica se a Fase foi alterado pra Fechado
		if(fase == 'FECHADO' || fase == 'VENDA FECHADA'){
			//Verificando se existe uma conta vinculada na Oportunidade
			if(oppty.AccountId != null){				
				if(recordTypeName != 'SIGGO' && recordTypeName != 'MICHELIN' 
				&& recordTypeName != 'MEXICO' && recordTypeName != 'MERCOSUL'
				&& recordTypeName != 'ARGENTINA - DEMONSTRAÇÃO'
				&& recordTypeName != 'ARGENTINA'){ //rbsilva 19-06-2018: Essa alteração é necessária por que estão exigindo CPF/CNPJ de quem não tem, as triggers de oportunidades precisam ser revistas. Essa alteração foi feita direto em QA, por que esse tipo de registro (MEXICO) não existe em DEVPROD.
					//Variaveis
					String msg, valor;
					Account accnt = [SELECT CNPJ_CPF__c, CNPJ__c FROM Account WHERE Id =:oppty.AccountId];
				
					if(recordTypeName == 'FRETEIRO'){
						msg = 'Por favor, preencha o CPF na CONTA.';
						valor = accnt.CNPJ_CPF__c;
					} else{
						msg = 'Por favor, preencha o CNPJ na CONTA.';
						valor = accnt.CNPJ__c;
					}
									
					//Verificando se o campo CPF/CNPJ está vazio
					if(valor == null){
						oppty.AccountId.addError(msg);
					}
				}			
			}
		}
	}
}