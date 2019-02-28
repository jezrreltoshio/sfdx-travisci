trigger HistoricoLead on Historico_Lead__c (before insert, before update) {
    
     String objeto;

    for(Historico_Lead__c n : trigger.new){
        objeto = n.Lead__c;
    }

    if(objeto != null){
    
        String obj = objeto.substring(0,3);
    
        if(obj == '00Q'){  
            Lead lead = new Lead(id=objeto);
            lead.Data_historico__c = System.Now();
            try{
                update lead;
            }catch(Exception e){
                System.debug('@@ Atualiza_Data_historico ERROR atualizarLead: ' + e.getMessage());
            }
        }
    }
}