/*
	Criado por: Mario Reis
	Data de criação: 25/08/2017
	Descrição: Classe com métodos para criar registros relacionados ao Usuário
					para apoio as classes de teste
*/
@isTest
public class Teste_Util_Usuario {

    // Método para retornar o perfil conforme o nome de parametro
    public static Profile getPerfilPorNome(String nomePerfil){

        return [SELECT Id, Name FROM Profile WHERE Name =: nomePerfil];
    } // Fim método getPerfilPorNome


    // Método para retornar o usuário
    public static User criaNovoUsuarioBR(String idPerfil, String userName, Decimal idUsuarioPreCadastro){

        User usuario = new User();
        usuario.alias = 'test123';
        usuario.email = 'test123@noemail.com';
        usuario.emailEncodingKey = 'ISO-8859-1'; 
        usuario.lastName = 'Teste'; 
        usuario.LanguageLocaleKey = 'pt_BR';
		usuario.localeSidKey='pt_BR'; 
        usuario.profileId = idPerfil; 
        usuario.country='Brazil';
        usuario.IsActive =true;
		usuario.timezoneSidKey='America/Sao_Paulo'; 
        usuario.userName=userName;
        usuario.IdUsuarioPreCadastro__c = idUsuarioPreCadastro;

        insert usuario;
        return usuario;
    } // Fim método criaNovoUsuarioBR


}