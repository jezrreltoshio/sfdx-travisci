/*
    @testClass PCL_SIG_OpportunityProcessTest
    
    @description Trata os dados das oportunidades Siggo
    
    @author Admin CRM Sascar
    @date 25/01/2014
    ---------------------------------
    @author Renan Rocha
    @date 12/12/2018
    @description Classe refatorada e novos debugs inseridos
    @JIRA KCA-10
    ---------------------------------
    @author Renan Rocha
    @date 14/01/2019
    @description Inserido novos debugs no método completeDoPersistirPropostaProcess
    @JIRA KCA-429
*/

public with sharing class PCL_SIG_OpportunityProcess {
    private static String CLASS_NAME = 'PCL_SIG_OpportunityProcess';
    
    public Void doAnalisePreliminarProcess(Id opptyId) {
        String METHOD_NAME = 'doAnalisePreliminarProcess';
        
        DateTime dataHoraInicio = DateTime.now();
        Opportunity oppty = null;

        oppty = DAO_Oportunidade.getOppById(opptyId);
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - oppty: '+ oppty);

        oppty.Siggo_AnalPrel_CodigoRetorno__c = null;
        oppty.Siggo_AnalPrel_MensagemRetorno__c = null;
        oppty.Siggo_AnalPrel_AguardandoRetorno__c = true;
        oppty.Siggo_AnalPrel_DataProcesso__c = null;
        oppty.Siggo_AnalPrel_MensagemProcesso__c = 'Aguardando resposta da intranet.';              
        update oppty;
        
        List<ItemPropostaSiggo__c> listaItem = DAO_ItemPropostaSiggo.getItemPropostaByOppId(oppty.Id);
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaItem: '+ listaItem);
        
        if (listaItem.size() > 0) {
            for(ItemPropostaSiggo__c item: listaItem) {
                clearAnalisePreliminarResult(item);
                update item;
            }
        }
        
        completeDoAnalisePreliminarProcess(opptyId, dataHoraInicio); 
    }
    
    private void clearAnalisePreliminarResult(ItemPropostaSiggo__c itemProposta) {
        String METHOD_NAME = 'clearAnalisePreliminarResult';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - itemProposta: '+ itemProposta);

        if (itemProposta != null) {
            itemProposta.AnalPrel_CodigoRetorno__c = null;
            itemProposta.AnalPrel_MensagemRetorno__c = null;
            itemProposta.AnalPrel_NumeroOrcamento__c = null;
            itemProposta.AnalPrel_ValorPremio__c = null;        
        }
    }
    
    @future(callout=true)
    private static void completeDoAnalisePreliminarProcess(Id opptyId, DateTime dataHoraInicio) {
        String METHOD_NAME = 'completeDoAnalisePreliminarProcess';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - opptyId: '+ opptyId);
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - dataHoraInicio: '+ dataHoraInicio);

        Exception erro = null;
        EXT_serverSiggo.AnalisePreliminar analisePreliminarResponse = null;
        Opportunity oppty = null;
        
        oppty = getOpportunityToIntranet(opptyId);
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - oppty: '+ oppty);
        
        PCL_SIG_OpptyParser opptyParser = new PCL_SIG_OpptyParser();
        
        Id currentUserId = UserInfo.getUserId();
        
        String xml = opptyParser.toProcessXML(OpportunityProcessType.AnalisePreliminar, currentUserId, oppty, PCL_SIG_OpportunityProcess.getProdutoComSeguroValue(opptyId));
        xml = '<![CDATA[' + BCL_HLP_String.subString(xml, 38, xml.length() - 1) + ']]>';
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - xml: '+ xml);
        
        EXT_serverSiggo.server_siggoPort port = new EXT_serverSiggo.server_siggoPort();
        port.timeout_x = 120000;
        
        try {
            analisePreliminarResponse = port.AnalisePreliminar(xml);    
        }
        catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());
            erro = e;           
        }
        
        String mensagemUsuario = '';
        if (erro != null) {
            mensagemUsuario = 'Erro interno: ' + erro.getMessage();
            mensagemUsuario += '\nStacktrace: ' + erro.getStackTraceString();
            mensagemUsuario += '\nType: ' + erro.getTypeName();
        }
            
        if (analisePreliminarResponse != null) {
            oppty.Siggo_AnalPrel_CodigoRetorno__c = analisePreliminarResponse.codigo;
            oppty.Siggo_AnalPrel_MensagemRetorno__c = analisePreliminarResponse.descricao;
            
            mensagemUsuario = mensagemUsuario + '\nIntranet informa: [' + String.valueOf(oppty.Siggo_AnalPrel_CodigoRetorno__c) + '] ' + oppty.Siggo_AnalPrel_MensagemRetorno__c;
                        
            if (analisePreliminarResponse.lista_orcamento.orcamento != null) {
                List<ItemPropostaSiggo__c> listaItem = DAO_ItemPropostaSiggo.getItemPropostaByOppId(opptyId, true);
                System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaItem: '+ listaItem);
                
                if (listaItem.size() > 0) {
                    integer i = 0;
                    for(EXT_serverSiggo.orcamento o: analisePreliminarResponse.lista_orcamento.orcamento) {
                        ItemPropostaSiggo__c item = listaItem[i++];
                        
                        item.AnalPrel_CodigoRetorno__c = o.codigo;
                        item.AnalPrel_MensagemRetorno__c = o.descricao;
                        item.AnalPrel_NumeroOrcamento__c = o.orcamento_numero;
                        item.AnalPrel_ValorPremio__c = o.valor_premio;
                        
                        update item;
                    }
                }
            }
        }

        oppty.Siggo_AnalPrel_MensagemProcesso__c = mensagemUsuario;
        oppty.Siggo_AnalPrel_DataProcesso__c = dataHoraInicio;
        oppty.Siggo_AnalPrel_AguardandoRetorno__c = false;
        update oppty;
    }
    
    /*
     private static void encerrarAnalisePreliminarProcess () {
     }
    */
    
    public String doAnaliseCreditoProcess(Id opptyId) {
        String METHOD_NAME = 'doAnaliseCreditoProcess';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - opptyId: '+ opptyId);

        String msgErroValidacao = '0'; // Equals success
        DateTime dataHoraInicio = DateTime.now();
        Opportunity oppty = null;

        oppty = DAO_Oportunidade.getOppById(opptyId);
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - oppty: '+ oppty);
        
        if (oppty.Siggo_AnalCred_ResultadoAnalise__c != 0 && oppty.Status_aprova_o_manual__c != 'Aprovada') {
            if (oppty.Quantidade_placas__c > 0 && oppty.N_de_Produtos__c > 0) {
                oppty.Siggo_AnalCred_CodigoRetorno__c = null;
                oppty.Siggo_AnalCred_MensagemRetorno__c = null;
                oppty.Siggo_AnalCred_AguardandoRetorno__c = true;
                
                oppty.Siggo_AnalCred_ResultadoAnalise__c = null;
                oppty.Siggo_AnalCred_RetornoGestor__c = null;
                
                oppty.Siggo_AnalCred_DataProcesso__c = null;
                oppty.Siggo_AnalCred_MensagemProcesso__c = 'Aguardando resposta da intranet.';
                update oppty;
                
                completeDoAnaliseCreditoProcess(opptyId, dataHoraInicio);
            } else {
                msgErroValidacao = 'É obrigatório selecionar produtos e veículos para realizar uma análise de crédito.';
            }
        } else {
            msgErroValidacao = 'Não é possível solicitar análise de crédito para uma oportunidade já aprovada. Reinicie a análise de crédito, se for necessário.';
        }
        
        return msgErroValidacao;
    }
    
    @future(callout=true)
    private static void completeDoAnaliseCreditoProcess(Id opptyId, DateTime dataHoraInicio) {
        String METHOD_NAME = 'completeDoAnaliseCreditoProcess';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - opptyId: '+ opptyId);
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - dataHoraInicio: '+ dataHoraInicio);

        Exception erro = null;
        EXT_serverSiggo.AnaliseCredito analiseCreditoResponse = null;
        Opportunity oppty = null;
        
        try {
            oppty = getOpportunityToIntranet(opptyId);
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - oppty: '+ oppty);
                              
            PCL_SIG_OpptyParser opptyParser = new PCL_SIG_OpptyParser();
            
            Id currentUserId = UserInfo.getUserId();
            
            String xml = opptyParser.toProcessXML(OpportunityProcessType.AnaliseCredito, currentUserId, oppty, PCL_SIG_OpportunityProcess.getProdutoComSeguroValue(opptyId));
            xml = '<![CDATA[' + BCL_HLP_String.subString(xml, 38, xml.length() - 1) + ']]>';
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - xml: '+ xml);
            
            EXT_serverSiggo.server_siggoPort port = new EXT_serverSiggo.server_siggoPort();
            port.timeout_x = 120000;
            analiseCreditoResponse = port.AnaliseCredito(xml);
            
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - analiseCreditoResponse: '+ analiseCreditoResponse);
        }
        catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());
            erro = e;           
        }
        finally {
            String mensagemUsuario = '';
            if (erro != null) {
                mensagemUsuario = 'Erro interno: ' + erro.getMessage();
                mensagemUsuario += '\nStacktrace: ' + erro.getStackTraceString();
                mensagemUsuario += '\nType: ' + erro.getTypeName();
            }
            
            if (analiseCreditoResponse != null) {
                BCL_HLP_String HLP_String = new BCL_HLP_String();
                
                oppty.Siggo_AnalCred_CodigoRetorno__c = 
                    analiseCreditoResponse.analise_credito.codigo;
                oppty.Siggo_AnalCred_MensagemRetorno__c = 
                    analiseCreditoResponse.analise_credito.descricao;
                if (analiseCreditoResponse.analise_credito.resultado_analise != null && analiseCreditoResponse.analise_credito.resultado_analise != '') {
                    oppty.Siggo_AnalCred_ResultadoAnalise__c = 
                        integer.valueOf(analiseCreditoResponse.analise_credito.resultado_analise);
                } else {
                    oppty.Siggo_AnalCred_ResultadoAnalise__c = null;
                }
                oppty.Siggo_AnalCred_RetornoGestor__c = 
                    analiseCreditoResponse.analise_credito.retorno_gestor;
                
                // 2014-04-29 18h40 FST eZly
                // New "credit" fields for manual approval
                oppty.AnaliseCredito_Exp_Cliente__c = 
                    analiseCreditoResponse.analise_credito.experiencia_cliente;
                oppty.AnaliseCredito_Valor_Medio_Parcela__c =
                    analiseCreditoResponse.analise_credito.valor_medio_parcela;
                oppty.Qtde_de_contratos_na_base__c = 
                    analiseCreditoResponse.analise_credito.quantidade_contratos_base;
                
                // Verify that we have a date in the "cliente_desde" response
                if (!String.isEmpty(analiseCreditoResponse.analise_credito.cliente_desde)) {
                    oppty.AnaliseCredito_Cliente_desde__c =
                        HLP_String.XMLStringToDate(analiseCreditoResponse.analise_credito.cliente_desde);
                } else {
                    oppty.AnaliseCredito_Cliente_desde__c = null;
                }
                
                oppty.AnaliseCredito_Maior_atraso__c =
                    analiseCreditoResponse.analise_credito.maior_atraso;
                
                if (analiseCreditoResponse.analise_credito.pendencia_financeira == NULL) {
                    oppty.Pendencia_Financeira__c = false;
                } else {
                    oppty.Pendencia_Financeira__c =
                        analiseCreditoResponse.analise_credito.pendencia_financeira;
                }
                
                oppty.analiseCredito_dias_atraso__c =
                    analiseCreditoResponse.analise_credito.dias_atraso;
                
                mensagemUsuario = 
                    mensagemUsuario + '\nIntranet informa: [' + String.valueOf(oppty.Siggo_AnalCred_CodigoRetorno__c) + '] ' + oppty.Siggo_AnalCred_MensagemRetorno__c;
            }
            
            oppty.Siggo_AnalCred_MensagemProcesso__c = mensagemUsuario;
            oppty.Siggo_AnalCred_DataProcesso__c = dataHoraInicio;
            oppty.Siggo_AnalCred_AguardandoRetorno__c = false;
            
            if (oppty.Siggo_AnalCred_ResultadoAnalise__c == 0) {
                Resumo_analise_manual_oportunidade__c resumo = 
                    new Resumo_analise_manual_oportunidade__c(
                        Oportunidade__c = oppty.Id,
                        Resultado_analise_automatica__c = oppty.Siggo_AnalCred_ResultadoAnalise__c,
                        T_rmino_do_processo_em__c = DateTime.now());
                insert resumo;
            }
            
            update oppty;
        }
        
    }
    
    public String doPersistirPropostaProcess(Id opptyId) {
        String METHOD_NAME = 'doPersistirPropostaProcess';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - opptyId: '+ opptyId);

        String msgErroValidacao = '0'; // Equals success
        DateTime dataHoraInicio = DateTime.now();
        Opportunity oppty = null;
        
        oppty = DAO_Oportunidade.getOppById(opptyId);
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - oppty: '+ oppty);
        
        if (oppty.Siggo_PersProp_NumeroProposta__c != null && oppty.Siggo_PersProp_NumeroProposta__c != '') {
            msgErroValidacao = 'Essa oportunidade já possui proposta gerada.';
        } else {
            if (oppty.Siggo_AnalCred_ResultadoAnalise__c == 0 || oppty.Status_aprova_o_manual__c == 'Aprovada') {
                oppty = getOpportunityToIntranet(opptyId);
                
                oppty.Siggo_PersProp_CodigoRetorno__c = null;
                oppty.Siggo_PersProp_MensagemRetorno__c = null;
                oppty.Siggo_PersProp_AguardandoRetorno__c = true;
                
                oppty.Siggo_PersProp_NumeroProposta__c = null;
                oppty.Siggo_PersProp_StatusProposta__c = null;
                
                oppty.Siggo_PersProp_DataProcesso__c = null;
                oppty.Siggo_PersProp_MensagemProcesso__c = 'Aguardando resposta da intranet.';              
                update oppty;
                
                completeDoPersistirPropostaProcess(opptyId, dataHoraInicio);
            } else {
                msgErroValidacao = 'A proposta só pode ser gerada para uma oportunidade aprovada.';
            }
        }
        return msgErroValidacao;
    }
    
    @future(callout=true)
    private static void completeDoPersistirPropostaProcess(Id opptyId, DateTime dataHoraInicio) {
        String METHOD_NAME = 'completeDoPersistirPropostaProcess';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - opptyId: '+ opptyId);
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - dataHoraInicio: '+ dataHoraInicio);

        Exception erro = null;
        EXT_serverSiggo.PersistirProposta persistirPropostaResponse = null;
        Opportunity oppty = null;
        
        try {
            oppty = getOpportunityToIntranet(opptyId);
                              
            PCL_SIG_OpptyParser opptyParser = new PCL_SIG_OpptyParser();
            
            Id currentUserId = UserInfo.getUserId();
            
            String xml = opptyParser.toProcessXML(OpportunityProcessType.PersistirProposta, currentUserId, oppty, PCL_SIG_OpportunityProcess.getProdutoComSeguroValue(opptyId));
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - xml (antes): '+ xml);

            xml = '<![CDATA[' + BCL_HLP_String.subString(xml, 38, xml.length() - 1) + ']]>';
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - xml: '+ xml);
            
            EXT_serverSiggo.server_siggoPort port = new EXT_serverSiggo.server_siggoPort();
            
            port.timeout_x = 120000;
            persistirPropostaResponse = port.PersistirProposta(xml);
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - persistirPropostaResponse: '+ persistirPropostaResponse); 
        }
        catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());
            erro = e;
        }
        finally {
            String mensagemUsuario = '';
            
            // Modification Carlos Prates - GI 1938 - String 'contratosERP' will store the number of ERP contract generated
            String contratosERP = '';
            
            if (erro != null) {
                mensagemUsuario = 'Erro interno: ' + erro.getMessage();
                mensagemUsuario += '\nStacktrace: ' + erro.getStackTraceString();
                mensagemUsuario += '\nType: ' + erro.getTypeName();
            }

            if (persistirPropostaResponse != null) {
                oppty.Siggo_PersProp_CodigoRetorno__c = persistirPropostaResponse.codigo;
                oppty.Siggo_PersProp_MensagemRetorno__c = persistirPropostaResponse.descricao;

                mensagemUsuario = mensagemUsuario + '\nIntranet informa: [' + String.valueOf(oppty.Siggo_PersProp_CodigoRetorno__c) + '] ' + oppty.Siggo_PersProp_MensagemRetorno__c;

                if (oppty.Siggo_PersProp_CodigoRetorno__c == 0) {
                    oppty.Siggo_PersProp_NumeroProposta__c = persistirPropostaResponse.proposta;
                    oppty.Siggo_PersProp_StatusProposta__c = persistirPropostaResponse.status_proposta;
                    
                    List<ItemPropostaSiggo__c> listaItemProposta = DAO_ItemPropostaSiggo.getItemPropostaByOppId(oppty.Id);
                    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaItemProposta: '+ listaItemProposta);
                    
                    integer i = -1;
                    for(ItemPropostaSiggo__c item: listaItemProposta) {
                        EXT_serverSiggo.contrato contrato = persistirPropostaResponse.lista_contratos.contrato[++i];
                        
                        item.NumeroContrato__c = contrato.numero_contrato;
                        item.StatusContrato__c = contrato.status_contrato;
                        
                        // Modification Carlos Prates - GI 1938 - String 'contratosERP' will store the number of ERP contract generated
                        if(contratosERP == '') contratosERP = contrato.numero_contrato;
                        else contratosERP += ', ' + contrato.numero_contrato;
                        
                        update item;
                    }   
                }           
            }
            // Modification Carlos Prates - GI 1938 - String 'contratosERP' will store the number of ERP contract generated
            oppty.Numero_dos_contratos_ERP__c = contratosERP;
                        
            oppty.Siggo_PersProp_MensagemProcesso__c = mensagemUsuario;
            oppty.Siggo_PersProp_DataProcesso__c = dataHoraInicio;
            oppty.Siggo_PersProp_AguardandoRetorno__c = false;
            update oppty;
        }   
    }
    
    private static boolean getProdutoComSeguroValue(Id opptyId) {
        String METHOD_NAME = 'getProdutoComSeguroValue';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - opptyId: '+ opptyId);

        List <OpportunityLineItem> item = DAO_Item_Oportunidade.getOppQliByOppId(opptyid);
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - item: '+ item);
        
        if (item.size() > 0) {
            Boolean temSeguro = false;
            
            temSeguro = item[0].Produto_com_seguro__c;
            
            return temSeguro;
        } else {
            
            /*
             * @TODO
             * @ERROR
             * Provocamos um erro aqui propositalmente!
             * Esta função deveria gerar um erro caso o 
             * retorno da lista/query não seja UM, porém
             * não temos o método-base para gerar este erro,
             * desta forma estamos gerando um erro fake para
             * lembrar de corrigir isso.
             * eZly - Fernando S. Trevisan - 2014.06.18
             * 
             */
            // Integer varError = 100/0;
            return false;
        }
    }
    
    private static Opportunity getOpportunityToIntranet(Id opptyId) {
        String METHOD_NAME = 'getOpportunityToIntranet';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - opptyId: '+ opptyId);

        Opportunity oppty = DAO_Oportunidade.getOppById(opptyId);
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - oppty: '+ oppty);
            
        return oppty;
    }
    
    public static void updateOwnerData(List<ItemPropostaSiggo__c> itemList) {
        String METHOD_NAME = 'updateOwnerData';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - itemList: '+ itemList);

        String sAccountId = '';
        
        //Modification Carlos Prates - adjustment to avoid exception limit SOQL query - 29/07/2014
        Set<Id> oppIds = new Set<Id>();
        for(ItemPropostaSiggo__c ip : itemList) oppIds.add(ip.Oportunidade__c);
        
        List <Opportunity> oppList = DAO_Oportunidade.getOportunidadesBySetId(oppIds);
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - oppList: '+ oppList);

        sAccountId = oppList[0].AccountId;
        // END Modification Carlos Prates - adjustment to avoid exception limit SOQL query - 29/07/2014

        Account acc = DAO_Conta.getContaPorId(sAccountId);
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - acc: '+ acc);
            
        for( ItemPropostaSiggo__c ip : itemList ){
            //Modification Carlos Prates - adjustment to avoid exception limit SOQL query - 29/07/2014
            //List <Opportunity> oppList = [select AccountId from Opportunity where id = :ip.Oportunidade__c limit 1];
            // END Modification Carlos Prates - adjustment to avoid exception limit SOQL query - 29/07/2014
            
            // for (Account acc : accList)
            // {
                //ip.Veiculo_Proprietario_TipoPessoa__c = acc.Tipo_de_pessoa__c;
                //ip.Veiculo_Proprietario_Nome__c = acc.Name;
                //Desabilitado, pois foi criado máscara para campos CPF e CNPJ - Carlos Prates 06/02/2014 11:20
                //ip.Veiculo_Proprietario_CNPJCPF__c = acc.CNPJ_CPF__c;
                //if(acc.Tipo_de_pessoa__c == HLP_Account.PLV_TIPODEPESSOAC_FISICA){
                // ip.Veiculo_Proprietario_CNPJCPF__c = BCL_HLP_String.getNumberFromFormatedString(acc.CPF__c);
                //}else{
                // ip.Veiculo_Proprietario_CNPJCPF__c = BCL_HLP_String.getNumberFromFormatedString(acc.CNPJ__c);
                //}
                //ip.Veiculo_Proprietario_Sexo__c = acc.DadosPF_Sexo__c;
                //ip.Veiculo_Proprietario_EMail__c = acc.EMail__c;
                //ip.Veiculo_Proprietario_RG__c = acc.DadosPF_RG__c;
                //ip.Veiculo_Proprietario_EstadoCivil__c = acc.DadosPF_EstadoCivil__c;
                //ip.Veiculo_Proprietario_DataNascimento__c = acc.DadosPF_DataNascimento__c;
            // }
        }
    }
    
    public static void adjustCreditCardData(List<Opportunity> opptyList) {
        String METHOD_NAME = 'adjustCreditCardData';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - opptyList: '+ opptyList);

        for(Opportunity oppty: opptyList) {
            if (oppty.Forma_de_pagamento_instala_o__c == HLP_Opportunity.PLV_FORMADEPAGAMENTOINSTALAOC_BOLETO) {
                //oppty.CartaoCredito_Numero__c = null;  - Desabilitado para uso do campo Criptografado - Carlos Prates 05/02/2014 18:00
                oppty.CartaoCredito_Numero_Cript__c = null;
                //oppty.CartaoCredito_CodigoSeguranca__c = null; - Desabilitado para uso do campo Criptografado - Carlos Prates 06/02/2014 15:00
                oppty.CartaoCredito_CodigoSeguranca_Cript__c = null; 
                oppty.CartaoCredito_Vencimento__c = null;
            }
        }
    }
    
    public String doRestartCreditAnalysis(Id opptyId){
        String METHOD_NAME = 'doRestartCreditAnalysis';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - opptyId: '+ opptyId);

        String msgRetorno = '0'; // Equals success
        Opportunity oppty = null;
        
        // Search for the oppty being updated
        oppty = DAO_Oportunidade.getOppById(opptyId);
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - opptyId: '+ opptyId);
             
        // Check if oppty is already approved
        //if (oppty.Siggo_AnalCred_ResultadoAnalise__c == 0 || oppty.Status_aprova_o_manual__c == 'Aprovada') {
            
            // Clear fields so the oppty gets restarted
            oppty.Siggo_AnalCred_CodigoRetorno__c = null;
            oppty.Siggo_AnalCred_MensagemRetorno__c = null;
            oppty.Siggo_AnalCred_AguardandoRetorno__c = false;
            
            oppty.Siggo_AnalCred_ResultadoAnalise__c = null;
            oppty.Siggo_AnalCred_RetornoGestor__c = null;
            
            oppty.Siggo_AnalCred_DataProcesso__c = null;
            oppty.Siggo_AnalCred_MensagemProcesso__c = null;
            
            oppty.Status_aprova_o_manual__c = 'Reiniciada';
            
            // Search report's record to delete
            List<Resumo_analise_manual_oportunidade__c> resumo = DAO_ResumoAnaliseManualOpp.getResumoAnaliseManualOppBySetId(new Set<Id>{oppty.Id});
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - resumo: '+ resumo);
            
            if (resumo.size() > 0) delete resumo;
            
            // Update oppty to clear fields
            update oppty;
        //} else {
        //    msgRetorno = 'A análise de crédito só pode ser reiniciada em oportunidades aprovadas.';
        //}
        
        return msgRetorno;
    }
}