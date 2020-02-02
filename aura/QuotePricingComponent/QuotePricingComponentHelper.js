({
    getQuoteLineItemList: function(component) {
        var action = component.get('c.getQuoteLineItems');
        action.setParams({ quoteId : component.get("v.recordId") });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS"){ 
                var existe =  component.find("existeItens");
                var naoExiste =  component.find("naoExisteItens");
                if(response.getReturnValue() != null && response.getReturnValue().length > 0){
                    component.set("v.existemItensDeCotacao", true);
                }else{
                    component.set("v.existemItensDeCotacao", false);
                }
                component.set('v.quoteLineItemList', response.getReturnValue());
                
            }else if(state === "ERROR"){
                helper.erroPadrao(component, event, helper, response);
            }
        });
        $A.enqueueAction(action);
    },
    
    getCurrentQuoteRelatedParentId: function (cmp){
        var getCurrentQuoteRelatedParentId = cmp.get("c.pegaParentIdEmissoresSelecionados");
        getCurrentQuoteRelatedParentId.setParams({currentQuoteId : cmp.get("v.recordId")});
        getCurrentQuoteRelatedParentId.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS"){ 
                cmp.set("v.EmissorSelecionadoParentIdList", response.getReturnValue());
                
            } else if(state === "ERROR"){
                helper.erroPadrao(component, event, helper, response);
            }
        });
        $A.enqueueAction(getCurrentQuoteRelatedParentId);
    },
    
    showSpinner : function(component, event, helper) {
        var spinnerMain =  component.find("Spinner");
        $A.util.removeClass(spinnerMain, "slds-hide");
    },
    
    hideSpinner : function(component, event, helper) {
        var spinnerMain =  component.find("Spinner");
        $A.util.addClass(spinnerMain, "slds-hide");
    },
    
    flattenStructure : function(topObject, prefix, toBeFlattened, helper) {
        for (const prop in toBeFlattened) {
            const curVal = toBeFlattened[prop];
            if (typeof curVal === 'object') {
                helper.flattenStructure(topObject, prefix + prop + '_', curVal, helper);
            }
            else {
                topObject[prefix + prop] = curVal;
            }
        }
    },
    tratarRelacionamento : function(response, helper){
        if(response != null){
            response.forEach(row => {
                for(const col in row){
                const curCol = row[col];
                if (typeof curCol === 'object'){
                const newVal = curCol.Id ? ('/' + curCol.Id) : null;
                helper.flattenStructure(row, col + '_', curCol,helper);
                if(newVal === null){
                delete row[col];
            }
                             else{
                             row[col] = newVal;
                             }
                             }
                             }
                             });
        }
    },
    setParametrosGerais : function(component){
        var action_memorial_calculo = [{label: 'Inspecionar Nota', name: 'inspecionar_nota', iconName: 'utility:preview' }];
        var actionPegaStatusDaCotacao = component.get("c.getQuoteStatus");
        actionPegaStatusDaCotacao.setParams({idDaQuote : component.get('v.recordId')});
        actionPegaStatusDaCotacao.setCallback(this, function(response){
            var toastParams = {
                "title": "Atenção!",
                "message": "Ocorreu algo inesperado, por favor tente novamente.",
                "type": "warning",
                "mode" : "dismissible"
            };
            var state = response.getState();
            if(state === "SUCCESS"){
                var resposta = response.getReturnValue();
                if(resposta == true){
                    var actions = [{label: 'Editar', name: 'editar_produto', iconName: 'utility:edit'},{label: 'Clonar', name: 'clonar_produto', iconName: 'utility:copy'}, {label: 'Excluir', name: 'deletar_produto', iconName: 'utility:delete', color: '#006dcc'}];
                }else{
                    var actions = [{label: 'Visualizar', name: 'visualizar_produto', iconName: 'utility:preview' }];
                }
            }
            else if(state === "ERROR"){
                helper.erroPadrao(component, event, helper, response);
                helper.hideSpinner(component, event, helper);
            }
            component.set('v.columnsSugest', [
                    {label: 'Segmento', fieldName: 'registro_Segmento__c', type: 'text',cellAttributes: { alignment: 'left' }},
                    {label: 'Vendedor', fieldName: 'registro_Vendedor__r_Name', type: 'text',cellAttributes: { alignment: 'left' }},
                    {label: 'Cód. Emissor', fieldName: 'registro_Codigo_do_Emissor__c', type: 'text',cellAttributes: { alignment: 'left' }},
                    {label: 'G. Rent.', fieldName: 'registro_Grupo_Rentabilidade__r_Name', type: 'text',cellAttributes: { alignment: 'left' }},
                    {label: 'SKU', fieldName: 'registro_SKU__c', type: 'text',cellAttributes: { alignment: 'left' }},
                    {label: 'Mercado Dest.', fieldName: 'registro_Mercado_Destino__c', type: 'text',cellAttributes: { alignment: 'left' }},
                    {label: 'Part Number do Cliente', fieldName: 'registro_Part_Number_Cliente__c', type: 'text',cellAttributes: { alignment: 'left' }},
                    {label: 'Aço', fieldName: 'registro_Aco__c', type: 'text',cellAttributes: { alignment: 'left' }},
                    {label: 'Produto', fieldName: 'registro_Produto__c', type: 'text',cellAttributes: { alignment: 'left' }},  
                    {label: 'Processo', fieldName: 'registro_Processo__c', type: 'text',cellAttributes: { alignment: 'left' }}, 
                    {label: 'Forma', fieldName: 'registro_Forma__c', type: 'text',cellAttributes: { alignment: 'left' }}, 
                    {label: 'Tratamento Térmico', fieldName: 'registro_Tratamento_Termico__c', type: 'text',cellAttributes: { alignment: 'left' }},
                    {label: 'Acabamento Superficial', fieldName: 'registro_Acabamento_Superficial__c', type: 'text',cellAttributes: { alignment: 'left' }},
                    {label: 'Bitola (mm)', fieldName: 'registro_Bitola_Numerico__c', type: 'number',cellAttributes: { alignment: 'left' }},
                    {label: 'Família do Aço', fieldName: 'registro_Familia_Aco__c', type: 'text',cellAttributes: { alignment: 'left' }},
                    {label: 'Norma', fieldName: 'registro_Norma__c', type: 'text',cellAttributes: { alignment: 'left' }},
                    {label: 'Peça', fieldName: 'registro_Peca__c', type: 'text',cellAttributes: { alignment: 'left' }},
                    {label: 'Sistema', fieldName: 'registro_Sistema__c', type: 'text',cellAttributes: { alignment: 'left' }},
                    {label: 'Sistemista', fieldName: 'registro_Sistemista__c', type: 'text',cellAttributes: { alignment: 'left' }},
                    {label: 'Cliente Final', fieldName: 'registro_Cliente_Final__c', type: 'text',cellAttributes: { alignment: 'left' }},
                    {label: 'Segmento de Mercado', fieldName: 'registro_Segmento_de_Mercado__c', type: 'text',cellAttributes: { alignment: 'left' }},
                    {label: 'Adicional Financeiro', fieldName: 'registro_Adicional_Financeiro__c', type: 'number', typeAttributes:{minimumFractionDigits: "3", maximumFractionDigits: "3"}, cellAttributes: { alignment: 'left' }},
                    {label: 'Condição de Pagamento', fieldName: 'registro_Condicao_de_Pagamento__c', type: 'text',cellAttributes: { alignment: 'left' }}, 
                    {label: 'Preço Líquido', fieldName: 'registro_Preco_Total__c', type: 'currency',cellAttributes: { alignment: 'left' }}, 
                    {label: 'Preco Líquido ZPLQ', fieldName: 'registro_Preco_ZPLQ__c', type: 'currency',cellAttributes: { alignment: 'left' }}, 
                    {label: 'Data Início', fieldName: 'registro_Valido_Desde__c', type: 'date-local', typeAttributes:{month: "2-digit", day: "2-digit"},cellAttributes: { alignment: 'left' }},
                    {label: 'Custo Padrão', fieldName: 'registro_Custo_Padrao__c', type: 'currency',cellAttributes: { alignment: 'left' }},
                    {label: 'Custo Real', fieldName: 'registro_Custo_Real__c', type: 'currency',cellAttributes: { alignment: 'left' }},
                    {label: 'Volume 12 meses (ton)', fieldName: 'registro_Volume_Ultimos_12_Meses__c', type: 'number',cellAttributes: { alignment: 'left' }}, 
                    {label: 'Data Últ. Fat.', fieldName: 'registro_Data_Ultima_Fatura__c', type: 'date-local', typeAttributes:{month: "2-digit", day: "2-digit"},cellAttributes: { alignment: 'left' }},
                    {label: 'Nota Final', fieldName: 'registro_Indice_de_Similaridade__c', type: 'number', cellAttributes: { alignment: 'left' }},
                    {type: 'action',initialWidth: 50, typeAttributes: { rowActions: action_memorial_calculo },cellAttributes: { alignment: 'center'} }
                ]);
                component.set('v.columns', [
                    {label: '', alignment:'center',fieldName: 'Etapa_Finalizacao__c', type: 'boolean',initialWidth: 50, cellAttributes: {alignment: 'center'}},
                    {label: 'Produto', fieldName: 'Produto_Gerdau__c', type: 'text'},
                    {label: 'Processo', fieldName: 'Processo__c', type: 'text'},
                    {label: 'Forma', fieldName: 'Forma__c', type: 'text', initialWidth: 110},
                    {label: 'Aço', fieldName: 'Aco__c', type: 'text', initialWidth: 120},
                    {label: 'Preço/ton', fieldName: 'UnitPrice', type: 'currency',initialWidth: 110, cellAttributes: { alignment: 'left'}},
                    {label: 'Qtde. (ton)', fieldName: 'Quantity', type: 'number',initialWidth: 110, cellAttributes: { alignment: 'left'}},
                    {type: 'action',initialWidth: 50, typeAttributes: { rowActions: actions },cellAttributes: { alignment: 'center'} }
                ]);
                component.set('v.columnsQuoteLineItemAtual', [
                    {label: 'CLIENTE FINAL', fieldName: 'Cliente_Final__c', type: 'text'},
                    {label: 'AÇO', fieldName: 'Aco__c', type: 'text'},
                    {label: 'AÇO REFERÊNCIA', fieldName: 'AcoReferencia__c', type: 'text'},
                    {label: 'PRODUTO', fieldName: 'Produto_Gerdau__c', type: 'text'},
                    {label: 'FORMA', fieldName: 'Forma__c', type: 'text'},
                    {label: 'PROCESSO', fieldName: 'Processo__c', type: 'text'},
                    {label: 'TRAT. TÉRMICO', fieldName: 'Tratamento_Termico__c', type: 'text'},
                    {label: 'ACAB. SUPERFICIAL', fieldName: 'Acabamento_Superficial__c', type: 'text'},
                    {label: 'PEÇA', fieldName: 'Peca__c', type: 'text'},
                    {label: 'SISTEMA', fieldName: 'Sistema__c', type: 'text'},
                    {label: 'SISTEMISTA', fieldName: 'Sistemista__c', type: 'text'},
                    {label: 'PREÇO/TON', fieldName: 'Preco_Liquido__c', type: 'text'}
                ]);
        });
        $A.enqueueAction(actionPegaStatusDaCotacao);
        var actionBuscaCambio = component.get("c.getCambio");
        actionBuscaCambio.setParams({});
        actionBuscaCambio.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                component.set("v.cambioBRLUSD", 1/response.getReturnValue().USD);
                component.set("v.cambioBRLEUR", 1/response.getReturnValue().EUR);
            }
            else if(state === "ERROR"){
                helper.erroPadrao(component, event, helper, response);
                helper.hideSpinner(component, event, helper);
            }
        });
        $A.enqueueAction(actionBuscaCambio);
    },
    
    carregaSistemaPontuacao: function(component, event, helper){
        
        var actionCarregaSistemaPontuacao = component.get("c.carregaSistemaPontuacao");
        actionCarregaSistemaPontuacao.setParams({QuoteId: component.get("v.recordId")});
        actionCarregaSistemaPontuacao.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var resposta = response.getReturnValue();
                if(resposta == null || resposta.length<0){
                    throw new ('Sistema de Pontuação não foi carregado corretamente.');
                }
                else{
                    console.log(resposta);
                    component.set("v.sistemaPontuacao", resposta);
                }
            }
            else if(state === "ERROR"){
                helper.erroPadrao(component, event, helper, response);
            }
        });
        $A.enqueueAction(actionCarregaSistemaPontuacao);
    },
    
    carregaAcoPoliticaPreco: function(component, event, helper){
        var actionCarregaPoliticaPreco = component.get("c.carregaAcoPoliticaPreco");
        actionCarregaPoliticaPreco.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var resposta = response.getReturnValue();
                if(resposta == null || resposta.length<0){
                    throw new ('Aco referência para a política de preço não foi carregado!');
                }
                else{
                    component.set("v.acoPoliticaPreco", resposta);
                }
            }
            else if(state === "ERROR"){
                helper.erroPadrao(component, event, helper, response);
            }
        });
        $A.enqueueAction(actionCarregaPoliticaPreco);
    },
    
    buscaReferenciaInternacional: function(component, event, helper){
        var actionBuscaReferenciaInternacional = component.get("c.buscaReferenciaInternacional");
        actionBuscaReferenciaInternacional.setParams({currentQLI: component.get("v.quoteLineItemEdit")});
        actionBuscaReferenciaInternacional.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS"){
                var resposta = response.getReturnValue();
                if(resposta.length > 0){
                    component.set("v.existeReferenciaInternacional", true);
                    component.set("v.referenciaInternacional", resposta[0]);
                    var semDB = component.get("v.referenciaInternacional.Preco_FOB__c")* 1.25*component.get("v.cambioBRLUSD");
                    var comDB = component.get("v.referenciaInternacional.Preco_FOB__c")* 1.11*component.get("v.cambioBRLUSD");
                    component.set("v.precoInternadoComDrawback", comDB.toFixed(2));
                    component.set("v.precoInternadoSemDrawback", semDB.toFixed(2));
                    var actionSalvaSugestaoReferenciaInternacional = component.get("c.salvaSugestaoReferenciaInternacional");
                    actionSalvaSugestaoReferenciaInternacional.setParams({referenciaInternacional: component.get("v.referenciaInternacional"), 
                                                                          precoInternadoSemDrawback: component.get("v.precoInternadoSemDrawback"), 
                                                                          precoInternadoComDrawback: component.get("v.precoInternadoComDrawback")});
                    actionSalvaSugestaoReferenciaInternacional.setCallback(this, function(response){
                        var state = response.getState();
                        if (state === "SUCCESS"){
                            console.log('ok refint');
                        }
                        else if(state === "ERROR"){
                            helper.erroPadrao(component, event, helper, response);
                        }
                    });
                    $A.enqueueAction(actionSalvaSugestaoReferenciaInternacional);
                }
                else{
                    component.set("v.existeReferenciaInternacional", false); 
                }
                
            }
            else if(state === "ERROR"){
                helper.erroPadrao(component, event, helper, response);
            }
        });
        $A.enqueueAction(actionBuscaReferenciaInternacional);  
    },
    
    montaTabelaReferenciaFinal: function (component, event, helper){
        helper.showSpinner(component, event, helper);
        var actionMontaTabelaReferenciaFinal = component.get("c.getSugestaoPrincipal");
        actionMontaTabelaReferenciaFinal.setParams({currentQLI : component.get("v.quoteLineItemEdit"), currType : component.get("v.quoteRecord.CurrencyIsoCode")});
        actionMontaTabelaReferenciaFinal.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS"){
                var listSugestEscolhida = response.getReturnValue();
                if(listSugestEscolhida != null && listSugestEscolhida.length > 0){
                    helper.tratarRelacionamento(listSugestEscolhida, helper);  
                    component.set('v.dataSugestEscolhida', listSugestEscolhida); 
                    component.set('v.idSugestaoEscolhida', listSugestEscolhida[0].registro_Id);
                }
                helper.montaTabelaQLIAtualFinal(component, helper, listSugestEscolhida);
            }
            else if(state === "ERROR"){
                helper.erroPadrao(component, event, helper, response);
                helper.hideSpinner(component, event, helper);
            }
        });
        $A.enqueueAction(actionMontaTabelaReferenciaFinal);
    },
    
    montaTabelaQLIAtualFinal : function(component, helper, listSugestEscolhida){
        helper.showSpinner(component, event, helper);
        var actionMontaTabelaQLIAtualFinal = component.get("c.getQuoteLineItemPrincipal");
        console.log("Entrou no item de linha principal")
        console.log(listSugestEscolhida[0].registro_Custo_Base_Real__c);
        actionMontaTabelaQLIAtualFinal.setParams({currentQLI : component.get("v.quoteLineItemEdit"), precoBase : listSugestEscolhida[0].registro_Preco_Base__c, custoBase : listSugestEscolhida[0].registro_Custo_Base__c, custoBaseReal : listSugestEscolhida[0].registro_Custo_Base_Real__c, currType : component.get("v.quoteRecord.CurrencyIsoCode")});
        actionMontaTabelaQLIAtualFinal.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS"){
                var resposta = response.getReturnValue();
                if(resposta != null && resposta.length >0){
                    component.set("v.dataQuoteLineItemAtual", resposta);
                    component.set("v.quoteLineItemEdit", resposta[0]);
                }
            }
            else if(state === "ERROR"){
                helper.erroPadrao(component, event, helper, response);
            }
            helper.hideSpinner(component, event, helper);
            component.set("v.isFinalizacaoTabVisible", false);
            component.set('v.isSugestaoTabVisible', false);
            component.set('v.isEdicaoTabVisible', false);
            component.set("v.isAjustesTabVisible", true);
            component.set("v.key","memorialTab");
            $A.get('e.force:refreshView').fire();
        });
        $A.enqueueAction(actionMontaTabelaQLIAtualFinal);
    },
    
    getSugestaoPoliticaPreco : function(component, helper, resposta){
        var actionPoliticaDePreco = component.get("c.getPoliticadePrecoBarraChataRep");
        actionPoliticaDePreco.setParams({currentQLI : component.get("v.quoteLineItemEdit")});
        actionPoliticaDePreco.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS"){
                var resposta = response.getReturnValue();
                if(resposta != null){
                    component.set("v.existeReferenciaBarraChataRep", true);
                    component.set("v.sugestaoEdit", resposta);
                }
                else{
                    component.set("v.existeReferenciaBarraChataRep", false);
                }
                component.set("v.isFinalizacaoTabVisible", false);
                component.set('v.isSugestaoTabVisible', true);
                component.set('v.isEdicaoTabVisible', false);
                component.set("v.isAjustesTabVisible", false);
                component.set("v.key","sugestaoTab");
                helper.hideSpinner(component, event, helper);
            }
            else if(state === "ERROR"){
                helper.erroPadrao(component, event, helper, response);
                helper.hideSpinner(component, event, helper);
            }
        });
        $A.enqueueAction(actionPoliticaDePreco);
    },
    
    validacaoClickToEdicao: function (component, event, helper){
        var okValidacao = true;
        var toastParams = {
            "title": "Atenção!",
            "message": "Ocorreu algo inesperado, por favor tente novamente.",
            "type": "error",
            "mode" : "dismissible"
        };
        let toastEvent = $A.get("e.force:showToast");
        if(component.get("v.quoteRecord.Condicao_de_Pagamento_Lookup__c") == null && component.get("v.quoteRecord.RecordType.DeveloperName") != 'Exportacao'){
            toastParams.message = "Preencha o Código de Pagamento nos detalhes da Cotação.";
            toastEvent.setParams(toastParams);
            toastEvent.fire();
            okValidacao = false;
        }
        return okValidacao;
    },
    
    validacaoClickToSugestao: function (component, event, helper){
        var okValidacao = true;
        var toastParams = {
            "title": "Atenção!",
            "message": "Ocorreu algo inesperado, por favor tente novamente.",
            "type": "error",
            "mode" : "dismissible"
        };
        if(component.get("v.acoPoliticaPreco").includes(component.get("v.quoteLineItemEdit.AcoReferencia__c")) && 
           !(component.get("v.quoteLineItemEdit.Produto_Gerdau__c") == 'Barra' && 
           component.get("v.quoteLineItemEdit.Forma__c") == 'Chato' && 
           component.get("v.quoteLineItemEdit.Cliente_Final__c") == 'Aftermarket')){
            toastParams.message = "Não é permitido um aço para reposição em Barra Chata sem Reposição";
            let toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams(toastParams);
            toastEvent.fire();
            okValidacao = false;
        }
        if(component.get("v.quoteLineItemEdit.Trader__c") != null && component.get("v.quoteLineItemEdit.Custo_Trader__c") == null){
            toastParams.message = "Preencha o campo Custo Trader.";
            let toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams(toastParams);
            toastEvent.fire();
            okValidacao = false;
        }
        if(component.get("v.quoteLineItemEdit.AcoReferencia__c") == null || component.get("v.quoteLineItemEdit.AcoReferencia__c").length < 3){
            toastParams.message = "O campo Aço Interno deve ter no mínimo 3 dígitos.";
            let toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams(toastParams);
            toastEvent.fire();
            okValidacao = false;
        }
        if(component.get("v.quoteLineItemEdit.Produto_Gerdau__c") == null || component.get("v.quoteLineItemEdit.Produto_Gerdau__c") == ""){
            toastParams.message = "Por favor, preencha o campo Produto Gerdau.";
            let toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams(toastParams);
            toastEvent.fire();
            okValidacao = false;
        }
        if(component.get("v.quoteLineItemEdit.Acabamento_Superficial__c") == null || component.get("v.quoteLineItemEdit.Acabamento_Superficial__c") == ""){
            toastParams.message = "Por favor, preencha o campo Acabamento Superficial.";
            let toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams(toastParams);
            toastEvent.fire();
            okValidacao = false;
        }
        if(component.get("v.quoteLineItemEdit.Tratamento_Termico__c") == null || component.get("v.quoteLineItemEdit.Tratamento_Termico__c") == ""){
            toastParams.message = "Por favor, preencha o campo Tratamento Térmico.";
            let toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams(toastParams);
            toastEvent.fire();
            okValidacao = false;
        }
        if(component.get("v.quoteLineItemEdit.Adicional_Financeiro__c") == null){
            toastParams.message = "Por favor, preencha o campo Adicional Financeiro.";
            let toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams(toastParams);
            toastEvent.fire();
            okValidacao = false;
        }
        if(component.get("v.quoteLineItemEdit.Quantity") == null){
            toastParams.message = "Por favor, preencha o campo Volume Potencial.";
            let toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams(toastParams);
            toastEvent.fire();
            okValidacao = false;
        }
        if(component.get("v.quoteLineItemEdit.Lote_Minimo__c") == null){
            toastParams.message = "Por favor, preencha o campo Lote Mínimo.";
            let toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams(toastParams);
            toastEvent.fire();
            okValidacao = false;
        }
        return okValidacao;
        
    },

    validacaoClickToAjustes: function (component, event, helper){
        var okValidacao = true;
        var toastParams = {
            "title": "Atenção!",
            "message": "Ocorreu algo inesperado, por favor tente novamente.",
            "type": "error",
            "mode" : "dismissible"
        };
        let toastEvent = $A.get("e.force:showToast");
        if(component.get("v.isBarraChataRep") && !component.get("v.existeReferenciaBarraChataRep")){
            toastParams.message = "Não existe nenhuma referência de preço para este item!";
            toastEvent.setParams(toastParams);
            toastEvent.fire();
            okValidacao = false;
        }if(!component.get("v.isBarraChataRep") && !component.get("v.existeReferenciaCliente")&& !component.get("v.existeReferenciaClienteQLI") && !component.get("v.existeReferenciaEmissoresSelecionados") && !component.get("v.existeReferenciaGeral") && !component.get("v.existeReferenciaInternacional")){
            toastParams.message = "Não existe nenhuma referência de preço para este item!";
            toastEvent.setParams(toastParams);
            toastEvent.fire();
            okValidacao = false;
        }
        return okValidacao;
    },
    
    validacaoClickToFinalizacao: function (component, event, helper){
        var okValidacao = true;
        var toastParams = {
            "title": "Atenção!",
            "message": "Ocorreu algo inesperado, por favor tente novamente.",
            "type": "error",
            "mode" : "dismissible"
        };
        let toastEvent = $A.get("e.force:showToast");
        if(component.get("v.quoteLineItemEdit.Preco_apos_Ajuste__c") == null || component.get("v.quoteLineItemEdit.Preco_apos_Ajuste__c") == 0){
            toastParams.message = "Preencha o campo Preço Após Ajuste.";
            toastEvent.setParams(toastParams);
            toastEvent.fire();
            okValidacao = false;
        }
        else if(component.get("v.quoteLineItemEdit.Justificativa_Para_Ajuste__c") == null && component.get("v.campoJustificativaObrigatorio")){
            toastParams.message = "Preencha o campo Justificativa para Ajuste.";
            toastEvent.setParams(toastParams);
            toastEvent.fire();
            okValidacao = false;
        }
        return okValidacao;
    },
    
     erroPadrao: function (component, event, helper, response){
        var toastParams = {
            "title": "Atenção!",
            "message": "Ocorreu algo inesperado, por favor tente novamente.",
            "type": "warning",
            "mode" : "dismissible"};
        let error = response.getError();      
        if (error && Array.isArray(error) && error.length > 0) {                        
            toastParams.message =  error[0].message;
        }             
        toastParams.title = "Erro!";
        toastParams.type = "error";
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams(toastParams);
        toastEvent.fire();
    },
    
    setQLIStatus: function(component, event, helper, status){
        if(status == 'sugestao'){
            component.set("v.quoteLineItemEdit.Etapa_Sugestao__c", true);
            component.set("v.quoteLineItemEdit.Etapa_Ajustes__c", false);
            component.set("v.quoteLineItemEdit.Etapa_Finalizacao__c", false);
        }else if(status == 'ajustes'){
            component.set("v.quoteLineItemEdit.Etapa_Sugestao__c", false);
            component.set("v.quoteLineItemEdit.Etapa_Ajustes__c", true);
            component.set("v.quoteLineItemEdit.Etapa_Finalizacao__c", false);
        }else if(status == 'finalizacao'){
            component.set("v.quoteLineItemEdit.Etapa_Sugestao__c", false);
            component.set("v.quoteLineItemEdit.Etapa_Ajustes__c", false);
            component.set("v.quoteLineItemEdit.Etapa_Finalizacao__c", true);
        }else if(status == 'edicao'){
            component.set("v.quoteLineItemEdit.Etapa_Sugestao__c", false);
            component.set("v.quoteLineItemEdit.Etapa_Ajustes__c", false);
            component.set("v.quoteLineItemEdit.Etapa_Finalizacao__c", false);
        }else{
            
        }
        var quoteLineItemEditJSON = JSON.stringify(component.get("v.quoteLineItemEdit"));
        var actionSaveQLI = component.get("c.upsertQuoteLineItem");
        actionSaveQLI.setParams({currentQuoteLineItemJSON : quoteLineItemEditJSON});
        actionSaveQLI.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                component.set("v.quoteLineItemEdit", response.getReturnValue());
            }
            else if(state === "ERROR"){
                helper.erroPadrao(component, event, helper, response);
                helper.hideSpinner(component, event, helper);
            }
        });
        $A.enqueueAction(actionSaveQLI);
            
    }
});