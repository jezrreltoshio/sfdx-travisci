trigger Busca_CEP_Conta on Account (before insert, before update) {

    /*if(System.IsBatch() == false && System.isFuture() == false) {
        for(Account acc : trigger.new){
            if(acc.Enderecos_Principal_CEP__c != null ){
                Busca_CEP_Conta.busca(acc.Id, acc.Enderecos_Principal_CEP__c );
            }
        
            if(acc.Enderecos_Cobranca_CEP__c != null ){
                Busca_CEP_Conta1.busca(acc.Id, acc.Enderecos_Cobranca_CEP__c );
            }
            
            if(acc.Enderecos_Entrega_CEP__c != null ){
                Busca_CEP_Conta2.busca(acc.Id, acc.Enderecos_Entrega_CEP__c );
            }
        }
    }*/
}