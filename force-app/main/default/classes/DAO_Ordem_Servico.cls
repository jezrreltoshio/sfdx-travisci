/*
    Classe de teste: Teste_DAO_Ordem_Servico
    Criado por: Mario Reis
    Data de criação: 16/04/2018
    Descrição: Classe DAO para o objeto Direcionamento de OS
    ---------------------------------
    @author Renan Rocha
    @date 03/12/2018
    @description Classe refatorada, novos debugs inseridos e método getQueryBatch inserido
    @JIRA KCA-86
    ---------------------------------
    @author Renan Rocha
    @date 07/01/2019
    @description:
        - Trazido métodos getListaOS, filtrarConsultaPorQuantidadeOS, getListaOsByUser, getMapClienteAtd e getAtdQtd que estavam na classe DAO_Direcionamento_OS
    @JIRA KCA-59
*/
public class DAO_Ordem_Servico {
    private static String CLASS_NAME = 'DAO_Ordem_Servico';

    // Método que retorna as Ordens de Servico
    public static List<WorkOrder> getListaOrdemServico(Set<Id> setIdOS){
        String METHOD_NAME = 'getListaOrdemServico';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - setIdOS: '+ setIdOS);

        try {

            List<WorkOrder> listaRetorno = new List<WorkOrder>();

            for(WorkOrder wo: [SELECT Id  
                                    , Agendado_para__c   
                                    , Aging__c   
                                    , Data_atualizacao_status_OS__c   
                                    , EndDate  
                                    , Faixa_Aging__c
                                    , Faixa_Aging__r.Aging_ate__c  
                                    , Faixa_Aging__r.Aging_de__c  
                                    , Faixa_Aging__r.Contatos_dias_distintos__c  
                                    , Faixa_Aging__r.Contatos_faixa__c  
                                    , Faixa_Aging__r.Name  
                                    , Faixa_Aging__r.Nome_faixa__c  
                                    , Faixa_Aging__r.Quantidade_contatos__c  
                                    , Faixa_Aging__r.Quantidade_minima_contatos_por_faixa__c  
                                    , Faixa_Aging__r.Tipo_Macro_OS__c  
                                    , Faixa_Aging__r.Tipo_Micro_OS__c  
                                    , OS_sem_agendamento_aging_85_dias__c  
                                    , Quantidade_contato__c
                                    , StartDate  
                                    , Status_OS__c  
                                    , Status_OS__r.Name
                                    , Status_OS__r.Tipo__c   
                                    , Tipo_OS__r.Codigo_Externo__c  
                                    , Tipo_OS__r.Id  
                                    , Tipo_OS__r.Name  
                                    , Tipo_macro_OS__c  
                                    , Tipo_micro_OS__c  
                                    , (SELECT Id  
                                            , Ativo__c  
                                            , Tipo_OS__r.Codigo_Externo__c  
                                            , Tipo_OS__r.Id  
                                            , Tipo_OS__r.Name  
                                            , Tipo_item_OS__r.Codigo_Externo__c  
                                            , Tipo_item_OS__r.Id  
                                            , Tipo_item_OS__r.Name  
                                      FROM Itens_ordem_servico__r ORDER BY Tipo_OS__r.Codigo_Externo__c)
                                    , (SELECT Id  
                                            , Categoria_contato__c 
                                            , Data__c 
                                            , Data_agenda__c 
                                            , Observacao__c 
                                            , Status__c  
                                            , Status__r.Name     
                                      FROM Historicos_OS__r ORDER BY Data__c DESC)
                              FROM WorkOrder 
                              WHERE Id IN: setIdOS]){
                listaRetorno.add(wo);
            }

            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaRetorno: '+ listaRetorno);

            return listaRetorno;

        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());

            return new List<WorkOrder>();
        } // Fim try/catch

    } // Fim método getListaOrdemServico

	/*
		@description Retorna uma String contendo uma Query que será utilizada para a batch
		@param String listaIdOS
		@return String
		
		@author Renan Rocha
		@date 03/12/2018
		@JIRA KCA-86
	*/
	public static String getQueryBatch(String listaIdOS){
		String METHOD_NAME = 'getQueryBatch';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaIdOS: '+ listaIdOS);
		
		return 
			'SELECT Id' +
				 ', Status_OS__c' + 
				 ', Tipo_macro_OS__c' +
				 ', Tipo_micro_OS__c' +
				 ', (SELECT Id' +
			      ' FROM Itens_ordem_servico__r' +
                  ' WHERE (CreatedDate = TODAY OR LastModifiedDate = TODAY)' +
                  ' OR (Ordem_servico__r.CreatedDate = TODAY OR Ordem_servico__r.LastModifiedDate = TODAY)' +
				  ' ORDER BY Tipo_OS__r.Codigo_Externo__c)' +        
				 ', (SELECT Id' +
				  ' FROM Historicos_OS__r' +
				  ' WHERE (CreatedDate = TODAY OR LastModifiedDate = TODAY)' +
                  ' OR (Ordem_servico__r.CreatedDate = TODAY OR Ordem_servico__r.LastModifiedDate = TODAY)' +
				  ' ORDER BY Data__c DESC)' +
		  ' FROM WorkOrder' +
          ' WHERE Id IN ' + listaIdOS +
		  ' ORDER BY LastModifiedDate ASC'; 
	}

    /*
        @description Retorna uma Ordem de serviço conforme o Id informado
        @param String pId
        @return WorkOrder
        
        @author Renan Rocha
        @date 05/12/2018
        @JIRA KCA-86
    */
    public static WorkOrder getOrdemById(String pId){
        String METHOD_NAME = 'getOrdemById';
        
        return
            [SELECT Id
                  , Status_OS__c
                  , Status_OS__r.Tipo__c
                  , StartDate
            FROM WorkOrder
            WHERE Id =: pId];
    }

    /*
        @description Retorna as OSs não atualizadas para serem enviadas para a Batchs
        @param 
        @return List<WorkOrder>
        
        @author Renan Rocha
        @date 18/12/2018
        @JIRA KCA-86
    */
    public static List<WorkOrder> getOSNaoAtualizadas(){
        String METHOD_NAME = 'getOSNaoAtualizadas';
        
        return
            [SELECT Id 
            FROM WorkOrder 
            WHERE LastModifiedDate < TODAY];   
    }

    // Método que retorna a lista de todas as OS's conforme o parametro e clientes de filtro
    public static List<WorkOrder> getListaOS(Direcionamento_OS__c parametro, List<String> clientesPesquisa){
        String METHOD_NAME = 'getListaOS';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - parametro: '+ parametro);
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - clientesPesquisa: '+ clientesPesquisa);

        String query = 'SELECT Id'+
                            ', Agendado_para__c'+
                            ', Aging__c'+
                            ', Cliente__c'+
                            ', Codigo_Externo__c'+
                            ', Contato_fora_faixa__c'+
                            ', CreatedDate'+
                            ', Data_direcionamento__c'+
                            ', Data_ultima_acao__c'+
                            ', OS_sem_acao__c'+
                            ', OS_sem_agendamento_aging_85_dias__c'+
                            ', Owner.Name'+
                            ', Proximo_contato__c'+
                            ', Quantidade_contato__c'+
                            ', Regional__c'+
                            ', Regra_direcionamento_OS__c'+
                            ', Regra_direcionamento_OS__r.CreatedDate'+
                            ', StartDate'+
                            ', Ultima_acao_OS__c'+
                      ' FROM WorkOrder'+
                      ' WHERE Id <> null'+
                      ' AND Tipo_OS__r.Codigo_externo__c <> \'3\''+
                      ' AND Cliente__c <> null';

        // Se a lista de cliente for informada, adiciona na consulta
        if(clientesPesquisa != null && clientesPesquisa.size() > 0){
            Integer linha = 0;
            
            query += ' AND ( ';
            
            for(String cli : clientesPesquisa){
                query += ' Cliente__c LIKE \'%'+cli+'%\' ';
                
                linha ++;
                
                if(linha != clientesPesquisa.size()) query += ' OR ';
                else query += ' ) ';
            }
        }

        if(parametro.Cliente__c != null && parametro.Cliente__c != '') query += ' AND Cliente__c LIKE \'%'+parametro.Cliente__c+'%\' ';

        if(parametro.Numero_OS__c != null) query += ' AND Codigo_Externo__c ='+parametro.Numero_OS__c+' ';

        if(parametro.OS_sem_agendamento_aging_85_dias__c != null && parametro.OS_sem_agendamento_aging_85_dias__c == true){
            query += ' AND OS_sem_agendamento_aging_85_dias__c = true ';
            query += ' AND (Agendado_para__c = null OR Agendado_para__c < TODAY) ';
        }

        if(parametro.Contato_fora_faixa__c != null && parametro.Contato_fora_faixa__c == true){
            query += ' AND Contato_fora_faixa__c = true ';
            query += ' AND (Agendado_para__c = null OR Agendado_para__c < TODAY) ';
        }

        if(parametro.OS_com_agendamento__c != null && parametro.OS_com_agendamento__c == true) query += ' AND Agendado_para__c <> null AND Agendado_para__c >= TODAY ';

        if(parametro.Ultima_acao_OS__c != null && parametro.Ultima_acao_OS__c != ''){
            if(parametro.Ultima_acao_OS__c == 'Vazio') query += ' AND (Ultima_acao_OS__c = null OR Ultima_acao_OS__c = \'\') ';
            else if(parametro.Ultima_acao_OS__c.contains('Vazio')){
                query += ' AND ( Ultima_acao_OS__c IN(\''+parametro.Ultima_acao_OS__c.replace(',','\',\'').replace(';','\',\'')+'\') ';
                query += ' OR Ultima_acao_OS__c = null OR Ultima_acao_OS__c = \'\') ';
            } else query += ' AND Ultima_acao_OS__c IN(\''+parametro.Ultima_acao_OS__c.replace(',','\',\'').replace(';','\',\'')+'\') ';
        }

        if(parametro.Motivo_noshow__c != null && parametro.Motivo_noshow__c != '') query += ' AND Motivo_noshow__c IN(\''+parametro.Motivo_noshow__c.replace(',','\',\'').replace(';','\',\'')+'\') ';

        if(parametro.Status_OS__c != null && parametro.Status_OS__c != '') query += ' AND Status_OS__c IN(\''+parametro.Status_OS__c.replace(',','\',\'')+'\') ';

        if(parametro.Tipo_contrato__c != null && parametro.Tipo_contrato__c != '') query += ' AND Tipo_contrato__c IN(\''+parametro.Tipo_contrato__c.replace(',','\',\'')+'\') ';

        if(parametro.Classe__c != null && parametro.Classe__c != '') query += ' AND Classe__c IN(\''+parametro.Classe__c.replace(',','\',\'').replace(';','\',\'')+'\') ';

        if(parametro.Regiao_comercial__c != null && parametro.Regiao_comercial__c != ''){
            if(parametro.Regiao_comercial__c == 'VAZIO') query += ' AND (Regional__c = null OR Regional__c = \'\') ';
            else if(parametro.Regiao_comercial__c.contains('VAZIO')){
                query += ' AND ( Regional__c IN(\''+parametro.Regiao_comercial__c.replace(',','\',\'').replace(';','\',\'')+'\') ';
                query += ' OR Regional__c = null OR Ultima_acao_OS__c = \'\') ';
            } else query += ' AND Regional__c IN(\''+parametro.Regiao_comercial__c.replace(',','\',\'').replace(';','\',\'')+'\') ';
        }

        if(parametro.Tipo_OS_Macro__c != null && parametro.Tipo_OS_Macro__c != '') query += ' AND Tipo_macro_OS__c IN(\''+parametro.Tipo_OS_Macro__c.replace(',','\',\'').replace(';','\',\'')+'\') ';

        if(parametro.Tipo_OS_Micro__c != null && parametro.Tipo_OS_Micro__c != '') query += ' AND Tipo_micro_OS__c IN(\''+parametro.Tipo_OS_Micro__c.replace(',','\',\'').replace(';','\',\'')+'\') ';

        if(parametro.Cliente_KA__c != null && parametro.Cliente_KA__c != '' && parametro.Cliente_KA__c == 'Sim') query += ' AND Cliente_KA__c = true ';
        else if(parametro.Cliente_KA__c != null && parametro.Cliente_KA__c != '' && parametro.Cliente_KA__c == 'Não') query += ' AND Cliente_KA__c = false ';
        else if(parametro.Cliente_KA__c != null && parametro.Cliente_KA__c != '' && parametro.Cliente_KA__c == 'Todos') query += ' AND (Cliente_KA__c = false OR Cliente_KA__c = true) ';

        if(parametro.OS_sem_servico__c != null && parametro.OS_sem_servico__c == true) query += ' AND Quantidade_servicos__c = 0 ';

        if(parametro.OS_sem_direcionamento__c != null && parametro.OS_sem_direcionamento__c == true) query += ' AND (Owner.Name LIKE \'%Pentaho%\' OR Owner.Name LIKE \'%Ordem de serviço%\') ';

        if(parametro.Aging_inicial__c != null && parametro.Aging_final__c != null){
            query += ' AND Aging__c >= '+ parametro.Aging_inicial__c+' ';
            query += ' AND Aging__c <= '+ parametro.Aging_final__c+' ';
        } else if(parametro.Aging_inicial__c != null && parametro.Aging_final__c == null) query += ' AND Aging__c >= '+ parametro.Aging_inicial__c+' ';                   
        else if(parametro.Aging_inicial__c == null && parametro.Aging_final__c != null) query += ' AND Aging__c <= '+ parametro.Aging_final__c+' ';                   
        
        if((parametro.Tipo_OS__c != null && parametro.Tipo_OS__c != '') 
            || (parametro.Motivo__c != null && parametro.Motivo__c != '') 
            || (parametro.Item__c != null && parametro.Item__c != '')
        ){
            query += ' AND Id IN (SELECT Ordem_servico__c FROM Item_ordem_servico__c WHERE Id != null ';
            
            if(parametro.Tipo_OS__c != null && parametro.Tipo_OS__c != '') query += ' AND Tipo_OS__c IN(\''+parametro.Tipo_OS__c.replace(',','\',\'')+'\') ';
            
            if(parametro.Motivo__c != null && parametro.Motivo__c != '') query += ' AND Tipo_item_OS__c IN(\''+parametro.Motivo__c.replace(',','\',\'')+'\') ';
            
            if(parametro.Item__c != null && parametro.Item__c != '') query += ' AND Item__c IN(\''+parametro.Item__c.replace(',','\',\'')+'\') ';
            
            query += '       )';
        }

        query += ' ORDER BY Cliente__c, StartDate, Tipo_OS__r.Name, Status_OS__r.Name LIMIT 10000';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - query: '+ query);

        List<WorkOrder> listaRetorno = database.query(query);
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaRetorno: '+ listaRetorno);

        return listaRetorno;
    } // Fim método getListaOS

    // Método para fazer pesquisa e filtrar pela quantidade de OS
    public static List<String> filtrarConsultaPorQuantidadeOS(Direcionamento_OS__c parametro){
        String METHOD_NAME = 'filtrarConsultaPorQuantidadeOS';

        String query = 'SELECT Cliente__c'+
                            ', Count(Id)'+
                      ' FROM WorkOrder'+
                      ' WHERE Id <> null'+
                      ' AND Tipo_OS__r.Codigo_externo__c <> \'3\''+
                      ' AND Cliente__c <> null';

        if(parametro.Cliente__c != null && parametro.Cliente__c != '') query += ' AND Cliente__c LIKE \'%'+parametro.Cliente__c+'%\' ';

        if(parametro.Numero_OS__c != null) query += ' AND Codigo_Externo__c ='+parametro.Numero_OS__c+' ';

        if(parametro.OS_sem_agendamento_aging_85_dias__c != null && parametro.OS_sem_agendamento_aging_85_dias__c == true){
            query += ' AND OS_sem_agendamento_aging_85_dias__c = true ';
            query += ' AND (Agendado_para__c = null OR Agendado_para__c < TODAY) ';
        }

        if(parametro.Contato_fora_faixa__c != null && parametro.Contato_fora_faixa__c == true){
            query += ' AND Contato_fora_faixa__c = true ';
            query += ' AND (Agendado_para__c = null OR Agendado_para__c < TODAY) ';
        }

        if(parametro.OS_com_agendamento__c != null && parametro.OS_com_agendamento__c == true) query += ' AND Agendado_para__c <> null AND Agendado_para__c >= TODAY ';

        if(parametro.Ultima_acao_OS__c != null && parametro.Ultima_acao_OS__c != ''){
            if(parametro.Ultima_acao_OS__c == 'Vazio') query += ' AND (Ultima_acao_OS__c = null OR Ultima_acao_OS__c = \'\') ';
            else if(parametro.Ultima_acao_OS__c.contains('Vazio')){
                query += ' AND ( Ultima_acao_OS__c IN(\''+parametro.Ultima_acao_OS__c.replace(',','\',\'').replace(';','\',\'')+'\') ';
                query += ' OR Ultima_acao_OS__c = null OR Ultima_acao_OS__c = \'\') ';
            } else query += ' AND Ultima_acao_OS__c IN(\''+parametro.Ultima_acao_OS__c.replace(',','\',\'').replace(';','\',\'')+'\') ';
        }

        if(parametro.Motivo_noshow__c != null && parametro.Motivo_noshow__c != '') query += ' AND Motivo_noshow__c IN(\''+parametro.Motivo_noshow__c.replace(',','\',\'').replace(';','\',\'')+'\') ';

        if(parametro.Status_OS__c != null && parametro.Status_OS__c != '') query += ' AND Status_OS__c IN(\''+parametro.Status_OS__c.replace(',','\',\'')+'\') ';

        if(parametro.Tipo_contrato__c != null && parametro.Tipo_contrato__c != '') query += ' AND Tipo_contrato__c IN(\''+parametro.Tipo_contrato__c.replace(',','\',\'')+'\') ';

        if(parametro.Classe__c != null && parametro.Classe__c != '') query += ' AND Classe__c IN(\''+parametro.Classe__c.replace(',','\',\'').replace(';','\',\'')+'\') ';

        if(parametro.Regiao_comercial__c != null && parametro.Regiao_comercial__c != ''){
            if(parametro.Regiao_comercial__c == 'VAZIO') query += ' AND (Regional__c = null OR Regional__c = \'\') ';
            else if(parametro.Regiao_comercial__c.contains('VAZIO')){
                query += ' AND ( Regional__c IN(\''+parametro.Regiao_comercial__c.replace(',','\',\'').replace(';','\',\'')+'\') ';
                query += ' OR Regional__c = null OR Ultima_acao_OS__c = \'\') ';
            } else query += ' AND Regional__c IN(\''+parametro.Regiao_comercial__c.replace(',','\',\'').replace(';','\',\'')+'\') ';
        }

        if(parametro.Tipo_OS_Macro__c != null && parametro.Tipo_OS_Macro__c != '') query += ' AND Tipo_macro_OS__c IN(\''+parametro.Tipo_OS_Macro__c.replace(',','\',\'').replace(';','\',\'')+'\') ';

        if(parametro.Tipo_OS_Micro__c != null && parametro.Tipo_OS_Micro__c != '') query += ' AND Tipo_micro_OS__c IN(\''+parametro.Tipo_OS_Micro__c.replace(',','\',\'').replace(';','\',\'')+'\') ';

        if(parametro.Cliente_KA__c != null && parametro.Cliente_KA__c != '' && parametro.Cliente_KA__c == 'Sim') query += ' AND Cliente_KA__c = true ';
        else if(parametro.Cliente_KA__c != null && parametro.Cliente_KA__c != '' && parametro.Cliente_KA__c == 'Não') query += ' AND Cliente_KA__c = false ';
        else if(parametro.Cliente_KA__c != null && parametro.Cliente_KA__c != '' && parametro.Cliente_KA__c == 'Todos') query += ' AND (Cliente_KA__c = false OR Cliente_KA__c = true) ';
    
        if(parametro.OS_sem_servico__c != null && parametro.OS_sem_servico__c == true) query += ' AND Quantidade_servicos__c = 0 ';

        if(parametro.OS_sem_direcionamento__c != null && parametro.OS_sem_direcionamento__c == true) query += ' AND (Owner.Name LIKE \'%pentaho%\' OR Owner.Name LIKE \'%Ordem de serviço%\') ';

        if(parametro.Aging_inicial__c != null && parametro.Aging_final__c != null){
            query += ' AND Aging__c >= '+ parametro.Aging_inicial__c+' ';
            query += ' AND Aging__c <= '+ parametro.Aging_final__c+' ';
        } else if(parametro.Aging_inicial__c != null && parametro.Aging_final__c == null) query += ' AND Aging__c >= '+ parametro.Aging_inicial__c+' ';                   
        else if(parametro.Aging_inicial__c == null && parametro.Aging_final__c != null) query += ' AND Aging__c <= '+ parametro.Aging_final__c+' ';
        
        if((parametro.Tipo_OS__c != null && parametro.Tipo_OS__c != '') 
            || (parametro.Motivo__c != null && parametro.Motivo__c != '') 
            || (parametro.Item__c != null && parametro.Item__c != '')
        ){
            query += ' AND Id IN (SELECT Ordem_servico__c FROM Item_ordem_servico__c WHERE Id != null ';
            
            if(parametro.Tipo_OS__c != null && parametro.Tipo_OS__c != '') query += ' AND Tipo_OS__c IN(\''+parametro.Tipo_OS__c.replace(',','\',\'')+'\') ';
            
            if(parametro.Motivo__c != null && parametro.Motivo__c != '') query += ' AND Tipo_item_OS__c IN(\''+parametro.Motivo__c.replace(',','\',\'')+'\') ';
            
            if(parametro.Item__c != null && parametro.Item__c != '') query += ' AND Item__c IN(\''+parametro.Item__c.replace(',','\',\'')+'\') ';
            
            query += '       )';
        }

        query += ' GROUP BY Cliente__c HAVING COUNT(Id) >= '+ Integer.valueOf(parametro.Quantidade_OS__c);

        List<String> clientesPesquisa = new List<String>();

        AggregateResult[] agRes = database.query(query);
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - agRes: '+ agRes);

        for (AggregateResult ar : agRes) clientesPesquisa.add((String) ar.get('Cliente__c'));
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - clientesPesquisa: '+ clientesPesquisa);

        return clientesPesquisa;
    } // Fim filtrarConsultaPorQuantidadeOS

    // Método que retorna a lista de OS por usuário
    public static List<WorkOrder> getListaOsByUser(Set<Id> setIdUsuario){
        String METHOD_NAME = 'getListaOsByUser';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - setIdUsuario: '+ setIdUsuario);

        return
            [SELECT Id
                  , Cliente__c
                  , OwnerId
            FROM WorkOrder 
            WHERE OwnerId IN: setIdUsuario
            ORDER BY OwnerId, Cliente__c];
    } // Fim método getListaOsByUser

    // Método que retorna o map de Cliente e Atendente não considerando as OSs
    public static Map<String, String> getMapClienteAtd(Set<Id> setIdUsuario){
        String METHOD_NAME = 'getMapClienteAtd';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - setIdUsuario: '+ setIdUsuario);

        try {

            Map<String, String> mapRetorno = new Map<String, String>();

            // Faz o laço com pesquisa e adicionar o atendente do cliente, conforme o atendente mais recente
            for(WorkOrder os :[SELECT Id
                                    , Cliente__c
                                    , OwnerId
                                    , CreatedDate
                               FROM WorkOrder 
                               WHERE OwnerId IN: setIdUsuario
                               AND Owner.Name <> 'Pentaho' 
                               AND Owner.Name <> 'Ordem de serviço'
                               ORDER BY CreatedDate, OwnerId, Cliente__c])
            {
                mapRetorno.put(os.Cliente__c, os.OwnerId);
            }

            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - mapRetorno: '+ mapRetorno);

            return mapRetorno;
        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());

            return new Map<String, String>();
        } // Fim try/catch
    } // Fim método getMapClienteAtd

    // Método que retorna a lista de atendentes com quantidade de OS
    public static List<String> getAtdQtd(Set<Id> setIdUsuario){
        String METHOD_NAME = 'getAtdQtd';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - setIdUsuario: '+ setIdUsuario);

        try {

            List<String> listaRetorno = new List<String>();

            // Faz o consulta para trazer o atendente com a qtd de OS para depois organizar
            for(AggregateResult ar :[SELECT OwnerId
                                          , COUNT(Id) 
                                    FROM WorkOrder 
                                    WHERE OwnerId IN: setIdUsuario
                                    GROUP BY OwnerId
                                    ORDER BY COUNT(Id) ASC])
            {
                listaRetorno.add((String) ar.get('OwnerId'));
            }

            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaRetorno: '+ listaRetorno);

            return listaRetorno;

        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());

            return new List<String>();
        } // Fim try/catch
    } // Fim método getAtdQtd

    /*
        @description Retorna uma query em string para utilização na Batch_Remove_OS_Regra
        @param String pStringSetIds, String pIdRegra
        @return String
        
        @author Renan Rocha
        @date 09/01/2019
        @JIRA KCA-59
    */
    public static String getQueryBatch(String pStringSetIds, String pIdRegra){
        String METHOD_NAME = 'getQueryBatch';

        String soql = 'SELECT Id'+
                    ' FROM WorkOrder'+
                    ' WHERE Regra_direcionamento_OS__c = \'' + pIdRegra + '\'';
        
        if(pStringSetIds != null) soql += ' AND Id NOT IN ' + pStringSetIds;
        
        return soql;
    }
}