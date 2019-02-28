trigger Busca_CEP_Contato on Contact (before insert, before update) {

    if(System.IsBatch() == false && System.isFuture() == false) {
        for(Contact c : trigger.new){
            if(c.MailingPostalCode != null ){
                Busca_CEP_Contato.busca(c.Id, c.MailingPostalCode );
            }
        }
    }
}