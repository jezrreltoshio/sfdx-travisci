trigger QuoteLineItem_PreenchePrazo on QuoteLineItem (before insert, before update) {
 
 QuoteLineItemTriggers.PreenchePrazo(Trigger.new);
 
}