import java.sql.*;

public class Main {
	static Statement statement;

	public static void main(String[] args) throws SQLException {		
		int numThreads = 1; 
		
        for (int i=0; i<numThreads; i++) 
        { 
            DatabaseAccess object = new DatabaseAccess(); 
            object.start(); 
        } 
	}
}