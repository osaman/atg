/*
   @Author Osama Nasir
   @name ATGError
   @CreateDate 15/03/2016
   @Description This class is used for logging exceptions in apex code
   @Version <1.0>
 */
public class ATGError {

	/*
   *  Checks if triggers are disabled orgwide
   *  @name log
   *  @param Exception object
   *  @param Subject - ideally class and methd names
   *  @return n/a
   *  @usage: ATGError.log(Exception e,'ClassName.methodName()');
   *  @throws none
   */
    
    public static void log(Exception e,String subject){
        String message = 'Exception: ' + e.getMessage() + '\n' + 
						 'Line Number: ' + e.getLineNumber() + '\n' +
						 'Stack Trace: ' + e.getStackTraceString() + '\n' +
						 'Exception Type: ' + e.getTypeName() + '\n';
        log(message, subject);
    }
    
    public static void log(String message, String subject){	
    	log(message, subject, 'Apex');
    }
    
    public static void log(String message, String subject, String errortype){
    	try
    	{
	        try
			{
				message = 'User Type: ' + Userinfo.getUserType() + '\n' + 
					'User Name: ' + Userinfo.getUserName() + '\n\n' + message;
			}
			catch (Exception e)
			{
				message = 'Userinfo unavailable\n\n' + message;
			}
	        
			subject = subject.abbreviate(80);
			message = message.abbreviate(32000);
	        
			insert new Error__c(Name=subject, Body__c=message, type__c = errortype);
			
	    }
	    catch (Exception e) { throw e;}
    }
}