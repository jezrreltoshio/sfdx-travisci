/*
    Classe de testes para a Classe "Handler_Contato"

    Criado por: Mario Reis
    Data: 07/12/2017

*/
@isTest
public class Teste_Handler_Contato {

    // Método para testar o a verificação
    static testmethod void testeVerificacao() {

        Test.startTest();

        Util_Conta.carregarTipoRegistro();
       
        Account conta = Teste_Util_Conta.criaContaCORP(Util_Conta.CORP, '13.469.768/0001-50');
        Contact contato = Teste_Util_Contato.criaContato(conta.Id, '83045200', 'rua', 'estado', 'cidade', 'Brasil');

        List<Contact> oldList = new List<Contact>();
        Map<Id, Contact> oldMap = new Map<Id, Contact>();
        List<Contact> newList = new List<Contact>();
        Map<Id, Contact> newMap = new Map<Id, Contact>();

        oldList.add(contato);
        newList.add(contato);
        oldMap.put(contato.Id, contato);
        newMap.put(contato.Id, contato);

        // Teste inserindo corretamente
        Boolean retorno = Handler_Contato.verificacao(true, true, true, true, true, true, 
                                  					oldList, oldMap, newList, newMap);
        System.assert(retorno == true);

        oldList.add(null);
        newList.add(null);
        oldMap.put(null, null);
        newMap.put(null, null);

        // Teste erro insert
        try {

			Handler_Contato.verificacao(true, true, true, true, true, true, 
                                  	oldList, oldMap, newList, newMap);            
        } catch(Exception e){
			System.debug(e.getMessage());
            System.assert(e.getMessage().contains('Attempt to de-reference a null object'));
		}

        // Teste erro update
        try {

			Handler_Contato.verificacao(true, true, false, true, true, true, 
                                  	oldList, oldMap, newList, newMap);            
        } catch(Exception e){
			System.debug(e.getMessage());
            System.assert(e.getMessage().contains('Attempt to de-reference a null object'));
		}

        Test.stopTest();

    } // Fim testeVerificacao

}