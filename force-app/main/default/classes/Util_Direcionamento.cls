/*
	Classe de teste: Teste_Util_Direcionamento
	Criado por: Mario Reis
	Data de criação: 20/05/2018
	Descrição: Classe com métodos para a tela de Direcionamento de OS
    ---------------------------------
    @author Renan Rocha
    @date 09/01/2019
    @description:
        - Classe refatorada
        - Novos debugs inseridos
        - Alterado classe de busca no método getStatusOS da classe DAO_Direcionamento_OS para a classe DAO_Status_OS
        - Alterado classe de busca no método getTipoOS da classe DAO_Direcionamento_OS para a classe DAO_Tipo_OS
        - Alterado classe de busca no método getTipoContrato da classe DAO_Direcionamento_OS para a classe DAO_TipoContrato
        - Alterado classe de busca no método getListaMotivo da classe DAO_Direcionamento_OS para a classe DAO_Tipo_Item_OS
    @JIRA KCA-59
*/
global with sharing class Util_Direcionamento {

    private static String CLASS_NAME = 'Util_Direcionamento';

    // Método que retorna se o usuário tem permissão para criar o direcionamento
    webservice static Boolean getStatusCriarDirecionamento(){
        String METHOD_NAME = 'getStatusCriarDirecionamento';

        Boolean retorno = false;
        
        try {
            List<PermissionSetAssignment> conjuntoPerm = DAO_Conjunto_Permissao.getConjPermissaoByUserAssignedIdAndName(UserInfo.getUserId(), 'Acesso_criar_direcionamento');
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - conjuntoPerm: '+ conjuntoPerm);

            if(conjuntoPerm.size() > 0) retorno = true;
            else retorno = false;

            return retorno;
        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());

            return false;
        } // Fim try/catch
    } // Fim getStatusCriarDirecionamento

    // Método que retorna a lista de Status solicitação equipamento para distribuição
    webservice static List<String> getStatusSolicitacaoEquipamento(){
        String METHOD_NAME = 'getStatusSolicitacaoEquipamento';

        List<String> listaRetorno = new List<String>();
        
        try {
            // Busca a lista de Status solicitação equipamento para distribuição do objeto Direcionamento_os__c
            Schema.DescribeFieldResult campos = Direcionamento_os__c.Status_solicitacao_equipamento__c.getDescribe();
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - campos: '+ campos);

            List<Schema.PicklistEntry> ple = campos.getPicklistValues();
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - ple: '+ ple);
            
            for(Schema.PicklistEntry f : ple) listaRetorno.add(f.getValue()+'|'+f.getLabel());
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaRetorno: '+ listaRetorno);

            return listaRetorno;
        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());

            return new List<String>();
        } // Fim try/catch
    } // Fim getStatusSolicitacaoEquipamento

    // Método que retorna a lista de Status da OS
    webservice static List<Status_OS__c> getStatusOS(){
        String METHOD_NAME = 'getStatusOS';

        try {
            // Busca lista de Status da OS
            List<Status_OS__c> listaRetorno = DAO_Status_OS.getListaStatusOS();
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaRetorno: '+ listaRetorno);

            return listaRetorno;
        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());

            return new List<Status_OS__c>();
        } // Fim try/catch
    } // Fim getStatusOS

    // Método que retorna a lista de Ultima ação da OS
    webservice static List<String> getUltimaAcaoOS(){
        String METHOD_NAME = 'getUltimaAcaoOS';

        List<String> listaRetorno = new List<String>();

        try {
            // Busca a lista de ultima ação da OS do objeto Direcionamento_os__c
            Schema.DescribeFieldResult campos = Direcionamento_os__c.Ultima_acao_OS__c.getDescribe();
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - campos: '+ campos);
            
            List<Schema.PicklistEntry> ple = campos.getPicklistValues();
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - ple: '+ ple);

            for(Schema.PicklistEntry f : ple) listaRetorno.add(f.getValue()+'|'+f.getLabel());
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaRetorno: '+ listaRetorno);

            return listaRetorno;
        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());

            return new List<String>();
        } // Fim try/catch
    } // Fim getUltimaAcaoOS

     // Método que retorna a lista de Tipo da OS
    webservice static List<Tipo_OS__c> getTipoOS(){
        String METHOD_NAME = 'getTipoOS';

        try {
            // Busca lista de tipo da OS
            List<Tipo_OS__c> listaRetorno = DAO_Tipo_OS.getListaTipoOS();
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaRetorno: '+ listaRetorno);

            return listaRetorno;
        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());

            return new List<Tipo_OS__c>();
        } // Fim try/catch
    } // Fim getTipoOS

     // Método que retorna a lista de Item
    webservice static List<String> getListaItem(){
        String METHOD_NAME = 'getListaItem';

        List<String> listaRetorno = new List<String>();

        try {
            // Busca a lista de item do objeto Direcionamento_os__c
            Schema.DescribeFieldResult campos = Direcionamento_os__c.Item__c.getDescribe();
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - campos: '+ campos);

            List<Schema.PicklistEntry> ple = campos.getPicklistValues();
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - ple: '+ ple);
            
            for( Schema.PicklistEntry f : ple) listaRetorno.add(f.getValue()+'|'+f.getLabel());
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaRetorno: '+ listaRetorno);

            return listaRetorno;
        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());

            return new List<String>();
        } // Fim try/catch
    } // Fim getListaItem

    // Método que retorna a lista de Tipo de Contrato
    webservice static List<TipoContrato__c> getTipoContrato(){
        String METHOD_NAME = 'getTipoContrato';

        try {
            // Busca lista de tipo de contrato
            List<TipoContrato__c> listaRetorno = DAO_TipoContrato.getListaTipoContrato();
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaRetorno: '+ listaRetorno);

            return listaRetorno;
        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());

            return new List<TipoContrato__c>();
        } // Fim try/catch
    } // Fim getTipoContrato

    // Método que retorna a lista de classe
    webservice static List<String> getListaClasse(){
        String METHOD_NAME = 'getListaClasse';

        List<String> listaRetorno = new List<String>();
        
        try {
            // Busca a lista de classe do objeto Direcionamento_os__c
            Schema.DescribeFieldResult campos = Direcionamento_os__c.Classe__c.getDescribe();
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - campos: '+ campos);
            
            List<Schema.PicklistEntry> ple = campos.getPicklistValues();
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - ple: '+ ple);
            
            for(Schema.PicklistEntry f : ple) listaRetorno.add(f.getValue()+'|'+f.getLabel());
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaRetorno: '+ listaRetorno);

            return listaRetorno;
        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());
            
            return new List<String>();
        } // Fim try/catch
    } // Fim getListaClasse

    // Método que retorna a lista de Motivo de noshow
    webservice static List<String> getMotivoNoshowOS(){
        String METHOD_NAME = 'getMotivoNoshowOS';

        List<String> listaRetorno = new List<String>();

        try {
            // Busca a lista de motivo noshow do objeto Direcionamento_os__c
            Schema.DescribeFieldResult campos = Direcionamento_os__c.Motivo_noshow__c.getDescribe();
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - campos: '+ campos);
            
            List<Schema.PicklistEntry> ple = campos.getPicklistValues();
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - ple: '+ ple);
            
            for(Schema.PicklistEntry f : ple) listaRetorno.add(f.getValue()+'|'+f.getLabel());
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaRetorno: '+ listaRetorno);

            return listaRetorno;
        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());
            
            return new List<String>();
        } // Fim try/catch
    } // Fim getMotivoNoshowOS
    
    // Método que retorna a lista de cliente KA
    webservice static List<String> getClienteKA(){
        String METHOD_NAME = 'getClienteKA';

        List<String> listaRetorno = new List<String>();

        try {
            // Busca a lista de cliente KA do objeto Direcionamento_os__c
            Schema.DescribeFieldResult campos = Direcionamento_os__c.Cliente_KA__c.getDescribe();
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - campos: '+ campos);

            List<Schema.PicklistEntry> ple = campos.getPicklistValues();
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - ple: '+ ple);
            
            for(Schema.PicklistEntry f : ple) listaRetorno.add(f.getValue()+'|'+f.getLabel());
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaRetorno: '+ listaRetorno);

            return listaRetorno;
        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());
            
            return new List<String>();
        } // Fim try/catch
    } // Fim getClienteKA

    // Método que retorna a lista de Motivo conforme item e tipo
    webservice static List<Tipo_item_OS__c> getListaMotivo(String tipoParametro, String itemParametro){
        String METHOD_NAME = 'getListaMotivo';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - tipoParametro: '+ tipoParametro);
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - itemParametro: '+ itemParametro);

        try {
            // Busca lista de tipo de item da OS
            List<Tipo_item_OS__c> listaRetorno = DAO_Tipo_Item_OS.getListaTipoItemOS(tipoParametro, itemParametro);
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaRetorno: '+ listaRetorno);

            return listaRetorno;
        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());

            return new List<Tipo_item_OS__c>();
        } // Fim try/catch
    } // Fim getListaMotivo

    // Método que retorna a lista de Região Comercial
    webservice static List<String> getRegiaoComercial(){
        String METHOD_NAME = 'getRegiaoComercial';

        List<String> listaRetorno = new List<String>();

        try {
            // Busca a lista de cliente KA do objeto Direcionamento_os__c
            Schema.DescribeFieldResult campos = Direcionamento_os__c.Regiao_comercial__c.getDescribe();
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - campos: '+ campos);

            List<Schema.PicklistEntry> ple = campos.getPicklistValues();
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - ple: '+ ple);

            for(Schema.PicklistEntry f : ple) listaRetorno.add(f.getValue()+'|'+f.getLabel());
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaRetorno: '+ listaRetorno);

            return listaRetorno;
        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());

            return new List<String>();
        } // Fim try/catch
    } // Fim getRegiaoComercial

    // Método que retorna a lista de Tipo de OS Macro
    webservice static List<String> getTipoOSMacro(){
        String METHOD_NAME = 'getTipoOSMacro';

        List<String> listaRetorno = new List<String>();

        try {
            // Busca a lista de cliente KA do objeto Direcionamento_os__c
            Schema.DescribeFieldResult campos = Direcionamento_os__c.Tipo_OS_macro__c.getDescribe();
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - campos: '+ campos);

            List<Schema.PicklistEntry> ple = campos.getPicklistValues();
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - ple: '+ ple);

            for( Schema.PicklistEntry f : ple) listaRetorno.add(f.getValue()+'|'+f.getLabel());
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaRetorno: '+ listaRetorno);

            return listaRetorno;
        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());

            return new List<String>();
        } // Fim try/catch
    } // Fim getTipoOSMacro

    // Método que retorna a lista de Tipo de OS Micro
    webservice static List<String> getTipoOSMicro(){
        String METHOD_NAME = 'getTipoOSMicro';

        List<String> listaRetorno = new List<String>();

        try {
            // Busca a lista de cliente KA do objeto Direcionamento_os__c
            Schema.DescribeFieldResult campos = Direcionamento_os__c.Tipo_OS_micro__c.getDescribe();
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - campos: '+ campos);

            List<Schema.PicklistEntry> ple = campos.getPicklistValues();
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - ple: '+ ple);

            for( Schema.PicklistEntry f : ple) listaRetorno.add(f.getValue()+'|'+f.getLabel());
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaRetorno: '+ listaRetorno);

            return listaRetorno;
        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());

            return new List<String>();
        } // Fim try/catch
    } // Fim getTipoOSMicro
}