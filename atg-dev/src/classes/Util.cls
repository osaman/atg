/*
   @Author Osama Nasir
   @name Util
   @CreateDate 16/03/2016
   @Description All the utility methods will be defined
   @Version <1.0>
 */

public with sharing class Util {
	
	/*
   *  Checks if triggers are disabled orgwide
   *  @name IsTriggerAllowed
   *  @param n/a 
   *  @return <parameter> - returns if triggers are disabled
   *  @throws none
   */
	public static Boolean IsTriggerAllowed(){
			App_Settings__c aps = App_Settings__c.getOrgDefaults();
		return !aps.Triggers_Disabled__c;
	}
}