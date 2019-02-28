trigger HistoricoLead_fillDetails on Historico_Lead__c (before insert, before update) {
    
    Map<String,String> mapNew = new Map<String, String>();
    
    for(Historico_Lead__c hl :trigger.new){
        hl.Data_da_Alteracao__c = datetime.now();
        hl.Usuario__c = UserInfo.getUserId();
    }
}