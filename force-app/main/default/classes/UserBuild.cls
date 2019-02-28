@isTest
public class UserBuild {
	
	@isTest 
	public static User newUser() {

		Id adminProfileId = [
            SELECT Id 
            FROM Profile 
            WHERE UserType = 'Standard' 
            AND PermissionsAuthorApex = true 
            ORDER BY CreatedDate ASC LIMIT 1
        ].Id;

		User usuario = new User(
            Alias = 'standt',
            Email='sascarTestclass@sascar.com.test',
            EmailEncodingKey='UTF-8',
            LastName='Testing',
            LanguageLocaleKey='en_US',
            LocaleSidKey='en_US',
            ProfileId = adminProfileId,
            TimeZoneSidKey='America/Los_Angeles',
            UserName='sascarTestclass@sascar.com.test',
            IdUsuarioPreCadastro__c = 1241420351
        );
        return usuario;
	}
	
}