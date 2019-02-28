trigger Valida_CNPJ_Lead on Lead (before insert, before update) {   
    /*
        Trigger que faz a validação do CNPJ na Conta
    */
    for(Lead conta : trigger.new){
    	if(conta.RecordTypeId != null){
    		//String recordTypeName = Schema.getGlobalDescribe().get('Lead').getDescribe().getRecordTypeInfosById().get(conta.RecordTypeId).getName();
    		
    		//if(recordTypeName != 'Cargo Tracck'){
		    /* verifica se está nulo, pois não é obrigatório */
		        if(conta.CNPJ__c != null){       
		            String CNPJ = conta.CNPJ__c;
		            String CNPJ_resultado = CNPJ;
		            
		            CNPJ_resultado = CNPJ_resultado.replace('.' , '');
		            CNPJ_resultado = CNPJ_resultado.replace('/', '');
		            CNPJ_resultado = CNPJ_resultado.replace('-', '');
		            
		        /* valida a quantidade de caracteres */
		            if(CNPJ_resultado.length() == 14){
		                String calculoVerificador1 = '543298765432';
		                String calculoVerificador2 = '6543298765432';
		                Integer digitoVerificador = 0;
		                Integer resultado = 0;
		            
		                CNPJ_resultado = CNPJ_resultado.substring(0, 12);
		                
		            /* primeiro digito verificador */
		                for(Integer a = 0; a < CNPJ_resultado.length(); a ++){
		                    String num1 = String.valueOf(CNPJ_resultado.substring(a, a + 1));
		                    String num2 = String.valueOf(calculoVerificador1.substring(a, a + 1));
		                    Integer num3 = Integer.valueOf(num1) * Integer.valueOf(num2);
		                    resultado += num3;
		                }
		              
		                if(Math.mod(resultado, 11) < 2){
		                    digitoVerificador = 0;
		                }else {
		                    digitoVerificador = 11 - (Math.mod(resultado, 11));
		                }
		                
		                CNPJ_resultado += digitoVerificador;        
		                resultado = 0;
		                
		            /* segundo digito verificador */
		                for(Integer a = 0; a < CNPJ_resultado.length(); a ++){
		                    String num1 = String.valueOf(CNPJ_resultado.substring(a, a + 1));
		                    String num2 = String.valueOf(calculoVerificador2.substring(a, a + 1));
		                    Integer num3 = Integer.valueOf(num1) * Integer.valueOf(num2);
		                    resultado += num3;
		                }
		                
		                if(Math.mod(resultado, 11) < 2){
		                    digitoVerificador = 0;
		                }else {
		                    digitoVerificador = 11 - (Math.mod(resultado, 11));
		                }
		                
		                CNPJ_resultado += digitoVerificador;
		                
		            /* formata o CNPJ */
		                CNPJ_resultado = CNPJ_resultado.substring(0, 2) + '.' + CNPJ_resultado.substring(2, 5) + '.' + 
		                                 CNPJ_resultado.substring(5, 8) + '/' + CNPJ_resultado.substring(8, 12) + '-' + 
		                                 CNPJ_resultado.substring(12, 14);
		                                 
		            /* verifica se a conta está batendo com o CNPJ digitado */
		            /* se estiver correto, adiciona ao objeto o CNPJ já formatado */
		                if(!CNPJ_resultado.substring(CNPJ_resultado.length() - 2, 
		                    CNPJ_resultado.length()).equals(CNPJ.substring(CNPJ.length() - 2, CNPJ.length()))){
		                    conta.addError('  CNPJ inválido, favor inserir número de CNPJ válido');
		                }else{
		                    conta.CNPJ__c = CNPJ_resultado;
		                }
		            }else{
		                conta.addError('  CNPJ inválido, favor inserir número de CNPJ válido');
		            }
		        }
    		//}
	    }
	}
}