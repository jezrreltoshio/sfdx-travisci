trigger Opportunity_VerificaBandeiraCartao on Opportunity (before insert, before update) {
    //Verifica a bandeira do cartão atraves do numero do mesmo e seleciona a bandeira no picklist
	OpportunityBandeiraCartao.setBandeiraCartao(Trigger.new[0]);
}