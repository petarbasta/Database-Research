import java.sql.*;

public class DatabaseAccess extends Thread {
	int numThreads;
	Statement statement;
	
	static int numRequests = 100;
	
	static int percentRead = 50;
	static int percentInsert = 0;
	// percentUpdate is simply remaining amount

	// Credentials
	static String username = "basta";
	static String password = "********";
	
	// JDBC URLs
	static String urlPSQL = "jdbc:postgresql://192.168.0.108:5432/netflix";
	static String urlMySQL = "jdbc:mysql://192.168.0.108:3306/netflix?allowPublicKeyRetrieval=true&useSSL=false";
	static String urlMonetDB = "jdbc:monetdb://192.168.0.108:1337/netflix";
	static String urlDB2 = "jdbc:db2://192.168.0.108:6969/netflix";
	
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

	// Randomly chooses read instruction to execute
	void executeRead() {
		int accid = (int) ((Math.random() * 2)); // Generate random number 0-1

		switch (accid) {
		case 0:
			getAvailableMedia();
			break;
		case 1:
			getNumEpisodes();
			break;
		}
	}

	// Randomly chooses insert instruction to execute
	void executeInsert() {
		int accid = (int) ((Math.random() * 2)); // Generate random number 0-1
		switch (accid) {
		case 0:
			createNewPayment();
			break;
		case 1:
			createAccount();
			break;
		}
	}

	// Randomly chooses update instruction to execute
	void executeUpdate() {
		int accid = (int) ((Math.random() * 1)); // Generate number 0-0 (Add more options for other projects)

		switch (accid) {
		case 0:
			increaseRockRatings();
			break;
		}
	}

	void getAvailableMedia() {
		int accid = (int) ((Math.random() * 10) + 1);
		
		try {
			// Create query
			String querySQL = "SELECT title, releaseYear FROM AccountUser au, available_in avail, Media med\r\n"
					+ "WHERE au.accid=" + accid
					+ " AND au.username=\'User\' AND avail.regname=au.regname AND med.mid=avail.mid;";

			// Execute query
			statement.executeQuery(querySQL);
		} catch (SQLException e) {
			String sqlMessage = e.getMessage();
			System.out.println(sqlMessage);
		}
	}

	void getNumEpisodes() {
		int seasonNum = (int) ((Math.random() * 10) + 1);

		try {
			// Create query
			String querySQL = "SELECT COUNT(*) \r\n" + "FROM Episode e, Media m\r\n"
					+ "WHERE e.mid=m.mid AND m.title=\'Pokemon\' AND e.seasonnum=" + seasonNum + ";";

			// Execute query
			statement.executeQuery(querySQL);
		} catch (SQLException e) {
			String sqlMessage = e.getMessage();
			System.out.println(sqlMessage);
		}
	}

	void createNewPayment() {
		int accid = (int) ((Math.random() * 10) + 1);
		String date = "2020-01-01";
		Double amount = (double) ((int) (Math.random() * 100) + 1);

		try {
			// Create insert string
			String insertSQL = "INSERT INTO Payment VALUES (DEFAULT, \'" + date + "\', " + amount + ", " + accid + ");";

			// Execute insert
			statement.executeUpdate(insertSQL);
		} catch (SQLException e) {
			String sqlMessage = e.getMessage();
			System.out.println(sqlMessage);
		}
	}

	void createAccount() {
		try {
			// Create insert string
			String insertSQL = "INSERT INTO Account VALUES (DEFAULT);";
			// Execute insert
			statement.executeUpdate(insertSQL);
		} catch (SQLException e) {
			String sqlMessage = e.getMessage();
			System.out.println(sqlMessage);
		}
	}

	void increaseRockRatings() {
		try {
			// Create update string
			String updateSQL = "UPDATE Rating\r\n" + "SET value = value + 1\r\n" + "WHERE value <= 4 AND mid IN \r\n"
					+ "(\r\n" + "	SELECT mid\r\n" + "	FROM describes d, Tag t \r\n"
					+ "	WHERE d.tid=t.tid AND t.tagname='The Rock'\r\n" + ");";

			// Execute insert
			statement.executeUpdate(updateSQL);
		} catch (SQLException e) {
			String sqlMessage = e.getMessage();
			System.out.println(sqlMessage);
		}
	}
}
