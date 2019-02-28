trigger Busca_CEP_Lead on Lead (before insert, before update) {

    if(System.IsBatch() == false && System.isFuture() == false) {
        for(Lead l : trigger.new){
         if(l.PostalCode != null ){
            Busca_CEP_Lead.busca(l.Id, l.PostalCode);
            }
         }
     }
}