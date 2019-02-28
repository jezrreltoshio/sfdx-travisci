/*
    Classe de testes para a classe "Service_Contato"

    Criado por: Mario Reis
    Data: 05/12/2017

*/
@isTest
public class Teste_Service_Contato {


    // Método para testar o método que passa as informações do Contato para a Conta
    static testmethod void testeCarregarEnderecoConta() {

        Test.startTest();

        Util_Conta.carregarTipoRegistro();

        List<Contact> listaContato = new List<Contact>();

        Account conta = Teste_Util_Conta.criaContaCORP(Util_Conta.CORP, '38.088.177/0001-64');
		Contact contato = Teste_Util_Contato.criaContato(conta.id, '83045200', 'Rua', 'Estado', 'Cidade', 'Brasil');

        listaContato.add(contato);

        Service_Contato.carregarEnderecoConta(listaContato);

        try {
            Service_Contato.carregarEnderecoConta(null);
        } catch (Exception e){
        }

        Test.stopTest();

    } // Fim testeCarregarEnderecoConta

}