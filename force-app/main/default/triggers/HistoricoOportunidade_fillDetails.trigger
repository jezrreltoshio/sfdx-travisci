trigger HistoricoOportunidade_fillDetails on Historico_Oportunidade__c (before insert, before update) {
    
    for(Historico_Oportunidade__c h :trigger.new){
        h.Data_da_Alteracao__c = datetime.now();
        h.Usuario__c = UserInfo.getUserId();
    }
}