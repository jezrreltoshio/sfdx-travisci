public with sharing class LeadBO {

	public static void convertLead(List<Lead> leads, Map<Id,Lead> leadOldValues){

		for(Lead newLead: leads){

			Lead oldLead = leadOldValues != null && leadOldValues.get(newLead.Id) != null ? 
				leadOldValues.get(newLead.Id) : null;

			if( oldLead != null && !oldLead.isConverted && newLead.isConverted){

				Account acc = LeadAndAccountMapping.getInstance().leadToAccountMapping(newLead, newLead.ConvertedAccountId);
				Contact con = LeadAndAccountMapping.getInstance().leadToContactMapping(newLead, newLead.ConvertedContactId);

				try{
					Update acc;
					Update con;
				}Catch(Exception e){
					System.debug('***Erro: '+e);
				}
			}

		}

	}

}