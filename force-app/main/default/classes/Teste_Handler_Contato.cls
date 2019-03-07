/*
    Classe de testes para a Classe "Handler_Contato"

    Criado por: Mario Reis
    Data: 07/12/2017

*/
@isTest
public class Teste_Handler_Contato {

    /*
        @author Renan Rocha
        @date 28/01/2019
    */
    static testMethod void buscaCEP(){
        Map<String, sObject> mapBase = Teste_Util.createMapBase();
        Contact contato = (Contact) mapBase.get('Contact');
        contato.MailingPostalCode = '83045-000';
        update contato;

        Account conta = (Account) mapBase.get('Account');

        Contact contatoOld = Teste_Util.newContact(conta.Id);
        contatoOld.MailingPostalCode = '83045-100';
        update contatoOld;

        Handler_Contato.buscaCEP(new List<Contact>{contato}, null, true);
        Handler_Contato.buscaCEP(new List<Contact>{contato}, new Map<Id, Contact>{contato.Id => contatoOld}, false);
    }
}