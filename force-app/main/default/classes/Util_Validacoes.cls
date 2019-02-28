/*
	Classe de teste: Teste_Util_Validacoes
	Criado por: Mario Reis
	Data de criação: 02/10/2017
	Descrição: Classe com métodos uteis de validação
*/
public class Util_Validacoes {

    // Método para validar o CUIT da Argentina
    public static Boolean validarCUIT (String cuit) {

        System.debug(LoggingLevel.ERROR, '__ [cls Util_Validacoes - validarCUIT()] - Start...');
        System.debug(LoggingLevel.ERROR, '__ [cls Util_Validacoes - validarCUIT()] - cuit: '+cuit);

        try {

			// Remova todos os caracteres não-numéricos
    		cuit = cuit.replaceAll ('-', '');

            System.debug(LoggingLevel.ERROR, '__ [cls Util_Validacoes - validarCUIT()] - cuit sem caracteres: '+cuit);

            // Controlamos se 11 números são deixados, se não for o caso, e retorna falso
            if (cuit.length() != 11) {
                return false;
            }

            if (cuit == '00000000000') {
                return false;
            }

            // Nós convertemos a string que foi deixada em uma série de caracteres
            String[] cuitArray = cuit.split('');

            // Inicialize uma matriz pela qual cada dígito será multiplicado
            Integer[] series = new Integer[]{5,4,3,2,7,6,5,4,3,2};

            // Criamos uma variável auxiliar onde salvaremos os resultados do cálculo do número do validador
            Integer aux = 0;

            // Percorremos as matrizes simultaneamente, adicionando os produtos da série pelo número na mesma posição
            for (Integer i = 0; i < 10; i ++) {
                aux += Integer.valueOf(cuitArray[i]) * series[i];
            }

            System.debug(LoggingLevel.ERROR, '__ [cls Util_Validacoes - validarCUIT()] - aux: '+aux);

            // Fazemos como especificado: 11 menos o restante da divisão da soma anterior de produtos em 11
            aux = 11 - (Math.mod(aux,11));

            // Se o resultado anterior for 11, o código é 0
            if(aux == 11) {
                aux = 0;
            }

            // Se o resultado anterior for 10, o código não precisa ser validado, o que, em qualquer caso, acontece
            // na comparação a seguir.
            // Retorna verdadeiro se eles são o mesmo, falso se não estiverem

            System.debug(LoggingLevel.ERROR, '__ [cls Util_Validacoes - validarCUIT()] - System.equals(Integer.valueOf(cuitArray[10]), aux): '+System.equals(Integer.valueOf(cuitArray[10]), aux));
            return System.equals(Integer.valueOf(cuitArray[10]), aux);
            
        } catch(Exception e){

        	System.debug(LoggingLevel.ERROR, '__ [cls Util_Validacoes - validarCUIT()] - ERRO: '+e.getMessage());
            return false;
        } // Fim try/catch

	} // Fim validarCUIT


    // Método para validar o CPF
    public static String validarCPF (String CPFParametro) {

        System.debug(LoggingLevel.ERROR, '__ [cls Util_Validacoes - validarCPF()] - Start...');
        System.debug(LoggingLevel.ERROR, '__ [cls Util_Validacoes - validarCPF()] - CPFParametro: '+CPFParametro);

        try {

            String CPF_resultado = CPFParametro;
            CPF_resultado = CPF_resultado.replace('.', '');
	        CPF_resultado = CPF_resultado.replace('-', '');

            //valida a quantidade de caracteres
            if(CPF_resultado.length() == 11){

                if(CPF_resultado == '00000000000' ||
                   CPF_resultado == '11111111111' ||
                   CPF_resultado == '22222222222' ||
                   CPF_resultado == '33333333333' ||
                   CPF_resultado == '44444444444' ||
                   CPF_resultado == '55555555555' ||
                   CPF_resultado == '66666666666' ||
                   CPF_resultado == '77777777777' ||
                   CPF_resultado == '88888888888' ||
                   CPF_resultado == '99999999999'){

					return null;
                }

                CPF_resultado = CPF_resultado.substring(0, 9);
                String validacao = '98765432';
                Integer digitoVerificador = 0;
                Integer resultado = 0;

                //primeiro digito verificador
                resultado += Integer.valueOf(String.valueOf(CPFParametro.substring(0, 1))) * 10;

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

                if(CPF_resultado.substring(CPF_resultado.length() - 2, CPF_resultado.length())
                   .equals(CPFParametro.substring(CPFParametro.length() - 2, CPFParametro.length()))){

                    return CPF_resultado;
				} else {

					return null;
				} // Fim if(CPF_resultado.substrin

            } else {

				return null;
            } // Fim if(CPF_resultado.length() == 11)

        } catch(Exception e){

        	System.debug(LoggingLevel.ERROR, '__ [cls Util_Validacoes - validarCUIT()] - ERRO: '+e.getMessage());
            return null;
        } // Fim try/catch

    } // Fim validarCPF


    // Método para validar o CNPJ
    public static String validarCNPJ(String CNPJParametro) {

        System.debug(LoggingLevel.ERROR, '__ [cls Util_Validacoes - validarCNPJ()] - Start...');
        System.debug(LoggingLevel.ERROR, '__ [cls Util_Validacoes - validarCNPJ()] - CNPJParametro: '+CNPJParametro);

        try {

            String CNPJ_resultado = CNPJParametro;
            CNPJ_resultado = CNPJ_resultado.replace('.', '');
	        CNPJ_resultado = CNPJ_resultado.replace('/', '');
            CNPJ_resultado = CNPJ_resultado.replace('-', '');

            //valida a quantidade de caracteres
            if(CNPJ_resultado.length() == 14){

                if(CNPJ_resultado == '00000000000000' ||
                   CNPJ_resultado == '11111111111111' ||
                   CNPJ_resultado == '22222222222222' ||
                   CNPJ_resultado == '33333333333333' ||
                   CNPJ_resultado == '44444444444444' ||
                   CNPJ_resultado == '55555555555555' ||
                   CNPJ_resultado == '66666666666666' ||
                   CNPJ_resultado == '77777777777777' ||
                   CNPJ_resultado == '88888888888888' ||
                   CNPJ_resultado == '99999999999999'){

                    return null;
                }

                String calculoVerificador1 = '543298765432';
                String calculoVerificador2 = '6543298765432';
                Integer digitoVerificador = 0;
                Integer resultado = 0;
                
				CNPJ_resultado = CNPJ_resultado.substring(0, 12);

                //primeiro digito verificador
                for(Integer a = 0; a < CNPJ_resultado.length(); a ++){
                    String num1 = String.valueOf(CNPJ_resultado.substring(a, a + 1));
                    String num2 = String.valueOf(calculoVerificador1.substring(a, a + 1));
                    Integer num3 = Integer.valueOf(num1) * Integer.valueOf(num2);
                    resultado += num3;
                }

                if(Math.mod(resultado, 11) < 2){

                    digitoVerificador = 0;
                } else {

                    digitoVerificador = 11 - (Math.mod(resultado, 11));
                }
                
                CNPJ_resultado += digitoVerificador;        
                resultado = 0;

                //segundo digito verificador
                for(Integer a = 0; a < CNPJ_resultado.length(); a ++){

                    String num1 = String.valueOf(CNPJ_resultado.substring(a, a + 1));
                    String num2 = String.valueOf(calculoVerificador2.substring(a, a + 1));
                    Integer num3 = Integer.valueOf(num1) * Integer.valueOf(num2);
                    resultado += num3;
                }

                if(Math.mod(resultado, 11) < 2){

                    digitoVerificador = 0;
                } else {

                    digitoVerificador = 11 - (Math.mod(resultado, 11));
                }

                CNPJ_resultado += digitoVerificador;

                //formata o CNPJ
                CNPJ_resultado = CNPJ_resultado.substring(0, 2) + '.' + CNPJ_resultado.substring(2, 5) + '.' + 
                                     CNPJ_resultado.substring(5, 8) + '/' + CNPJ_resultado.substring(8, 12) + '-' + 
                                     CNPJ_resultado.substring(12, 14);

                System.debug(LoggingLevel.ERROR, '__ [cls Util_Validacoes - validarCNPJ()] - CNPJ_resultado.substring(CNPJ_resultado.length() - 2, CNPJ_resultado.length()): ' + CNPJ_resultado.substring(CNPJ_resultado.length() - 2, CNPJ_resultado.length()));
				System.debug(LoggingLevel.ERROR, '__ [cls Util_Validacoes - validarCNPJ()] - CNPJParametro.substring(CNPJParametro.length() - 2, CNPJParametro.length()): ' + CNPJParametro.substring(CNPJParametro.length() - 2, CNPJParametro.length()));

                System.debug(LoggingLevel.ERROR, '__ [cls Util_Validacoes - validarCNPJ()] - CNPJParametro: '+CNPJParametro);
                System.debug(LoggingLevel.ERROR, '__ [cls Util_Validacoes - validarCNPJ()] - CNPJ_resultado: '+CNPJ_resultado);

                if(CNPJ_resultado.substring(CNPJ_resultado.length() - 2, 
                   CNPJ_resultado.length()).equals(CNPJParametro.substring(CNPJParametro.length() - 2, CNPJParametro.length()))){

                    return CNPJ_resultado;
				} else {
				
                     //throw new customException(Label.MSG_ERRO_0013); // deverão ser comentadas os lançamentos de exceção quando for rodar a trigger em todos os registros.
                    
					return null;
				} // Fim if(CNPJ_resultado.substrin

            } else {
                
                //throw new customException(Label.MSG_ERRO_0013); // deverão ser comentadas os lançamentos de exceção quando for rodar a trigger em todos os registros.
                
				return null;
            } // Fim if(CPF_resultado.length() == 14)

        } catch(Exception e){

        	System.debug(LoggingLevel.ERROR, '__ [cls Util_Validacoes - validarCUIT()] - ERRO: '+e.getMessage());
             //throw new customException(Label.MSG_ERRO_0013); // deverão ser comentadas os lançamentos de exceção quando for rodar a trigger em todos os registros.
            return null;
        } // Fim try/catch

    } // Fim validarCNPJ


}