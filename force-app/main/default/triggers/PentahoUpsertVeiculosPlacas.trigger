trigger PentahoUpsertVeiculosPlacas on Veiculos_e_placas__c (before insert) {
    Boolean b = false;
    List<Veiculos_e_placas__c> frota = Trigger.new;
    
    if(Trigger.isInsert){b = true;}
    ProjetoCRM.pentahoUpsertVeiculosPlacas(frota, b);
}