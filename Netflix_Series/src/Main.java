import java.sql.*;

public class Main {
	static Statement statement;

	public static void main(String[] args) throws SQLException {		
		int numThreads = 50; 
		
        DatabaseAccess object = new DatabaseAccess(numThreads); 
        object.start(); 
	}
}