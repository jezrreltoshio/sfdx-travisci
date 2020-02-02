({
    doInit: function (component, event, helper) {
        helper.getQuoteLineItemList(component);
        helper.setParametrosGerais(component);
        helper.carregaSistemaPontuacao(component, event, helper);
        helper.carregaAcoPoliticaPreco(component, event, helper);
        $A.get('e.force:refreshView').fire();
    },
    selectTab : function(component, event, helper) { 
        var selected = component.get("v.key");
        component.find("tabs").set("v.selectedTabId",selected);
    },
    selectResumo : function(component, event, helper){
        component.set("v.activeResumo", true);
        component.set("v.activeEdicao", false);
        component.set("v.activeSugestao", false);
        component.set("v.activeMemorial", false);
        component.set("v.activeFinalizacao", false);
    },
    selectEdicao : function(component, event, helper){
        component.set("v.activeResumo", false);
        component.set("v.activeEdicao", true);
        component.set("v.activeSugestao", false);
        component.set("v.activeMemorial", false);
        component.set("v.activeFinalizacao", false);
    },
    selectSugestao : function(component, event, helper){
        component.set("v.activeResumo", false);
        component.set("v.activeEdicao", false);
        component.set("v.activeSugestao", true);
        component.set("v.activeMemorial", false);
        component.set("v.activeFinalizacao", false);
    },
    selectMemorial : function(component, event, helper){
        component.set("v.activeResumo", false);
        component.set("v.activeEdicao", false);
        component.set("v.activeSugestao", false);
        component.set("v.activeMemorial", true);
        component.set("v.activeFinalizacao", false);
    },
    selectFinalizacao : function(component, event, helper){
        component.set("v.activeResumo", false);
        component.set("v.activeEdicao", false);
        component.set("v.activeSugestao", false);
        component.set("v.activeMemorial", false);
        component.set("v.activeFinalizacao", true);
    },
    handleClickToEdicao : function(component, event, helper){
        var okValidacao = helper.validacaoClickToEdicao(component, event, helper);
        if(okValidacao == true){
            window.scrollTo({
                'behavior': 'smooth',
                'left': 0,
                'top': 230
            });
            helper.showSpinner(component, event, helper);
            var actionNewQLI = component.get("c.createNewItem");
            actionNewQLI.setParams({idDaQuote : component.get("v.recordId"), curIsoCode : component.get("v.quoteRecord.CurrencyIsoCode")});
            actionNewQLI.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    component.set("v.quoteLineItemEdit", response.getReturnValue());
                    component.set('v.isEdicaoTabVisible', true);
                    component.set("v.key","edicaoTab");
                    component.set('v.isAdicionarItemDisabled', true);
                }
                else if(state === "ERROR"){
                    helper.erroPadrao(component, event, helper, response);
                }
                helper.hideSpinner(component, event, helper);
            });
            $A.enqueueAction(actionNewQLI);
        }
        
    },
    handleClickToSugestao : function(component, event, helper){
        var okValidacao = helper.validacaoClickToSugestao(component, event, helper);
        if(okValidacao == true){
            window.scrollTo({
                'behavior': 'smooth',
                'left': 0,
                'top': 230
            });
            helper.showSpinner(component, event, helper);
            helper.setParametrosGerais(component);
            helper.getCurrentQuoteRelatedParentId(component);
            var quoteLineItemEditJSON = JSON.stringify(component.get("v.quoteLineItemEdit"));
            var actionSaveQLI = component.get("c.upsertQuoteLineItem");
            actionSaveQLI.setParams({currentQuoteLineItemJSON : quoteLineItemEditJSON});
            actionSaveQLI.setCallback(this, function(response){
                var state = response.getState();
                if (state === "SUCCESS") {
                    component.set("v.quoteLineItemEdit", response.getReturnValue());
                    var resposta = response.getReturnValue();
                    if(component.get("v.quoteLineItemEdit.Produto_Gerdau__c") == 'Barra' && component.get("v.quoteLineItemEdit.Forma__c") == 'Chato' && component.get("v.quoteLineItemEdit.Cliente_Final__c") == 'Aftermarket'){
                        component.set("v.isBarraChataRep", true);
                        helper.getSugestaoPoliticaPreco(component, helper, resposta);
                    }else{
                        component.set("v.isBarraChataRep", false);
                        var actionMontaSugestaoReferenciaPreco = component.get("c.buscaTabelasDePrecosReferencia");
                        actionMontaSugestaoReferenciaPreco.setParams({acoSugerido: component.get("v.quoteLineItemEdit.AcoReferencia__c"), 
                                                                      grIdList: component.get("v.quoteRecord.Opportunity.Account.ParentId"),
                                                                      grIdEmissoresSelecionados: component.get("v.EmissorSelecionadoParentIdList"),
                                                                      filtroSugest : component.find("toggleButton").get("v.checked"),
                                                                      currentQLI: component.get("v.quoteLineItemEdit"),
                                                                      sistemaPontuacao: component.get("v.sistemaPontuacao"),
                                                                      acoPoliticaPreco: component.get("v.acoPoliticaPreco")});
                        actionMontaSugestaoReferenciaPreco.setCallback(this, function(response){
                            var state = response.getState();
                            if (state === "SUCCESS"){
                                var resposta = response.getReturnValue();
                                console.log(resposta.notaAcimaDe80);
                                if(resposta.notaAcimaDe80){
                                    component.find('overlayLib').showCustomModal({
                                        header: "Atenção!",
                                        body: "Sugestões com alta pontuação foram identificadas. Isto pode significar que este item de cotação já esteja em fornecimento.", 
                                        showCloseButton: true,
                                        closeCallback: function(ovl) {
                                        }
                                    }).then(function(overlay){
                                    });
                                }
                                if(resposta.listaSugestoesCliente != null && resposta.listaSugestoesCliente.length > 0){
                                    helper.tratarRelacionamento(resposta.listaSugestoesCliente, helper);
                                    component.set('v.existeReferenciaCliente', true);
                                    component.set('v.dataSugest', resposta.listaSugestoesCliente);
                                }else{
                                    component.set('v.existeReferenciaCliente', false);
                                }
                                if(resposta.listaSugestoesQLI != null && resposta.listaSugestoesQLI.length > 0){
                                    helper.tratarRelacionamento(resposta.listaSugestoesQLI, helper);
                                    component.set('v.existeReferenciaClienteQLI', true);
                                    component.set('v.dataSugestQLI', resposta.listaSugestoesQLI);
                                }else{
                                    component.set('v.existeReferenciaClienteQLI', false);
                                }
                                if(resposta.listaSugestoesEmissores != null && resposta.listaSugestoesEmissores.length > 0){
                                    helper.tratarRelacionamento(resposta.listaSugestoesEmissores, helper);
                                    component.set('v.existeReferenciaEmissoresSelecionados', true);
                                    component.set('v.dataSugestConcorr', resposta.listaSugestoesEmissores);
                                }else{
                                    component.set('v.existeReferenciaEmissoresSelecionados', false);
                                }
                                if(resposta.listaSugestoesGerais != null && resposta.listaSugestoesGerais.length > 0){
                                    helper.tratarRelacionamento(resposta.listaSugestoesGerais, helper);
                                    component.set('v.existeReferenciaGeral', true);
                                    component.set('v.dataSugestGeral', resposta.listaSugestoesGerais);
                                }else{
                                    component.set('v.existeReferenciaGeral', false);
                                }
                                if(resposta.idSugestaoEscolhida != null && resposta.idSugestaoEscolhida != ''){
                                    component.set('v.selectedRows', resposta.idSugestaoEscolhida);
                                }
                                /*if(resposta.sugestaoEscolhida != null && resposta.sugestaoEscolhida.length > 0){
                                    component.set('v.sugestaoEdit', resposta.sugestaoEscolhida[0].registro);
                                    helper.tratarRelacionamento(resposta.sugestaoEscolhida, helper);  
                                    component.set('v.dataSugestEscolhida',  resposta.sugestaoEscolhida); 
                                    component.set('v.idSugestaoEscolhida', resposta.sugestaoEscolhida[0].registro_Id);
                                }*/
                                if(component.get('v.existeReferenciaGeral') || 
                                   component.get('v.existeReferenciaEmissoresSelecionados') || 
                                   component.get('v.existeReferenciaClienteQLI') || 
                                   component.get('v.existeReferenciaCliente')){
                                    component.set('v.showCustoEngenharia', false);
                                    component.set('v.isSugestaoTabVisible', true);
                                    component.set("v.key","sugestaoTab");
                                    component.set('v.isEdicaoTabVisible', false);
                                }
                                else{
                                    component.set('v.showCustoEngenharia', true);
                                    var message = 'Não foram encontradas referências para o Aço Referência '+component.get("v.quoteLineItemEdit.AcoReferencia__c")+'. Por favor insira outro Aço Referência e o respectivo custo (sem acabamento e sem tratamento térmico).';
                                    var toastParams = {
                                        "title": "Atenção!",
                                        "message": message,
                                        "type": "error",
                                        "mode" : "dismissible",
                                        "duration" : 30000
                                    };
                                    let toastEvent = $A.get("e.force:showToast");
                                    toastEvent.setParams(toastParams);
                                    toastEvent.fire();
                                    $A.util.addClass(component.find('acoReferencia'), 'layout-destacado');
                                    $A.util.addClass(component.find('acoReferencia'), 'slds-form-element_stacked');
                                    $A.util.addClass(component.find('custoEngenharia'), 'layout-destacado');
                                    $A.util.removeClass(component.find('custoEngenharia'), 'slds-hide');
                                }
                            }
                            else if(state === "ERROR"){
                                helper.erroPadrao(component, event, helper, response);
                                
                            }
                            helper.hideSpinner(component, event, helper);
                        });
                        $A.enqueueAction(actionMontaSugestaoReferenciaPreco);
                        helper.buscaReferenciaInternacional(component, event, helper);
                    }
                }
                else if(state === "ERROR"){
                    helper.erroPadrao(component, event, helper, response);
                    helper.hideSpinner(component, event, helper);
                }
            });
            $A.enqueueAction(actionSaveQLI);
        }
    },
    
    handleClickToMemorial : function(component, event, helper){
        var okValidacao = helper.validacaoClickToAjustes(component, event, helper);
        if(okValidacao == true){
            window.scrollTo({
                'behavior': 'smooth',
                'left': 0,
                'top': 230
            });
            if(!component.get("v.isBarraChataRep")){
                console.log("entrou")
                helper.montaTabelaReferenciaFinal(component, event, helper);
                //helper.montaTabelaQLIAtualFinal(component, helper, component.get("v.dataSugestEscolhida"));
            }else{
                component.set("v.quoteLineItemEdit.Sugestao_de_Preco__c", component.get("v.sugestaoEdit.Preco_Total__c"));
                component.set("v.quoteLineItemEdit.Preco_ADF__c", component.get("v.sugestaoEdit.Preco_ADF__c"));
                component.set("v.quoteLineItemEdit.Preco_Base__c", component.get("v.sugestaoEdit.Preco_ZPLQ__c"));
                if(component.get("v.quoteLineItemEdit.Preco_apos_Ajuste__c") == null){
                    component.set("v.quoteLineItemEdit.Preco_apos_Ajuste__c", component.get("v.quoteLineItemEdit.Sugestao_de_Preco__c"));
                }
                component.set("v.isFinalizacaoTabVisible", false);
                component.set('v.isSugestaoTabVisible', false);
                component.set('v.isEdicaoTabVisible', false);
                component.set("v.isAjustesTabVisible", true);
                component.set("v.key","memorialTab");
                helper.setQLIStatus(component, event, helper, 'ajustes');
            }
        }
    },
    
    handleClickToFinalizacao : function(component, event, helper){
        var okValidacao = helper.validacaoClickToFinalizacao(component, event, helper);
        if(okValidacao == true){
             window.scrollTo({
                'behavior': 'smooth',
                'left': 0,
                'top': 230
            });
            if(!component.get("v.isBarraChataRep")){
                var cambioQuoteLineItem = component.get("v.quoteLineItemEdit.CurrencyIsoCode") == 'BRL' ? 1.0000 : component.get("v.quoteLineItemEdit.CurrencyIsoCode") == 'USD'? component.get("v.cambioBRLUSD"):component.get("v.cambioBRLEUR");
                component.set("v.quoteLineItemEdit.Margem_2__c", (component.get("v.quoteLineItemEdit.Custo_Total__c") != 0 ? ((component.get("v.quoteLineItemEdit.Preco_apos_Ajuste__c") - component.get("v.quoteLineItemEdit.Custo_Total__c"))/component.get("v.cambioBRLUSD")*(cambioQuoteLineItem)).toFixed(2) : 0));
                component.set("v.quoteLineItemEdit.UnitPrice", component.get("v.quoteLineItemEdit.Preco_apos_Ajuste__c"));
            }
            component.set("v.key","finalizacaoTab"); // value assignation
            component.set("v.isAjustesTabVisible", false);
            component.set("v.isFinalizacaoTabVisible", true);
            helper.setQLIStatus(component, event, helper, 'finalizacao');
        }
    },
    
    handleClickToResumo : function(component, event, helper){
        window.scrollTo({
            'behavior': 'smooth',
            'left': 0,
            'top': 230
        });
        component.set("v.key","resumoTab");
        component.set('v.isFinalizacaoTabVisible', false);
        component.set("v.quoteLineItemEdit", null);
        component.set('v.isAdicionarItemDisabled', false);
        helper.getQuoteLineItemList(component);
    },
    
    handleClickBackToEdicao : function(component, event, helper){
        window.scrollTo({
            'behavior': 'smooth',
            'left': 0,
            'top': 230
        });
        component.set('v.isEdicaoTabVisible', true);
        component.set('v.dataSugest', null);
        component.set('v.dataSugestConcorr', null);
        component.set('v.dataSugestGeral', null);
        component.set('v.dataSugestEscolhida', null);
        component.set('v.listaReferenciasMasterList', null);
        component.set('v.selectedRows', null);
        component.set("v.key","edicaoTab"); // value assignation
        component.set('v.isSugestaoTabVisible', false);
        component.set('v.existeReferenciaGeral', false);
        component.set('v.existeReferenciaEmissoresSelecionados', false);
        component.set('v.existeReferenciaClienteQLI', false);
        component.set('v.existeReferenciaCliente', false);
        component.set('v.existeReferenciaBarraChataRep', false);
        helper.setQLIStatus(component, event, helper, 'edicao');
        var actionDeletaSugestoesDePrecoAntigas = component.get("c.deletaSugestoesAntigas");
        actionDeletaSugestoesDePrecoAntigas.setParams({currentQLI: component.get("v.quoteLineItemEdit")});
        actionDeletaSugestoesDePrecoAntigas.setCallback(this, function(response){
            var state = response.getState();
            var resposta = response.getReturnValue();
            if(state === 'SUCCESS'){
                
            }else if(state === "ERROR"){
                helper.erroPadrao(component, event, helper, response);
            }
        });
        $A.enqueueAction(actionDeletaSugestoesDePrecoAntigas);
    },
    
    handleClickBackToMemorial : function(component, event, helper){
        window.scrollTo({
            'behavior': 'smooth',
            'left': 0,
            'top': 230
        });
        if(!component.get("v.isBarraChataRep")){
            helper.montaTabelaReferenciaFinal(component, event, helper);
        }else{
            component.set("v.isFinalizacaoTabVisible", false);
            component.set('v.isSugestaoTabVisible', false);
            component.set('v.isEdicaoTabVisible', false);
            component.set("v.isAjustesTabVisible", true);
            component.set("v.key","memorialTab");
            helper.setQLIStatus(component, event, helper, 'ajustes');
        }
    },
    
    handleClickBackToSugestao : function(component, event, helper){
        window.scrollTo({
            'behavior': 'smooth',
            'left': 0,
            'top': 230
        });
        component.set("v.key", "sugestaoTab");
        component.set("v.isSugestaoTabVisible", true);
        component.set("v.isAjustesTabVisible", false);
        helper.setQLIStatus(component, event, helper, 'sugestao');
    },
    handleClickBackToResumo : function(component, event, helper){
        component.set("v.quoteLineItemEdit", null);
        component.set("v.key","resumoTab"); 
        component.set('v.isEdicaoTabVisible', false);
        component.set('v.showCustoEngenharia', false);
        component.set('v.isAdicionarItemDisabled', false);
        helper.getQuoteLineItemList(component);
        $A.get('e.force:refreshView').fire();
    },
    setQuoteLineItem: function(component, event, helper){
        helper.showSpinner(component, event, helper);
        component.set("v.quoteLineItemEdit", null);
        component.set("v.dataSugest", null);
        component.set("v.dataSugestConcorr", null);
        component.set("v.dataSugestGeral", null);
        component.set("v.dataSugestQLI", null);
        var toastParams = {
            "title": "Atenção!",
            "message": "Ocorreu algo inesperado, por favor tente novamente.",
            "type": "warning",
            "mode" : "dismissible"};
        var eventValue = event.getParam("quoteLineItemEdit");
        component.set("v.quoteLineItemEdit", eventValue);
        component.set("v.isBarraChataRep", (eventValue.Produto_Gerdau__c == 'Barra' && eventValue.Cliente_Final__c == 'Aftermarket' && eventValue.Forma__c == 'Chato'));
        console.log(component.get("v.isBarraChataRep"));
        if(eventValue.Etapa_Ajustes__c || eventValue.Etapa_Finalizacao__c || eventValue.Etapa_Sugestao__c){
            var actionSelecionaTodasSugestoesDoItem = component.get("c.selecionaSugestoesExistentes");
            actionSelecionaTodasSugestoesDoItem.setParams({currentQLI : component.get("v.quoteLineItemEdit")});
            actionSelecionaTodasSugestoesDoItem.setCallback(this, function(response){
                var state = response.getState();
                if (state === "SUCCESS"){
                    var resposta = response.getReturnValue();
                    if(resposta != null){
                        if(resposta.listaSugestoesCliente != null && resposta.listaSugestoesCliente.length > 0){
                            helper.tratarRelacionamento(resposta.listaSugestoesCliente, helper);
                            component.set('v.existeReferenciaCliente', true);
                            component.set('v.dataSugest', resposta.listaSugestoesCliente);
                        }else{
                            component.set('v.existeReferenciaCliente', false);
                        }
                        if(resposta.listaSugestoesQLI != null && resposta.listaSugestoesQLI.length > 0){
                            helper.tratarRelacionamento(resposta.listaSugestoesQLI, helper);
                            component.set('v.existeReferenciaClienteQLI', true);
                            component.set('v.dataSugestQLI', resposta.listaSugestoesQLI);
                        }else{
                            component.set('v.existeReferenciaClienteQLI', false);
                        }
                        if(resposta.listaSugestoesEmissores != null && resposta.listaSugestoesEmissores.length > 0){
                            helper.tratarRelacionamento(resposta.listaSugestoesEmissores, helper);
                            component.set('v.existeReferenciaEmissoresSelecionados', true);
                            component.set('v.dataSugestConcorr', resposta.listaSugestoesEmissores);
                        }else{
                            component.set('v.existeReferenciaEmissoresSelecionados', false);
                        }
                        if(resposta.listaSugestoesGerais != null && resposta.listaSugestoesGerais.length > 0){
                            helper.tratarRelacionamento(resposta.listaSugestoesGerais, helper);
                            component.set('v.existeReferenciaGeral', true);
                            component.set('v.dataSugestGeral', resposta.listaSugestoesGerais);
                        }else{
                            component.set('v.existeReferenciaGeral', false);
                        }
                        if(resposta.sugestaoPoliticaBarraChataRep != null && resposta.sugestaoPoliticaBarraChataRep.Id != null){
                            component.set('v.existeReferenciaBarraChataRep', true);
                            component.set('v.sugestaoEdit', resposta.sugestaoPoliticaBarraChataRep);
                        }else{
                            component.set('v.existeReferenciaBarraChataRep', false);
                        }
                        if(resposta.idSugestaoEscolhida != null && resposta.idSugestaoEscolhida != ''){
                            component.set('v.selectedRows', resposta.idSugestaoEscolhida);
                        }
                    }
                    if(eventValue.Etapa_Sugestao__c){
                        component.set('v.isSugestaoTabVisible', true);
                        component.set("v.key","sugestaoTab");
                        component.set('v.isEdicaoTabVisible', false);
                        component.set('v.isAjustesTabVisible', false);
                        component.set('v.isFinalizacaoTabVisible', false);
                    }else if(eventValue.Etapa_Ajustes__c){
                        if(!component.get("v.isBarraChataRep")){
                            helper.montaTabelaReferenciaFinal(component, event, helper);
                        }
                        component.set('v.isAjustesTabVisible', true);
                        component.set("v.key","memorialTab");
                        component.set('v.isEdicaoTabVisible', false);
                        component.set('v.isFinalizacaoTabVisible', false);
                    }else if(eventValue.Etapa_Finalizacao__c){
                        component.set('v.isFinalizacaoTabVisible', true);
                        component.set("v.key","finalizacaoTab");
                        component.set('v.isEdicaoTabVisible', false);
                        component.set('v.isAjustesTabVisible', false);
                        component.set('v.isSugestaoTabVisible', false);
                    }
                    helper.hideSpinner(component, event, helper);
                }
                else if(state === "ERROR"){
                    helper.erroPadrao(component, event, helper, response);
                }
                $A.get('e.force:refreshView').fire();
                helper.hideSpinner(component, event, helper);
            });
            $A.enqueueAction(actionSelecionaTodasSugestoesDoItem);
            helper.buscaReferenciaInternacional(component, event, helper);
        }else{
            component.set('v.isEdicaoTabVisible', true);
            component.set("v.key","edicaoTab"); 
            component.set('v.isEditingExistingItem', true);
            helper.hideSpinner(component, event, helper);
        }
    },
    handleShowModal: function(component){
        $A.createComponent("c:modalConfirmationWindow", {},
                           function(content, status) {
                               if (status === "SUCCESS") {
                                   var modalBody = content;
                                   component.find('overlayLib').showCustomModal({
                                       header: "Você deseja excluir o item?",
                                       body: modalBody, 
                                       showCloseButton: false,
                                       closeCallback: function(ovl) {
                                       }
                                   }).then(function(overlay){
                                   });
                               }
                           });
    },
    atualizarPagina: function(component, event, helper){
        helper.getQuoteLineItemList(component);        
        $A.get('e.force:refreshView').fire();
    },
    showSpinner : function(component, event, helper) {
        helper.showSpinner(component, event, helper);
    },
    hideSpinner : function(component, event, helper) {
        helper.hideSpinner(component, event, helper);
    },
    
    handleRecordUpdated: function (component, event, helper){
        if(component.get("v.quoteLineItemEdit.Preco_apos_Ajuste__c") == component.get("v.quoteLineItemEdit.Sugestao_de_Preco__c")){
            component.set("v.campoJustificativaObrigatorio", false);
        }
        else{
            component.set("v.campoJustificativaObrigatorio", true);
        }
        component.find('recordLoader').reloadRecord(true); 
        var stats = component.get("v.quoteRecord.Status");
        if(stats != "Em Elaboração"){
            component.set("v.isAdicionarItemDisabled", true);
            component.set("v.isBackToMemorialDisabled", true);
            var actions = [
                { label: 'Visualizar', name: 'visualizar_produto' }
            ];
        }else{
            component.set("v.isAdicionarItemDisabled", false);
            component.set("v.isBackToMemorialDisabled", false);
            var actions = [
                { label: 'Editar', name: 'editar_produto' },
                { label: 'Excluir', name: 'deletar_produto' }
            ];
        }
    },
    
    handleSugestaoRowAction: function (component, event, helper){
        helper.showSpinner(component, event, helper);
        var action = event.getParam('action');
        var row = event.getParam('row');
        var actionQuerySugestao = component.get("c.querySugestao");
        actionQuerySugestao.setParams({sugestaoId: row.registro_Id});
        actionQuerySugestao.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS"){
                var sugestao = response.getReturnValue();
                $A.createComponent("c:MemorialSugestao", {"quoteLineItemEdit" : component.get("v.quoteLineItemEdit"),
                                                          "sugestaoAtual" : sugestao
                                                         },
                                   function(content, status) {
                                       if (status === "SUCCESS") {
                                           var modalBody = content;
                                           component.find('overlayLib').showCustomModal({
                                               header: "Composição do Índice de Similaridade",
                                               body: modalBody, 
                                               showCloseButton: true,
                                               closeCallback: function(ovl) {
                                               }
                                           }).then(function(overlay){
                                           });
                                       }
                                   });
            }
            else if(state === "ERROR"){
                helper.erroPadrao(component, event, helper, response);
            }
            helper.hideSpinner(component, event, helper);
        });
        $A.enqueueAction(actionQuerySugestao);
        
    },
    getCambios: function (component, event, helper){
        component.set("v.quoteLineItemEdit.CambioEURBRL__c", component.get("v.cambioBRLUSD").toFixed(4));
        component.set("v.quoteLineItemEdit.CambioUSDBRL__c", component.get("v.cambioBRLEUR").toFixed(4));
    },
    
    changeStateAplicacaoSection : function changeState (component){ 
        var elemento = component.find('aplicacaoSection');
        $A.util.toggleClass(elemento, 'slds-is-open');
    },
    changeStatePrecificacaoSection : function changeState (component){ 
        var elemento = component.find('precificacaoSection');
        $A.util.toggleClass(elemento, 'slds-is-open');
    },
    changeStateDetalhesSection : function changeState (component){ 
        var elemento = component.find('detalhesSection');
        $A.util.toggleClass(elemento, 'slds-is-open');
    },
    changeStateSugestaoDePrecoSection : function changeState (component){ 
        var elemento = component.find('sugestaoDePrecoSection');
        $A.util.toggleClass(elemento, 'slds-is-open');
    },
    changeStateItemAtualSection : function changeState (component){ 
        var elemento = component.find('itemAtualSection');
        $A.util.toggleClass(elemento, 'slds-is-open');
    },
    changeStateAjusteFinalSection : function changeState (component){ 
        var elemento = component.find('ajusteFinalSection');
        $A.util.toggleClass(elemento, 'slds-is-open');
    },
    changeStateReferenciasDePrecoClienteSection : function changeState (component){ 
        var elemento = component.find('referenciasDePrecoClienteSection');
        $A.util.toggleClass(elemento, 'slds-is-open');
    },
    changeStateReferenciasDePrecoItemDaCotacaoSection : function changeState (component){ 
        var elemento = component.find('referenciasDePrecoItemDaCotacaoSection');
        $A.util.toggleClass(elemento, 'slds-is-open');
    },
    changeReferenciasDePrecoEmissoresSelecionadosSection : function changeState (component){ 
        var elemento = component.find('referenciasDePrecoEmissoresSelecionadosSection');
        $A.util.toggleClass(elemento, 'slds-is-open');
    },
    changeStateReferenciasDePrecoGeraisSection : function changeState (component){ 
        var elemento = component.find('referenciasDePrecoGeraisSection');
        $A.util.toggleClass(elemento, 'slds-is-open');
    },
    changeStateReferenciasDePrecoInternacionaisSection : function changeState (component){ 
        var elemento = component.find('referenciasDePrecoInternacionaisSection');
        $A.util.toggleClass(elemento, 'slds-is-open');
    },
    changeStateMargem2Section : function changeState (component){ 
        var elemento = component.find('margem2Section');
        $A.util.toggleClass(elemento, 'slds-is-open');
    },
    changeStateMargem2RealSection : function changeState(component){
        var elemento = component.find('margem2RealSection');
        $A.util.toggleClass(elemento, 'slds-is-open');
    },
    changeStatePoliticaPreco : function changeState(component){
		var elemento = component.find('sugestaoBarraChataReposicaoSection');
		$A.util.toggleClass(elemento, 'slds-is-open');        
    },
    changeStateReferenciasDePrecoBarraChataRepSection : function changeState(component){
		var elemento = component.find('referenciasDePrecoBarraChataRepSection');
		$A.util.toggleClass(elemento, 'slds-is-open');        
    }
    
});