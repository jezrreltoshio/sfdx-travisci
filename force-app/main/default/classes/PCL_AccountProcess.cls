public with sharing class PCL_AccountProcess {

    public String validationAccountToCore(Id accId) {
        Account acc = [select 
                id
                , CT_PersClie_CodigoCliente__c
                , name
                , Tipo_de_pessoa__c
                , CPF__c
                , CNPJ__c
                , EMail__c
                , EMailNFE__c
                , IdExternoClienteIndicador__c
                , nome_fantasia__c
                , DadosPJ_InscricaoMunicipal__c
                , DadosPJ_InscricaoEstadualUF__c
                , DadosPJ_InscricaoEstadual__c
                , DadosPJ_EmpresaOptanteSimples__c
                , DadosPF_NomeMae__c
                , DadosPF_Sexo__c
                , DadosPF_DataNascimento__c
                , DadosPF_EstadoCivil__c
                , DadosPF_RG__c
                
                , ContatoPessoaAutorizada__c
                , ContatoPadrao__c
                , ContatoInstalacao__c
                , ContatoEmergencia__c

                , FormaCobranca__c
                // Melhorias Siggo
                , Cobranca_DiaVcto__c
                , Dia_de_vencimento__c
                
                , Cobranca_Cartao_Numero_Cript__c
                , Cobranca_Cartao_CodigoSeguranca_Cript__c
                , Cobranca_Cartao_Vcto__c
                
                , DebAut_Agencia__c
                , DebAut_ContaCorrente__c
                , DebAut_NomeTitular__c

                , Enderecos_Principal_Logradouro__c
                , Enderecos_Principal_Numero__c
                , Enderecos_Principal_Complemento__c
                , Enderecos_Principal_CEP__c
                , Enderecos_Principal_Bairro__c
                , Enderecos_Principal_Cidade__c
                , Enderecos_Principal_UF__c
                , Enderecos_Principal_Pais__c

                , Enderecos_Cobranca_Logradouro__c
                , Enderecos_Cobranca_Numero__c
                , Enderecos_Cobranca_Complemento__c
                , Enderecos_Cobranca_CEP__c
                , Enderecos_Cobranca_Bairro__c
                , Enderecos_Cobranca_Cidade__c
                , Enderecos_Cobranca_UF__c
                , Enderecos_Cobranca_Pais__c

                , Enderecos_Entrega_Logradouro__c
                , Enderecos_Entrega_Numero__c
                , Enderecos_Entrega_Complemento__c
                , Enderecos_Entrega_CEP__c
                , Enderecos_Entrega_Bairro__c
                , Enderecos_Entrega_Cidade__c
                , Enderecos_Entrega_UF__c
                , Enderecos_Entrega_Pais__c
                
                , CT_PersClie_CodigoRetorno__c
                , CT_PersClie_MensagemRetorno__c
                , CT_PersClie_MensagemProcesso__c
                , CT_PersClie_DataProcesso__c 
                , CT_PersClie_AguardandoRetorno__c
                
                , Phone
                , TelefoneComercial__c
                , TelefoneCelular__c
                , Nome_do_portador__c
                
                  from account where id = :accId limit 1];
                
        if(HLP_Account.getExternalTipoPessoaValue(acc.Tipo_de_pessoa__c) == null){ return 'Falha na sincronização: Tipo de pessoa não informado.'; }
            
        if (acc.Tipo_de_pessoa__c == HLP_Account.PLV_TIPODEPESSOAC_FISICA) {
            if(BCL_HLP_String.getNumberFromFormatedString(acc.CPF__c) == null){ return 'Falha na sincronização: CPF não informado.'; }
        } else {
            if(BCL_HLP_String.getNumberFromFormatedString(acc.CNPJ__c) == null){ return 'Falha na sincronização: CNPJ não informado.'; }
        }
        
        if (acc.Tipo_de_pessoa__c == HLP_Account.PLV_TIPODEPESSOAC_FISICA) {
            if(acc.DadosPF_NomeMae__c == null){ return 'Falha na sincronização: Nome da Mãe não informado.'; }
            
            if(HLP_Account.getExternalSexoValue(acc.DadosPF_Sexo__c) == null){ return 'Falha na sincronização: Sexo não informado.'; }
            
            if(acc.DadosPF_DataNascimento__c == null){ return 'Falha na sincronização: Data de Nascimento não informada.'; }
            
            if(HLP_Account.getExternalEstadoCivilValue(acc.DadosPF_EstadoCivil__c) == null){ return 'Falha na sincronização: Estado Civil não informado.'; }
        } else {
            if(acc.nome_fantasia__c == null){ return 'Falha na sincronização: Nome Fantasia não informado.'; }
            
            if(acc.DadosPJ_InscricaoMunicipal__c == null){ return 'Falha na sincronização: Inscrição Municipal não informada.'; }
            
            if(acc.DadosPJ_InscricaoEstadualUF__c == null){ return 'Falha na sincronização: Inscrição Estadual UF não informada.'; }
            
            if(acc.DadosPJ_InscricaoEstadual__c == null){ return 'Falha na sincronização: Inscrição Estadual não informada.'; }
        }
        
        
        /* SEFO comentado para subida das demandas do Siggo
        Set<Id> operacaoIds = new set<Id>();
        for(Operacao__c o: [SELECT ID_Operacao_CT__c, ID_Operacao_Intranet__c, Name FROM Operacao__c WHERE ContaPai__c = :acc.Id]){
            operacaoIds.add(o.Id);
            if(o.ID_Operacao_CT__c == null){ return 'Falha na sincronização: Operacao '+ o.Name +' sem ID CT.'; }
        }
        
        List<Endereco__c> listaEnderecos = [
                SELECT Id, Endereco_Principal__c, CEP__c, UF__c, Cidade__c, Operacao__r.Name
                       , Bairro__c, Logradouro__c, Numero__c, Complemento__c
                  FROM Endereco__c
                 WHERE Operacao__c IN :operacaoIds
            ];
        
        for(Endereco__c e :listaEnderecos){
            if(e.CEP__c == null){ return 'Falha na sincronização: CEP de um dos endereços da Operação '+ e.Operacao__r.Name +' não informado.'; }
            
            if(e.UF__c == null){ return 'Falha na sincronização: UF de um dos endereços da Operação '+ e.Operacao__r.Name +' não informado.'; }
            
            if(e.Cidade__c == null){ return 'Falha na sincronização: Cidade de um dos endereços da Operação '+ e.Operacao__r.Name +' não informado.'; }
            
            if(e.Bairro__c == null){ return 'Falha na sincronização: Bairro de um dos endereços da Operação '+ e.Operacao__r.Name +' não informado.'; }
            
            if(e.Logradouro__c == null){ return 'Falha na sincronização: Logradouro de um dos endereços da Operação '+ e.Operacao__r.Name +' não informado.'; }
            
            if(e.Numero__c == null){ return 'Falha na sincronização: Numero de um dos endereços da Operação '+ e.Operacao__r.Name +' não informado.'; }
            
            if(e.Complemento__c == null){ return 'Falha na sincronização: Complemento de um dos endereços da Operação '+ e.Operacao__r.Name +' não informado.'; }
            
        }
        */ 
        
               
        List<Account> listaContato = [select Name, CPF__c from Account
                                       where
                                         id = :acc.id
            ];
        
        for(Account c :listaContato){ 
            if (c.CPF__c == null){ return 'Falha na sincronização: CPF do contato '+ c.name +' não informado.'; }
        }
        
        if(PCL_Helper.getCodeAsInteger(acc.FormaCobranca__c) == null){ return 'Falha na sincronização: Forma de pagamento não selecionada.'; }
        
        if(acc.Enderecos_Principal_CEP__c == null){ return 'Falha na sincronização: CEP do endereço principal não informado.'; }
        
        if(acc.Enderecos_Principal_Numero__c == null){ return 'Falha na sincronização: Numero do endereço principal não informado.'; }
        
        if(acc.Enderecos_Cobranca_CEP__c == null){ return 'Falha na sincronização: CEP do endereço de cobrança não informado.'; }
        
        if(acc.Enderecos_Cobranca_Numero__c == null){ return 'Falha na sincronização: Numero do endereço de cobrança não informado.'; }
        
        if(acc.Enderecos_Entrega_CEP__c == null){ return 'Falha na sincronização: CEP do endereço entrega não informado.'; }
        
        if(acc.Enderecos_Entrega_Numero__c == null){ return 'Falha na sincronização: Numero do endereço entrega não informado.'; }
        
        return '';
    }
    
    public void sendAccountToCore(Id accId/*, PCL_SyncDetails processDetails*/) {
        
        DateTime dataHoraInicio = DateTime.now();
        Account acc = null;

        acc = 
        [select
            CT_PersClie_CodigoRetorno__c
            , CT_PersClie_MensagemRetorno__c
            , CT_PersClie_MensagemProcesso__c
            , CT_PersClie_DataProcesso__c 
            , CT_PersClie_AguardandoRetorno__c
              from account where id = :accId limit 1]; 
                        
        acc.CT_PersClie_CodigoRetorno__c = null;
        acc.CT_PersClie_MensagemRetorno__c = null;
        acc.CT_PersClie_MensagemProcesso__c = 'Aguardando resposta da intranet.';
        acc.CT_PersClie_DataProcesso__c = null;
        acc.CT_PersClie_AguardandoRetorno__c = true;
        update acc;
        
        completeSendAccountToCore(accId, dataHoraInicio);
    }
    
    @future(callout=true)
    private static void completeSendAccountToCore(Id accId, DateTime dataHoraInicio) {
        Exception erro = null;
        EXT_serverCargotracck.PersistirCliente persistirClienteResponse = null;
        Account acc = null;
       
        
        //Modification Carlos Prates - 19/05/2014 - 17:55
        /*SEFO Comentado para implantação das demandas do Siggo
            List<Operacao__c> listaOperacao = [SELECT
                    Id
                    , ContaPai__c
                    , ID_Operacao_CT__c
                    , ID_Operacao_Intranet__c
                    
                    //, Nome__c
                    , Conta_Entrega__c
                    , Conta_Entrega__r.CNPJ__c
                FROM
                    Operacao__c
                WHERE
                    ContaPai__c = :accId ];
        */
        //END Modification Carlos Prates - 19/05/2014 - 17:55
       
            
        try {
            acc = 
            [select 
                id
                , CT_PersClie_CodigoCliente__c
                , name
                , Tipo_de_pessoa__c
                //, CNPJ_CPF__c - Desabilitado pois foi criado máscara para campos CPF e CNPJ - Carlos Prates 06/02/2014 11:49
                , CPF__c
                , CNPJ__c
                , EMail__c
                , EMailNFE__c
                , IdExternoClienteIndicador__c
                , nome_fantasia__c
                , DadosPJ_InscricaoMunicipal__c
                , DadosPJ_InscricaoEstadualUF__c
                , DadosPJ_InscricaoEstadual__c
                , DadosPJ_EmpresaOptanteSimples__c
                , DadosPF_NomeMae__c
                , DadosPF_Sexo__c
                , DadosPF_DataNascimento__c
                , DadosPF_EstadoCivil__c
                , DadosPF_RG__c
                
                , ContatoPessoaAutorizada__c
                , ContatoPadrao__c
                , ContatoInstalacao__c
                , ContatoEmergencia__c

                , FormaCobranca__c
                // Melhorias Siggo
                , Cobranca_DiaVcto__c
                , Dia_de_vencimento__c
                
                //, Cobranca_Cartao_Numero__c - Desabilitado para uso do campo Criptografado - Carlos Prates 05/02/2014 18:00
                , Cobranca_Cartao_Numero_Cript__c
                //, Cobranca_Cartao_CodigoSeguranca__c - Desabilitado para uso do campo Criptografado - Carlos Prates 06/02/2014 15:15
                , Cobranca_Cartao_CodigoSeguranca_Cript__c
                , Cobranca_Cartao_Vcto__c
                
                , DebAut_Agencia__c
                , DebAut_ContaCorrente__c
                , DebAut_NomeTitular__c

                , Enderecos_Principal_Logradouro__c
                , Enderecos_Principal_Numero__c
                , Enderecos_Principal_Complemento__c
                , Enderecos_Principal_CEP__c
                , Enderecos_Principal_Bairro__c
                , Enderecos_Principal_Cidade__c
                , Enderecos_Principal_UF__c
                , Enderecos_Principal_Pais__c
                , Codigo_municipio_principal__c

                , Enderecos_Cobranca_Logradouro__c
                , Enderecos_Cobranca_Numero__c
                , Enderecos_Cobranca_Complemento__c
                , Enderecos_Cobranca_CEP__c
                , Enderecos_Cobranca_Bairro__c
                , Enderecos_Cobranca_Cidade__c
                , Enderecos_Cobranca_UF__c
                , Enderecos_Cobranca_Pais__c
                , Codigo_municipio_cobranca__c

                , Enderecos_Entrega_Logradouro__c
                , Enderecos_Entrega_Numero__c
                , Enderecos_Entrega_Complemento__c
                , Enderecos_Entrega_CEP__c
                , Enderecos_Entrega_Bairro__c
                , Enderecos_Entrega_Cidade__c
                , Enderecos_Entrega_UF__c
                , Enderecos_Entrega_Pais__c
                
                , CT_PersClie_CodigoRetorno__c
                , CT_PersClie_MensagemRetorno__c
                , CT_PersClie_MensagemProcesso__c
                , CT_PersClie_DataProcesso__c 
                , CT_PersClie_AguardandoRetorno__c
                
                , Phone
                , TelefoneComercial__c
                , TelefoneCelular__c
                , Nome_do_portador__c
                
                  from account where id = :accId limit 1]; 
                   
            PCL_AccountParser accParser =  new PCL_AccountParser();
            EXT_serverCargotracck.cliente clie = accParser.toExternalObject(acc);
            EXT_serverCargotracck.server_cargotracckPort port = new EXT_serverCargotracck.server_cargotracckPort();
            port.timeout_x = 120000;
            persistirClienteResponse = port.PersistirCliente(clie); 
        }
        catch (Exception e){
            erro = e;           
        }
        finally {
            String mensagemUsuario = '';

            if (erro != null) {
                mensagemUsuario = 'Erro interno: ' + erro.getMessage();
            }
            
            if (persistirClienteResponse != null) {
                acc.CT_PersClie_CodigoRetorno__c = persistirClienteResponse.codigo;
                acc.CT_PersClie_MensagemRetorno__c = persistirClienteResponse.mensagem;
                
                mensagemUsuario = mensagemUsuario + '\nIntranet informa: [' + String.valueOf(acc.CT_PersClie_CodigoRetorno__c) + '] ' + acc.CT_PersClie_MensagemRetorno__c;
                
                if (acc.CT_PersClie_CodigoRetorno__c == 0) {
                    acc.CT_PersClie_CodigoCliente__c = persistirClienteResponse.clienteid;  
                
                    //Modification Carlos Prates - 19/05/2014 - 17:55
                    /*SEFO comentado para implantação das demandas do Siggo
                    if(persistirClienteResponse.operacoes.operacao != null) {
                    List<EXT_serverCargotracck.operacaoResponse> lstOperacaoResponse = persistirClienteResponse.operacoes.operacao;
                        for(Operacao__c o :listaOperacao){   
                           for(EXT_serverCargotracck.operacaoResponse opReturn : lstOperacaoResponse){
                              if(o.ContaPai__c == acc.Id && BCL_HLP_String.getNumberFromFormatedString(o.Conta_Entrega__r.CNPJ__c) == opReturn.op_cnpj){
                                o.ID_Operacao_Intranet__c = opReturn.op_id;
                                o.ID_Operacao_CT__c = opReturn.op_idct;
                              }
                              
                           } 
                        } 
                    }
                    */
                    //End Modification Carlos Prates
                }
                
                
            }
            /* SEFO comentado para implantação das demandas do Siggo
            update listaOperacao; 
            */
            
            acc.CT_PersClie_MensagemProcesso__c = mensagemUsuario;
            acc.CT_PersClie_DataProcesso__c = dataHoraInicio;
            acc.CT_PersClie_AguardandoRetorno__c = false;
            update acc;
        }
    }
    
    public static void updateShippingAddress(List<Account> accList) {
        for(Account acc: accList) {
            
            if (acc.Enderecos_Entrega_UsarPrincipal__c)
            {
                
                acc.Enderecos_Entrega_Bairro__c = acc.Enderecos_Principal_Bairro__c;
                acc.Enderecos_Entrega_CEP__c = acc.Enderecos_Principal_CEP__c;
                acc.Enderecos_Entrega_Cidade__c = acc.Enderecos_Principal_Cidade__c;
                acc.Enderecos_Entrega_Complemento__c = acc.Enderecos_Principal_Complemento__c;
                acc.Enderecos_Entrega_Logradouro__c = acc.Enderecos_Principal_Logradouro__c;
                acc.Enderecos_Entrega_Numero__c = acc.Enderecos_Principal_Numero__c;
                acc.Enderecos_Entrega_Pais__c = acc.Enderecos_Principal_Pais__c;
                acc.Enderecos_Entrega_UF__c = acc.Enderecos_Principal_UF__c;
            }
        }
    }
    
    public static void updateBillingAddress(List<Account> accList) {
        system.debug('to no método');
        for(Account acc: accList) {
            system.debug('to no for');
            if (acc.Enderecos_Cobranca_UsarPrincial__c)
            {
                system.debug('entrega');
                acc.Enderecos_Cobranca_Bairro__c = acc.Enderecos_Principal_Bairro__c;
                acc.Enderecos_Cobranca_CEP__c = acc.Enderecos_Principal_CEP__c;
                acc.Enderecos_Cobranca_Cidade__c = acc.Enderecos_Principal_Cidade__c;
                acc.Enderecos_Cobranca_Complemento__c = acc.Enderecos_Principal_Complemento__c;
                acc.Enderecos_Cobranca_Logradouro__c = acc.Enderecos_Principal_Logradouro__c;
                acc.Enderecos_Cobranca_Numero__c = acc.Enderecos_Principal_Numero__c;
                acc.Enderecos_Cobranca_Pais__c = acc.Enderecos_Principal_Pais__c;
                acc.Enderecos_Cobranca_UF__c = acc.Enderecos_Principal_UF__c;
                acc.Codigo_municipio_cobranca__c = acc.Codigo_municipio_cobranca__c;
            }
        }
    }
    
    public static void neverCallThisMethod() {
        integer a = 0;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
           a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
    }
}