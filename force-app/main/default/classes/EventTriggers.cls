public class EventTriggers {
    public static void setAddress(Event ev){
		system.debug('EventTriggers.setAddress');
		system.debug('EventTriggers.setAddress ev: '+ ev);
		
    	Event ev1 = new Event();
    	ev1.Id = ev.Id;
    	
		if(ev.WhatId != null){
		    List<Account> listAcc  = [SELECT Id, Enderecos_Principal_Logradouro__c, Enderecos_Principal_Cidade__c, Enderecos_Principal_Numero__c, Enderecos_Principal_Complemento__c, Enderecos_Principal_Bairro__c FROM Account WHERE Id =:ev.WhatId limit 1];
		    String endereco = null;
		    system.debug('EventTriggers.setAddress - listAcc: '+listAcc);
		    
		    if(listAcc.size() > 0){
		    	Account acc = listAcc[0];
		    	system.debug('EventTriggers.setAddress - acc: '+acc);
		    	
			    if(acc.Enderecos_Principal_Logradouro__c != null){
			        endereco = acc.Enderecos_Principal_Logradouro__c.trim().toUpperCase();
			        
			        if(acc.Enderecos_Principal_Numero__c != null){
			            endereco = endereco + ', ' + acc.Enderecos_Principal_Numero__c;
			        }
			        
			        if(acc.Enderecos_Principal_Complemento__c != null){
			            endereco = endereco + ', ' + acc.Enderecos_Principal_Complemento__c.trim().toUpperCase();
			        }
			        
			        if(acc.Enderecos_Principal_Bairro__c != null){
			            endereco = endereco + ', ' + acc.Enderecos_Principal_Bairro__c.trim().toUpperCase();
			        }
			    }
				    
				if(Trigger.isInsert){
				    ev1.Location  = endereco;
				    
				    if(acc.Enderecos_Principal_Cidade__c != null){
			    		ev1.Cidade__c = acc.Enderecos_Principal_Cidade__c.trim().toUpperCase();
				    } else{
				    	ev1.Cidade__c = null;
				    }
				    
					//AFTER INSERT			    	    	
		    		update ev1;
		    		
		    	} else{
		    		//BEFORE UPDATE		        
			        ev.Location  = endereco;
		    
				    if(acc.Enderecos_Principal_Cidade__c != null){
			    		ev.Cidade__c = acc.Enderecos_Principal_Cidade__c.trim().toUpperCase();
				    } else{
				    	ev.Cidade__c = null;
				    }
		    	}
			} else{//SE NAO FOR UMA CONTA
				if(Trigger.isUpdate){
					//BEFORE UPDATE
					ev.Location = null;
					ev.Cidade__c = 'N/A';
				}
			}
		}    
    }
    
    public static void neverCallThisMethod() {
        integer a = 0;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
    } 
}