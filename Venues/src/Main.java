import java.sql.*;

public class Main {
	public static void main(String[] args) throws SQLException {		
		int numThreads = 50; 
		
        for (int i=0; i<numThreads; i++) 
        { 
            DatabaseAccess object = new DatabaseAccess(); 
            object.start(); 
        } 
	}
}