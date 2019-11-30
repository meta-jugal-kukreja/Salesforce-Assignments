/**
 * Controller class for QueryExecutor Page
 */ 
public class QueryController 
{
    public String query{get;set;}
    public Boolean showQueryResultsArea{get;set;}
    
    /**
     * Constructor to initialize the data members.
     */ 
    public QueryController()
    {
        this.query = '';
        this.showQueryResultsArea = false;
    }
    
    /**
     * Method to render the ShowQueryResult Area.
     */ 
    public void execute()
    {
        if(!String.isBlank(query))
        {
            this.showQueryResultsArea = true;
        }
    }
}