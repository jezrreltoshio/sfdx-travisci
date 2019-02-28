/*
    Classe de teste: Teste_Direcionamento_OS
    Criado por: Mario Reis
    Data de criação: 16/04/2018
    Descrição: Classe com métodos para a tela de Direcionamento de OS
    ---------------------------------
    @author Renan Rocha
    @date 08/01/2019
    @description:
        - Classe refatorada
        - Novos debugs inseridos 
        - Alterado classe de busca no método getListaUser da classe DAO_Direcionamento_OS para a classe DAO_Usuario
        - Alterado classe de busca no método getUsuariosDirecionamentoOS da classe DAO_Direcionamento_OS para a classe DAO_Atendente_Direcionamento_OS
        - Alterado classe de busca no método getUserDisponivelDirecionamento da classe DAO_Direcionamento_OS para a classe DAO_Usuario
        - Alterado classe de busca no método pesquisarOS da classe DAO_Direcionamento_OS para a classe DAO_Ordem_Servico
    @JIRA KCA-59
*/
global with sharing class Direcionamento_OS {

    private static String CLASS_NAME = 'Direcionamento_OS';

    // Método que retorna as configurações de direcionamento de OS
    webservice static List<Direcionamento_os__c> getDirecionamentoOS(){
        String METHOD_NAME = 'getDirecionamentoOS';

        try {
            // Busca lista de OS
            List<Direcionamento_os__c> listaRetorno = DAO_Direcionamento_OS.getListaDirecionamentoOS();
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaRetorno: '+ listaRetorno);

            return listaRetorno;
        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());
            
            return new List<Direcionamento_os__c>();
        } // Fim try/catch
    } // Fim getDirecionamentoOS

    // Método que retorna a lista de Usuários para direcionamento
    webservice static List<User> getListaUser(){
        String METHOD_NAME = 'getListaUser';

        try {
            // Busca lista de usuarios
            List<User> listaRetorno = DAO_Usuario.getListaUser();
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaRetorno: '+ listaRetorno);

            return listaRetorno;
        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());

            return new List<User>();
        } // Fim try/catch
    } // Fim getListaUser

    // Método que retorna a configuração selecionada
    webservice static Direcionamento_os__c getConfigDirecionamentoOS(String idDirecionamentoOS){
        String METHOD_NAME = 'getConfigDirecionamentoOS';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - idDirecionamentoOS: '+ idDirecionamentoOS);

        try {
            // Busca configuração do direcionamento de OS pelo Id
            Direcionamento_os__c retorno = DAO_Direcionamento_OS.getDirecionamentoOsById(idDirecionamentoOS);
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - retorno: '+ retorno);

            return retorno;
        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());

            return new Direcionamento_os__c();
        } // Fim try/catch
    } // Fim getConfigDirecionamentoOS

     // Método que retorna a configuração selecionada
    webservice static List<Atendente_Direcionamento_OS__c> getUsuariosDirecionamentoOS(String idDirecionamentoOS){
        String METHOD_NAME = 'getUsuariosDirecionamentoOS';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - idDirecionamentoOS: '+ idDirecionamentoOS);

        try {
            // Busca configuração do direcionamento de OS pelo Id
            List<Atendente_Direcionamento_OS__c> listaRetorno = DAO_Atendente_Direcionamento_OS.getUsuariosSelecionados(idDirecionamentoOS);
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaRetorno: '+ listaRetorno);

            return listaRetorno;
        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());

            return new List<Atendente_Direcionamento_OS__c>();
        } // Fim try/catch
    } // Fim getUsuariosDirecionamentoOS

    // Método que retorna os usuários disponiveis que não estão na configuração
    webservice static List<User> getUserDisponivelDirecionamento(String idUsuariosSelecionados){
        String METHOD_NAME = 'getUserDisponivelDirecionamento';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - idUsuariosSelecionados: '+ idUsuariosSelecionados);

        List<String> listaIdUsuariosSelecionados = new List<String>();

        try {
            

            String[] parserId = idUsuariosSelecionados.split(',');
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - parserId: '+ parserId);
            
            for(String id : parserId) listaIdUsuariosSelecionados.add(id);
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaIdUsuariosSelecionados: '+ listaIdUsuariosSelecionados);

            // Busca configuração do direcionamento de OS pelo Id
            List<User> listaRetorno = DAO_Usuario.getListaUserDisponivel(listaIdUsuariosSelecionados);
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaRetorno: '+ listaRetorno);

            return listaRetorno;
        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());

            return new List<User>();
        } // Fim try/catch
    } // Fim getUserDisponivelDirecionamento

    // Método para salvar a configuração do registro
    webservice static String salvarConfiguracao(String configuracaoRegistro, String usuarios){
        String METHOD_NAME = 'salvarConfiguracao';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - configuracaoRegistro: '+ configuracaoRegistro);
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - usuarios: '+ usuarios);

        // Cria save point para controlar a transação
        Savepoint savePoint = Database.setSavepoint();
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - savePoint: '+ savePoint);

        try {

            Direcionamento_os__c direcionamentoOS = (Direcionamento_os__c) JSON.deserialize(configuracaoRegistro, Direcionamento_os__c.class);
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - direcionamentoOS: '+ direcionamentoOS);

            if(direcionamentoOS.Id != null) {
                update direcionamentoOS;
                
                List<Atendente_Direcionamento_OS__c> listaAtendente = getUsuariosDirecionamentoOS(direcionamentoOS.Id);
                System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaAtendente: '+ listaAtendente);
                
                delete listaAtendente;
            } else insert direcionamentoOS;

            JSONParser parserUsuario = JSON.createParser(usuarios);
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - parserUsuario: '+ parserUsuario);

            List<String> listaIdUsuario = new List<String>();

            while(parserUsuario.nextToken() != null) {

                System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - parserUsuario.getCurrentName(): '+ parserUsuario.getCurrentName());
                System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - parserUsuario.getCurrentToken(): '+ parserUsuario.getCurrentToken());

                if(parserUsuario.getCurrentName() == 'Id') { 
                    parserUsuario.nextToken();
                    listaIdUsuario.add(parserUsuario.getText());
                }
            } // fim while(parserUsuario.nextToken() != null)

            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaIdUsuario: '+ listaIdUsuario);

            List<Atendente_Direcionamento_OS__c> listaAtendente = new List<Atendente_Direcionamento_OS__c>();

            for(String idUsuario : listaIdUsuario){
                Atendente_Direcionamento_OS__c atendenteOS = new Atendente_Direcionamento_OS__c();
                atendenteOS.Direcionamento_OS__c = direcionamentoOS.Id;
                atendenteOS.Usuario__c = idUsuario;
                listaAtendente.add(atendenteOS);
            } // Fim for(String idUsuario : listaIdUsuario)

            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaAtendente: '+ listaAtendente);

            if(listaAtendente.size() > 0) insert listaAtendente;

            Util_Direcionamento_OS.direcionarOS(direcionamentoOS);

            return direcionamentoOS.Id;
        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());

            Database.rollback(savePoint);
            
            return null;
        } // Fim try/catch
    } // Fim salvarConfiguracao

    // Método para salvar a configuração do registro
    webservice static List<WorkOrder> pesquisarOS(String parametrosPesquisa){
        String METHOD_NAME = 'pesquisarOS';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - parametrosPesquisa: '+ parametrosPesquisa);

        try {

            // Faz o parse da String em formado JSON para o objeto Direcionamento_os__c
            Direcionamento_os__c direcionamentoOS = (Direcionamento_os__c) JSON.deserialize(parametrosPesquisa, Direcionamento_os__c.class);
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - direcionamentoOS: '+ direcionamentoOS);

            List<WorkOrder> listaRetorno = new List<WorkOrder>();
            List<String> listaClientes = new List<String>();

            if(direcionamentoOS != null){

                // Se houver quantidade de OS informada, primeiro faz a pesquisa para verificar quais os clientes
                // que atendem essa regra para passar como parametro
                if(direcionamentoOS.Quantidade_OS__c != null && direcionamentoOS.Quantidade_OS__c > 0){
					listaClientes = DAO_Ordem_Servico.filtrarConsultaPorQuantidadeOS(direcionamentoOS);
                    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaClientes: '+ listaClientes);
                    
                    if(listaClientes.size() > 0){
                        listaRetorno = DAO_Ordem_Servico.getListaOS(direcionamentoOS, listaClientes);
                    }
                } else {
                	listaRetorno = DAO_Ordem_Servico.getListaOS(direcionamentoOS, listaClientes);
            	} // Fim if(direcionamentoOS.Quantidade_OS__c != null && direcionamentoOS.Quantidade_OS__c > 0)

            } // if(direcionamentoOS != null)

            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaRetorno: '+ listaRetorno);

            return listaRetorno;
        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());

            return new List<WorkOrder>();
        } // Fim try/catch
    } // Fim salvarConfiguracao
    
    // Método para remover a configuração
    webservice static Boolean removerConfiguracao(String idConfiguracao){
        String METHOD_NAME = 'removerConfiguracao';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - idConfiguracao: '+ idConfiguracao);

        try {

            // Se houver o Id da configuração, remove o registro
            if(idConfiguracao != null && idConfiguracao != ''){
                Direcionamento_os__c registroRemover = new Direcionamento_os__c(Id = idConfiguracao);
                System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - registroRemover: '+ registroRemover);
                
                delete registroRemover;
                return true;
            } else {
                return false;
            } // Fim if(idConfiguracao != null && idConfiguracao != '')
        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());
            return false;
        } // Fim try/catch
    } // Fim removerConfiguracao
}