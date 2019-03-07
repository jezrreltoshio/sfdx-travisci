/*
    Classe de testes para a classe "Service_Contato"

    Criado por: Mario Reis
    Data: 05/12/2017

*/
@isTest
public class Teste_Service_Contato {

    /*
        @author Renan Rocha
        @date 28/01/2019
    */
    static testMethod void carregarEnderecoConta(){
        Map<String, sObject> mapBase = Teste_Util.createMapBase();
        Contact contato = (Contact) mapBase.get('Contact');
        contato.MailingPostalCode = '83045-000';
        contato.MailingStreet = 'Rua';
        contato.MailingState = 'PR';
        contato.MailingCity = 'Curitiba';
        contato.MailingCountry = 'BRASIL';
        contato.Numero_endereco__c = 18;
        contato.Complemento_endereco__c = 'Casa';
        contato.Bairro_endereco__c = 'Bairro';
        update contato;

        Service_Contato.carregarEnderecoConta(new List<Contact>{contato});   
    }

    /*
        @author Renan Rocha
        @date 28/01/2019
    */
    static testMethod void copiarDadosConta(){
        Map<String, sObject> mapBase = Teste_Util.createMapBase();
        Contact contato = (Contact) mapBase.get('Contact');
        Account conta = (Account) mapBase.get('Account');
        conta.CPF__c = '341.760.355-28';
        conta.DadosPF_RG__c = '58746524';
        conta.EmailNFE__c = 'brunabarbosarocha@einrot.com';
        conta.Phone = '(61) 8854-9664';
        conta.TelefoneCelular__c = '(61) 8854-9664';
        conta.Tipo_de_pessoa__c = 'F-Física';
        update conta;

        Service_Contato.copiarDadosConta(new List<Contact>{contato});
    }

    /*
        @author Renan Rocha
        @date 28/01/2019
    */
    static testMethod void cleanBlankSpaceFields(){
        Map<String, sObject> mapBase = Teste_Util.createMapBase();
        Contact contato = (Contact) mapBase.get('Contact');

        Service_Contato.cleanBlankSpaceFields(new List<Contact>{contato});
    }

    /*
        @author Renan Rocha
        @date 28/01/2019
    */
    static testMethod void formataCPF(){
        Map<String, sObject> mapBase = Teste_Util.createMapBase();
        Contact contato = (Contact) mapBase.get('Contact');
        contato.CPF__c = '25719669795';
        update contato;

        Service_Contato.formataCPF(new List<Contact>{contato});
    }

    /*
        @author Renan Rocha
        @date 28/01/2019
    */
    static testMethod void buscaCEP(){
        Map<String, sObject> mapBase = Teste_Util.createMapBase();
        Contact contato = (Contact) mapBase.get('Contact');
        contato.MailingPostalCode = '83045-270';
        update contato;

        Service_Contato.buscaCEP(new List<Id>{contato.Id});
    }
}