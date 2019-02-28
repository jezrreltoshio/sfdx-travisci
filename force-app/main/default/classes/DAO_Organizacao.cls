/*
	Classe de teste: Teste_DAO_Organizacao
	Criado por: Mario Reis
	Data de criação: 31/08/2017
	Descrição: Classe DAO para consultas da Organização
*/
public class DAO_Organizacao {

    // Método que retorna o objeto que armazena os registros da Organização
	public static Organization getOrganizacao(){
        
		System.debug(LoggingLevel.ERROR, '__ [cls DAO_Organizacao - getOrganizacao()] - Inicio...');
        return Database.query('SELECT '+todosCampos()+' FROM Organization');
    } // Fim getOrganizacao


    // Método que retorna todos os campos da Organização, utilizado para adicionar as consultas SOQL
    public static String todosCampos(){

		return  'Id' +
            	', InstanceName '+
            	', IsSandbox '+
            	', Name '+
            	', OrganizationType ';
    } // Fim método todosCampos

}