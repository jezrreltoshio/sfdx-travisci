public class attachmentSendEmailController extends PageControllerBase {
    public String subject { get; set; }
    public String body { get; set; }
    public String tipoTermo { get; set; }
    
    private final Account account;
    private final Opportunity opp;
    
    // Create a constructor that populates the Account object
    public attachmentSendEmailController() {
        opp = [SELECT Id, AccountId, Name, OwnerId, Owner.Name,Owner.Email
               FROM Opportunity
               WHERE id=:ApexPages.currentPage().getParameters().get('id')];
        
        
        account =  [SELECT Name, Owner.Name, AnnualRevenue, NumberOfEmployees,
                    (SELECT Contact.Name, Contact.Email FROM Account.Contacts) 
                    FROM Account
                    WHERE Id = :opp.AccountId];
        
    }
    
    public Account getAccount() {
        return account;
    }
    public Opportunity getOpp() {
        return opp;
    }
    
    public PageReference send() {
        save();
        
        // Define the email
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 
        
        // Reference the attachment page and pass in the account ID
        tipoTermo = ApexPages.currentPage().getParameters().get('tipoTermo');
        PageReference pdf = (tipoTermo == 'Base') ? Page.PDF_Termo_Novo : Page.PDF_Termo_Novo;
        pdf.getParameters().put('id',(String)opp.id); 
        pdf.setRedirect(true);
        
        // Take the PDF content
        Blob b = null;
        if(!Test.isRunningTest()){
            b = pdf.getContent();
        }
        // Create the email attachment
        Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
        efa.setFileName('attachment.pdf');
        efa.setBody(b);
        
        
        String addresses;
        /*if (account.Contacts[0].Email != null) {
addresses = account.Contacts[0].Email;
// Loop through the whole list of contacts and their emails
for (Integer i = 1; i < account.Contacts.size(); i++) {
if (account.Contacts[i].Email != null) {
addresses += ':' + account.Contacts[i].Email;
}
}
}
addresses = '';*/
        addresses = opp.Owner.Email;
        String[] toAddresses = addresses.split(':', 0);
        
        // Sets the paramaters of the email
        email.setSubject( subject );
        //email.setToAddresses( toAddresses );
        email.setToAddresses( toAddresses );
        email.setPlainTextBody( body );
        
        email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
        // Sends the email
        try{
            Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});   
        }catch(Exception e){
            ApexPages.Message mess = new ApexPages.Message(ApexPages.Severity.ERROR,'Erro no processo de envio: \n' + e);
            ApexPages.addMessage(mess);
        }     
        PageReference pageRef = new PageReference('/' + ApexPages.currentPage().getParameters().get('id'));
        return pageRef ;
        
    }
    
    public void save(){
        PageReference pdf = null;
        tipoTermo = ApexPages.currentPage().getParameters().get('tipoTermo');
        if(tipoTermo == 'Base'){
            pdf = Page.PDF_Termo_Novo;
        }else{
            pdf = Page.PDF_Termo_Novo;
        }
        
        // Add parent id to the parameters for standardcontroller
        pdf.getParameters().put('id',(String)opp.id);
        
        // Create the new attachment
        Attachment attach = new Attachment();
        
        // The contents of the attachment from the pdf
        Blob body;
        try{
            // returns the output of the page as a PDF
            body = pdf.getContent();
            // need to pass unit test -- current bug    
        }catch (VisualforceException e) {
            body = Blob.valueOf('Some Text');
        }
        
        attach.Body = body;
        // add the user entered name
        attach.Name = 'Termo ' + this.tipoTermo + ' ' + opp.Name + '.pdf';
        attach.IsPrivate = false;
        // attach the pdf to the account
        attach.ParentId = opp.id;
        insert attach;
        
        Opportunity oppty = [SELECT Id, StageName FROM Opportunity WHERE Id = :opp.id];
        oppty.StageName = 'Aguardando documentação';
        update oppty;
        
    }
    
    public PageReference cancel() {
        //List<Attachment> lstAttachment = [SELECT Id, ParentId FROM Attachment WHERE ParentId = :opp.Id ORDER BY CreatedDate DESC LIMIT 1];
        //delete lstAttachment;
        PageReference pageRef = new PageReference('/' + ApexPages.currentPage().getParameters().get('id'));
        return pageRef ;
    }
    
}