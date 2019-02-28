trigger Valida_CNPJ_Account on Account (before insert, before update) {
	
	//Trigger que faz a validação do CNPJ na Conta      
    for(Account conta : trigger.new){
    	if(conta.RecordTypeId != null){
	    	String recordTypeName = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosById().get(conta.RecordTypeId).getName();
	    	
	    	//Foi aplicado esse IF por causa do projeto CRM com integração via Pentaho
	    	//if(recordTypeName != 'CORP'){
		        if(conta.CNPJ__c != null){
		            String CNPJ = conta.CNPJ__c;
		            String CNPJ_resultado = CNPJ;
		            
		            CNPJ_resultado = CNPJ_resultado.replace('.' , '');
		            CNPJ_resultado = CNPJ_resultado.replace('/', '');
		            CNPJ_resultado = CNPJ_resultado.replace('-', '');
		            	            
					// Valida tamanho
					if (CNPJ_resultado.length() == 14){
						Integer i = 0;
						Integer j = 5;
						Long soma = 0;
						Long resto = 0;
						
						// Valida primeiro dígito verificador				
						for (i = 0; i < 12; i++){
							soma = soma + Long.valueOf(CNPJ_resultado.substring(i, (i+1))) * j;
							
							if(j == 2){
								j = 9;
							} else{
								j = j - 1;
							}
						}
						
						resto = Math.mod(soma, 11);
						
						if(resto < 2){
							resto = 0;
						} else{
							resto = 11 - resto;
						}
		
						if(Long.valueOf(CNPJ_resultado.substring(12, 13)) != resto){
							conta.addError(' CNPJ inválido, por favor inserir um número de CNPJ válido. #1');
						} else{
							// Valida segundo dígito verificador
							j = 6;
							soma = 0;
							
							for (i = 0; i < 13; i++){
								soma = soma + Long.valueOf(CNPJ_resultado.substring(i, (i+1))) * j;
														
								if(j == 2){
									j = 9;
								} else{
									j = j - 1;
								}
							}
							
							resto = Math.mod(soma, 11);
							
							if(resto < 2){
								resto = 0;
							} else{
								resto = 11 - resto;
							}
							
							if(Long.valueOf(CNPJ_resultado.substring(13, 14)) != resto){
								conta.addError(' CNPJ inválido, por favor inserir um número de CNPJ válido. #2');
							} else{
								CNPJ_resultado = CNPJ_resultado.substring(0, 2) + '.' + CNPJ_resultado.substring(2, 5) + '.' + 
									CNPJ_resultado.substring(5, 8) + '/' + CNPJ_resultado.substring(8, 12) + '-' + 
										CNPJ_resultado.substring(12, 14);
								
								conta.CNPJ__c = CNPJ_resultado;
							}
						}
					} else{
						conta.addError(' O CNPJ não possui a quantidade correta de dígitos.');
					}       
		        }
    		//}
    	}
    }
}