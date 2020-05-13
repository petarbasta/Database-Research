import java.sql.*;

public class DatabaseAccess extends Thread {
	Statement statement;
	
	static int numRequests = 100;
	
	static int percentRead = 0;
	static int percentInsert = 100;
	// percentUpdate is simply remaining amount

	// Credentials
	static String username = "basta";
	static String password = "*********";
	
	// JDBC URLs
	static String urlPSQL = "jdbc:postgresql://192.168.0.108:5432/venues";
	static String urlMySQL = "jdbc:mysql://192.168.0.108:3306/venues?allowPublicKeyRetrieval=true&useSSL=false";
	static String urlMonetDB = "jdbc:monetdb://192.168.0.108:1337/venues";
	static String urlDB2 = "jdbc:db2://192.168.0.108:6969/venues";

	public void run() {
		try {
			Connection con = DriverManager.getConnection(urlDB2, username, password);
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
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// Randomly chooses read instruction to execute from Queries
	void executeRead() {
		int index = (int) ((Math.random() * 19)); // Generate number 0-18
		String readSQL = Queries.readQueries[index];

		try {
			// Execute query
			statement.executeQuery(readSQL);
		} catch (SQLException e) {
			System.out.println(index);

			String sqlMessage = e.getMessage();
			System.out.println(sqlMessage);
		}
	}

	// Randomly chooses insert instruction to execute
	void executeInsert() {
		int oid = (int) ((Math.random() * Integer.MAX_VALUE)); // Generate random integer
		String oname = getAlphaNumericString(10);
		
		String insertSQL = "INSERT INTO organization VALUES (" + oid + ", \'" + oname + "\');";
		
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
		String newName = getAlphaNumericString(10);

		String updateSQL = "UPDATE person SET pname = \'" + newName + "\' WHERE pid = 69696969;";
		
		try {
			// Execute query
			statement.executeUpdate(updateSQL);
		} catch (SQLException e) {
			String sqlMessage = e.getMessage();
			System.out.println(sqlMessage);
		}
	}
	
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
