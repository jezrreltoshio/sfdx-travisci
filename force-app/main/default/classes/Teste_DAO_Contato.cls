/*
    Classe de testes para a Classe "DAO_Contato"

    Criado por: Mario Reis
    Data: 06/12/2017

*/
@isTest
public class Teste_DAO_Contato {

    // Verifica o método que retorna o contato pelo Id
    static testmethod void testeGetContatoPorId() {

		Test.startTest();

        Util_Conta.carregarTipoRegistro();

        Account conta = Teste_Util_Conta.criaContaCORP(Util_Conta.CORP, '88.480.580/0001-02');
		Contact contato = Teste_Util_Contato.criaContato(conta.Id, '83045200', 'rua', 'estado', 'cidade', 'Brasil');

        DAO_Contato.getContatoPorId(contato.Id);

        try {
			DAO_Contato.getContatoPorId(null);
        } catch (Exception e){
			System.Assert(e.getMessage().contains(Label.MSG_ERRO_0025));
        }

        Test.stopTest();

    } // Fim testeGetContatoPorId

}