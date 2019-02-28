/*
	Classe de teste: Teste_Util_LeadT
	Criado por: Mario Reis
	Data de criação: 02/10/2017
	Descrição: Classe com métodos uteis para o objeto Lead
*/
public class Util_Lead {

    // Definição do nome de API dos tipos de registro
    public static String bluetec; // Blue_tec
    public static String CORP; // CORP
    public static String cargoTracck; // Cargo_Tracck
    public static String freteiro; // Freteiro
    public static String mercosul; // Mercosul
    public static String michelin; // Michelin
    public static String siggo; // Siggo

    // Mensagens de regra de validação
    public static String formatoDNI = 'Formato: 00.000.000';
    public static String formatoCUIT = 'Formato: 00-00000000-0';
    public static String pessoaFisicaSoDNI = 'Para pessoa fisica, informe somente o DNI.';
    public static String pessoaJuridicaSoCUIT = 'Para pessoa jurídica, informe somente o CUIT.';
    
    // Metodo que vai chamar consulta no banco e gravar o Id do tipo do registro correspondente
	public static void carregarTipoRegistro(){

		System.debug(LoggingLevel.ERROR, '__ [cls Util_Lead - carregarTipoRegistro()] - Inicio...');

		Map<String, String> mapTipoRegistro = new Map<String, String>();

		try {

			mapTipoRegistro = DAO_Lead.getMapTipoRegistro();

			System.debug(LoggingLevel.ERROR, '__ [cls Util_Lead - carregarTipoRegistro()] - mapTipoRegistro: '+mapTipoRegistro);

			bluetec = mapTipoRegistro.get('Blue_tec');
            CORP = mapTipoRegistro.get('CORP');
            cargoTracck = mapTipoRegistro.get('Cargo_Tracck');
            freteiro = mapTipoRegistro.get('Freteiro');
            mercosul = mapTipoRegistro.get('Mercosul');
            michelin = mapTipoRegistro.get('Michelin');
            siggo = mapTipoRegistro.get('Siggo');

		} catch (Exception e){

			System.debug(LoggingLevel.ERROR, '__ [cls Util_Conta - carregarTipoRegistro()] - ERRO: '+e.getMessage());
			throw new customException(Label.MSG_ERRO_0003);

		} // Fim try/catch

	} // Fim carregarTipoRegistro

}