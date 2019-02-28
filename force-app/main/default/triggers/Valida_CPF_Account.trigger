trigger Valida_CPF_Account on Account (before insert, before update) {

        System.debug(LoggingLevel.ERROR, '__ [trg Valida_CPF_Account] - Inicio... ');
    
        if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)){
        String debug = 'Valida_CPF_Contato : ';
        
        System.debug(LoggingLevel.ERROR, '__ [trg Valida_CPF_Account] - ' + debug);
        
        for(Account conta : trigger.new){
            if(conta.CPF__c == null) continue;            
    
            String CPF_resultado = conta.CPF__c;
            CPF_resultado = CPF_resultado.replace('.', '');
            CPF_resultado = CPF_resultado.replace('-', '');
            //Recuperando o Record type name do objeto Oportunidade
            String recordTypeName = Account.SObjectType.getDescribe().getRecordTypeInfosById().get(Trigger.new[0].RecordTypeId).getName();
            recordTypeName = recordTypeName.touppercase();

            System.debug(LoggingLevel.ERROR, '__ [trg Valida_CPF_Account] - ' + debug);
            System.debug(LoggingLevel.ERROR, '__ [trg Valida_CPF_Account] - recordTypeName: ' + recordTypeName);
                
            if(recordTypeName != 'CORP'){
                //valida a quantidade de caracteres
                if(CPF_resultado.length() == 11){

                    System.debug(LoggingLevel.ERROR, '__ [trg Valida_CPF_Account] - conta.CPF__c: ' + conta.CPF__c);

                    CPF_resultado = CPF_resultado.substring(0, 9);
                    String validacao = '98765432';
                    Integer digitoVerificador = 0;
                    Integer resultado = 0;
        
                    //primeiro digito verificador
                    resultado += Integer.valueOf(String.valueOf(conta.CPF__c.substring(0, 1))) * 10;
        
                    for(Integer a = 1; a < CPF_resultado.length(); a ++){
                        String num1 = String.valueOf(CPF_resultado.substring(a, a + 1));
                        String num2 = String.valueOf(validacao.substring(a - 1, a));
                        resultado += Integer.valueOf(num1) * Integer.valueOf(num2);
                    }
        
                    digitoVerificador = (Math.mod(resultado, 11) < 2 ? 0 : 11 - (Math.mod(resultado, 11)));
        
                    CPF_resultado += digitoVerificador;
                    resultado = 0;
        
                    //segundo digito verificador
                    resultado += Integer.valueOf(String.valueOf(CPF_resultado.substring(0, 1))) * 11;
                    resultado += Integer.valueOf(String.valueOf(CPF_resultado.substring(1, 2))) * 10;
        
                    for(Integer a = 2; a < CPF_resultado.length(); a ++){
                        String num1 = String.valueOf(CPF_resultado.substring(a, a + 1));
                        String num2 = String.valueOf(validacao.substring(a - 2, a - 1));
                        resultado += Integer.valueOf(num1) * Integer.valueOf(num2);
                    }
        
                    digitoVerificador = (Math.mod(resultado, 11) < 2 ? 0 : 11 - (Math.mod(resultado, 11)));
        
                    CPF_resultado += digitoVerificador;
        
                    //formata o CPF
                    CPF_resultado = CPF_resultado.substring(0, 3) +
                                    + '.' +
                                    CPF_resultado.substring(3, 6) + 
                                    + '.' +
                                    CPF_resultado.substring(6, 9) + 
                                    + '-' + 
                                    CPF_resultado.substring(9, 11);
        
                    //verificar se o CPF está batendo com o digitado
                    //se estiver correto, adiciona ao objeto o CPF já formatado
                    if(CPF_resultado.substring(CPF_resultado.length() - 2, CPF_resultado.length())
                       .equals(conta.CPF__c.substring(conta.CPF__c.length() - 2, conta.CPF__c.length()))){
                        conta.CPF__c = CPF_resultado;
                    } else {conta.addError('Favor de verificar o CPF é inválido na Conta');}
                }
            }
        }
    }

}