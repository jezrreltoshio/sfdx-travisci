/*
    Classe de testes para a Classe "DAO_Contato"

    Criado por: Mario Reis
    Data: 06/12/2017

*/
@isTest
public class Teste_DAO_Contato {

    /*
        @author Renan Rocha
        @date 28/01/2019
    */
    static testMethod void getContatoPorId(){
        Map<String, sObject> mapBase = Teste_Util.createMapBase();
        Contact contato = (Contact) mapBase.get('Contact');

        System.assertEquals(contato.Id, DAO_Contato.getContatoPorId(contato.Id).Id);
    }

    /*
        @author Renan Rocha
        @date 28/01/2019
    */
    static testMethod void getContatoByListId(){
        Map<String, sObject> mapBase = Teste_Util.createMapBase();
        Contact contato = (Contact) mapBase.get('Contact');

        System.assertEquals(1, DAO_Contato.getContatoByListId(new List<Id>{contato.Id}).size());
    }
}