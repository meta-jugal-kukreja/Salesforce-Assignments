//Trigger to update CloseDate Field of the Opportunity object whenever StageName field is changed to 'Closed Won' or 'Closed Lost'
trigger OpportunityUpdateTrigger on Opportunity (before update) {
    
    for(Opportunity oneOpportunity : Trigger.New)
    {
        if(oneOpportunity.StageName == 'Closed Won' || oneOpportunity.StageName == 'Closed Lost')
        {
            oneOpportunity.CloseDate = System.today();
        }
    }
}