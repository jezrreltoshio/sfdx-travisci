trigger Account_FormatPhone on Account (before insert, before update) {
    BCL_HLP_String HLP_String = new BCL_HLP_String();
    
	for(Account ac :Trigger.new){
        if (!String.isEmpty(ac.Phone)){
            ac.Phone = HLP_String.formatPhone(ac.Phone);
        }
        if (!String.isEmpty(ac.Telefone_2__c)){
            ac.Telefone_2__c = HLP_String.formatPhone(ac.Telefone_2__c);
        }
        if (!String.isEmpty(ac.Telefone_3__c)){
            ac.Telefone_3__c = HLP_String.formatPhone(ac.Telefone_3__c);
        }
        if (!String.isEmpty(ac.Telefone_4__c)){
            ac.Telefone_4__c = HLP_String.formatPhone(ac.Telefone_4__c);
        }
        if (!String.isEmpty(ac.TelefoneCelular__c)){
            ac.TelefoneCelular__c = HLP_String.formatPhone(ac.TelefoneCelular__c);
        }
        if (!String.isEmpty(ac.TelefoneComercial__c)){
            ac.TelefoneComercial__c = HLP_String.formatPhone(ac.TelefoneComercial__c);
        }
    }
}