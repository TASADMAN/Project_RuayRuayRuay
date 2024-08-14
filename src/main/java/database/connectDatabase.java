package database;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class connectDatabase {
	
	public Connection connect()  throws IOException {
		
		System.out.println("\n-------- MySQL DB JDBC Connection Testing ------");

		try {

			Class.forName("org.mariadb.jdbc.Driver");

		} catch (ClassNotFoundException e) {

			System.out.println("Where is your MySQL DB JDBC Driver?");
			e.printStackTrace();
		}

		Connection connection = null;
		System.out.println("MySQL JDBC Driver Registered!");

		try {

			connection = DriverManager.getConnection(
					"jdbc:mariadb://202.28.34.205:3306/db64011211048", 
					"64011211048", "64011211048");

		} catch (SQLException e) {

			System.out.println("Connection Failed! Check output console");
			e.printStackTrace();
		}

		if (connection != null) {
			System.out.println("You made it, take control your database now!");
		} else {
			System.out.println("Failed to make connection!");
		}
		
		System.out.println("Connected to database\n");
		return connection;
	}

}
