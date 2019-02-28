/*
	Criado por: Mario Reis
	Data de criação: 05/12/2017
	Descrição: Classe com métodos para criar registros relacionados ao Contato
					para apoio as classes de teste
*/
@isTest
public class Teste_Util_Contato {

    // Método para retornar o Contato
    public static Contact criaContato(String idConta, String cep, 
                                      String rua, String estado, 
                                      String cidade, String pais){

        Contact contato = new Contact();
		contato.AccountId = idConta;

		contato.LastName = 'Contato';
		contato.MailingPostalCode = cep;
		contato.MailingStreet = rua;
		contato.MailingState = estado;
		contato.MailingCity = cidade;
		contato.MailingCountry = pais;

        insert contato;
        return contato;

    } // Fim criaContato

}