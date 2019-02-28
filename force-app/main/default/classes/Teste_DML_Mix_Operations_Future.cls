/*
    @testClass DML_Mix_Operations_Future
    
    @author Renan Rocha
    @date 28/12/2018
*/

@isTest
public class Teste_DML_Mix_Operations_Future{

    /*
        @author Renan Rocha
        @date 28/12/2018
    */
    static testMethod void Handler_Lead_vericaUsuarioCanalExclusivoHelper(){
        Map<String, sObject> mapBaseConfig = Teste_Util.createMapBaseConfig();
        Group grupo = (Group) mapBaseConfig.get('Group');
        User usuario = (User) mapBaseConfig.get('User');

        DML_Mix_Operations_Future.Handler_Lead_vericaUsuarioCanalExclusivoHelper(usuario.Id);
    }

    /*
        @author Renan Rocha
        @date 09/01/2019
    */
    static testMethod void DAO_Conjunto_Permissao_getConjPermissaoByUserAssignedIdAndName(){
        Map<String, sObject> mapBaseConfig = Teste_Util.createMapBaseConfig();
        User usuario = (User) mapBaseConfig.get('User');

        DML_Mix_Operations_Future.DAO_Conjunto_Permissao_getConjPermissaoByUserAssignedIdAndName(usuario.Id);
    }
}