public without sharing class CaseBO {
    
    
    public static void isCaseHasComments(List<Case> caseList, Map<Id,Case> caseOldValue ){
        
        ProcessorControl.isRecursiveCommentVerif = true; //[rbsilva] - 20180910 - Garantir que esse método não será chamado duas vezes para uma única inserção ou atualização.
        
        List<CaseComment> commList = [SELECT Id, ParentId FROM CaseComment WHERE ParentId IN: caseList];
        
        List<RecordType> recTypeList = [SELECT Id FROM RecordType WHERE DeveloperName = 'Juridico' OR DeveloperName = 'Procon'];
        
        Group filaAtendimento = new Group();
        
        filaAtendimento = [SELECT Id, Name, Type FROM Group WHERE Name = 'ATENDIMENTO' AND Type = 'Queue'];
        
        List<GroupMember> gmList = [
            SELECT UserOrGroupId, GroupId
            FROM GroupMember 
            WHERE GroupId IN (
                SELECT Id FROM Group WHERE DeveloperName = 'OUVIDORIA2')
        ];

        Set<Id> ouvidoriaUsers = new Set<Id>();
        for(GroupMember gm: gmList){
            ouvidoriaUsers.add(gm.UserOrGroupId);
            ouvidoriaUsers.add(gm.GroupId);
        }
        
        Set<Id> recTypes = new Set<Id>(); //rbsilva 20180906 - Serve pra alguma coisa esse set?
        for(RecordType rt: recTypeList){
            recTypes.add(rt.Id);
        }
        
        Map<Id,Id> commentMap = new Map<Id,Id>();
        for(CaseComment cc: commList){
            commentMap.put(cc.ParentId,cc.Id);
        }

        String usuarioAntigo; 
        
        for(Case c: caseList){

            if(caseOldValue != null && caseOldValue.get(c.Id) != null && 
                caseOldValue.get(c.Id).OwnerId != null){
                usuarioAntigo = caseOldValue.get(c.Id).OwnerId;
            }
            
            System.debug('Valor de Registro_inserido__c: '+c.Registro_inserido__c);
            // Apenas usuario da ouvidoria tem que adicionar comentarios no caso antes de transferir
            if( Trigger.isUpdate &&
                ouvidoriaUsers.contains(UserInfo.getUserId()) && 
                !ouvidoriaUsers.contains(c.OwnerId) && 
                usuarioAntigo != null && usuarioAntigo != c.OwnerId &&
                commentMap.get(c.Id) == null &&
                c.Registro_inserido__c == true
              ){
                c.addError('Para alterar o proprietário deste caso adicione pelo menos um comentário');
                return;
              }else{
                  c.Registro_inserido__c = true;
              }      
           
        }       
    }

    public static void setStatusEmAndamento(List<Case> caseList, Map<Id,Case> caseOldValue ){

        RecordType rcMexico = [SELECT Id, DeveloperName FROM RecordType WHERE DeveloperName = 'Mexico' AND SObjectType = 'Case'];
        
        Id filaOuvidoriaId = [SELECT Id FROM Group WHERE DeveloperName = 'Ouvidoria2'].Id;

        Id usuarioAntigo;

        for(Case c: caseList){

            if(caseOldValue != null && caseOldValue.get(c.Id) != null && 
                caseOldValue.get(c.Id).OwnerId != null && c.RecordTypeId != rcMexico.Id){
                usuarioAntigo = caseOldValue.get(c.Id).OwnerId;
            }

            if(usuarioAntigo != null && usuarioAntigo == filaOuvidoriaId && usuarioAntigo != c.OwnerId && c.RecordTypeId != rcMexico.Id){
                c.Status = 'Em andamento';
            }
        }
    }
    
    public static void whatQueueIsUser(List<Case> cases){
        
        Set<Id> ownerIds = new Set<Id>();
        for(Case c: cases){
            ownerIds.add(c.OwnerId);
        }

        System.debug('***ownerIds: '+ownerIds);
        
        List<GroupMember> gMembers = [
            SELECT UserOrGroupId, Group.Name 
            FROM GroupMember 
            WHERE GroupId 
            IN (
                SELECT QueueId FROM QueueSobject WHERE SobjectType = 'Case' 
            )
        ];

        System.debug('***gMembers: '+gMembers);
        
        List<User> profileNames = [SELECT Id, Profile.Name FROM User WHERE Id IN: ownerIds ];

        System.debug('***profileNames: '+profileNames);
        
        Map<Id,String> mapProfile = new Map<Id,String>();
        for(User p: profileNames){
            mapProfile.put(p.Id,p.Profile.Name);
        }

        System.debug('***mapProfile: '+mapProfile);
        
        Map<Id,String> queueMap = new Map<Id,String>();
        Map<Id,String> mapFila = new Map<Id,String>();
        for(GroupMember gm: gMembers){
            if( !gm.Group.Name.contains('N2') && !gm.Group.Name.contains('N3') && !gm.Group.Name.contains('N4') &&
                !gm.Group.Name.contains('N5')){
                queueMap.put(gm.UserOrGroupId,gm.Group.Name);
                mapFila.put(gm.GroupId,gm.Group.Name);
            }
        }

        System.debug('***queueMap: '+queueMap);
        System.debug('***mapFila: '+mapFila);
        
        for(Case c: cases){
            String owner = c.OwnerId;
            if( mapProfile != null && mapProfile.get(c.OwnerId) != null && mapProfile.get(c.OwnerId) == 'Ouvidoria' ){
                System.debug('***mapProfile.get(c.OwnerId): '+mapProfile.get(c.OwnerId));
                c.Departamento__c = 'OUVIDORIA';
            }
            else if( !String.isEmpty(owner) && owner.substring(0,3) == '00G' ){
                System.debug('***mapFila.get(owner): '+mapFila.get(owner));
                c.Departamento__c = mapFila.get(owner);
            }
            else if( c.Departamento__c != queueMap.get( c.OwnerId ) ){
                System.debug('***queueMap.get( c.OwnerId ): '+queueMap.get( c.OwnerId ));
                c.Departamento__c = queueMap.get( c.OwnerId );
            }
        }      
    }
    
    public static void searchAccount(List<Case> cases, Map<Id,Case> caseOldValue ){
        RecordType rcMexico = [SELECT Id, DeveloperName FROM RecordType WHERE DeveloperName = 'Mexico' AND SObjectType = 'Case'];
        Map<String,String> cpfMap = new Map<String,String>();
        String cnpjCpfAntigo; 
        
        for(Case c: cases){
            
            if(caseOldValue != null && caseOldValue.get(c.Id) != null && caseOldValue.get(c.Id).CNPJ_CPF__c != null && c.RecordTypeId != rcMexico.Id){
                cnpjCpfAntigo = caseOldValue.get(c.Id).CNPJ_CPF__c;
            }
            
            if(c.CNPJ_CPF__c != null && cnpjCpfAntigo != c.CNPJ_CPF__c && c.RecordTypeId != rcMexico.Id){
                if(c.CNPJ_CPF__c.length() == 11){
                    cpfMap.put(c.CNPJ_CPF__c, BCL_HLP_String.formatCPF(c.CNPJ_CPF__c));
                }
                if(c.CNPJ_CPF__c.length() == 14){
                    cpfMap.put(c.CNPJ_CPF__c, BCL_HLP_String.formatCNPJ(c.CNPJ_CPF__c));
                }
            }else if(c.CNPJ_CPF__c == null && c.RecordTypeId != rcMexico.Id){
                //c.AccountId = null;
                return;
            }
        }

        System.debug('***cpfMap: '+cpfMap);
        
        if(cpfMap.isEmpty()){
            return;
        }
        
        Map<String,Id> contasMap = new Map<String,Id>();
        List<Account> contas = [
            SELECT Id, CNPJ__c, CPF__c
            FROM Account 
            WHERE CNPJ__c IN: cpfMap.values() OR CPF__c IN: cpfMap.values() 
            ORDER BY LastModifiedDate DESC
            LIMIT 1
        ];

        System.debug('***contas: '+contas);
        
        for(Account a: contas){
            contasMap.put(a.CNPJ__c, a.Id);
            contasMap.put(a.CPF__c, a.Id);
        }
        
        for(Case c: cases){
            if( contasMap.get(cpfMap.get(c.CNPJ_CPF__c)) != null ){
            	c.AccountId = contasMap.get(cpfMap.get(c.CNPJ_CPF__c));
            }
        }
    
    }
    
    public static void fillFieldDeadLineForResponse(List<Case> cases, Map<Id, Case> caseOldValue){
        
        RecordType rcMexico = [SELECT Id, DeveloperName FROM RecordType WHERE DeveloperName = 'Mexico' AND SObjectType = 'Case'];
        
        Id businessHoursId = [SELECT Id FROM BusinessHours WHERE Name = 'Atendimento casos'].Id;

        Datetime startDate;

        String motivoAntigo; 

        for(Case c: cases){

            if(caseOldValue != null && caseOldValue.get(c.Id) != null && 
                caseOldValue.get(c.Id).MotivoReclamacao__c != null && c.RecordTypeId != rcMexico.Id){
                motivoAntigo = caseOldValue.get(c.Id).MotivoReclamacao__c;
            }

            if( Trigger.isInsert ){
                startDate = System.now();
            }else{
                startDate = c.CreatedDate;
            }

            if( (motivoAntigo == null || motivoAntigo != c.MotivoReclamacao__c) && c.RecordTypeId != rcMexico.Id){

                // 30 horas comerciais após criação do caso em milisegundos
                c.PrazoConclusaoResposta__c = BusinessHours.add(businessHoursId, startDate, 30*60*60*1000);

            }

            if( c.MotivoReclamacao__c != 'Cancelamento/Downgrade de contrato não concluído' &&
                c.MotivoReclamacao__c != 'Informações contratuais e comerciais' && c.RecordTypeId != rcMexico.Id){
                if( motivoAntigo == null || (motivoAntigo != null && motivoAntigo != c.MotivoReclamacao__c)){

                    System.debug('***SOLUCAO 150***');

                    // 150 horas comerciais após criação do caso em milisegundos
                    c.PrazoConclusaoSolucao__c = BusinessHours.add(businessHoursId, startDate, 150*60*60*1000);

                }
            }

            if( c.MotivoReclamacao__c == 'Cancelamento/Downgrade de contrato não concluído'){
                if( motivoAntigo == null || (motivoAntigo != null && motivoAntigo != c.MotivoReclamacao__c)){

                    System.debug('***SOLUCAO 100***');

                    // 100 horas comerciais após criação do caso em milisegundos
                    c.PrazoConclusaoSolucao__c = BusinessHours.add(businessHoursId, startDate, 100*60*60*1000);

                }
            }

            if( c.MotivoReclamacao__c == 'Informações contratuais e comerciais' ){
                if( motivoAntigo == null || (motivoAntigo != null && motivoAntigo != c.MotivoReclamacao__c)){

                    System.debug('***SOLUCAO 120***');

                    // 120 horas comerciais após criação do caso em milisegundos
                    c.PrazoConclusaoSolucao__c = BusinessHours.add(businessHoursId, startDate, 120*60*60*1000);

                }
            }
            
        }
        
    }
    
    public static void mxProprietarioForaDoCAC(List<Case> cases)
    {
        Group filaCAC = new Group();
        filaCAC = [SELECT Id, DeveloperName FROM Group WHERE DeveloperName = 'MX_Atendimento_ao_Cliente'];
        
        List<GroupMember> proprietarios = new List<GroupMember>();
        proprietarios = [SELECT Id, UserOrGroupId, GroupId FROM GroupMember WHERE GroupId = : filaCAC.Id];
        
        Map<Id, GroupMember> mapIdGroupMember = new Map<Id, GroupMember>();
        for(GroupMember gm : proprietarios)
        {
            mapIdGroupMember.put(gm.Id, gm);
        }

		for(Case c : cases)
        {
            if(mapIdGroupMember.get(c.OwnerId) == null && c.OwnerId != filaCAC.Id)
                c.Status = 'ESCALADO';
        }
        
    }
    
    public static void devolverCasoCAC(List<Case> cases)
    {
        Group filaCAC = new Group();
        filaCAC = [SELECT Id, DeveloperName FROM Group WHERE DeveloperName = 'MX_Atendimento_ao_Cliente'];
        
        for(Case c : cases)
        {
            c.OwnerId = filaCac.Id;
            c.Status = 'Tratado';
        }
            
        
    }
    
    
    public static void escalarCasoMexico(List<Case> cases)
    {
        List<Group> filasMX = new List<Group>();
        List<CaseTeamTemplate> timesMX = new List<CaseTeamTemplate>();
        Map<String,Id> mapIdNomeFila = new Map<String,Id>();
        filasMX = [Select Id, DeveloperName FROM Group WHERE DeveloperName LIKE 'MX%' AND Type = 'Queue'];
        timesMX = [SELECT Id, Name FROM CaseTeamTemplate];
        Map<String, Id> mapIdNomeTime = new Map<String,Id>();
        List<CaseTeamTemplateRecord> equipesDeletar = new List<CaseTeamTemplateRecord>();
        List<CaseTeamTemplateRecord> equipesCriar = new List<CaseTeamTemplateRecord>();
        List<Id> idsToQuery = new List<Id>();
        
        for(Case c1 : cases)
            idsToQuery.add(c1.Id);
        
        equipesDeletar = [SELECT Id, ParentId FROM CaseTeamTemplateRecord WHERE ParentId IN : idsToQuery];
        delete equipesDeletar;
        
        for(Group g : filasMX)
            mapIdNomeFila.put(g.DeveloperName, g.Id);
        
        for(CaseTeamTemplate ctt : timesMX)
        {
            mapIdNomeTime.put(ctt.Name, ctt.Id);
        }
        
        for(Case c : cases)
        {
            if(c.Area_responsavel__c == 'Administración de SIMs')
            {
                c.OwnerId = mapIdNomeFila.get('MX_Administracao_de_SIMs');
                CaseTeamTemplateRecord equipecaso = new CaseTeamTemplateRecord();
                equipecaso.ParentId = c.Id;
               	equipecaso.TeamTemplateId = mapIdNomeTime.get('Administración de SIMs');
                equipesCriar.add(equipeCaso);
            }
            
            if(c.Area_responsavel__c == 'Analista de Plataforma')
            {
                c.OwnerId = mapIdNomeFila.get('MX_Analista_de_Plataforma');
                CaseTeamTemplateRecord equipecaso = new CaseTeamTemplateRecord();
                equipecaso.ParentId = c.Id;
               	equipecaso.TeamTemplateId = mapIdNomeTime.get('Analista de Plataforma');
                equipesCriar.add(equipeCaso);
            }
            
            if(c.Area_responsavel__c == 'Atención a Clientes')
            {
                c.OwnerId = mapIdNomeFila.get('MX_Atendimento_ao_Cliente');
                CaseTeamTemplateRecord equipecaso = new CaseTeamTemplateRecord();
                equipecaso.ParentId = c.Id;
               	equipecaso.TeamTemplateId = mapIdNomeTime.get('Centro de Atención a Clientes');
                equipesCriar.add(equipeCaso);
            }
                
            
            if(c.Area_responsavel__c == 'CAI')
            {
                c.OwnerId = mapIdNomeFila.get('MX_CAI');
                CaseTeamTemplateRecord equipecaso = new CaseTeamTemplateRecord();
                equipecaso.ParentId = c.Id;
               	equipecaso.TeamTemplateId = mapIdNomeTime.get('CAI');
                equipesCriar.add(equipeCaso);
            }
            
            if(c.Area_responsavel__c == 'Cobranza')
            {
                c.OwnerId = mapIdNomeFila.get('MX_Cobranca');
                CaseTeamTemplateRecord equipecaso = new CaseTeamTemplateRecord();
                equipecaso.ParentId = c.Id;
               	equipecaso.TeamTemplateId = mapIdNomeTime.get('Cobranza');
                equipesCriar.add(equipeCaso);
            }
            
            if(c.Area_responsavel__c == 'Desarrollo')
            {
                c.OwnerId = mapIdNomeFila.get('MX_Desenvolvimento');
                CaseTeamTemplateRecord equipecaso = new CaseTeamTemplateRecord();
                equipecaso.ParentId = c.Id;
               	equipecaso.TeamTemplateId = mapIdNomeTime.get('Desarrollo');
                equipesCriar.add(equipeCaso);
            }
            
            if(c.Area_responsavel__c == 'Ejecutivo de Ventas')            
            {
                c.OwnerId = mapIdNomeFila.get('MX_Executivos_de_Vendas');
                CaseTeamTemplateRecord equipecaso = new CaseTeamTemplateRecord();
                equipecaso.ParentId = c.Id;
               	equipecaso.TeamTemplateId = mapIdNomeTime.get('Ejecutivos de Ventas');
                equipesCriar.add(equipeCaso);
            }
            
            if(c.Area_responsavel__c == 'Facturación')
            {
                c.OwnerId = mapIdNomeFila.get('MX_Faturamento');
                CaseTeamTemplateRecord equipecaso = new CaseTeamTemplateRecord();
                equipecaso.ParentId = c.Id;
               	equipecaso.TeamTemplateId = mapIdNomeTime.get('Facturación');
                equipesCriar.add(equipeCaso);
            }
                
            if(c.Area_responsavel__c == 'Infraestructura')
            {
                c.OwnerId = mapIdNomeFila.get('MX_Infraestrutura');
                CaseTeamTemplateRecord equipecaso = new CaseTeamTemplateRecord();
                equipecaso.ParentId = c.Id;
               	equipecaso.TeamTemplateId = mapIdNomeTime.get('Infraestructura');
                equipesCriar.add(equipeCaso);
            }
            
            if(c.Area_responsavel__c == 'Instalaciones')
            {
                c.OwnerId = mapIdNomeFila.get('MX_Instalacoes');
                CaseTeamTemplateRecord equipecaso = new CaseTeamTemplateRecord();
                equipecaso.ParentId = c.Id;
               	equipecaso.TeamTemplateId = mapIdNomeTime.get('Instalaciones');
                equipesCriar.add(equipeCaso);
            }
            
            if(c.Area_responsavel__c == 'Laboratorio')
            {
                c.OwnerId = mapIdNomeFila.get('MX_Laboratorio');
                CaseTeamTemplateRecord equipecaso = new CaseTeamTemplateRecord();
                equipecaso.ParentId = c.Id;
               	equipecaso.TeamTemplateId = mapIdNomeTime.get('Laboratorio');
                equipesCriar.add(equipeCaso);
            }
                
            if(c.Area_responsavel__c == 'Operador de Plataforma')
            {
                c.OwnerId = mapIdNomeFila.get('MX_Operador_de_Plataforma');
                CaseTeamTemplateRecord equipecaso = new CaseTeamTemplateRecord();
                equipecaso.ParentId = c.Id;
               	equipecaso.TeamTemplateId = mapIdNomeTime.get('Operador de Plataforma');
                equipesCriar.add(equipeCaso);
            }
                
            
            if(c.Area_responsavel__c == 'Televentas')
            {
                c.OwnerId = mapIdNomeFila.get('MX_Telemarketing');
                CaseTeamTemplateRecord equipecaso = new CaseTeamTemplateRecord();
                equipecaso.ParentId = c.Id;
               	equipecaso.TeamTemplateId = mapIdNomeTime.get('Televentas');
                equipesCriar.add(equipeCaso);
            }

            if(c.Area_responsavel__c == 'Capacitación UC')
            {
                c.OwnerId = mapIdNomeFila.get('MX_Treinamento_UC');
                CaseTeamTemplateRecord equipecaso = new CaseTeamTemplateRecord();
                equipecaso.ParentId = c.Id;
               	equipecaso.TeamTemplateId = mapIdNomeTime.get('Capacitación');
                equipesCriar.add(equipeCaso);
            }
                
            
            if(c.Area_responsavel__c == 'Ingeniería')
            {
                c.OwnerId = mapIdNomeFila.get('MX_Engenharia');
                CaseTeamTemplateRecord equipecaso = new CaseTeamTemplateRecord();
                equipecaso.ParentId = c.Id;
               	equipecaso.TeamTemplateId = mapIdNomeTime.get('Ingeniería');
                equipesCriar.add(equipeCaso);
            }
                
            if(c.Area_responsavel__c == 'Consultoría')
            {
                c.OwnerId = mapIdNomeFila.get('MX_Consultores');
                CaseTeamTemplateRecord equipecaso = new CaseTeamTemplateRecord();
                equipecaso.ParentId = c.Id;
               	equipecaso.TeamTemplateId = mapIdNomeTime.get('Consultoría');
                equipesCriar.add(equipeCaso);
            }
            
            if(c.Area_responsavel__c == 'Fuerza Comercial')
            {
                c.OwnerId = mapIdNomeFila.get('MX_Forca_Comercial');
                CaseTeamTemplateRecord equipecaso = new CaseTeamTemplateRecord();
                equipecaso.ParentId = c.Id;
               	equipecaso.TeamTemplateId = mapIdNomeTime.get('Fuerza Comercial');
                equipesCriar.add(equipeCaso);
            }
        }
        if(equipesCriar.size()>0)
            insert equipesCriar;
        
    }
    
    public static void fillAccountMexico(List<Case> cases)
    {
        List<Contact> contacts = new List<Contact>();
        List<String> emailsToQuery = new List<String>();
        Map<Id,String> mapCaseIdEmail = new Map<Id,String>();
        
        for(Case c : cases)
        {
            mapCaseIdEmail.put(c.Id, c.SuppliedEmail);
            emailsToQuery.add(c.SuppliedEmail);
        }
        
        contacts = [SELECT Id, AccountId, Email FROM Contact WHERE Email IN : emailsToQuery];
        
        for(Case c : cases)
        {
            for(Contact con : contacts)
            {
                if(con.Email == c.SuppliedEmail)
                {
                    c.AccountId = con.AccountId;
                    c.ContactId = con.Id;
                }
                    
            }
        }
        
    }
    
    public static void fillCaseTeamRecentlyCreated(List<Case> cases)
    {
        Map<String, Id> mapIdNomeTime = new Map<String,Id>();
        List<CaseTeamTemplate> timesMX = new List<CaseTeamTemplate>();
        timesMX = [SELECT Id, Name FROM CaseTeamTemplate];
        List<CaseTeamTemplateRecord> equipesCriar = new List<CaseTeamTemplateRecord>();
        for(CaseTeamTemplate ctt : timesMX)
        {
            mapIdNomeTime.put(ctt.Name, ctt.Id);
        }
        
        for(Case c : cases)
        {
            CaseTeamTemplateRecord equipecaso = new CaseTeamTemplateRecord();
            equipecaso.ParentId = c.Id;
            equipecaso.TeamTemplateId = mapIdNomeTime.get('Centro de Atención a Clientes');
            equipesCriar.add(equipeCaso);
        }
        
        if(equipesCriar.size()>0)
            insert equipesCriar;
    }
    
    
    public static void fillRespCACTelefone(List<Case> cases, Id userId)
    {
        for(Case c : cases)
        {
            c.Responsavel_CAC__c = userId;
            c.Status = 'Em andamento';
        }
    }
    
    
    public static void fillRespCACMexico(List<Case> cases, Map<Case, Id> mapa)
    {
        for(Case c : cases)
        {
            c.Responsavel_CAC__c = mapa.get(c);
            c.Status = 'Em andamento';
        }
       // update cases;
    }
    
    public static void fillFieldDeadLineForResponseMexico(List<Case> cases)
    {
        Id businessHoursId = [SELECT Id FROM BusinessHours WHERE Name = 'México'].Id;
        Datetime start = System.now();
        List<Id> caseIds = new List<Id>();
        
        for(Case c : cases)
        {
            Case oldCase = new Case();
            
            if(c.Id != null)
            	oldCase = (Case) Trigger.oldMap.get(c.Id);
            
            if(c.Reason == null)
                c.PrazoConclusaoSolucao__c = BusinessHours.add(businessHoursId, start, 4*60*60*1000);
            
            if(c.Id == null && c.Origin == 'Telefone')
            {
                c.PrazoConclusaoSolucao__c = BusinessHours.add(businessHoursId, start, 4*60*60*1000);
                
                if(c.Reason == 'Creción de DV')
                    c.PrazoConclusaoSolucao__c = start.addHours(120);
                if(c.Reason == 'Reporte de Robo')
                    c.PrazoConclusaoSolucao__c = start.addHours(72);
                if((c.Type == 'Problema' && c.Priority == 'Alto')||(c.Type == 'Incidente' && c.Priority == 'Alto'))
                    c.PrazoConclusaoSolucao__c = start.addHours(4);
            }
            
            if(oldCase.Reason != c.Reason && c.Id != null)
            {
                c.MX_Reavaliar_Alerta_1__c = true;
                System.debug('Reavaliar Alerta 1? - '+c.MX_Reavaliar_Alerta_1__c);
                
                if(c.Reason == 'Creción de DV')
                    c.PrazoConclusaoSolucao__c = c.CreatedDate.addHours(120);
                if(c.Reason == 'Reporte de Robo')
                    c.PrazoConclusaoSolucao__c = c.CreatedDate.addHours(72);
                if((c.Type == 'Problema' && c.Priority == 'Alto')||(c.Type == 'Incidente' && c.Priority == 'Alto'))
                    c.PrazoConclusaoSolucao__c = c.CreatedDate.addHours(4);
            }
            
            System.debug('EUREKA! PrazoConclusãoSolução: '+ c.PrazoConclusaoSolucao__c);
            
        }
    }
    
    
    public static void defineMarcoSLA(List<Case> cases){
        
        RecordType rcMexico = [SELECT Id, DeveloperName FROM RecordType WHERE DeveloperName = 'Mexico' AND SObjectType = 'Case'];
        
        Set<Id> casesId = new Set<Id>();
        for(Case c: cases){
            if(c.RecordTypeId != rcMexico.Id)
            	casesId.add(c.Id);
        }
        
        Id marcoResposta = [SELECT Id, Name FROM MilestoneType WHERE Name = 'Resposta'].Id;
        Id marcoSolucao = [SELECT Id, Name FROM MilestoneType WHERE Name = 'Solução'].Id;
       
        List<CaseMilestone> caseMilestoneResp = [SELECT Id, CaseId FROM CaseMilestone WHERE CaseId IN: casesId AND MilestoneTypeId =: marcoResposta];
        Map<Id,CaseMilestone> cmMapResp = new Map<Id,CaseMilestone>();
        for(CaseMilestone cm: caseMilestoneResp){
            cmMapResp.put(cm.CaseId,cm);
        }
        
        List<CaseMilestone> caseMilestoneSol = [SELECT Id, CaseId FROM CaseMilestone WHERE CaseId IN: casesId AND MilestoneTypeId =: marcoSolucao];
        Map<Id,CaseMilestone> cmMapSol = new Map<Id,CaseMilestone>();
        for(CaseMilestone cm: caseMilestoneSol){
            cmMapSol.put(cm.CaseId,cm);
        }
        
        List<CaseMilestone> caseMilestones = new List<CaseMilestone>();
        for(Case c: cases){
            if(c.DataFinalizacaoResposta__c != null && cmMapResp != null && cmMapResp.get(c.Id) != null){
                cmMapResp.get(c.Id).CompletionDate = c.DataFinalizacaoResposta__c;
            }
            if(c.DataFinalizacaoAcaoSolucao__c != null && cmMapSol != null && cmMapSol.get(c.Id) != null){
                cmMapSol.get(c.Id).CompletionDate = c.DataFinalizacaoAcaoSolucao__c;
            }
            caseMilestones.add(cmMapResp.get(c.Id));
            caseMilestones.add(cmMapSol.get(c.Id));
        }
        
        try{
            Update caseMilestones;
        }catch(Exception e){
            System.debug('ERROR: '+e);
        }
        
    }
    
    public static void setValuesOfCaseInitial(List<Case> cases){
        
        Id recTypeJuridico = [SELECT Id FROM RecordType WHERE Name = 'Jurídico'].Id;
        Id recTypeProcon = [SELECT Id FROM RecordType WHERE Name = 'Procon'].Id;
        Id recTypeReclamacao = [SELECT Id FROM RecordType WHERE Name = 'Reclamação'].Id;
        
        for(Case c: cases){
            
            if(c.RecordTypeId == recTypeJuridico){
                c.Subject = 'Processo Juridico';
            }
            
            if(c.RecordTypeId == recTypeProcon){
                c.Subject = 'Processo Procon';
            }
            
            if(c.RecordTypeId == recTypeReclamacao){
                c.Subject = 'Reclamação';
            }
            
            c.Status = 'Não iniciado';
            c.StatusResposta__c = 'Não iniciada';
            c.StatusSolucao__c = 'Não iniciada';
            c.NivelEscalacao__c = 'N1';
            
        }
    }
    
    public static void setEscalationLevels(List<Case> cases){
        
        List<GroupMember> gMembers = [
            SELECT UserOrGroupId, Group.Name 
            FROM GroupMember 
            WHERE GroupId 
            IN (
                SELECT QueueId FROM QueueSobject WHERE SobjectType = 'Case' 
            )
        ];
        
        System.debug('***gMembers: '+gMembers);
        
        Map<Id,String> mapFila = new Map<Id,String>();
        for(GroupMember gm: gMembers){
            mapFila.put(gm.GroupId,gm.Group.Name);
        }
        
        System.debug('***mapFila: '+mapFila);
        
        for(Case c: cases){
            String owner = c.OwnerId;
            String fila;
            
            if(mapFila != null && mapFila.get(owner) != null){
                fila = mapFila.get(owner);
            }
            
            System.debug('***fila: '+fila);
            
            if( !String.isEmpty(owner) && owner.substring(0,3) == '00G' && fila != null ){
                if( fila.contains('N2') ){
                    c.NivelEscalacao__c = 'N2';
                }
                if( fila.contains('N3') ){
                    c.NivelEscalacao__c = 'N3';
                }
                if( fila.contains('N4') ){
                    c.NivelEscalacao__c = 'N4';
                }
                if( fila.contains('N5') ){
                    c.NivelEscalacao__c = 'N5';
                }
            }
        }
    }
    
    public static void setStatusRespostaAndStatusSolucao(List<Case> cases){
        
        RecordType rcMexico = [SELECT Id, DeveloperName FROM RecordType WHERE DeveloperName = 'Mexico' AND SObjectType = 'Case'];
        
        for(Case c: cases){
            if( c.Status != 'Finalizado' && c.Status != 'Cancelado'){
                if(c.StatusResposta__c != 'Em andamento aguardando cliente' && c.AcaoRespostaReclamacao__c != null &&
                    c.DataFinalizacaoResposta__c == null && !c.RespostaAtrasada__c && c.RecordTypeId != rcMexico.Id){
                    c.StatusResposta__c = 'Em andamento';
                }
                else if(c.StatusResposta__c != 'Em andamento aguardando cliente' && 
                    c.StatusResposta__c != 'Atrasado aguardando cliente' &&
                    c.DataFinalizacaoResposta__c == null && c.RespostaAtrasada__c  && c.RecordTypeId != rcMexico.Id){
                    c.StatusResposta__c = 'Atrasada';
                }
                else if(c.AcaoRespostaReclamacao__c != null && 
                    c.DataFinalizacaoResposta__c != null &&
                    !c.RespostaAtrasada__c  && c.RecordTypeId != rcMexico.Id){
                    c.StatusResposta__c = 'Concluída';
                }
                else if(c.AcaoRespostaReclamacao__c != null && 
                    c.DataFinalizacaoResposta__c != null &&
                    c.RespostaAtrasada__c  && c.RecordTypeId != rcMexico.Id){
                    c.StatusResposta__c = 'Concluída com atraso';
                }
                if(c.StatusSolucao__c != 'Em andamento aguardando cliente' && c.AcaoSolucaoReclamacao__c != null &&
                    c.DataFinalizacaoAcaoSolucao__c == null && !c.SolucaoAtrasada__c  && c.RecordTypeId != rcMexico.Id){
                    c.StatusSolucao__c = 'Em andamento';
                }
                else if(c.StatusSolucao__c != 'Em andamento aguardando cliente' && 
                    c.StatusSolucao__c != 'Atrasado aguardando cliente' &&
                    c.DataFinalizacaoAcaoSolucao__c == null && c.SolucaoAtrasada__c  && c.RecordTypeId != rcMexico.Id){
                    c.StatusSolucao__c = 'Atrasada';
                }
                else if(c.AcaoSolucaoReclamacao__c != null && 
                    c.DataFinalizacaoAcaoSolucao__c != null &&
                    !c.SolucaoAtrasada__c  && c.RecordTypeId != rcMexico.Id){
                    c.StatusSolucao__c = 'Concluída';
                }
                else if(c.AcaoSolucaoReclamacao__c != null && 
                    c.DataFinalizacaoAcaoSolucao__c != null &&
                    c.SolucaoAtrasada__c  && c.RecordTypeId != rcMexico.Id){
                    c.StatusSolucao__c = 'Concluída com atraso';
                }
                else if(c.StatusResposta__c == 'Em andamento aguardando cliente' && c.RespostaAtrasada__c && 
                    c.Status != 'Finalizado' && c.Status != 'Cancelado'  && c.RecordTypeId != rcMexico.Id){
                    c.StatusResposta__c = 'Atrasado aguardando cliente';
                }
                else if(c.StatusSolucao__c == 'Em andamento aguardando cliente' && c.SolucaoAtrasada__c && 
                    c.Status != 'Finalizado' && c.Status != 'Cancelado'  && c.RecordTypeId != rcMexico.Id){
                    c.StatusResposta__c = 'Atrasado aguardando cliente';
                }
            }
        }
    }

}