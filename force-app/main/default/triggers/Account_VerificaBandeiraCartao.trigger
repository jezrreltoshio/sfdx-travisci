trigger Account_VerificaBandeiraCartao on Account (before insert, before update){
    //Verifica a bandeira do cartão atraves do numero do mesmo e seleciona a bandeira no picklist
    AccountBandeiraCartao.setBandeiraCartao(Trigger.new[0]);
}