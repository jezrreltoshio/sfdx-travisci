trigger Contact_CopyAccountData on Contact (before insert) {
    
    Map<Id,Account> acc = new Map<Id,Account>();
    
    // Build account list
    for(Contact con: trigger.new) {
        acc.put(con.accountId,null);
    }
    for (Account ac : [select Id, Phone, TelefoneCelular__c, EMailNFE__c, DadosPF_RG__c, CPF__c, Tipo_de_pessoa__c, 
                       Enderecos_Principal_Logradouro__c, Enderecos_Principal_Numero__c, Enderecos_Principal_Complemento__c, 
                       Enderecos_Principal_Bairro__c, Enderecos_Principal_Cidade__c, Enderecos_Principal_UF__c, Enderecos_Principal_Pais__c, 
                       Enderecos_Principal_CEP__c
                       from Account where id in :acc.keySet()]) {
                           acc.put(ac.Id, ac);
                       }
    
    for (Contact con : Trigger.new) {
        if (con != null) {
            if (con.AccountId != null) {
        
                if (!String.isEmpty(acc.get(con.AccountId).Tipo_de_pessoa__c) && acc.get(con.AccountId).Tipo_de_pessoa__c == 'F-Física'){
                    if (String.isEmpty(con.CPF__c) && !String.isEmpty(acc.get(con.AccountId).CPF__c)){
                        con.CPF__c = acc.get(con.AccountId).CPF__c;
                    }
                    if (String.isEmpty(con.RG__c) && !String.isEmpty(acc.get(con.AccountId).DadosPF_RG__c)){
                        con.RG__c = acc.get(con.AccountId).DadosPF_RG__c;
                    }
                }
                if (String.isEmpty(con.Email) && !String.isEmpty(acc.get(con.AccountId).EmailNFE__c)){
                    con.Email = acc.get(con.AccountId).EmailNFE__c;
                }
                if (String.isEmpty(con.Phone) && !String.isEmpty(acc.get(con.AccountId).Phone)){
                    con.Phone = acc.get(con.AccountId).Phone;
                }
                if (String.isEmpty(con.MobilePhone) && !String.isEmpty(acc.get(con.AccountId).TelefoneCelular__c)){
                    con.MobilePhone = acc.get(con.AccountId).TelefoneCelular__c;
                }
                /*
                if (String.isEmpty(con.MailingStreet) && !String.isEmpty(acc.get(con.AccountId).Enderecos_Principal_Logradouro__c)){
                    con.MailingStreet = acc.get(con.AccountId).Enderecos_Principal_Logradouro__c + ' ' + String.valueOf(acc.get(con.AccountId).Enderecos_Principal_Numero__c) + ' ' + 
                        acc.get(con.AccountId).Enderecos_Principal_Complemento__c + ' ' + acc.get(con.AccountId).Enderecos_Principal_Bairro__c;
                }
                if (String.isEmpty(con.MailingCity) && !String.isEmpty(acc.get(con.AccountId).Enderecos_Principal_Cidade__c)){
                    con.MailingCity = acc.get(con.AccountId).Enderecos_Principal_Cidade__c;
                }
                if (String.isEmpty(con.MailingState) && !String.isEmpty(acc.get(con.AccountId).Enderecos_Principal_UF__c)){
                    con.MailingState = acc.get(con.AccountId).Enderecos_Principal_UF__c;
                }
                if (String.isEmpty(con.MailingCountry) && !String.isEmpty(acc.get(con.AccountId).Enderecos_Principal_Pais__c)){
                    con.MailingCountry = acc.get(con.AccountId).Enderecos_Principal_Pais__c;
                }
                if (String.isEmpty(con.MailingPostalCode) && !String.isEmpty(String.valueOf(acc.get(con.AccountId).Enderecos_Principal_CEP__c))){
                    con.MailingPostalCode = String.valueOf(acc.get(con.AccountId).Enderecos_Principal_CEP__c);
                }
                */
            }
        }
    }
}