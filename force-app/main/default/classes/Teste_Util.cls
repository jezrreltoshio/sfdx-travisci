/*
  @description Teste_Util geral
  
  @author Renan Rocha
  @date 05/12/2018
  @JIRA KCA-86
*/

@isTest
public class Teste_Util{

    public static Lead newLead(){
        Lead lead = new Lead();
        lead.LastName = 'Lead Teste';
        lead.Company = 'Empresa Teste';
        
        insert lead;
        
        return
            [SELECT Id
                  , Company
                  , LastName
                  , Name
            FROM Lead
            WHERE Id =: lead.Id];
    }

    public static Account newAccount(){
        Account acc = new Account();
        acc.Name = 'Conta Teste';
        acc.TelefoneCelular__c = '1198765432';
        acc.Phone = '1198765432';
        acc.Circuito__c = '1';
        acc.Cadencia__c = '2';
        
        insert acc;
        
        return
            [SELECT Id
                  , Cadencia__c
                  , Circuito__c
                  , Cobranca_Cartao_Numero_Cript__c
                  , Name
                  , Phone
                  , TelefoneCelular__c
            FROM Account
            WHERE Id =: acc.Id];
    }

    public static Contact newContact(String accountId){
        Contact con = new Contact();
        con.LastName = 'Contato Teste';
        con.AccountId = accountId;
        
        insert con;
        
        return
            [SELECT Id
                  , Account.Name
                  , AccountId
                  , CPF__c
                  , Email
                  , FirstName
                  , LastName
                  , Name
            FROM Contact
            WHERE Id =: con.Id];
    }

    public static Opportunity newOpportunity(String AccountId){
        Opportunity opp = new Opportunity();
        opp.Name = 'Oportunidade Teste';
        opp.AccountId = AccountId;
        opp.CloseDate = System.today();
        opp.StageName = 'Abordagem inicial';
        opp.CartaoCredito_Numero_Cript__c = '1111444477778884';
        opp.CartaoCredito_CodigoSeguranca_Cript__c = '123';
        opp.CartaoCredito_Vencimento__c = '1012';
        opp.Description = 'Teste';
        
        insert opp;
        
        return
            [SELECT Id
                  , Account.Cobranca_Cartao_Numero_Cript__c
                  , Account.Name
                  , AccountId
                  , CartaoCredito_CodigoSeguranca_Cript__c
                  , CartaoCredito_Numero_Cript__c
                  , CartaoCredito_Vencimento__c
                  , CloseDate
                  , Description
                  , Executivo_de_vendas_new__c
                  , IdLeadForOpp__c
                  , N_mero_do_C_de_Cr_dito_do_Monitoramento__c
                  , Name
                  , OwnerId
                  , Pricebook2Id
                  , Produtos__c
                  , RecordTypeId
                  , Siggo_AnalCred_ResultadoAnalise__c
                  , StageName
                  , Status_aprova_o_manual__c
                  , Total_Produtos_com_Seguro__c
            FROM Opportunity
            WHERE Id =: opp.Id];
    }

    public static Product2 newProduct2(){
        Product2 prod = new Product2();
        prod.Name = 'Produto Teste';
        prod.isActive = true;
        
        insert prod;
        
        return
            [SELECT Id
                  , IsActive
                  , Name
            FROM Product2
            WHERE Id =: prod.Id];
    }

    public static PricebookEntry newPricebookEntry(String product2Id){
        PricebookEntry pbe = new PricebookEntry();
        pbe.Pricebook2Id = Test.getStandardPriceBookId();
        pbe.Product2Id = product2Id;
        pbe.UseStandardPrice = false;
        pbe.IsActive = true;
        pbe.UnitPrice = 10;
        
        insert pbe;
        
        return
            [SELECT Id
                  , IsActive
                  , PriceBook2Id
                  , Product2Id
                  , UnitPrice
            FROM PriceBookEntry
            WHERE Id =: pbe.Id];
    }

    public static OpportunityLineItem newOpportunityLineItem(String opportunityId, String pricebookEntryId){
        OpportunityLineItem oppli = new OpportunityLineItem();
        oppli.OpportunityId = opportunityId;
        oppli.PricebookEntryId = pricebookEntryId;
        oppli.Prazo_do_contrato2__c = 18;
        oppli.Quantity = 10;
        oppli.UnitPrice = 10;
        
        insert oppli;
        
        return
            [SELECT Id
          , Prazo_do_contrato2__c
                  , Opportunity.Name
                  , OpportunityId
                  , PriceBookEntryId
                  , Quantity
                  , UnitPrice
            FROM OpportunityLineItem
            WHERE Id =: oppli.Id];
    }

    public static User newUser(){
        User u = new User();
        u.Email = 'usuarioteste@usuarioteste.com';
        u.UserName = u.Email;
        u.FirstName = 'Usuario';
        u.LastName = 'Teste';
        u.Alias = 'uTeste';
        u.EmailEncodingKey = 'UTF-8';
        u.LanguageLocaleKey = 'pt_BR';
        u.ProfileId = [SELECT Id FROM Profile LIMIT 1].Id;
        u.LocaleSidKey = 'pt_BR';
        u.TimeZoneSidKey = 'America/Sao_Paulo';
        u.IdUsuarioPreCadastro__c = 56454654;
                    
        insert u;
        
        return
            [SELECT Id
                  , Alias
                  , Email
                  , FirstName
                  , LastName
                  , Name
                  , UserName
            FROM User
            WHERE Id =: u.Id];
    }

    public static UserRole newPapelUsuario(){
        UserRole papel = new UserRole();
        papel.Name = 'Teste';
        papel.OpportunityAccessForAccountOwner = 'Read';

        insert papel;

        return
            [SELECT Id
            FROM UserRole
            WHERE Id =: papel.Id];
    }

    public static String getFaseGanha(){
        return 
            [SELECT ApiName
            FROM OpportunityStage
            WHERE IsClosed = true
      AND IsWon = true
            LIMIT 1].ApiName;
    }

    public static Parametrizacao_faixa_aging__c newParametrizacaoAging(){
        Parametrizacao_faixa_aging__c paramAg = new Parametrizacao_faixa_aging__c();
        paramAg.Nome_faixa__c = 'Param Teste';
        paramAg.Aging_de__c = 4;
        paramAg.Tipo_Macro_OS__c = 'Assistência';
        paramAg.Quantidade_contatos__c = 2;
        insert paramAg;

        return
        [SELECT Id
            , Aging_de__c
            , Nome_faixa__c
            , Quantidade_contatos__c
            , Tipo_Macro_OS__c
        FROM Parametrizacao_faixa_aging__c
        WHERE Id =: paramAg.Id];
    }

    public static Tipo_OS__c newTipoOS(){
        Tipo_OS__c tipoOS = new Tipo_OS__c();
        tipoOS.Codigo_Externo__c = '564654654';
        tipoOS.Pais_Referencia__c = 'BRA';
        
        insert tipoOS;

        return
        [SELECT Id
            , Codigo_Externo__c
            , Pais_Referencia__c
        FROM Tipo_OS__c
        WHERE Id =: tipoOS.Id];
    }

    public static Tipo_item_OS__c newTipoItemOS(String pIdTipoOS){
        Tipo_item_OS__c tipoItemOS = new Tipo_item_OS__c();
        tipoItemOS.Name = 'AGUARDANDO DEFINIÇÃO';
        tipoItemOS.Nome__c = 'AGUARDANDO DEFINIÇÃO';
        tipoItemOS.Codigo_Externo__c = '10';
        tipoItemOS.Pais_Referencia__c = 'BRA';
        tipoItemOS.Item__c = 'A';
        tipoItemOS.Ativo__c = true;
        tipoItemOS.Tipo_OS__c = pIdTipoOS;

        insert tipoItemOS;

        return
            [SELECT Id
                  , Name
                  , Nome__c
                  , Codigo_Externo__c
                  , Pais_Referencia__c
                  , Item__c
                  , Ativo__c
                  , Tipo_OS__c
            FROM Tipo_item_OS__c
            WHERE Id =: tipoItemOS.Id];
    }

    public static Status_OS__c newStatusOS(){
        Status_OS__c statusOS = new Status_OS__c();
        statusOS.Name = 'Status da OS Teste';
        statusOS.Codigo_Externo__c = '65456465';
        statusOS.Pais_Referencia__c = 'BRL';
        
        insert statusOS;

        return
            [SELECT Id
                , Codigo_Externo__c
                , Pais_Referencia__c
            FROM Status_OS__c
            WHERE Id =: statusOS.Id];
    }
      
    public static WorkOrder newOrdemServico(String pTipoOsId, String pStatusOSId){
        WorkOrder OS = new WorkOrder();
        OS.Codigo_Externo__c = 46549798;
        OS.Tipo_OS__c = pTipoOsId;
        OS.Status_OS__c = pStatusOSId;
        OS.Cliente__c = 'Cliente teste';
        os.StartDate = System.today();
        
        insert OS;

        return
        [SELECT Id
            , Cliente__c
            , StartDate
            , Status_OS__c
            , Tipo_OS__c
        FROM WorkOrder
        WHERE Id =: OS.Id];
    }

    public static Historico_Lead__c newHistoricoLead(String pLeadId){
        Historico_Lead__c histLead = new Historico_Lead__c();
        histLead.Name = 'Histórico teste';
        histLead.Lead__c = pLeadId;

        insert histLead;

        return
            [SELECT Id
            FROM Historico_Lead__c
            WHERE Id =: histLead.Id];
    }

    public static Quote newCotacao(String pOppId, String pCatId){
        Quote cotacao = new Quote();
        cotacao.Name = 'Cotação teste';
        cotacao.OpportunityId = pOppId;

        if(pCatId == null) cotacao.Pricebook2Id = Test.getStandardPriceBookId();
        else cotacao.Pricebook2Id = pCatId;

        insert cotacao;

        return
            [SELECT Id
                  , Name
                  , OpportunityId
                  , PriceBook2Id
            FROM Quote
            WHERE Id =: cotacao.Id];
    }

    public static QuoteLineItem newQli(String pCotacaoId, String pPBEId){
        QuoteLineItem qli = new QuoteLineItem();
        qli.QuoteId = pCotacaoId;
        qli.PricebookEntryId = pPBEId;
        qli.Quantity = 10;
        qli.UnitPrice = 10;
        
        insert qli;

        return
            [SELECT Id
                  , QuoteId
                  , PricebookEntryId
                  , Quantity
                  , UnitPrice
            FROM QuoteLineItem
            WHERE Id =: qli.Id];
    }

    public static Resumo_analise_manual_oportunidade__c newResumoAnaliseManualOpp(String pOppId){
        Resumo_analise_manual_oportunidade__c resumoAMOpp = new Resumo_analise_manual_oportunidade__c();
        resumoAMOpp.Oportunidade__c = pOppId;
        resumoAMOpp.Resultado_analise_automatica__c = 1;
        resumoAMOpp.T_rmino_do_processo_em__c = System.now();

        insert resumoAMOpp;

        return
            [SELECT Id
                  , Oportunidade__c
                  , Resultado_analise_automatica__c
                  , T_rmino_do_processo_em__c
            FROM Resumo_analise_manual_oportunidade__c
            WHERE Id =: resumoAMOpp.Id];
    }

    public static Historico_OS__c newHistoricoOS(String pOSId, String pStatusId){
        Historico_OS__c histOS = new Historico_OS__c();
        histOS.Codigo_externo__c = '1';
        histOS.Data_agenda__c = System.now();
        histOS.Data__c = System.now();
        histOS.Observacao__c = 'Observação';
        histOS.Ordem_servico__c = pOSId;
        histOS.Status__c = pStatusId;
        
        insert histOS;
        
        return
            [SELECT Id
                  , Codigo_externo__c
                  , Data_agenda__c
                  , Data__c
                  , Observacao__c
                  , Ordem_servico__c
                  , Status__c
            FROM Historico_OS__c
            WHERE Id =: histOS.Id];
    }

    public static Acao_historico_OS__c newAcaoHistoricoOS(){
        Acao_historico_OS__c acaoHistOS = new Acao_historico_OS__c();
        acaoHistOS.Name = 'Teste classe';
        acaoHistOS.Pais_referencia__c = 'BRA';
        acaoHistOS.Codigo_externo__c = '4489156';

        insert acaoHistOS;

        return
            [SELECT Id
                  , Codigo_externo__c
                  , Name
                  , Pais_referencia__c
            FROM Acao_historico_OS__c
            WHERE Id =: acaoHistOS.Id];
    }

    public static Item_ordem_servico__c newItemOS(String pOSId){
        Item_ordem_servico__c itemOS = new Item_ordem_servico__c();
        itemOS.Ordem_servico__c = pOSId;

        insert itemOS;

        return
            [SELECT Id
                  , Ordem_servico__c
            FROM Item_ordem_servico__c
            WHERE Id =: itemOS.Id];
    }

    public static Historico_Oportunidade__c newHistoricoOportunidade(String pOppId){
        Historico_Oportunidade__c histOpp = new Historico_Oportunidade__c();
        histOpp.Name = 'Teste hist';
        histOpp.Oportunidade__c = pOppId;

        insert histOpp;

        return
        [SELECT Id
        FROM Historico_Oportunidade__c
        WHERE Id =: histOpp.Id];
    }

    public static ItemPropostaSiggo__c newItemPropostaSiggo(String pOppId){
        ItemPropostaSiggo__c item = new ItemPropostaSiggo__c();
        item.Oportunidade__c = pOppId;

        insert item;

        return
        [SELECT Id
            , Oportunidade__c
        FROM ItemPropostaSiggo__c
        WHERE Id =: item.Id];
    }

    public static Group newGroup(){
        Group grupo = new Group();
        grupo.Name = 'Grupo teste';

        insert grupo;

        return
            [SELECT Id
                  , Name
            FROM Group
            WHERE Id =: grupo.Id];
    }

    public static GroupMember newGroupMember(String pGrupoId, String pUserId){
        GroupMember membroGrupo = new GroupMember();
        membroGrupo.GroupId = pGrupoId;
        membroGrupo.UserOrGroupId = pUserId;

        insert membroGrupo;

        return
            [SELECT Id
                  , GroupId
                  , UserOrGroupId
            FROM GroupMember
            WHERE Id =: membroGrupo.Id];
    }

    public static Parametros_ORG__c newConfigParamORG(String pGrupoId){
        Parametros_ORG__c param = new Parametros_ORG__c();
        param.Id_grupo_origem_lead_canal_exclusivo__c = pGrupoId;
        
        insert param;

        return
            [SELECT Id
                  , Id_grupo_origem_lead_canal_exclusivo__c
            FROM Parametros_ORG__c
            WHERE Id =: param.Id];
    }

    public static Direcionamento_os__c newDirecionamentoOS(){
        Direcionamento_os__c dirOS = new Direcionamento_os__c();
        
        dirOS.OS_sem_servico__c = false;
        dirOS.Name = 'Tratativa Frotas';
        dirOS.OS_sem_agendamento_aging_85_dias__c = false;
        dirOS.OS_sem_agendamento__c = false;
        dirOS.OS_com_agendamento__c = false;
        dirOS.Status_OS__c = 'Teste Status';
        dirOS.OS_sem_direcionamento__c = false;
        dirOS.Contato_fora_faixa__c = false;
        dirOS.Tipo_OS_Macro__c = 'Instalação';
        dirOS.OS_sem_acao__c = false;
        dirOS.Tipo_OS_Micro__c = 'Instalação de Equipamento';
        dirOS.Cliente_KA__c = 'Não';
        dirOS.Quantidade_OS__c = 10;
        dirOS.Regiao_comercial__c = 'ASSOCIAÇÃO; CANAL SEGURADORAS; CANAL TELEVENDAS;';
        
        insert dirOS;

        return
            [SELECT Id
                  , Cliente_KA__c
                  , Contato_fora_faixa__c
                  , Name
                  , OS_com_agendamento__c
                  , OS_sem_acao__c
                  , OS_sem_agendamento__c
                  , OS_sem_agendamento_aging_85_dias__c
                  , OS_sem_direcionamento__c
                  , Quantidade_OS__c
                  , Regiao_comercial__c
                  , Status_OS__c
                  , Tipo_OS_Macro__c
                  , Tipo_OS_Micro__c
            FROM Direcionamento_os__c
            WHERE Id =: dirOS.Id];
    }

    public static Atendente_Direcionamento_OS__c newAtendenteDirOS(String pDirOSId, String pUserId){
        Atendente_Direcionamento_OS__c atendDirOS = new Atendente_Direcionamento_OS__c();
        atendDirOS.Direcionamento_OS__c = pDirOSId;
        atendDirOS.Usuario__c = pUserId;

        insert atendDirOS;

        return
            [SELECT Id
                  , Direcionamento_OS__c
                  , Usuario__c
            FROM Atendente_Direcionamento_OS__c
            WHERE Id =: atendDirOS.Id];
    }

    public static User newUserAtendimento(){
        User u = new User();
        u.Email = 'usuarioteste@usuarioteste.com.atendimento';
        u.UserName = u.Email;
        u.FirstName = 'Usuario';
        u.LastName = 'Teste';
        u.Alias = 'uTeste';
        u.EmailEncodingKey = 'UTF-8';
        u.LanguageLocaleKey = 'pt_BR';
        u.ProfileId = [SELECT Id FROM Profile WHERE Name = 'Atendimento' LIMIT 1].Id;
        u.LocaleSidKey = 'pt_BR';
        u.TimeZoneSidKey = 'America/Sao_Paulo';
        u.IdUsuarioPreCadastro__c = 879814;
        u.isActive = true;
                    
        insert u;
        
        return
            [SELECT Id
                  , Alias
                  , Email
                  , EmailEncodingKey
                  , FirstName
                  , IdUsuarioPreCadastro__c
                  , LanguageLocaleKey
                  , LastName
                  , LocaleSidKey
                  , Name
                  , ProfileId
                  , TimeZoneSidKey
                  , UserName
                  , isActive
            FROM User
            WHERE Id =: u.Id];
    }

    public static User newUserConfig(){
        User u = new User();
        u.Email = 'usuarioteste@usuarioteste.com.config';
        u.UserName = u.Email;
        u.FirstName = 'Usuario';
        u.LastName = 'Teste';
        u.Alias = 'uConf';
        u.EmailEncodingKey = 'UTF-8';
        u.LanguageLocaleKey = 'pt_BR';
        u.ProfileId = [SELECT Id FROM Profile LIMIT 1].Id;
        u.LocaleSidKey = 'pt_BR';
        u.TimeZoneSidKey = 'America/Sao_Paulo';
        u.IdUsuarioPreCadastro__c = 45787988;
                    
        insert u;
        
        return
            [SELECT Id
                  , Alias
                  , Email
                  , FirstName
                  , LastName
                  , Name
                  , UserName
            FROM User
            WHERE Id =: u.Id];
    }

    public static TipoContrato__c newTipoContrato(){
        TipoContrato__c tipoContrato = new TipoContrato__c();
        tipoContrato.Codigo_Externo__c = '999';
        tipoContrato.Name = 'Teste';
        tipoContrato.Ativo__c = true;
        tipoContrato.Pais_Referencia__c = 'BRA';

        insert tipoContrato;

        return
            [SELECT Id
                  , Ativo__c
                  , Codigo_Externo__c
                  , Name
                  , Pais_Referencia__c
            FROM TipoContrato__c
            WHERE Id =: tipoContrato.Id];
    }
    
    public static Map<String, sObject> createMapBase(){
    
        Map<String, sObject> mapBase = new Map<String, sObject>();
        
        //Criação dos objetos
        Lead lead = newLead();
        Account conta = newAccount();
        Contact contato = newContact(conta.Id);
        Opportunity oportunidade = newOpportunity(conta.Id);
        Product2 produto = newProduct2();
        PricebookEntry pbe = newPricebookEntry(produto.Id);
        User usuario = newUser();
        Tipo_OS__c tipoOS = newTipoOS();
        OpportunityLineItem oppLi = newOpportunityLineItem(oportunidade.Id, pbe.Id);
        Quote cotacao = newCotacao(oportunidade.Id, null);
        QuoteLineItem qli = newQli(cotacao.Id, pbe.Id);
        
        Status_OS__c statusOS = newStatusOS();
        statusOS.Codigo_Externo__c = '49871932';
        update statusOS;
        
        WorkOrder OS = newOrdemServico(tipoOS.Id, statusOS.Id);
        Parametrizacao_faixa_aging__c paramAging = newParametrizacaoAging();
        Historico_Lead__c histLead = newHistoricoLead(lead.Id);
        Resumo_analise_manual_oportunidade__c resumoAMOpp = newResumoAnaliseManualOpp(oportunidade.Id);
        Acao_historico_OS__c acaoHistOS = newAcaoHistoricoOS();
        Historico_OS__c histOS = newHistoricoOS(OS.Id, acaoHistOS.Id);
        Item_ordem_servico__c itemOS = newItemOS(OS.Id);
        Historico_Oportunidade__c histOpp = newHistoricoOportunidade(oportunidade.Id);
        ItemPropostaSiggo__c itemPropostaSiggo = newItemPropostaSiggo(oportunidade.Id);
        Group grupo = newGroup();
        Parametros_ORG__c param = newConfigParamORG(grupo.Id);
        Direcionamento_os__c dirOS = newDirecionamentoOS();
        Atendente_Direcionamento_OS__c atendDirOS = newAtendenteDirOS(dirOS.Id, newUserAtendimento().Id);
        Tipo_item_OS__c tipoItemOS = newTipoItemOS(tipoOS.Id);
        TipoContrato__c tipoContrato = newTipoContrato();

        //Inserção no map
        mapBase.put('Lead', lead);
        mapBase.put('Account', conta);
        mapBase.put('Contact', contato);
        mapBase.put('Opportunity', oportunidade);
        mapBase.put('Product2', produto);
        mapBase.put('PricebookEntry', pbe);
        mapBase.put('User', usuario);
        mapBase.put('Tipo_OS__c', tipoOS);
        mapBase.put('OpportunityLineItem', oppLi);
        mapBase.put('Quote', cotacao);
        mapBase.put('QuoteLineItem', qli);
        mapBase.put('Status_OS__c', statusOS);
        mapBase.put('WorkOrder', OS);
        mapBase.put('Parametrizacao_faixa_aging__c', paramAging);
        mapBase.put('Historico_Lead__c', histLead);
        mapBase.put('Resumo_analise_manual_oportunidade__c', resumoAMOpp);
        mapBase.put('Acao_historico_OS__c', acaoHistOS);
        mapBase.put('Historico_OS__c', histOS);
        mapBase.put('Item_ordem_servico__c', itemOS);
        mapBase.put('Historico_Oportunidade__c', histOpp);
        mapBase.put('ItemPropostaSiggo__c', itemPropostaSiggo);
        mapBase.put('Group', grupo);
        mapBase.put('Parametros_ORG__c', param);
        mapBase.put('Direcionamento_os__c', dirOS);
        mapBase.put('Atendente_Direcionamento_OS__c', atendDirOS);
        mapBase.put('Tipo_item_OS__c', tipoItemOS);
        mapBase.put('TipoContrato__c', tipoContrato);

        return mapBase;
    }
    
    public static Map<String, sObject> createMapBaseConfig(){

        //MapBase para objetos de configuração, para evitar erros de DML
    
        Map<String, sObject> mapBase = new Map<String, sObject>();
        
        //Criação dos objetos
        User usuario = newUserConfig();
        Group grupo = newGroup();
        GroupMember membroGrupo = newGroupMember(grupo.Id, usuario.Id);

        //Inserção no map
        mapBase.put('User', usuario);
        mapBase.put('Group', grupo);
        mapBase.put('GroupMember', membroGrupo);

        return mapBase;
    }
}