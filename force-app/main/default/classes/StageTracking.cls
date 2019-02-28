public with sharing class StageTracking {

    // Campo adicionado para fazer verificação e não chamar a funcionalidade 2 vezes
    public static Boolean rastreamentoCamposLead = false;
    public static Boolean rastreamentoCamposOportunidade= false;

    public static User usuarioLogado = [SELECT Alias, UserRole.Name FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];

    public static void createOpportunityStageTracking(Map<Id,Opportunity> oppOldMap, List<Opportunity> oppList){

        List<RastreamentoCampos__c> rastrList = [
            SELECT Id, Oportunidade__c, Campo_rastreado__c, Data_atual__c, Data_anterior__c
            FROM RastreamentoCampos__c 
            WHERE Oportunidade__c 
            IN: oppList
            ORDER BY CreatedDate ASC
            LIMIT 50000
        ];

        for(RastreamentoCampos__c r: rastrList){
            System.debug('#####OPP: '+r.Oportunidade__c + ' CAMPO: '+r.Campo_rastreado__c + ' DATA ATUAL: ' +
                r.Data_atual__c + ' DATA ANTIGA: ' +r.Data_anterior__c);
        }

        Map<String,RastreamentoCampos__c> rastrMap = new Map<String,RastreamentoCampos__c>();
        for(RastreamentoCampos__c ost: rastrList){
            rastrMap.put(ost.Oportunidade__c + ost.Campo_rastreado__c, ost);
        }

        for(Opportunity opp: oppList){

            List<RastreamentoCampos__c> rastCampoListInsert = new List<RastreamentoCampos__c>();

            if(oppOldMap == null || oppOldMap.isEmpty()){

                RastreamentoCampos__c rastCampo1 = new RastreamentoCampos__c();
                rastCampo1 = rastrearCampo(
                    rastCampo1,
                    'Fase', 
                    System.now(),
                    opp.StageName,
                    opp.StageName
                );

                RastreamentoCampos__c rastCampo2 = new RastreamentoCampos__c();
                rastCampo2 = rastrearCampo(
                    rastCampo2,
                    'Nome catálogo', 
                    System.now(),
                    opp.Nome_catalogo__c,
                    opp.Nome_catalogo__c
                );

                RastreamentoCampos__c rastCampo3 = new RastreamentoCampos__c();
                rastCampo3 = rastrearCampo(
                    rastCampo3,
                    'Tipo de contrato', 
                    System.now(),
                    opp.Tipo_contrato__c,
                    opp.Tipo_contrato__c
                );

                rastCampo1.Oportunidade__c = opp.Id;
                rastCampo2.Oportunidade__c = opp.Id;
                rastCampo3.Oportunidade__c = opp.Id;
                rastCampoListInsert.add(rastCampo1);
                rastCampoListInsert.add(rastCampo2);
                rastCampoListInsert.add(rastCampo3);

                Try{
                    Insert rastCampoListInsert;
                }Catch(Exception e){
                    opp.addError(e);
                }

                return;

            }

            if( rastrMap != null || !rastrMap.isEmpty() ){

                if( isCurrentDateDiffLastModified(rastrMap,opp,'Fase') && oppOldMap.get(opp.Id).StageName != opp.StageName){

                    RastreamentoCampos__c rastCampo = new RastreamentoCampos__c();

                    rastCampo = rastrearCampo(
                        rastCampo,
                        'Fase', 
                        isBlank(rastrMap,opp,'Fase') || rastrMap.get(opp.Id+'Fase').Data_atual__c == null ? 
                        System.now() : rastrMap.get(Opp.Id+'Fase').Data_atual__c,
                        oppOldMap == null || oppOldMap.isEmpty() || oppOldMap.get(opp.Id).StageName == null ? 
                        opp.StageName : oppOldMap.get(opp.Id).StageName,
                        opp.StageName
                    );

                    rastCampo.Oportunidade__c = opp.Id;
                    rastCampoListInsert.add(rastCampo);

                }

                if( isCurrentDateDiffLastModified(rastrMap,opp,'Nome catálogo') 
                    && oppOldMap.get(opp.Id).Nome_catalogo__c != opp.Nome_catalogo__c){

                    RastreamentoCampos__c rastCampo = new RastreamentoCampos__c();

                    rastCampo = rastrearCampo(
                        rastCampo,
                        'Nome catálogo', 
                        isBlank(rastrMap,opp,'Nome catálogo') || rastrMap.get(opp.Id+'Nome catálogo').Data_atual__c == null ? 
                        System.now() : rastrMap.get(Opp.Id+'Nome catálogo').Data_atual__c,
                        oppOldMap == null || oppOldMap.isEmpty() || oppOldMap.get(opp.Id).Nome_catalogo__c == null ? 
                        opp.Nome_catalogo__c : oppOldMap.get(opp.Id).Nome_catalogo__c,
                        opp.Nome_catalogo__c
                    );

                    rastCampo.Oportunidade__c = opp.Id;
                    rastCampoListInsert.add(rastCampo);

                }

                if( isCurrentDateDiffLastModified(rastrMap,opp,'Tipo de contrato') && 
                    oppOldMap.get(opp.Id).Tipo_contrato__c != opp.Tipo_contrato__c){

                    RastreamentoCampos__c rastCampo = new RastreamentoCampos__c();

                    rastCampo = rastrearCampo(
                        rastCampo,
                        'Tipo de contrato', 
                        isBlank(rastrMap,opp,'Tipo de contrato') || rastrMap.get(opp.Id+'Tipo de contrato').Data_atual__c == null ? 
                        System.now() : rastrMap.get(Opp.Id+'Tipo de contrato').Data_atual__c,
                        oppOldMap == null || oppOldMap.isEmpty() || oppOldMap.get(opp.Id).Tipo_contrato__c == null ? 
                        opp.Tipo_contrato__c : oppOldMap.get(opp.Id).Tipo_contrato__c,
                        opp.Tipo_contrato__c
                    );

                    rastCampo.Oportunidade__c = opp.Id;
                    rastCampoListInsert.add(rastCampo);

                }

                Try{
                    Insert rastCampoListInsert;
                }Catch(Exception e){
                    opp.addError(e);
                }

                // Campo adicionado para fazer verificação e não chamar a funcionalidade 2 vezes
                rastreamentoCamposOportunidade = true;

                return;

            }

        }

    }

    public static void createLeadStageTracking(Map<Id,Lead> leadOldMap, List<Lead> leadList){

        List<RastreamentoCampos__c> rastrList = [
            SELECT Id, Lead__c, Campo_rastreado__c, Data_atual__c, Data_anterior__c
            FROM RastreamentoCampos__c 
            WHERE Lead__c 
            IN: leadList
            ORDER BY CreatedDate ASC
            LIMIT 50000
        ];

        for(RastreamentoCampos__c r: rastrList){
            System.debug('***CAMPO: '+r.Campo_rastreado__c);
            System.debug('***LEAD: '+r.Lead__c);
            System.debug('***DATA ANTERIOR: '+r.Data_anterior__c);
            System.debug('***DATA ATUAL: '+r.Data_atual__c);
        }

        // Mapa de Id de lead com rastreamento de campos
        Map<String,RastreamentoCampos__c> rastrMap = new Map<String,RastreamentoCampos__c>();
        for(RastreamentoCampos__c ost: rastrList){
            rastrMap.put(ost.Lead__c + ost.Campo_rastreado__c, ost);
        }

        // Mapa de Id de tipo de registro de lead com os nomes
        List<RecordType> recordTypes = [SELECT Id,Name FROM RecordType WHERE SobjectType = 'Lead'];
        Map<Id,String> recTypeMap = new Map<Id,String>();
        for(RecordType r: recordTypes){
            recTypeMap.put(r.Id,r.Name);
        }

        // Mapa de Id de usuario com nomes
        List<Lead> leads = [SELECT Id, OwnerId, Owner.Name FROM Lead WHERE Id IN: leadList];
        Map<Id,String> userMap = new Map<Id,String>();
        for(Lead l: leads){
            userMap.put(l.OwnerId,l.Owner.Name);
        }

        // Mapa de Id de usuario com nomes com base nos valores antigos do lead
        if(leadOldMap != null && !leadOldMap.isEmpty()){
            Set<Id> leadSet = new Set<Id>();
            for(Lead l: leadOldMap.values()){
                leadSet.add(l.OwnerId);
            }
            List<User> leadsOld = [SELECT Id, Name FROM User WHERE Id IN: leadSet];
            for(User l: leadsOld){
                userMap.put(l.Id,l.Name);
            }
        }

        for(Lead lead: leadList){

            List<RastreamentoCampos__c> rastCampoListInsert = new List<RastreamentoCampos__c>();

            if( leadOldMap == null || leadOldMap.isEmpty()){

                RastreamentoCampos__c rastCampo1 = new RastreamentoCampos__c();
                rastCampo1 = rastrearCampo(
                    rastCampo1,
                    'Status', 
                    System.now(),
                    lead.Status,
                    lead.Status
                );

                RastreamentoCampos__c rastCampo2 = new RastreamentoCampos__c();
                rastCampo2 = rastrearCampo(
                    rastCampo2,
                    'Tipo de registro Lead', 
                    System.now(),
                    recTypeMap.get(lead.RecordTypeId),
                    recTypeMap.get(lead.RecordTypeId)
                );

                RastreamentoCampos__c rastCampo3 = new RastreamentoCampos__c();
                rastCampo3 = rastrearCampo(
                    rastCampo3,
                    'Motivo desqualificação Lead', 
                    System.now(),
                    lead.Motivo_da_desqualifica_o_do_lead__c,
                    lead.Motivo_da_desqualifica_o_do_lead__c
                );

                RastreamentoCampos__c rastCampo4 = new RastreamentoCampos__c();
                rastCampo4 = rastrearCampo(
                    rastCampo4,
                    'Campanha atual', 
                    System.now(),
                    lead.Campanha__c,
                    lead.Campanha__c
                );

                RastreamentoCampos__c rastCampo5 = new RastreamentoCampos__c();
                rastCampo5 = rastrearCampo(
                    rastCampo5,
                    'Proprietario do lead', 
                    System.now(),
                    userMap.get(lead.OwnerId),
                    userMap.get(lead.OwnerId)
                );

                RastreamentoCampos__c rastCampo6 = new RastreamentoCampos__c();
                rastCampo6 = rastrearCampo(
                    rastCampo6,
                    'Origem do lead', 
                    System.now(),
                    lead.LeadSource,
                    lead.LeadSource
                );

                rastCampo1.lead__c = lead.Id;
                rastCampo2.lead__c = lead.Id;
                rastCampo3.lead__c = lead.Id;
                rastCampo4.lead__c = lead.Id;
                rastCampo5.lead__c = lead.Id;
                rastCampo6.lead__c = lead.Id;
                rastCampoListInsert.add(rastCampo1);
                rastCampoListInsert.add(rastCampo2);
                rastCampoListInsert.add(rastCampo3);
                rastCampoListInsert.add(rastCampo4);
                rastCampoListInsert.add(rastCampo5);
                rastCampoListInsert.add(rastCampo6);

                Try{
                    Insert rastCampoListInsert;
                }Catch(Exception e){
                    lead.addError(e);
                }

                return;
            }

            if(rastrMap != null || !rastrMap.isEmpty()){

                if( isCurrentDateDiffLastModified(rastrMap,lead,'Status') && leadOldMap.get(lead.Id).Status != lead.Status){

                    RastreamentoCampos__c rastCampo = new RastreamentoCampos__c();

                    rastCampo = rastrearCampo(
                        rastCampo,
                        'Status', 
                        isBlank(rastrMap,lead,'Status') || rastrMap.get(lead.Id+'Status').Data_atual__c == null ? 
                        System.now() : rastrMap.get(lead.Id+'Status').Data_atual__c,
                        leadOldMap == null || leadOldMap.isEmpty() || leadOldMap.get(lead.Id).Status == null ? 
                        lead.Status : leadOldMap.get(lead.Id).Status,
                        lead.Status
                    );

                    rastCampo.Lead__c = lead.Id;
                    rastCampoListInsert.add(rastCampo);

                }

                if( isCurrentDateDiffLastModified(rastrMap,lead,'Tipo de registro Lead') && 
                    leadOldMap.get(lead.Id).RecordTypeId != lead.RecordTypeId){

                    RastreamentoCampos__c rastCampo = new RastreamentoCampos__c();

                    rastCampo = rastrearCampo(
                        rastCampo,
                        'Tipo de registro Lead', 
                        isBlank(rastrMap,lead,'Tipo de registro Lead') || 
                            rastrMap.get(lead.Id+'Tipo de registro Lead').Data_atual__c == null ? 
                            System.now() : rastrMap.get(lead.Id+'Tipo de registro Lead').Data_atual__c,
                        leadOldMap == null || leadOldMap.isEmpty() || leadOldMap.get(lead.Id).RecordTypeId == null ? 
                            recTypeMap.get(lead.RecordTypeId) : recTypeMap.get(leadOldMap.get(lead.Id).RecordTypeId),
                        recTypeMap.get(lead.RecordTypeId)
                    );

                    rastCampo.Lead__c = lead.Id;
                    rastCampoListInsert.add(rastCampo);

                }

                if( isCurrentDateDiffLastModified(rastrMap,lead,'Motivo desqualificação Lead') &&
                    leadOldMap.get(lead.Id).Motivo_da_desqualifica_o_do_lead__c != lead.Motivo_da_desqualifica_o_do_lead__c){

                    RastreamentoCampos__c rastCampo = new RastreamentoCampos__c();

                    rastCampo = rastrearCampo(
                        rastCampo,
                        'Motivo desqualificação Lead', 
                        isBlank(rastrMap,lead,'Motivo desqualificação Lead') || 
                            rastrMap.get(lead.Id+'Motivo desqualificação Lead').Data_atual__c == null ? 
                            System.now() : rastrMap.get(lead.Id+'Motivo desqualificação Lead').Data_atual__c,
                        leadOldMap == null || leadOldMap.isEmpty() || leadOldMap.get(lead.Id).Motivo_da_desqualifica_o_do_lead__c == null ? 
                            lead.Motivo_da_desqualifica_o_do_lead__c : leadOldMap.get(lead.Id).Motivo_da_desqualifica_o_do_lead__c,
                        lead.Motivo_da_desqualifica_o_do_lead__c
                    );

                    rastCampo.Lead__c = lead.Id;
                    rastCampoListInsert.add(rastCampo);

                }

                if( isCurrentDateDiffLastModified(rastrMap,lead,'Campanha atual') && 
                    leadOldMap.get(lead.Id).Campanha__c != lead.Campanha__c){

                    RastreamentoCampos__c rastCampo = new RastreamentoCampos__c();

                    rastCampo = rastrearCampo(
                        rastCampo,
                        'Campanha atual',
                        isBlank(rastrMap,lead,'Campanha atual') || rastrMap.get(lead.Id+'Campanha atual').Data_atual__c == null ? 
                        System.now() : rastrMap.get(lead.Id+'Campanha atual').Data_atual__c,
                        leadOldMap == null || leadOldMap.isEmpty() || leadOldMap.get(lead.Id).Campanha__c == null ? 
                        lead.Campanha__c : leadOldMap.get(lead.Id).Campanha__c,
                        lead.Campanha__c
                    );

                    rastCampo.Lead__c = lead.Id;
                    rastCampoListInsert.add(rastCampo);

                }

                /*
                * Aqui uso o campo do lead "Enviado em" por causa de um workflow de atualização de campo que chama a trigger de lead
                * novamente duplicando este registro
                */
                System.debug('***lead.Enviado_Em__c: '+lead.Enviado_Em__c);
                if( isCurrentDateDiffLastModified(rastrMap,lead,'Proprietario do lead') && leadOldMap.get(lead.Id).OwnerId != lead.OwnerId
                    && (lead.Enviado_Em__c == null || lead.Enviado_Em__c.format() != System.now().format())){

                    RastreamentoCampos__c rastCampo = new RastreamentoCampos__c();

                    rastCampo = rastrearCampo(
                        rastCampo,
                        'Proprietario do lead', 
                        isBlank(rastrMap,lead,'Proprietario do lead') || rastrMap.get(lead.Id+'Proprietario do lead').Data_atual__c == null ? 
                        System.now() : rastrMap.get(lead.Id+'Proprietario do lead').Data_atual__c,
                        leadOldMap == null || leadOldMap.isEmpty() || leadOldMap.get(lead.Id).OwnerId == null ? 
                        userMap.get(lead.OwnerId) : userMap.get(leadOldMap.get(lead.Id).OwnerId),
                        userMap.get(lead.OwnerId)
                    );

                    rastCampo.Lead__c = lead.Id;
                    rastCampoListInsert.add(rastCampo);

                }

                if( isCurrentDateDiffLastModified(rastrMap,lead,'Origem do lead') && 
                    leadOldMap.get(lead.Id).LeadSource != lead.LeadSource){

                    RastreamentoCampos__c rastCampo = new RastreamentoCampos__c();

                    rastCampo = rastrearCampo(
                        rastCampo,
                        'Origem do lead', 
                        isBlank(rastrMap, lead, 'Origem do lead') || rastrMap.get(lead.Id+'Origem do lead').Data_atual__c == null ? 
                        System.now() : rastrMap.get(lead.Id+'Origem do lead').Data_atual__c,
                        leadOldMap == null || leadOldMap.isEmpty() || leadOldMap.get(lead.Id).LeadSource == null ? 
                        lead.LeadSource : leadOldMap.get(lead.Id).LeadSource,
                        lead.LeadSource
                    );

                    rastCampo.Lead__c = lead.Id;
                    rastCampoListInsert.add(rastCampo);

                }

                Try{
                    Insert rastCampoListInsert;
                }Catch(Exception e){
                    lead.addError(e);
                }

                // Campo adicionado para fazer verificação e não chamar a funcionalidade 2 vezes
                rastreamentoCamposLead = true;

                return;

            }

        }

    }

    public static RastreamentoCampos__c rastrearCampo(
        RastreamentoCampos__c ost, 
        String campoRastreado, 
        Datetime dataAnterior,
        String valueOldField, 
        String valueNewField
        ){

        ost.Campo_rastreado__c = campoRastreado;
        ost.Data_anterior__c = dataAnterior;
        ost.Data_atual__c = System.now();
        ost.Valor_antigo__c = valueOldField;
        ost.Valor_novo__c = valueNewField;
        ost.Editado_por__c = UserInfo.getUserId();
        ost.Editado_por_papel__c = usuarioLogado.UserRole.Name;
        ost.Editado_por_alias__c = usuarioLogado.Alias;

        return ost;
    }

    public static Boolean isCurrentDateDiffLastModified(Map<String,RastreamentoCampos__c> rastrMap, SObject obj, String field){

        if(rastrMap != null || !rastrMap.isEmpty() || rastrMap.get( (String)obj.get('Id') + field ) != null || 
            rastrMap.get( (String)obj.get('Id') + field).get('Data_atual__c') != (Datetime)obj.get('LastModifiedDate')){
            return true;
        }else{
            return false;
        }

    }

    public static Boolean isBlank(Map<String,RastreamentoCampos__c> rastrMap, SObject obj, String field){

        if(rastrMap == null || rastrMap.isEmpty() || rastrMap.get( (String)obj.get('Id') + field ) == null){
            return true;
        }else{
            return false;
        }

    }
}