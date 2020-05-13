import java.io.IOException;
import java.net.InetSocketAddress;
import java.sql.*;

import net.spy.memcached.MemcachedClient;

public class Main {
	static MemcachedClient cache;
	
	public static void main(String[] args) throws SQLException {		
		int numThreads = 50; 
		
	    try {
			cache = new MemcachedClient(new InetSocketAddress("192.168.0.108", 11211));
		} catch (IOException e) {
			e.printStackTrace();
			return;
		}  

        for (int i=0; i<numThreads; i++) 
        { 
            DatabaseAccess object = new DatabaseAccess(); 
            object.start(); 
        } 
	}
}