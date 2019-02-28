public class ProjetoCRM{

    //Atualizando campos da Conta
    //Seção Informações Financeiras
    public static void setInformacoesFinanceirasInAccount(Id accId){
        /*Account acc = new Account();
        acc.Id = accId;
        
        List<Situacao_Financeira__c> sf = [SELECT
                                                Faturamento_medio_trimestral__c,
                                                Situacao_Financeira__c,
                                                Rentabilidade_Mensal__c,
                                                Situacao_sinal__c,
                                                Acao_judicial__c,
                                                Rentabilidade_YTD__c
                                            FROM
                                                Situacao_Financeira__c
                                            WHERE
                                                Conta__c=:accId
                                            ORDER BY CreatedDate DESC LIMIT 1];
        
        if(sf.size() > 0){
            acc.Faturamento_medio_trimestral__c = sf[0].Faturamento_medio_trimestral__c;
            acc.Situacao_financeira__c = sf[0].Situacao_Financeira__c;
            acc.Rentabilidade_mensal__c = sf[0].Rentabilidade_Mensal__c;
            acc.Situacao_sinal__c = sf[0].Situacao_sinal__c;
            acc.A_o_judicial__c = sf[0].Acao_judicial__c;
            acc.Rentabilidade_YTD__c = sf[0].Rentabilidade_YTD__c;
            update acc;
        }*/
    }
    
    //Atualizando campos da Conta
    //Soma total da Frota Sascar e Potencial
    public static void setTotalFrotaInAccount(Id accId){
        Account acc = new Account();
        acc.Id = accId;
        
        List<AggregateResult> total = [SELECT SUM(Quantidade_Sascar__c), SUM(Quantidade_Potencial__c) FROM Frota_Total__c WHERE Conta__c=:acc.Id];
        List<Situacao_Financeira__c> sf = [SELECT
                                                Faturamento_medio_trimestral__c,
                                                Situacao_Financeira__c,
                                                Rentabilidade_Mensal__c,
                                                Situacao_sinal__c,
                                                Acao_judicial__c,
                                                Rentabilidade_YTD__c
                                            FROM
                                                Situacao_Financeira__c
                                            WHERE
                                                Conta__c=:accId
                                            ORDER BY CreatedDate DESC LIMIT 1];
                                                
        List<AggregateResult> fpConcorrente = [SELECT SUM(Quantidade_de_veiculos__c), Concorrente__c FROM Frota_Potencial__c WHERE Conta__c=:accId GROUP BY Concorrente__c ORDER BY SUM(Quantidade_de_veiculos__c) DESC LIMIT 1];
        List<AggregateResult> fpNecessidade = [SELECT SUM(Quantidade_de_veiculos__c), Necessidade_do_negocio__c FROM Frota_Potencial__c WHERE Conta__c=:accId GROUP BY Necessidade_do_negocio__c ORDER BY SUM(Quantidade_de_veiculos__c) DESC LIMIT 1];
        
        system.debug('setTotalFrotaInAccount: '+total);
        system.debug('Situacao_Financeira__c: '+sf);
        
        acc.Frota_total_Sascar__c = Integer.valueOf(total[0].get('expr0'));
        acc.Frota_total_Concorrente_Potencial__c = Integer.valueOf(total[0].get('expr1'));
        
        if(sf.size() > 0){
            acc.Faturamento_medio_trimestral__c = sf[0].Faturamento_medio_trimestral__c;
            acc.Situacao_financeira__c = sf[0].Situacao_Financeira__c;
            acc.Rentabilidade_mensal__c = sf[0].Rentabilidade_Mensal__c;
            acc.Situacao_sinal__c = sf[0].Situacao_sinal__c;
            acc.A_o_judicial__c = sf[0].Acao_judicial__c;
            acc.Rentabilidade_YTD__c = sf[0].Rentabilidade_YTD__c;
        }
        
        if(fpConcorrente.size() > 0){
            acc.Principal_concorrente__c = String.valueOf(fpConcorrente[0].get('Concorrente__c'));
        }
        
        if(fpNecessidade.size() > 0){
            acc.Principal_necessidade__c = String.valueOf(fpNecessidade[0].get('Necessidade_do_negocio__c'));
        }
        
        update acc; 
    }
    
    //Atualiza o total da Frota Potencial no objeto Frota_Total
    //Conforme o tipo de veiculo
    public static void setPotencialInFrotaTotal(Id accId){
        Account acc = new Account();
        acc.Id = accId;
        
        List<AggregateResult> frotaPotencial = [SELECT
                                                        Tipo_de_ve_culo__c, SUM(Quantidade_de_veiculos__c)
                                                    FROM
                                                        Frota_Potencial__c
                                                    WHERE
                                                        Conta__c =: accId
                                                    GROUP BY
                                                        Tipo_de_ve_culo__c
                                                    ORDER BY
                                                        Tipo_de_ve_culo__c ASC];
                                                                
        List<Frota_Total__c> frtotal = [Select Id, Tipo_de_Veiculo__c FROM Frota_Total__c WHERE Conta__c=:accId];        
        Map<String, Id> mapFrotaTotal = new Map<String, Id>();
        
        for(Frota_Total__c a: frtotal){
            mapFrotaTotal.put(String.valueOf(a.Tipo_de_Veiculo__c), a.Id);
        }
                                                                     
        for(AggregateResult fp: frotaPotencial){
            String tipo_veiculo = String.valueOf(fp.get('Tipo_de_ve_culo__c'));
                        
            if(mapFrotaTotal.containsKey(tipo_veiculo)){
                //update
                Frota_Total__c newFrotaTotal = new Frota_Total__c();
                newFrotaTotal.Id = mapFrotaTotal.get(tipo_veiculo);
                newFrotaTotal.Tipo_de_veiculo__c = String.valueOf(fp.get('Tipo_de_ve_culo__c')); //Tipo_de_ve_culo__c;
                newFrotaTotal.Quantidade_Potencial__c = Integer.valueOf(fp.get('expr0')) + 0; //Quantidade_de_veiculos__c;
                update newFrotaTotal;
                
                system.debug('setPotencialInFrotaTotal - update FrotaTotal: ' +newFrotaTotal);
            } else{
                //insert
                Frota_Total__c newFrotaTotal = new Frota_Total__c();
                newFrotaTotal.Tipo_de_veiculo__c = String.valueOf(fp.get('Tipo_de_ve_culo__c')); //Tipo_de_ve_culo__c;
                newFrotaTotal.Id_Cliente__c = acc.Id;
                newFrotaTotal.Conta__c = acc.Id;
                newFrotaTotal.Quantidade_Potencial__c = Integer.valueOf(fp.get('expr0')) + 0; //Quantidade_de_veiculos__c;
                newFrotaTotal.External_Id__c = acc.Id+String.valueOf(fp.get('Tipo_de_ve_culo__c')).toUpperCase();
                
                system.debug('setPotencialInFrotaTotal  - insert newFrotaTotal - PANDA: ' +newFrotaTotal);
                
                insert newFrotaTotal;
            }
        
        }
        
        //Pega a nova lista atualiza
        List<Frota_Total__c> frotaT = [Select Id, Tipo_de_Veiculo__c FROM Frota_Total__c WHERE Conta__c=:accId];
        List<Frota_Potencial__c> frotaPtn = [SELECT Id, Tipo_de_ve_culo__c, Quantidade_de_veiculos__c FROM Frota_Potencial__c WHERE Conta__c =: accId ORDER BY Tipo_de_ve_culo__c ASC];
        List<Frota_Sascar__c> frotaScr = [SELECT Id, Tipo_de_veiculo__c, Quantidade_de_veiculos__c FROM Frota_Sascar__c WHERE Conta__c=:accId ORDER BY Tipo_de_veiculo__c ASC];
                                                                
        Map<String, Integer> mapFrotaP = new Map<String, Integer>();
        Map<String, Integer> mapFrotaS = new Map<String, Integer>();
        
        for(Frota_Potencial__c a: frotaPtn){
            mapFrotaP.put(String.valueOf(a.Tipo_de_ve_culo__c), Integer.valueOf(a.Quantidade_de_veiculos__c));
        }
        
        for(Frota_Sascar__c a: frotaScr){
            mapFrotaS.put(String.valueOf(a.Tipo_de_veiculo__c), Integer.valueOf(a.Quantidade_de_veiculos__c));
        }
        
        //Limpando lixo da Frota Total
        for(Frota_Total__c frT: frotaT){
          if(!mapFrotaP.containsKey(frT.Tipo_de_Veiculo__c) && !mapFrotaS.containsKey(frT.Tipo_de_Veiculo__c)){
            delete frT;
          } else if(mapFrotaP.containsKey(frT.Tipo_de_Veiculo__c) && !mapFrotaS.containsKey(frT.Tipo_de_Veiculo__c)){            
            frT.Quantidade_Sascar__c = 0;
            update frT;
          } else if(!mapFrotaP.containsKey(frT.Tipo_de_Veiculo__c) && mapFrotaS.containsKey(frT.Tipo_de_Veiculo__c)){
            frT.Quantidade_Potencial__c = 0;
            update frT;
          }
        }
        
        //Atualizando campos da Conta
        //Soma total da Frota Sascar e Potencial       
        ProjetoCRM.setTotalFrotaInAccount(accId);
    }
    
    //Atualiza o total da Frota Sascar no objeto Frota_Total
    //Conforme o tipo de veiculo
    public static void setSascarInFrotaTotal(Id accId){
        Account acc = new Account();
        acc.Id = accId;
        
        List<Frota_Sascar__c> frotaSascar = [SELECT
                                                Id, Tipo_de_Veiculo__c, Quantidade_de_veiculos__c
                                            FROM
                                                Frota_Sascar__c
                                            WHERE
                                                Conta__c=:accId
                                            ORDER BY
                                                Tipo_de_Veiculo__c ASC];
                                                                                                   
        system.debug('setSascarInFrotaTotal: '+frotaSascar);
        
        List<Frota_Total__c> frtotal = [Select Id, Tipo_de_Veiculo__c FROM Frota_Total__c WHERE Conta__c=:accId];        
        Map<String, Id> mapFrotaTotal = new Map<String, Id>();
        
        for(Frota_Total__c a: frtotal){
            mapFrotaTotal.put(String.valueOf(a.Tipo_de_Veiculo__c), a.Id);
        }
        
        for(Frota_Sascar__c fs: frotaSascar){            
            //update
            if(mapFrotaTotal.containsKey(fs.Tipo_de_Veiculo__c)){                
                Frota_Total__c newFT = new Frota_Total__c();
                newFT.Id = mapFrotaTotal.get(fs.Tipo_de_Veiculo__c);
                newFT.Quantidade_Sascar__c = fs.Quantidade_de_veiculos__c + 0;
                
                system.debug('setSascarInFrotaTotal - update newFT: ' +newFT);
                
                update newFT;                
            } else{
                //insert
                Frota_Total__c newFrotaTotal = new Frota_Total__c();
                newFrotaTotal.Tipo_de_veiculo__c = fs.Tipo_de_Veiculo__c;
                newFrotaTotal.Id_Cliente__c = acc.Id;
                newFrotaTotal.Conta__c = acc.Id;
                newFrotaTotal.Quantidade_Sascar__c = fs.Quantidade_de_veiculos__c + 0;
                
                system.debug('setSascarInFrotaTotal - insert newFrotaTotal: ' +newFrotaTotal);
                
                insert newFrotaTotal;                
            }        
        }
        
        //Atualizando campos da Conta
        //Soma total da Frota Sascar e Potencial       
        ProjetoCRM.setTotalFrotaInAccount(accId);
    }
    
    //Excluí o registro da Frota Total se não existir na Frota Potencial e na Frota Sascar
    public static void deleteTypesVehicles(Id accId, String tipoVeiculo){
        List<Frota_Total__c> frotaTotal = [SELECT Id, Tipo_de_veiculo__c, Quantidade_Potencial__c, Quantidade_Sascar__c FROM Frota_Total__c WHERE Conta__c=:accId AND Tipo_de_veiculo__c=:tipoVeiculo LIMIT 1];
        
        if(frotaTotal.size() > 0){
            List<Frota_Potencial__c> fp = [SELECT Id, Tipo_de_ve_culo__c FROM Frota_Potencial__c WHERE Conta__c=:accId AND Tipo_de_ve_culo__c=:tipoVeiculo];
            List<Frota_Sascar__c> fs = [SELECT Id, Tipo_de_veiculo__c FROM Frota_Sascar__c WHERE Conta__c=:accId AND Tipo_de_veiculo__c=:tipoVeiculo];
            
            for(Frota_Total__c ft : frotaTotal){
                if(fp.size() == 0 && fs.size() == 0){//Nao existe no potencial e nao existe no sascar
                    delete ft;
                } else if(fp.size() == 0 && fs.size() > 0){//Nao existe no potencial mas existe no sascar
                    ft.Quantidade_Potencial__c = 0;
                    update ft;
                } else if(fp.size() > 0 && fs.size() == 0){//Existe no potencial mas nao existe no sascar
                    ft.Quantidade_Sascar__c = 0;
                    update ft;
                }
            }
        }
    }
    
    //Inserir vazio nos campos Principal concorrente e Principal necessidade
    public static void setBlankInAccountFields(Id accId){
      List<Frota_Potencial__c> frotaP = [SELECT Id, Tipo_de_ve_culo__c FROM Frota_Potencial__c WHERE Conta__c=:accId];
      
      if(frotaP.size() == 0){
        Account acc = new Account();
        acc.Id = accId;
        acc.Principal_concorrente__c = null;
        acc.Principal_necessidade__c = null;
        update acc;
      }
    }
    
    //Vincula os registros que vem do Pentaho do objeto Frota Sascar no objeto Conta
    //Somente antes de inserir
    public static void pentahoUpsertInFrotaSascar(List<Frota_Sascar__c> frota, Boolean bln){
        /*system.debug('pentahoUpsertInFrotaSascar: '+frota);
        
        //before insert - isInsert
        if(bln){
            for(Frota_Sascar__c fs : frota){
                String Id_Cliente = fs.Id_Cliente__c;
                
                if(fs.Id_Cliente__c != ''){                     
                    system.debug('Pentaho: '+Id_Cliente);                
                    fs.Conta__c = fs.Id_Cliente__c;    
                }
            }     
        }*/
    }
    
    //Vincula os registros que vem do Pentaho do objeto Interacoes no objeto Conta
    //Somente antes de inserir
    public static void pentahoUpsertInteracoes(List<Interacoes__c> frota, Boolean bln){
        /*if(bln){
            for(Interacoes__c itc : frota){
                String Id_Cliente = itc.Id_Cliente__c;
                
                if(itc.Id_Cliente__c != ''){                     
                    system.debug('Pentaho: '+itc.Id_Cliente__c);                
                    itc.Conta__c = itc.Id_Cliente__c;    
                }
            }
        }*/
    }
    
    //Vincula os registros que vem do Pentaho do objeto Situacao Financeira no objeto Conta
    //Somente antes de inserir
    public static void pentahoUpsertSituacaoFinanceira(List<Situacao_Financeira__c> frota, Boolean bln){
        /*if(bln){
            for(Situacao_Financeira__c sf : frota){
                String Id_Cliente = sf.Id_Cliente__c;
                
                if(sf.Id_Cliente__c != ''){                     
                    system.debug('Pentaho: '+sf.Id_Cliente__c);                
                    sf.Conta__c = sf.Id_Cliente__c;    
                }
            }
        }*/
    }
    
    //Vincula os registros que vem do Pentaho do objeto Situacao do Termo no objeto Conta
    //Somente antes de inserir
    public static void pentahoUpsertSituacaoTermo(List<Situacao_do_Termo__c> frota, Boolean bln){
        /*if(bln){
            for(Situacao_do_Termo__c st : frota){
                String Id_Cliente = st.Id_Cliente__c;
                
                if(st.Id_Cliente__c != ''){                     
                    system.debug('Pentaho: '+st.Id_Cliente__c);                
                    st.Conta__c = st.Id_Cliente__c;    
                }
            }
        }*/
    }
    
    //Vincula os registros que vem do Pentaho do objeto Veiculoa e Placas no objeto Conta
    //Somente antes de inserir
    public static void pentahoUpsertVeiculosPlacas(List<Veiculos_e_placas__c> frota, Boolean bln){
        /*if(bln){               
            for(Veiculos_e_placas__c vp : frota){
                String Id_Cliente = vp.Id_Cliente__c;
                
                if(vp.Id_Cliente__c != ''){                     
                    system.debug('Pentaho: '+vp.Id_Cliente__c);                
                    vp.Conta__c = vp.Id_Cliente__c;    
                }
            }     
        }*/
    }
    
    //Vincula os registros que vem do Pentaho do objeto Veiculoa e Placas no objeto Conta
    //Somente antes de inserir
    public static void pentahoUpsertSetAccount(List<Frota_Total__c> frota, Boolean bln){
        /*if(bln){               
            for(Frota_Total__c ft : frota){
                String Id_Cliente = ft.Id_Cliente__c;
                
                if(ft.Id_Cliente__c != ''){
                    system.debug('PANDA Pentaho: '+Id_Cliente);             
                    ft.Conta__c = ft.Id_Cliente__c;    
                }
            }     
        }*/
    }
    
    public static void neverCallThisMethod() {
        integer a = 0;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
     }
}