trigger Opportunity_VerificaAlteracaoAdesaoExecutivo on Opportunity (before update) {
	//public class VerificaAlteracaoAdesaoExecutivo
	if(!Test.isRunningTest()) VerificaAlteracaoAdesaoExecutivo.oppVerificarAlteracaoAdesao(trigger.new[0]);
}