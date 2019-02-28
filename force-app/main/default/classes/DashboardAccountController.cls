/**************************************************************************************************************
* 
* @author           Ernani href=<ernani.junior.ext@sascar.com>
* Project:          SASCAR
* 
*
* Changes (Version)
* ------------------------------------- 
*           No.     Date            Author                  Desc       		  Sprint
*           -----   ----------      --------------------    ---------------   -------------
* @version   1.0    2018-06-02      Ernani Junior (EJ)      Class created      8     
*************************************************************************************************************/

public class DashboardAccountController 
{   
	public 	List< DashboardComponent > listaItensDashboard {get;set;}
    
    private final 	Account 	conta			{get;set;}    
    public 			String 		idConta			{get;set;}
    public 			Decimal 	cpfConta		{get;set;}
    public 			Decimal 	cnpjConta		{get;set;}
    
    
    public DashboardAccountController( ApexPages.StandardController stdController ) 
    {
        this.conta 	= ( Account )stdController.getRecord();
        idConta 	= conta.id;
        Account contaConsulta = [SELECT Id, CPF__c, CNPJ__c FROM Account WHERE Id =: idConta];
        
        String cpfContaString	= contaConsulta.CPF__c;
        String cnpjContaString	= contaConsulta.CNPJ__c;
        
        cpfContaString = cpfContaString != null ? cpfContaString.replace('.','').replace('-','') : '0';
        cnpjContaString = cnpjContaString != null ? cnpjContaString.replace('.','').replace('-','').replace('/','') : '0';
        
        cpfConta = cpfContaString != null ? Decimal.valueOf(cpfContaString) : 0;
        cnpjConta = cnpjContaString != null ? Decimal.valueOf(cnpjContaString) : 0;

        System.debug(LoggingLevel.ERROR, 'DashboardAccountController - cpfConta: '+cpfConta);
        System.debug(LoggingLevel.ERROR, 'DashboardAccountController - cnpjConta: '+cnpjConta);
        obterItensDoDashboard();
    }
    
    
    private void obterItensDoDashboard()
    {
        listaItensDashboard = [ SELECT CustomReportId,DashboardId,Id,Name FROM DashboardComponent WHERE Dashboard.DeveloperName = 'Ordem_de_Servico' ];
    }
    
}