public class OpportunityOperations {
	
    public static void updateOpportunities(List<Opportunity> Opportunities)
    {
        List<Opportunity> Oppor = new List<Opportunity>();
        for(Opportunity opp: Opportunities)
        {
            if(opp.BillToContact__c != null && opp.Manager__c == null)
            {
                opp.Manager__c = opp.BillToContact__r.AccountId;
                Oppor.add(opp);
            }
        }
        upsert Oppor;
    }
}