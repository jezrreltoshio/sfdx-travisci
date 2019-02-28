/*
    Classe de teste: -
    Criado por: Mauricio Alexandre Silva
    Data de criação: 11/01/2016
    Descrição: Trigger para verificar a duplicidade de conta

    ===================================================

    Classe de teste: Teste_Trigger_Conta
    Atualizado por: Mario Reis
    Data da alteração: 24/08/2017
    Descrição: - Controle de execução da Trigger pela configuração personalizada
               - Verificação do usuário que está executando
               - Verificação sendo ennviada para Trigger

*/
/*
 * ATUALMENTE HA VÁRIAS TRIGGER PARA O MESMO OBJETO, COM O TEMPO ISSO SERÁ MODIFICADO E TODAS SERÃO
 * NA TRIGGER "Trigger_Conta"
 * ENQUANTO A ALTERAÇÃO NÃO É REALIZADA, TODOS OS TESTES DAS TRIGGERS ALTERADAS SERÃO NA CLASSE 
 * "Teste_Trigger_Conta" 
 * */
trigger DuplicidadeConta on Account (before insert, before update) {

    /*System.debug(LoggingLevel.ERROR, '__ [trg DuplicidadeConta ] - Inicio...');
    System.debug(LoggingLevel.ERROR, '__ [trg DuplicidadeConta ] - Parametros_ORG__c.getOrgDefaults().Email_usuario_pentaho__c: '+Parametros_ORG__c.getOrgDefaults().Email_usuario_pentaho__c);
    System.debug(LoggingLevel.ERROR, '__ [trg DuplicidadeConta ] - UserInfo.getUserEmail(): '+UserInfo.getUserEmail());

    if(UserInfo.getUserEmail() == Parametros_ORG__c.getOrgDefaults().Email_usuario_pentaho__c) return;
    if(!Triggers__c.getOrgDefaults().Duplicidade_conta__c) return;

    try {

        Boolean executou = Handler_Conta.verificacao(trigger.isBefore, trigger.isAfter, trigger.isInsert, trigger.isUpdate, 
                              trigger.isDelete, trigger.isUndelete, trigger.old, trigger.oldMap,
                              trigger.new, trigger.newMap);

    } catch (Exception e){

        trigger.new[0].addError(e);
    }*/
    
}