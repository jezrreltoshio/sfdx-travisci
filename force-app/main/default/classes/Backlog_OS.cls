/*
    Classe de teste: Teste_Backlog_OS
    Criado por: Mario Reis
    Data de criação: 22/05/2018
    Descrição: Classe com métodos para a tela de Backlog de OS
*/
global class Backlog_OS {

    // Método para pesquisar a OS
    webservice static List<WorkOrder> pesquisarOS(String parametrosPesquisa){

        System.debug(LoggingLevel.ERROR, '__ [cls Backlog_OS - pesquisarOS()] - Inicio...');
        System.debug(LoggingLevel.ERROR, '__ [cls Backlog_OS - pesquisarOS()] - parametrosPesquisa: '+parametrosPesquisa);

        try {

            Direcionamento_OS__c direcionamentoOS = new Direcionamento_OS__c();

            JSONParser parser = JSON.createParser(parametrosPesquisa);

            System.debug(LoggingLevel.ERROR, '__ [cls Backlog_OS - pesquisarOS()] - parser: '+parser);

            while(parser.nextToken() != null) {

                System.debug(LoggingLevel.ERROR, '__ [cls Backlog_OS - pesquisarOS()] - parser.getCurrentName(): '+parser.getCurrentName());

                if(parser.getCurrentName() == 'Numero_OS__c') { 
                    parser.nextToken();
                    direcionamentoOS.Numero_OS__c = parser.getText() != null && parser.getText() != '' && parser.getText() != 'null' ? parser.getText() : null;
                }
                if(parser.getCurrentName() == 'Cliente__c') { 
                    parser.nextToken();
                    direcionamentoOS.Cliente__c = parser.getText() != null && parser.getText() != '' && parser.getText() != 'null' ? parser.getText() : null;
                }
                if(parser.getCurrentName() == 'Aging_inicial__c') { 
                    parser.nextToken();
                    direcionamentoOS.Aging_inicial__c = parser.getText() != null && parser.getText() != '' && parser.getText() != 'null' ? Integer.valueOf(parser.getText()) : null;
                }
                if(parser.getCurrentName() == 'Aging_final__c') { 
                    parser.nextToken();
                    direcionamentoOS.Aging_final__c = parser.getText() != null && parser.getText() != '' && parser.getText() != 'null' ? Integer.valueOf(parser.getText()) : null;
                }
                if(parser.getCurrentName() == 'Data_agendamento_inicial__c') { 
                    parser.nextToken();
                    direcionamentoOS.Data_agendamento_inicial__c = parser.getText() != null && parser.getText() != '' && parser.getText() != 'null' ? parser.getDateValue() : null;
                }
                if(parser.getCurrentName() == 'Data_agendamento_final__c') { 
                    parser.nextToken();
                    direcionamentoOS.Data_agendamento_final__c = parser.getText() != null && parser.getText() != '' && parser.getText() != 'null' ? parser.getDateValue() : null;
                }
                if(parser.getCurrentName() == 'Agendamento_proximo_contato__c') { 
                    parser.nextToken();
                    direcionamentoOS.Agendamento_proximo_contato__c = parser.getText() != null && parser.getText() != '' && parser.getText() != 'null' ? parser.getDateValue() : null;
                }
                if(parser.getCurrentName() == 'Tipo_OS__c') { 
                    parser.nextToken();
                    direcionamentoOS.Tipo_OS__c = parser.getText();
                }
                if(parser.getCurrentName() == 'Item__c') { 
                    parser.nextToken();
                    direcionamentoOS.Item__c = parser.getText();
                }
                if(parser.getCurrentName() == 'Motivo__c') { 
                    parser.nextToken();
                    direcionamentoOS.Motivo__c = parser.getText();
                }
                if(parser.getCurrentName() == 'Status_OS__c') { 
                    parser.nextToken();
                    direcionamentoOS.Status_OS__c = parser.getText();
                }
                if(parser.getCurrentName() == 'Ultima_acao_OS__c') { 
                    parser.nextToken();
                    direcionamentoOS.Ultima_acao_OS__c = parser.getText();
                }
                if(parser.getCurrentName() == 'Motivo_noshow__c') { 
                    parser.nextToken();
                    direcionamentoOS.Motivo_noshow__c = parser.getText();
                }
                if(parser.getCurrentName() == 'Tipo_contrato__c') { 
                    parser.nextToken();
                    direcionamentoOS.Tipo_contrato__c = parser.getText();
                }
                if(parser.getCurrentName() == 'Status_solicitacao_equipamento__c') { 
                    parser.nextToken();
                    direcionamentoOS.Status_solicitacao_equipamento__c = parser.getText();
                }
                if(parser.getCurrentName() == 'Sem_contato_faixa__c') { 
                    parser.nextToken();
                    direcionamentoOS.Contato_fora_faixa__c = parser.getBooleanValue();
                }
                if(parser.getCurrentName() == 'OS_sem_agendamento__c') { 
                    parser.nextToken();
                    direcionamentoOS.OS_sem_agendamento__c = parser.getBooleanValue();
                }
                if(parser.getCurrentName() == 'OS_sem_acao__c') { 
                    parser.nextToken();
                    direcionamentoOS.OS_sem_acao__c = parser.getBooleanValue();
                }
                if(parser.getCurrentName() == 'OS_sem_agendamento_aging_85_dias__c') { 
                    parser.nextToken();
                    direcionamentoOS.OS_sem_agendamento_aging_85_dias__c = parser.getBooleanValue();
                }
                if(parser.getCurrentName() == 'OS_com_agendamento__c') { 
                    parser.nextToken();
                    direcionamentoOS.OS_com_agendamento__c = parser.getBooleanValue();
                }
                if(parser.getCurrentName() == 'Classe__c') { 
                    parser.nextToken();
                    direcionamentoOS.Classe__c = parser.getText();
                }
                if(parser.getCurrentName() == 'Regiao_comercial__c') { 
                    parser.nextToken();
                    direcionamentoOS.Regiao_comercial__c = parser.getText();
                }
                if(parser.getCurrentName() == 'Tipo_OS_macro__c') { 
                    parser.nextToken();
                    direcionamentoOS.Tipo_OS_macro__c = parser.getText();
                }
                if(parser.getCurrentName() == 'Tipo_OS_micro__c') { 
                    parser.nextToken();
                    direcionamentoOS.Tipo_OS_micro__c = parser.getText();
                }
                if(parser.getCurrentName() == 'Todas_agendamento_proximo_contato__c') { 
                    parser.nextToken();
                    direcionamentoOS.Todas_agendamento_proximo_contato__c = parser.getBooleanValue();
                }
                

            }

            System.debug(LoggingLevel.ERROR, '__ [cls Backlog_OS - pesquisarOS()] - direcionamentoOS: '+direcionamentoOS);

            List<WorkOrder> listaRetorno = new List<WorkOrder>();

            listaRetorno = getListaOS(direcionamentoOS);

            return listaRetorno;

        } catch (Exception e){

            System.debug(LoggingLevel.ERROR, '__ [cls Backlog_OS - pesquisarOS()] - ERRO: '+e.getMessage());
            return new List<WorkOrder>();
        } // Fim try/catch

    } // Fim salvarConfiguracao


    // Método que retorna a lista de todas as OS's
    public static List<WorkOrder> getListaOS(Direcionamento_OS__c parametro){

        System.debug(LoggingLevel.ERROR, '__ [cls Backlog_OS - getListaOS()] - Inicio...');
        System.debug(LoggingLevel.ERROR, '__ [cls Backlog_OS - getListaOS()] - parametro: '+parametro);

        try {

            List<WorkOrder> listaConsulta = new List<WorkOrder>();
            Boolean filtrarPorItem = false;

            String consulta = '';
            consulta += 'SELECT Id';
            consulta += '      ,Codigo_Externo__c';
            consulta += '      ,Cliente__c';
            consulta += '      ,Owner.Name';
            consulta += '      ,Regional__c';
            consulta += '      ,StartDate';
            consulta += '      ,Aging__c';
            consulta += '      ,Cliente_KA__c';
            consulta += '      ,Faixa_aging__c';
            consulta += '      ,Faixa_aging__r.Nome_faixa__c';
            consulta += '      ,Ultima_acao_OS__c';
            consulta += '      ,Quantidade_contato__c';
            consulta += '      ,Data_ultima_acao__c';
            consulta += '      ,Agendado_para__c';
            consulta += '      ,Data_direcionamento__c';
            consulta += '      ,OS_sem_acao__c';
            consulta += '      ,Proximo_contato__c';
            consulta += '      ,Contato_fora_faixa__c';
            consulta += '      ,OS_sem_agendamento_aging_85_dias__c';

            consulta += ' FROM WorkOrder WHERE Id != null AND Tipo_OS__r.Codigo_externo__c <> \'3\' AND Cliente__c <> null ';

            if(parametro.Cliente__c != null && parametro.Cliente__c != ''){
                consulta += ' AND Cliente__c LIKE \'%'+parametro.Cliente__c+'%\' ';
            } else {
                consulta += ' AND OwnerId = \''+UserInfo.getUserId()+'\' ';
            }
            if(parametro.Numero_OS__c != null){
                consulta += ' AND Codigo_Externo__cCodigo_Externo__c ='+parametro.Numero_OS__c+' ';
            }

            if(parametro.Aging_inicial__c != null && parametro.Aging_final__c != null){
                consulta += ' AND Aging__c >= '+ parametro.Aging_inicial__c+' ';
                consulta += ' AND Aging__c <= '+ parametro.Aging_final__c+' ';
            } else if(parametro.Aging_inicial__c != null && parametro.Aging_final__c == null){
                consulta += ' AND Aging__c >= '+ parametro.Aging_inicial__c+' ';                   
            } else if(parametro.Aging_inicial__c == null && parametro.Aging_final__c != null){
                consulta += ' AND Aging__c <= '+ parametro.Aging_final__c+' ';                   
            }

            if(parametro.OS_sem_agendamento_aging_85_dias__c != null && parametro.OS_sem_agendamento_aging_85_dias__c == true){
                consulta += ' AND OS_sem_agendamento_aging_85_dias__c = true ';
            }

            if(parametro.OS_com_agendamento__c != null && parametro.OS_com_agendamento__c == true){
                consulta += ' AND Agendado_para__c <> null AND Agendado_para__c >= TODAY ';
            }

            if(parametro.Data_agendamento_inicial__c != null && parametro.Data_agendamento_final__c != null){
                consulta += ' AND Agendado_para__c <> null ';
                consulta += ' AND Agendado_para__c >= '+ String.valueOf(parametro.Data_agendamento_inicial__c)+'T00:00:00Z';
                consulta += ' AND Agendado_para__c <= '+ String.valueOf(parametro.Data_agendamento_final__c)+'T23:59:59Z';
            } else if(parametro.Data_agendamento_inicial__c != null && parametro.Data_agendamento_final__c == null){
                consulta += ' AND Agendado_para__c <> null ';
                consulta += ' AND Agendado_para__c >= '+ String.valueOf(parametro.Data_agendamento_inicial__c)+'T00:00:00Z';
            } else if(parametro.Data_agendamento_inicial__c == null && parametro.Data_agendamento_final__c != null){
                consulta += ' AND Agendado_para__c <> null ';
                consulta += ' AND Agendado_para__c <= '+ String.valueOf(parametro.Data_agendamento_final__c)+'T23:59:59Z';
            }

            if(parametro.OS_sem_agendamento__c != null && parametro.OS_sem_agendamento__c == true){
                consulta += ' AND (Agendado_para__c = null OR Agendado_para__c < TODAY) ';
            }

            if(parametro.Agendamento_proximo_contato__c != null){
                consulta += ' AND Proximo_contato__c <> NULL AND ';
                consulta += ' Proximo_contato__c >= '+ String.valueOf(parametro.Agendamento_proximo_contato__c)+'T00:00:00Z ';
                consulta += ' AND Proximo_contato__c <= '+ String.valueOf(parametro.Agendamento_proximo_contato__c)+'T23:59:59Z ';
            }

            if(parametro.Contato_fora_faixa__c != null && parametro.Contato_fora_faixa__c == true){
                consulta += ' AND Contato_fora_faixa__c = true ';
            }

            if(parametro.OS_sem_acao__c != null && parametro.OS_sem_acao__c == true){
                consulta += ' AND OS_sem_acao__c = true ';
            }

            if(parametro.Ultima_acao_OS__c != null && parametro.Ultima_acao_OS__c != ''){
                if(parametro.Ultima_acao_OS__c == 'Vazio'){
                    consulta += ' AND (Ultima_acao_OS__c = null OR Ultima_acao_OS__c = \'\')';
                } else if(parametro.Ultima_acao_OS__c.contains('Vazio')){
                    consulta += ' AND ( Ultima_acao_OS__c IN(\''+parametro.Ultima_acao_OS__c.replace(',','\',\'').replace(';','\',\'')+'\') ';
                    consulta += ' OR Ultima_acao_OS__c = null OR Ultima_acao_OS__c = \'\')';
                } else {
                    consulta += ' AND Ultima_acao_OS__c IN(\''+parametro.Ultima_acao_OS__c.replace(',','\',\'').replace(';','\',\'')+'\') ';
                }
            }

            if(parametro.Motivo_noshow__c != null && parametro.Motivo_noshow__c != ''){
                consulta += ' AND Motivo_noshow__c IN(\''+parametro.Motivo_noshow__c.replace(',','\',\'')+'\') ';
            }

            if(parametro.Status_OS__c != null && parametro.Status_OS__c != ''){
                consulta += ' AND Status_OS__c IN(\''+parametro.Status_OS__c.replace(',','\',\'')+'\') ';
            }

            if(parametro.Tipo_contrato__c != null && parametro.Tipo_contrato__c != ''){
                consulta += ' AND Tipo_contrato__c IN(\''+parametro.Tipo_contrato__c.replace(',','\',\'')+'\') ';
            }

            if(parametro.Status_solicitacao_equipamento__c != null && parametro.Status_solicitacao_equipamento__c != ''){
                if( (parametro.Status_solicitacao_equipamento__c.contains('Aguardando estoque CD') || 
                     parametro.Status_solicitacao_equipamento__c.contains('Estoque CD reabastecido')) &&
                     parametro.Status_solicitacao_equipamento__c.contains('Sem Solicitação')
                  ){
                    consulta += ' AND (( ((Agendado_para__c = null OR Agendado_para__c < TODAY) ';
                    if(parametro.Status_solicitacao_equipamento__c.contains('Aguardando estoque CD') && 
                       !parametro.Status_solicitacao_equipamento__c.contains('Estoque CD reabastecido')){
						consulta += ' AND Status_solicitacao__c IN(\'Aguardando estoque CD\') ) OR ';      
                    } else if(!parametro.Status_solicitacao_equipamento__c.contains('Aguardando estoque CD') && 
                       			parametro.Status_solicitacao_equipamento__c.contains('Estoque CD reabastecido')){
                    	consulta += ' AND Status_solicitacao__c IN(\'Estoque CD reabastecido\') ) OR ';      
					} else {
                        consulta += ' AND Status_solicitacao__c IN(\'Aguardando estoque CD\',\'Estoque CD reabastecido\') ) OR ';
					}
                    consulta += ' ((Agendado_para__c <> null AND Agendado_para__c >= TODAY) ';
                    consulta += ' AND Status_solicitacao__c IN(\'Sem Solicitação\'))';
                    consulta += ' OR (Status_solicitacao__c IN(\''+parametro.Status_solicitacao_equipamento__c
                        .replace(',Sem Solicitação','')
                        .replace('Sem Solicitação,','')
                        .replace('Sem Solicitação','')
                        .replace(',Aguardando estoque CD','')
                        .replace('Aguardando estoque CD,','')
                        .replace('Aguardando estoque CD','')
                        .replace(',Estoque CD reabastecido','')
                        .replace('Estoque CD reabastecido,','')
                        .replace('Estoque CD reabastecido','')
                        .replace(',,','')
                        .replace(',)',')')
                        .replace(',','\',\'')
                        +'\') AND Status_solicitacao__c <> \'\') ) )';
                } else if(parametro.Status_solicitacao_equipamento__c.contains('Aguardando estoque CD') || 
                   parametro.Status_solicitacao_equipamento__c.contains('Estoque CD reabastecido')
                  ){
                    consulta += ' AND (((Agendado_para__c = null OR Agendado_para__c < TODAY) ';

                    if(parametro.Status_solicitacao_equipamento__c.contains('Aguardando estoque CD') && 
                       !parametro.Status_solicitacao_equipamento__c.contains('Estoque CD reabastecido')){
						consulta += ' AND Status_solicitacao__c IN(\'Aguardando estoque CD\') ) ';      
                    } else if(!parametro.Status_solicitacao_equipamento__c.contains('Aguardando estoque CD') && 
                       			parametro.Status_solicitacao_equipamento__c.contains('Estoque CD reabastecido')){
                    	consulta += ' AND Status_solicitacao__c IN(\'Estoque CD reabastecido\') )  ';      
					} else {
                        consulta += ' AND Status_solicitacao__c IN(\'Aguardando estoque CD\',\'Estoque CD reabastecido\') ) ';
					}
                    consulta += ' OR (Status_solicitacao__c IN(\''+parametro.Status_solicitacao_equipamento__c
                        .replace(',Aguardando estoque CD','')
                        .replace('Aguardando estoque CD,','')
                        .replace('Aguardando estoque CD','')
                        .replace(',Estoque CD reabastecido','')
                        .replace('Estoque CD reabastecido,','')
                        .replace('Estoque CD reabastecido','')
                        .replace(',,','')
                        .replace(',)',')')
                        .replace(',','\',\'')
                        +'\') AND Status_solicitacao__c <> \'\') )';
                } else if(parametro.Status_solicitacao_equipamento__c.contains('Sem Solicitação')){
                    consulta += ' AND Agendado_para__c <> null AND Agendado_para__c >= TODAY ';
                    consulta += ' AND (Status_solicitacao__c IN(\'Sem Solicitação\') ';
                    consulta += ' OR (Status_solicitacao__c IN(\''+parametro.Status_solicitacao_equipamento__c
                        .replace(',Sem Solicitação','')
                        .replace('Sem Solicitação,','')
                        .replace('Sem Solicitação','')
                        .replace(',','\',\'')
                        +'\') AND Status_solicitacao__c <> \'\') )';
                } else {
                    consulta += ' AND Status_solicitacao__c IN(\''+parametro.Status_solicitacao_equipamento__c.replace(',','\',\'')+'\') ';
                }

            }

            if(parametro.Classe__c != null && parametro.Classe__c != ''){
                consulta += ' AND Classe__c IN(\''+parametro.Classe__c.replace(',','\',\'').replace(';','\',\'')+'\') ';
            }

            if(parametro.Regiao_comercial__c != null && parametro.Regiao_comercial__c != ''){
                consulta += ' AND Regional__c IN(\''+parametro.Regiao_comercial__c.replace(',','\',\'').replace(';','\',\'')+'\') ';
            }

            if(parametro.Tipo_OS_Macro__c != null && parametro.Tipo_OS_Macro__c != ''){
                consulta += ' AND Tipo_macro_OS__c IN(\''+parametro.Tipo_OS_Macro__c.replace(',','\',\'').replace(';','\',\'')+'\') ';
            }

            if(parametro.Tipo_OS_Micro__c != null && parametro.Tipo_OS_Micro__c != ''){
                consulta += ' AND Tipo_micro_OS__c IN(\''+parametro.Tipo_OS_Micro__c.replace(',','\',\'').replace(';','\',\'')+'\') ';
            }
            
            if(parametro.Todas_agendamento_proximo_contato__c != null && parametro.Todas_agendamento_proximo_contato__c == true){
                consulta += ' AND Proximo_contato__c <> NULL AND Proximo_contato__c >= TODAY ';
            }

            if( (parametro.Tipo_OS__c != null && parametro.Tipo_OS__c != '') ||
                (parametro.Motivo__c != null && parametro.Motivo__c != '') ||
                (parametro.Item__c != null && parametro.Item__c != '')
              ){
                consulta += ' AND Id IN (SELECT Ordem_servico__c FROM Item_ordem_servico__c WHERE Id != null ';
                if(parametro.Tipo_OS__c != null && parametro.Tipo_OS__c != ''){
                    consulta += ' AND Tipo_OS__c IN(\''+parametro.Tipo_OS__c.replace(',','\',\'')+'\') ';
                }
                if(parametro.Motivo__c != null && parametro.Motivo__c != ''){
                    consulta += ' AND Tipo_item_OS__c IN(\''+parametro.Motivo__c.replace(',','\',\'')+'\') ';
                }
                if(parametro.Item__c != null && parametro.Item__c != ''){
                    consulta += ' AND Item__c IN(\''+parametro.Item__c.replace(',','\',\'')+'\') ';
                }
                consulta += '       )';
            }

            consulta += ' ORDER BY Cliente__c, StartDate ';

            System.debug(LoggingLevel.ERROR, '__ [cls Backlog_OS - getListaOS()] - consulta: '+consulta);

            List<WorkOrder> listaRetorno = database.query(consulta);

            List<WorkOrder> listaEditada = new List<WorkOrder>();
            List<WorkOrder> listaOsSemAcao = new List<WorkOrder>();
            List<WorkOrder> listaQtdForaFaixa = new List<WorkOrder>();
            List<WorkOrder> listaAgendamentoProximoContato = new List<WorkOrder>();
            List<WorkOrder> listaSemAgendamentoAging85Dias = new List<WorkOrder>();
            List<WorkOrder> listaRestante = new List<WorkOrder>();

            for(WorkOrder wo : listaRetorno){

                if(wo.OS_sem_acao__c == true) {
                    listaOsSemAcao.add(wo);
                } else if(wo.Contato_fora_faixa__c == true){
                    listaQtdForaFaixa.add(wo);
                } else if(wo.Proximo_contato__c != null && wo.Proximo_contato__c >= System.today()){
                    listaAgendamentoProximoContato.add(wo);
                } else if(wo.OS_sem_agendamento_aging_85_dias__c == true){
                    listaSemAgendamentoAging85Dias.add(wo);
                } else {
                    listaRestante.add(wo);
                }
            }

            if(listaOsSemAcao.size()>0) listaEditada.addAll(listaOsSemAcao);
            if(listaQtdForaFaixa.size()>0) listaEditada.addAll(listaQtdForaFaixa);
            if(listaAgendamentoProximoContato.size()>0) listaEditada.addAll(listaAgendamentoProximoContato);
            if(listaSemAgendamentoAging85Dias.size()>0) listaEditada.addAll(listaSemAgendamentoAging85Dias);
            if(listaRestante.size()>0) listaEditada.addAll(listaRestante);

            return listaEditada;

        } catch (Exception e){

            System.debug(LoggingLevel.ERROR, '__ [cls Backlog_OS - getListaOS()] - ERRO: '+e.getMessage());
            return new List<WorkOrder>();

        } // Fim try/catch

    } // Fim método getListaOS

}