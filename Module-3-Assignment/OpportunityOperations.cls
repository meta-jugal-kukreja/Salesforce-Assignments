/**
 * Class to update Opportunities whose BillToContact__c field is not null and Manager__c is null.
 */
public class OpportunityOperations 
{
    public static void updateOpportunities(List<Opportunity> Opportunities)
    {
        List<Opportunity> OpportunityList = new List<Opportunity>();
        for(Opportunity opp: Opportunities)
        {
            if(opp.BillToContact__c != null && opp.Manager__c == null)
            {
                opp.Manager__c = opp.BillToContact__r.AccountId;
                OpportunityList.add(opp);
            }
        }
        upsert OpportunityList;
    }
}