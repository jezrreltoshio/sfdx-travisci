@isTest
private class CampaignMemberTriggerTest {
 public static Lead createLead() {
  Lead l = new Lead();
  l.RecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Lead' AND Name = 'Siggo'].Id;
  l.FirstName = 'Lead';
  l.LastName = 'Teste';
  l.Company = 'Empresa Teste';
  l.Status = 'Em aberto';
  l.Email = 'teste@teste.com';
  l.Phone = '1122224455';
  l.MobilePhone = '11965439876';
  l.Canal_de_entrada__c = 'Ativo';
  l.LeadSource = 'Internet';
  l.Description = 'Teste';
  
  return l;
 }
 
 public static Campaign createCampaign() {
  Campaign c = new Campaign();
  c.Name = 'Teste';
  
  return c;
 }
 
 static testMethod void AtualizaLeadTest() {
  Lead l = createLead();
  insert l;
  
  Campaign c = createCampaign();
  insert c;
  
  CampaignMember cm = new CampaignMember(LeadId = l.Id, CampaignId = c.Id);
  insert cm;
  
  delete cm;
 }
 
}