import java.sql.*;

public class DatabaseAccess extends Thread {
	int numThreads;
	Statement statement;
	
	static int numRequests = 1;
	
	static int percentRead = 100;
	static int percentInsert = 0;
	// percentUpdate is simply remaining amount

	// Credentials
	static String username = "basta";
	static String password = "********";
	
	// JDBC URLs
	static String urlPSQL = "jdbc:postgresql://192.168.0.107:5432/mcgill";
	static String urlMySQL = "jdbc:mysql://192.168.0.107:3306/mcgill?allowPublicKeyRetrieval=true&useSSL=false";
	static String urlMonetDB = "jdbc:monetdb://192.168.0.107:1337/mcgill";
	static String urlDB2 = "jdbc:db2://192.168.0.107:6969/mcgill";

	public DatabaseAccess(int numThreads) {
		this.numThreads = numThreads;
	}
	public void run() {
		try {
			Connection con = DriverManager.getConnection(urlMonetDB, username, password);
			statement = con.createStatement();

			for (int i = 0; i < numRequests; i++) {
				// Randomly choose an operation based on % probabilities
				int choice = (int) (Math.random() * 100); // Generate random number 0-99

				if (choice < percentRead) {
					executeRead();
				} else if (choice < percentRead + percentInsert) {
					executeInsert();
				} else {
					executeUpdate();
				}
			}

			statement.close();
			con.close();
			
			if (numThreads > 1) {
		        DatabaseAccess object = new DatabaseAccess(numThreads -1); 
		        object.start(); 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// Randomly chooses read instruction to execute from Queries
	void executeRead() {
		int index = (int) ((Math.random() * 18)); // Generate number 0-17
		String readSQL = Queries.readQueries[index]; // Get query to run
		
		try {
			// Execute query
			statement.executeQuery(readSQL);
			
			
		} catch (SQLException e) {
			String sqlMessage = e.getMessage();
			System.out.println(sqlMessage);
		}
	}

	// Randomly chooses insert instruction to execute
	void executeInsert() {
		String ccode = getAlphaNumericString(10); // Generate random string of length 10
		int credits = (int) ((Math.random() * 100)); // Generate random number 0-5
		
		String insertSQL = "INSERT INTO course VALUES (\'" + ccode + "\', " + credits + ", \'dept\');";
		
		try {
			// Execute query
			statement.executeUpdate(insertSQL);
		} catch (SQLException e) {
			String sqlMessage = e.getMessage();
			System.out.println(sqlMessage);
		}
	}

	// Randomly chooses update instruction to execute
	void executeUpdate() {
		int credits = (int) ((Math.random() * 100)); // Generate random number 0-5
		
		String updateSQL = "UPDATE course SET credits = " + credits + " WHERE ccode = \'math-241\';";
		
		try {
			// Execute query
			statement.executeUpdate(updateSQL);
		} catch (SQLException e) {
			String sqlMessage = e.getMessage();
			System.out.println(sqlMessage);
		}
	}
	
	
	// Generate random string of length n
	static String getAlphaNumericString(int n) 
    { 
  
        // chose a Character random from this String 
        String AlphaNumericString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                                    + "0123456789"
                                    + "abcdefghijklmnopqrstuvxyz"; 
  
        // create StringBuffer size of AlphaNumericString 
        StringBuilder sb = new StringBuilder(n); 
  
        for (int i = 0; i < n; i++) { 
  
            // generate a random number between 
            // 0 to AlphaNumericString variable length 
            int index 
                = (int)(AlphaNumericString.length() 
                        * Math.random()); 
  
            // add Character one by one in end of sb 
            sb.append(AlphaNumericString 
                          .charAt(index)); 
        } 
  
        return sb.toString(); 
    } 
}
