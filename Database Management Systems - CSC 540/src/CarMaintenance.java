package src;

import java.sql.*;
import java.util.Scanner;
import src.services.AdminService;
import src.services.CustomerService;
import src.services.ManagerService;
import src.services.MechanicService;
import src.services.ReceptionistService;
/**
 *
 * @author Matthew Replogle
 */
// Acknowledgments: This example is a modification of code provided 
// by Dimitri Rakitine.

// Usage from command line on key.csc.ncsu.edu: 
// see instructions in FAQ
// Website for Oracle setup at NCSU : http://www.csc.ncsu.edu/techsupport/technotes/oracle.php

public class CarMaintenance {

    static final String jdbcURL 
	= "jdbc:oracle:thin:@ora.csc.ncsu.edu:1521:orcl01";
    
    static final String adminUser = "admin";
    
    static final String adminPassword = "admin";

    public static void main(String[] args) {
    	try {
    		Class.forName("oracle.jdbc.OracleDriver");
    		
    		Connection conn = null;
    		try {
    			conn = DriverManager.getConnection(jdbcURL, args[0], args[1]);
    			
    			Scanner scanner = new Scanner(System.in);
                int input = 0;
                do {
                    System.out.println("Welcome");
                    System.out.println("----------------------");
                    System.out.println("(1) Log In");
                    System.out.println("(2) Exit");
                    System.out.println("----------------------");
                    System.out.print("Please enter a number:");

                    input = scanner.nextInt();

                    switch (input) {
                        case 1:
                            System.out.println("Moving to Login...");
                            login_user(conn, scanner);
                            break;
                        case 2:
                            break;
                    }
                } while(input != 2);
                scanner.close();
    		} finally {
    			close(conn);

    		}
    	} catch (Throwable oops) {
    		oops.printStackTrace();
    	}
    }

    public static void login_user(Connection conn, Scanner scanner) {
        scanner.nextLine();
        System.out.println("(A) UserID: ");
        String userID = scanner.nextLine();
        System.out.println("(B) Password: ");
        String password = scanner.nextLine();
        int input = 0;
        do {
            System.out.println("----------------------");
            System.out.println("(1) Sign In");
            System.out.println("(2) Go Back");
            System.out.println("----------------------");
            System.out.print("Please enter a number:");

            input = scanner.nextInt();

            switch (input) {
                case 1:
                    System.out.println("Moving to Sign In...");
                    signin_user(conn, userID, password, scanner);
                    break;
                case 2:
                    System.out.println("Returning to Landing Page...");
                    break;
            }
        } while(input > 2);
    }

    static void signin_user(Connection conn, String userID, String password, Scanner scanner) {        
        try {
			Statement stmt = conn.createStatement();
			
			// Find the entry in the Users table with the matching userId
			ResultSet rs = stmt.executeQuery("SELECT password "
					+ "FROM Users "
					+ "WHERE userId = '" + userID + "'");
			
			// If there is no entry with matching userID
			if (!rs.next()) {
				// Check to see if it is admin user/password
				if (userID.equals(adminUser) &&  password.equals(adminPassword)) {
					System.out.println("User Recognized as Admin, Moving to Admin View...");
	                AdminService.handleview(conn, scanner);
				} else {
					// Otherwise print out incorrect login and re-prompt user
					System.out.println("Login Incorrect");
					login_user(conn, scanner);
				}
			} else {
				// Otherwise, make sure the password matches the entered password
				String dbPassword = rs.getString("password");
				if (password.equals(dbPassword)) {
					// First, check to see if the userId is in the customers table
					rs = stmt.executeQuery("SELECT customerId, centerId "
							+ "FROM Customer "
							+ "WHERE userId = '" + userID + "'");
					
					if (!rs.next()) {
						// If not a customer, check to see if the userId is in the employee table
						rs = stmt.executeQuery("SELECT empId, centerId "
								+ "FROM Employee "
								+ "WHERE userId = '" + userID + "'");
						
						if (!rs.next()) {
							System.out.println("Login Incorrect");
							login_user(conn, scanner);
						} else {
							// If in the employee table, get the employeeId
							int empID = rs.getInt("empId");
							int centerID = rs.getInt("centerId");
							
							// First, check to see if the employeeId is in the manages table
							rs = stmt.executeQuery("SELECT * "
									+ "FROM Manager "
									+ "WHERE empId = " + empID + " AND centerId = " + centerID);
							
							if (!rs.next()) {
								// If not in the manages table, check to see if the employeeId is in the receptionist table
								rs = stmt.executeQuery("SELECT * "
										+ "FROM Receptionist "
										+ "WHERE empId = " + empID + " AND centerId = " + centerID);
								
								if (!rs.next()) {
									// If not in the receptionist table, must be a mechanic so navigate to MechanicService
									rs = stmt.executeQuery("SELECT * "
											+ "FROM Mechanic "
											+ "WHERE empId = " + empID + " AND centerId = " + centerID);
                                    rs.next();
									System.out.println("User Recognized as Mechanic, Moving to Mechanic View...");
					                MechanicService.handleview(conn, empID, centerID, scanner);
								} else {
									// If in the receptionist table, navigate to ReceptionistService
                                    System.out.println("User Recognized as Receptionist, Moving to Receptionist View...");
					                ReceptionistService.handleview(conn, empID, centerID, scanner);
								}
							} else {
								// If in the manages table, get the centerId and navigate to ManagerService
								System.out.println("User Recognized as Manager, Moving to Manager View...");
				                ManagerService.handleview(conn, centerID, scanner);
							}
						}
					} else {
						int centerID = rs.getInt("centerId");
						int customerID = rs.getInt("customerId");
						close(rs);
						// If the userId was in the customer table, navigate to the CustomerService class
						System.out.println("User Recognized as Customer, Moving to Customer View...");
		                CustomerService.handleview(conn, centerID, customerID, scanner);
					}
				} else {
					// Otherwise, if the password is incorrect re-prompt the user
					System.out.println("Login Incorrect");
					login_user(conn, scanner);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
        
        /**
        System.out.println("Prompt for Login Details, then check DB for creds, then either advance into" +
                " new menu, or return to prompt for credentials.");
                System.out.println("For now, enter the role menu you wish to access:");
        Scanner scanner = new Scanner(System.in);
        int input = 0;
        System.out.println("----------------------");
        System.out.println("(1) Admin");
        System.out.println("(2) Manager");
        System.out.println("(3) Receptionist");
        System.out.println("(4) Customer");
        System.out.println("(5) Mechanic");
        System.out.println("(6) Exit back to login");
        System.out.println("----------------------");
        System.out.print("Please enter a number:");
        input = scanner.nextInt();
        switch (input) {
            case 1:
                System.out.println("User Recognized as Admin, Moving to Admin View...");
                AdminService.handleview();
                break;
            case 2:
                System.out.println("User Recognized as Manager, Moving to Manager View...");
                int centerID = 1;  //temp centerID
                ManagerService.handleview(conn, centerID);
                break;
            case 3:
                System.out.println("User Recognized as Receptionist, Moving to Receptionist View...");
                ReceptionistService.handleview();
                break;
            case 4:
                System.out.println("User Recognized as Customer, Moving to Customer View...");
                CustomerService.handleview();
                break;
            case 5:
                System.out.println("User Recognized as Mechanic, Moving to Mechanic View...");
                MechanicService.handleview(conn);
                break;
            case 6:
                System.out.println("Heading Back to Login...");
        }
        
        **/
    }

    static void close(Connection conn) {
        if(conn != null) {
            try { conn.close(); } catch(Throwable whatever) {}
        }
    }

    static void close(Statement st) {
        if(st != null) {
            try { st.close(); } catch(Throwable whatever) {}
        }
    }

    static void close(ResultSet rs) {
        if(rs != null) {
            try { rs.close(); } catch(Throwable whatever) {}
        }
    }
}


/**
 * Old Code to Use SQL Connections for Reference Below
 * 
 * try {

// Load the driver. This creates an instance of the driver
// and calls the registerDriver method to make Oracle Thin
// driver available to clients.

//  Class.forName("oracle.jdbc.driver.OracleDriver"); older


        Class.forName("oracle.jdbc.OracleDriver");

	    String user = System.console().readline("Username: ");	// For example, "jsmith"
	    String passwd = System.console().readLine("Password: ");	// Your 9 digit student ID number


        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {

		// Get a connection from the first driver in the
		// DriverManager list that recognizes the URL jdbcURL

		conn = DriverManager.getConnection(jdbcURL, user, passwd);

		// Create a statement object that will be sending your
		// SQL statements to the DBMS

		stmt = conn.createStatement();

		// Create the COFFEES table

		stmt.executeUpdate("ALTER TABLE COFFEES1 " +
			   "ADD CONSTRAINT COFFEEKEY PRIMARY KEY (COF_NAME)");


		// Try repeat insert into COFFEES1
        try {
            stmt.executeUpdate("INSERT INTO COFFEES1 " +
			   "VALUES ('Colombian', 101, 7.99, 0, 0)");
        } catch (java.sql.SQLException e) {
            System.out.println("Caught SQLException " + e.getErrorCode() + "/" + e.getSQLState() + " " + e.getMessage() ) ; 
        }
		
        System.out.println("Matthew Replogle completed secondexample successfully!")

            } finally {
                close(rs);
                close(stmt);
                close(conn);
            }
        } catch(Throwable oops) {
            oops.printStackTrace();
        }
 */