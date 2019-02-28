public class attachmentController extends ComponentControllerBase {
 
 public Account accountOpp {get; set;}
 
 //Campos de Oportunidade - Dados Cadastrais
 public Opportunity opp {get; set;}
 public String idOpportunity {get;set;}
 public String pdfName {get;set;}
 
 public String Opportunity_Name {get; set;} 
 public String Opportunity_ExecutivoDeVendas {get; set;} 
 public String Opportunity_Televendas {get;set;}
 public String Opportunity_Indicador {get;set;}
 public String Opportunity_TipoNegociacao {get;set;}
 public String Opportunity_TipoContrato {get;set;}
 
 //Campos de Conta - Dados do Cliente
 public String Account_RazaoSocial {get;set;} 
 public String Account_Cidade_UF {get;set;} 
 public String Account_CEP {get;set;} 
 public String Account_Endereco_Bairro {get;set;}
 public String Account_Complemento {get;set;}
 public String Contact_Email {get;set;} 
 public String Contact_EmailNFE {get;set;} 
 public String Account_CNPJ_CPF {get;set;}
 public String Account_InscricaoEstadual {get;set;} 
 public String Account_Telefone {get;set;} 
 public String Account_NomeDoPai {get;set;} 
 public String Account_NomeDaMae {get;set;} 
 public String Account_RG {get;set;} 
 public String Account_DtNascimento {get;set;}
 
 //Campos para exibir informações de Contato - Pessoas Autorizadas
 public String Contact1_NomeCompleto {get;set;}
 public String Contact1_RG {get;set;}
 public String Contact1_CPF {get;set;}
 public String Contact1_Tel1 {get;set;}
 public String Contact1_Tel2 {get;set;}
 public String Contact1_Tel3 {get;set;}
 public String Contact1_Tel4 {get;set;}
 public String Contact2_NomeCompleto {get;set;}
 public String Contact2_RG {get;set;}
 public String Contact2_CPF {get;set;}
 public String Contact2_Tel1 {get;set;}
 public String Contact2_Tel2 {get;set;}
 public String Contact2_Tel3 {get;set;}
 public String Contact2_Tel4 {get;set;}
 
 //Campos para exibir informações de Contato - Casos de Emergência  
 public String SOS_Contact1_NomeCompleto {get;set;}
 public String SOS_Contact1_RG {get;set;}
 public String SOS_Contact1_CPF {get;set;}
 public String SOS_Contact1_Tel1 {get;set;}
 public String SOS_Contact1_Tel2 {get;set;}
 public String SOS_Contact1_Tel3 {get;set;}
 public String SOS_Contact1_Tel4 {get;set;}
 public String SOS_Contact2_NomeCompleto {get;set;}
 public String SOS_Contact2_RG {get;set;}
 public String SOS_Contact2_CPF {get;set;}
 public String SOS_Contact2_Tel1 {get;set;}
 public String SOS_Contact2_Tel2 {get;set;}
 public String SOS_Contact2_Tel3 {get;set;}
 public String SOS_Contact2_Tel4 {get;set;}
 
 //Campos de Conta SIGGO - Forma de Pagamento
 public String FormaDeCobranca {get;set;}
 public String Boleto_DiaDeVencimento {get;set;}
 public String Debito_Agencia {get;set;}
 public String Debito_Conta {get;set;}
 public String Debito_DiaDeVencimento {get;set;}
 public String Credito_NomeCartao {get;set;}    
 public String Credito_NumeroCartao {get;set;}
 public String Credito_VencimentoCartao {get;set;}
 
 //Campos exibidos apenas no PDF
 public String DataDeCriacao {get;set;} //Campo para armazenar data da geração do termo (Data Atual)
 List<SelectOption> optionTermo = new List<SelectOption>(); // Opções de uso ou não de Adesivo
 public String tipoTermo {get;set;} // Valor selecionado em página exibida antes do PDF
 List<SelectOption> options = new List<SelectOption>(); // Opções de uso ou não de Adesivo
 public String adesivo {get;set;} // Valor selecionado em página exibida antes do PDF
 public String MultaRescisoria {get;set;} //Valor armazenado em Rótulo Personalizado (Armazenado em Rótulo Personalizado)
 
 //Campos de Cotação
 public String Quote_Proposta {get;set;}
 public String Quote_Validade {get;set;}
 public String Quote_DataDeCriacao {get;set;}
 public String Quote_TaxaDeAdesao {get;set;}
 public String Quote_QtdeEquipamentosVendidos {get;set;}
 public String Quote_TotalTaxaDeAdesao {get;set;}
 public String Quote_ValorMensal {get;set;}
 public String Quote_ValorUntMensal {get;set;}
 
 //Campos de Item de Linha da Cotação
 public List<QuoteLineItem> lstQli {get;set;}
 //public String ILQ_Produto {get;set;}
 //public String ILQ_Familia {get;set;}
 //public String ILQ_Prazo {get;set;}
 //public String ILQ_Qtde {get;set;}
 //public String ILQ_ValorMensal {get;set;}
 //public String ILQ_ValorUntMensal {get;set;}
 
 //Campos de Veículo
 public String Veiculo_Marca {get;set;}
 public String Veiculo_Modelo {get;set;}
 public String Veiculo_Placa {get;set;}
 public String Veiculo_Chassi {get;set;}
 public String Veiculo_Ano {get;set;}
 public String Veiculo_Cor {get;set;}
 public String Veiculo_Renavam {get;set;}
 public String Veiculo_Produto {get;set;}
 
 //Construtor
 public attachmentController()
 {
 }
  
}