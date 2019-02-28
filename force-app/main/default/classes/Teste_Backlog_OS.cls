/*
    Classe de teste: Teste_Backlog_OS
    Descrição: Classe de Teste para cobertura de:
        Backlog_OS

    Modificado por: Diego Araújo
    Modificado em: 01/06/2018
    Coverage: 71%
*/
@isTest
public class Teste_Backlog_OS {

    @testSetup
    private static void setDataMass(){
        Profile profTest = [Select Id from Profile where Name='Atendimento'][0];

        User uTest = new User(
            FirstName = 'Teste Nome 1',
            LastName = 'Teste Sobrenome 1',            
            Email = 'teste_user_direcionamento@sascar.com.br',
            Username = 'teste_user_direcionamento@sascar.com.br.devprod',
            Alias = 'tnome01',
            CommunityNickname ='tnome01',
            EmailEncodingKey='UTF-8', 
            LanguageLocaleKey='pt_BR',
            LocaleSidKey='pt_BR', 
            ProfileId = profTest.Id,
            TimeZoneSidKey='America/Sao_Paulo',
            IdUsuarioPreCadastro__c = 9998,
            IsActive = true
        );   
        insert uTest;

        Direcionamento_os__c dirOsTest1 = new Direcionamento_os__c(
            Name = 'Teste Direcionamento OS 1', 
            Aging_inicial__c = 12,
            Aging_final__c = 14,
            Numero_OS__c = '01062018',
            Cliente__c = 'Teste Cliente OS 01',
            Classe__c = 'SASCARGA',
            Cliente_KA__c = 'Sim',
            Item__c = 'Equipamento',
            Motivo__c = 'Teste Motivo 01',
            Motivo_noshow__c = 'FALTA_EQUIPAMENTO',
            OS_sem_servico__c = true,
            Quantidade_OS__c = 2,
            OS_sem_direcionamento__c = true,
            OS_com_agendamento__c = true,
            OS_sem_agendamento_aging_85_dias__c = true,
            Agendamento_proximo_contato__c = Date.valueOf(System.today()+7),
            Data_agendamento_inicial__c = Date.valueOf(System.today()),
            Data_agendamento_final__c = Date.valueOf(System.today()+3),
            OS_sem_agendamento__c = true,
            OS_sem_acao__c = true,
            Status_OS__c = 'Teste Status OS 01',
            Tipo_contrato__c = 'Teste Tipo Contrato 01',
            Tipo_OS__c = 'Teste Tipo OS 01',
            Ultima_acao_OS__c = 'Autorizado Instalação',
            Contato_fora_faixa__c = true
        );
        insert dirOsTest1;

        Id rtConta = Schema.SobjectType.Account.getRecordTypeInfosByName().get('CORP').getRecordTypeId();
        Account contaTest1 = new Account(
            Name = 'Teste Cliente 01',
            RecordTypeId = rtConta
        );
        insert contaTest1;

        Contact contatoTest1 = new Contact(
            FirstName = 'Teste Nome Contato 1',
            LastName = 'Teste SobreNome Contato 1',
            Email = 'teste_contato_direcionamento@sascar.com.br',
            AccountId = contaTest1.Id
        );
        insert contatoTest1;

        Status_OS__c statusOsTest1 = new Status_OS__c(
            Codigo_Externo__c = '999998',
            Ativo__c = true,
            Pais_Referencia__c = 'BRA'
        );
        insert statusOsTest1;

        WorkOrder osTest1 = new WorkOrder(
            AccountId = contaTest1.Id,
            ContactId = contatoTest1.Id,
            Codigo_Externo__c = 999998, 
            Cliente__c = 'Cliente Final Teste 01', 
            Status_OS__c = statusOsTest1.Id          
        );
        insert osTest1;

        Item_ordem_servico__c osItem1Test = new Item_ordem_servico__c(
            Ordem_servico__c = osTest1.Id
        );
        insert osItem1Test;
    }

    static testmethod void teste_Backlog_OS() {

        Profile profTest2 = [Select Id from Profile where Name='Atendimento'][0];

        User uTest2 = new User(
            FirstName = 'Teste Nome 2',
            LastName = 'Teste Sobrenome 2',            
            Email = 'teste_user_direcionamento2@sascar.com.br',
            Username = 'teste_user_direcionamento2@sascar.com.br.devprod',
            Alias = 'tnome02',
            CommunityNickname ='tnome02',
            EmailEncodingKey='UTF-8', 
            LanguageLocaleKey='pt_BR',
            LocaleSidKey='pt_BR', 
            ProfileId = profTest2.Id,
            TimeZoneSidKey='America/Sao_Paulo',
            IdUsuarioPreCadastro__c = 9997,
            IsActive = true
        );   
        insert uTest2;

        Direcionamento_os__c dirOsTest2 = new Direcionamento_os__c(
            Name = 'Teste Direcionamento OS 2', 
            Aging_inicial__c = 12,
            Aging_final__c = 14,
            Numero_OS__c = '01062018.2',
            Cliente__c = 'Teste Cliente OS 02',
            Classe__c = 'SASCARGA',
            Cliente_KA__c = 'Sim',
            Item__c = 'Equipamento',
            Motivo__c = 'Teste Motivo 02',
            Motivo_noshow__c = 'FALTA_EQUIPAMENTO',
            OS_sem_servico__c = true,
            Quantidade_OS__c = 2,
            OS_sem_direcionamento__c = true,
            OS_com_agendamento__c = true,
            OS_sem_agendamento_aging_85_dias__c = true,
            Agendamento_proximo_contato__c = Date.valueOf(System.today()+7),
            Data_agendamento_inicial__c = Date.valueOf(System.today()),
            Data_agendamento_final__c = Date.valueOf(System.today()+3),
            OS_sem_agendamento__c = true,
            OS_sem_acao__c = true,
            Status_OS__c = 'Teste Status OS 02',
            Tipo_contrato__c = 'Teste Tipo Contrato 02',
            Tipo_OS__c = 'Teste Tipo OS 02',
            Ultima_acao_OS__c = 'Autorizado Instalação',
            Contato_fora_faixa__c = true
        );
        insert dirOsTest2;
                        
        Backlog_OS.pesquisarOS(JSON.serialize(dirOsTest2));
        Backlog_OS.getListaOS(dirOsTest2);
    }
}