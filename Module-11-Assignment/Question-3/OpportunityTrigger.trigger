/**
 * Trigger to update CloseDate Field of the Opportunity object whenever StageName field is changed to 'Closed Won' or 'Closed Lost' 
 * and send email to user whenever the stage is changed.
 */
trigger OpportunityTrigger on Opportunity (before update, after update) 
{
    //When opportunity stage is changed to Closed Won OR Closed Lost.
    if(Trigger.isBefore)
    {
        for(Opportunity oneOpportunity : Trigger.New)
        {   
            Opportunity oldOpportunity = Trigger.oldMap.get(oneOpportunity.Id);
            if((oldOpportunity.StageName != 'Closed Won' && oneOpportunity.StageName == 'Closed Won') || 
               (oldOpportunity.StageName != 'Closed Lost' && oneOpportunity.StageName == 'Closed Lost'))
            {
                oneOpportunity.CloseDate = System.today();
            }
        }
    }
    
    //When an opportunity's status is changed.
    if(Trigger.isAfter)
    {
        for(Opportunity oneOpportunity : Trigger.New)
        {
            Opportunity oldOpportunity = Trigger.oldMap.get(oneOpportunity.Id);
            if(oneOpportunity.StageName != oldOpportunity.StageName)
            {
                OpportunityEmailHelper.sendEmail(oneOpportunity);
            }
        }
    }
}