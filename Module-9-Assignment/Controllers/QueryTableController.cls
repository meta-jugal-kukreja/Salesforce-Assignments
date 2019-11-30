/**
 * Controller class for QueryResultComponent
 */ 
public class QueryTableController 
{
    public String queryToBeExecuted = '';
    public List<String> fieldsList{get;set;}
    public String sortBy = '';
    public Integer DesiredPage{get;set;}
    public Boolean isSortingLinkClicked = false;
    
    //Initializing StandardSetController
    public ApexPages.StandardSetController setCon
    {
        get
        {
            if(setCon == null)
            {
                List<sObject> displayFields = new List<sObject>();
                displayFields = getDisplayFields(queryToBeExecuted);
                if(displayFields != null)
                {
                    setCon = new ApexPages.StandardSetController(displayFields);
                    setCon.setPageSize(10);
                }
            }
            return setCon;
        }
        set;
    }
    
    /**
     * Constructor to initialze the data members.
     */ 
    public QueryTableController()
    {
        this.queryToBeExecuted = '';
        this.sortBy = '';
        System.debug(this.DesiredPage);
    }
    
    /**
     * This method returns the query to be executed string.
     */ 
    public String getQueryToBeExecuted()
    {
        return this.queryToBeExecuted;
    }
    
    /**
     * This method sets the getQueryToBeExecuted data member with the query string passed in the component.
     */ 
    public void setQueryToBeExecuted(String query)
    {
        if(!this.queryToBeExecuted.equalsIgnoreCase(query))
        {
            this.queryToBeExecuted = query;
            this.setCon = null;
        }
    }
    
    /**
     * This method sets setCon to null in order to perform sorting according to a field name clicked on the UI.
     */ 
    public void sortByMethod()
    {
        this.setCon = null;
        this.isSortingLinkClicked = true;
    }
    
    /**
     * This method sets the sortBy data member to the field's name which is clicked on the UI.
     */ 
    public void setSortBy(String fieldName)
    {
        this.sortBy = fieldName;
    }
    
    /**
     * This method returns the sortBy data member.
     */ 
    public String getSortBy()
    {
        return this.sortBy;
    }
    
    /**
     * This method returns the record to the UI.
     */ 
    public List<sObject> getRecordsList()
    {
        if(setCon != null)
        {
            this.DesiredPage = setCon.getPageNumber();
            return setCon.getRecords();
        }
        else
        {
            return null;
        }
    }
    
    /**
     * This method creates the final query to be executed with the passed query string and sortBy field.
     */ 
    private String createQuery(String query)
    {
        String orderedQuery = query;        
        if(isSortingLinkClicked && String.isNotBlank(this.getSortBy()))
        {
            if(query.containsIgnoreCase('order by'))
            {
                orderedQuery = orderedQuery.substring(0, query.indexOfIgnoreCase('order by') - 1);
            }
            orderedQuery = orderedQuery + ' ORDER BY ' + this.getSortBy();
        }
        return orderedQuery;
    }
    
    /**
     * This method executes the query and returns the result if there is no error else returns null.
     */ 
    private List<sObject> executeQuery(String query)
    {
        String orderedQuery = createQuery(query);
        List<sObject> sObjectList = new List<sObject>();
        try
        {
            sObjectList = Database.query(orderedQuery);
            
        }
        catch(Exception excp)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, excp.getMessage())); 
            return null;
        }
        return sObjectList;
    }
    
    /**
     * This method returns sets the Fields to be shown and returns the query result. 
     */ 
    public List<sObject> getDisplayFields(String query)
    {
        List<sObject> records = executeQuery(query);
        if(records == null)
        {
            return null;
        }
        else
        {
            if(records.isEmpty())
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'No records found'));
                records = new List<Account>();
            }
            else
            {
                Set<String> fieldsSet = new Set<String>();
                for(sObject record : records)
                {
                    fieldsSet.addAll(record.getPopulatedFieldsAsMap().keySet());
                }
                this.fieldsList = new List<String>();
                this.fieldsList.addAll(fieldsSet);
            }
            return records; 
        }
    }  
    
    /**
     * This method is used to set the page number the user wishes to see.
     */ 
    public void jumpToPage()
    {
        this.setCon.setPageNumber(DesiredPage);
    }
}