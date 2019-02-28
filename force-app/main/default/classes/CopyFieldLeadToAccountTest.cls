/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 *
 * [STI 85892] - Novos campos objeto LEADs e CONTA.
 * @author Bruno B. Affonso <bruno.bonfim@sascar.com.br>
 * @sinze 20/08/2015
 */
@isTest
private class CopyFieldLeadToAccountTest{

    static testMethod void copyFieldLeadToAccount(){
        test.startTest();
        
        //Criando e inserindo o Lead
        Lead lead = new Lead();
        lead.FirstName = 'Nome';
        lead.LastName = 'Sobrenome';
        lead.Status = 'Em aberto';      
        lead.Company = 'Teste Ltda';
        lead.Possui_Escolta_Armada__c = 'SIM';
        lead.Qual_empresa_esta_agregando__c = 'MICROSOFT';
        lead.agregado__c = 'SIM';
        lead.Qual_empresa_esta_agregando__c = 'ABC SA';
        lead.Nome_gestor_responsavel__c = 'GESTOR';
        lead.Telefone_gestor_responsavel__c = '5894-2312';
        
        lead.CNPJ__c = '36.966.964/0001-36';
                
        insert lead;
        
        System.debug('Lead criado e inserido.');
        
        //Criando e inserindo a Conta
        Account accnt = new Account();
        accnt.Name = 'Nome da Conta Ltda';
        accnt.Type = 'Novo cliente';
        //accnt.CNPJ__c = '25.844.767/0001-28';
        //accnt.Executivo_de_vendas_new__c = 'Administrador';
        accnt.Phone = '4132996159';
        accnt.AccountSource = 'Facebook';
        accnt.Regional__c = 'SUL';
        accnt.Possui_Escolta_Armada__c = 'NÃO';
        accnt.Qual_empresa_esta_agregando__c = 'ORACLE';
        accnt.agregado__c = 'NÃO';
        
        insert accnt;
        
        System.debug('Conta criada e inserida.');
        
        //Convertendo o Lead e vinculando a conta criada
        Database.LeadConvert leadConvert = new database.LeadConvert();
        leadConvert.setLeadId(lead.Id);
        leadConvert.setAccountId(accnt.Id);
        
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted = true LIMIT 1];
        leadConvert.setConvertedStatus(convertStatus.MasterLabel);
        
        //Convertendo o Lead
        Database.LeadConvertResult leadConvertResult = Database.convertLead(leadConvert);
        
        //Verificando se converteu com sucesso.
        System.assert(leadConvertResult.isSuccess());       
        
        //Lead está convertido? Copiar dados do lead e atualizar na Conta
        Lead leadConverted = [SELECT l.Id, l.isConverted, l.ConvertedAccountId, l.Possui_Escolta_Armada__c, l.agregado__c, l.Qual_empresa_esta_agregando__c
                                    FROM Lead l
                                        WHERE l.Id = :leadConvertResult.getLeadID()];
        
        //Verifica se o Lead está convertido
        if(leadConverted.isConverted){
            //Se possui uma Conta
            if(leadConverted.ConvertedAccountId != null){
                //Recupera os dados da conta
                Account account = [SELECT a.Possui_Escolta_Armada__c, a.agregado__c, a.Qual_empresa_esta_agregando__c
                                        FROM Account a
                                            WHERE a.Id = :leadConvertResult.getAccountId()];
                                            
                //Atualizando os campos da Conta com os dados do Lead
                account.Possui_Escolta_Armada__c = leadConverted.Possui_Escolta_Armada__c;
                account.agregado__c = leadConverted.agregado__c;    
                account.Qual_empresa_esta_agregando__c = leadConverted.Qual_empresa_esta_agregando__c;  
                
                update account;         
            }
        }
        
        test.stopTest();
    }
}