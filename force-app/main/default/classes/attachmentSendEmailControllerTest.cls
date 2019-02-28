/*
    @testClass attachmentSendEmailController
    
    @author Renan Rocha
    @date 12/12/2018
*/

@isTest
public class attachmentSendEmailControllerTest{
    
    static testMethod void myUnitTest() {
        Map<String, sObject> mapBase = Teste_Util.createMapBase();
        Opportunity opp = (Opportunity) mapBase.get('Opportunity');
        opp.StageName = 'Negociação/Proposta';
        update opp;

        //Instancia pagina
        PageReference pageRef;
        pageRef = Page.attachmentSendEmail;
        pageRef.getParameters().put('Id', opp.Id);
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', opp.Id);
        PageControllerBase pageControllerBase = new PageControllerBase();
        attachmentSendEmailController att = new attachmentSendEmailController();
        att.save();
        att.cancel();
        att.send();
    }
}