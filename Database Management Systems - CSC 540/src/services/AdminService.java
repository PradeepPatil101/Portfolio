package src.services;

import java.util.Scanner;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.Reader;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class AdminService {

    public static void handleview(Connection conn, Scanner scanner) {
        // Stubbed Out for duplication
        while(true) {
            int input = 0;
            System.out.println("Welcome to Admin View");
            System.out.println("----------------------");
            System.out.println("(1) System Setup");
            System.out.println("(2) Add New Store");
            System.out.println("(3) Add New Service");
            System.out.println("(4) Execute Queries");
            System.out.println("(5) Logout");
            System.out.println("----------------------");
            System.out.print("Please enter a number:");

            input = scanner.nextInt();

            switch (input) {
                case 1:
                    handleSetup(conn, scanner);
                    break;
                case 2:
                    addStore(conn, scanner);
                    break;
                case 3:
                    addService(conn, scanner);
                    break;
                case 4:
                    queryMenu(conn, scanner);
                    break;
                case 5:
                    return;
            }
        }
    }

    public static void handleSetup(Connection conn, Scanner scanner) {
        scanner.nextLine();
        while(true) {
            int input = 0;
            System.out.println("Enter the path of the File to use for Setup:");
            String filepath = scanner.nextLine();
            System.out.println("Now, Enter the Option for which the File Sets Up the System:");
            System.out.println("----------------------");
            System.out.println("(1) Upload service general information");
            System.out.println("(2) Upload store general information");
            System.out.println("(3) Go Back");
            System.out.println("----------------------");
            System.out.print("Please enter a number:");

            input = scanner.nextInt();
            scanner.nextLine();

            switch (input) {
                case 1:
                    System.out.println("Uploading Service Information");
                    setupFileUpload(conn, filepath);
                    break;
                case 2:
                    System.out.println("Uploading Store Information");
                    setupFileUpload(conn, filepath);
                    break;
                case 3:
                    return;
            }
        }
    }

    public static void setupFileUpload(Connection conn, String filepath) {
        ScriptRunner runner = new ScriptRunner(conn);

        Reader reader;
        try {
            reader = new BufferedReader(new FileReader(filepath));
            runner.runScript(reader);
        } catch (Exception e){
            System.out.println("Failed to run script: " + e.getMessage());
            return;
        }
        System.out.println("Successfully ran script!");
    }

    public static void addStore(Connection conn, Scanner scanner) {
        scanner.nextLine();
        while(true) {
            int input = 0;
            //Get all the store info from the user
    	    System.out.println("Enter Store info:");
    	    System.out.println("----------------------");
    	    System.out.println("(A) Store ID");
    	    String storeID = scanner.nextLine();
    	    System.out.println("(B) Address");
    	    String address = scanner.nextLine();
    	    System.out.println("(Ca) Manager's Name");
    	    String mngrName = scanner.nextLine();
            System.out.println("(Cc) Manager's Username");
    	    String mngrUsername = scanner.nextLine();
            System.out.println("(Cd) Manager's Password");
    	    String mngrPwd = scanner.nextLine();
            System.out.println("(Ce) Manager's Salary");
    	    String mngrSal = scanner.nextLine();
            System.out.println("(Cf) Manager's Employee ID");
    	    String mngrID = scanner.nextLine();
    	    System.out.println("(Da) Mechanic Minimum Wage");
    	    String minWage = scanner.nextLine();
    	    System.out.println("(Db) Mechanic Maximum Wage");
    	    String maxWage = scanner.nextLine();

        	System.out.println("----------------------");
        	System.out.println("(1) Add Store");
            System.out.println("(2) Go Back");
            
            input = scanner.nextInt();
            scanner.nextLine();
            
            switch (input) {
            case 1:
            	try {
						Statement stmt = conn.createStatement();

                        stmt.executeUpdate("INSERT INTO ServiceCenter " + "(centerId,address,mechMinWage,mechMaxWage) "
								+ "VALUES(" + storeID + ", '" + address + "', "
								+ minWage + ", " + maxWage + ")");
						
						stmt.executeUpdate("INSERT INTO Users "
								+ "VALUES('" + mngrUsername.replaceAll(" ", "") + "', '"
								+ mngrPwd.replaceAll(" ", "") + "')");
						
						stmt.executeUpdate("INSERT INTO Employee " + "(userID,empID,name,address,centerId) "
								+ "VALUES('" + mngrName.replaceAll(" ", "") + "', " + mngrID 
								+ ", '" + mngrName + "', '" + address + "', " + storeID + ")");

                        stmt.executeUpdate("INSERT INTO Manager "
                                + "VALUES(" + mngrID + ", " + storeID + ", " + mngrSal + ")");
						
				} catch (SQLException e) {
					e.printStackTrace();
				}
            	System.out.println("Store made successfully");
            	break;
            case 2:
                return;
            }
        } //If anything other than 1 or 2 is entered re-prompt the user
    }

    public static void addService(Connection conn, Scanner scanner) {
        scanner.nextLine();
        while(true) {
            int input = 0;
            //Get all the service info from the user
    	    System.out.println("Enter Service info:");
    	    System.out.println("----------------------");
    	    System.out.println("(A) Service Category");
    	    String serviceCat = scanner.nextLine();
    	    System.out.println("(B) Service Name");
    	    String serviceName = scanner.nextLine();
    	    System.out.println("(C) Service Duration");
    	    String serviceDur = scanner.nextLine();

        	System.out.println("----------------------");
        	System.out.println("(1) Add Service");
            System.out.println("(2) Go Back");
            
            input = scanner.nextInt();
            scanner.nextLine();
            
            switch (input) {
            case 1:
                if (serviceCat.equals("Engine Services") || serviceCat.equals("Exhaust Services") || serviceCat.equals("Electrical Services")
                    || serviceCat.equals("Transmission Services") || serviceCat.equals("Tire Services") || serviceCat.equals("Heating and A/C Services")) {
            	    try {
						Statement stmt = conn.createStatement();

                        stmt.executeUpdate("INSERT INTO ServiceListing "
                            + "VALUES('" + serviceName + "', " + "'r'" + ")");

                        ResultSet rs = stmt.executeQuery("SELECT MAX(serviceId)"
							+ "FROM Services");
						
						int serviceId = 1;
						if (rs.next()) {
						    serviceId += rs.getInt("MAX(serviceId)");
						}

                        stmt.executeUpdate("INSERT INTO Services "
                            + "VALUES(" + serviceId + ", " + serviceDur + ")");

                        stmt.executeUpdate("INSERT INTO RepairService "
                            + "VALUES(" + serviceId + ", '" + serviceCat + "')");
                                
                        stmt.executeUpdate("INSERT INTO ServiceListingIsARepairService "
                            + "VALUES(" + serviceId + ", '" + serviceName + "')");
                    } catch (SQLException e) {
					    e.printStackTrace();
				    }
                    System.out.println("Service made successfully");
                } else {
                    System.out.println("Invalid Service Category");
                }
                break;
            case 2:
                return;
            }
        } //If anything other than 2 is entered re-prompt the user
    }

    public static void queryMenu(Connection conn, Scanner scanner) {
        while(true) {
            int input = 0;
            System.out.println("Welcome to Query Runner Menu");
            System.out.println("----------------------");
            System.out.println("(1) Query 1");
            System.out.println("(2) Query 2");
            System.out.println("(3) Query 3");
            System.out.println("(4) Query 4");
            System.out.println("(5) Query 5");
            System.out.println("(6) Query 6");
            System.out.println("(7) Back to Admin View");
            System.out.println("----------------------");
            System.out.print("Please enter a number:");

            input = scanner.nextInt();

            switch (input) {
                case 1:
                    try {
                        Statement stmt = conn.createStatement();

                        ResultSet rs = stmt.executeQuery("SELECT centerId FROM (SELECT centerId, COUNT(customerId) as customerCount FROM Customer GROUP BY centerId) WHERE customerCount = (SELECT MAX(customerCount) FROM (SELECT centerId, COUNT(customerId) as customerCount FROM Customer GROUP BY centerId))");
                    
                        if (rs.next()) {
                            System.out.println(rs.getInt("centerId"));
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    break;
                case 2:
                    try {
                        Statement stmt = conn.createStatement();


                        ResultSet rs = stmt.executeQuery("SELECT AVG(S.cost) FROM service S, ServiceListingIsARepairService R WHERE S.serviceId = R.serviceId AND R.name = 'Evaporator Repair' AND S.model = 'Honda'");

                        if (rs.next()) {
                            System.out.println(rs.getFloat("AVG(S.cost)"));
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    break;
                case 3:
                    try {
                        Statement stmt = conn.createStatement();

                        ResultSet rs = stmt.executeQuery("SELECT s.customerId FROM serviceEvent s, Invoice i WHERE s.invoiceId = i.invoiceId AND i.paid = '0' AND s.centerId = 30003");

                        while (rs.next()) {
                            System.out.println(rs.getInt("customerId"));
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    break;
                case 4:
                    try {
                        Statement stmt = conn.createStatement();


                        ResultSet rs = stmt.executeQuery("SELECT name FROM ServiceListing WHERE type = 'mr'");

                        while (rs.next()) {
                            System.out.println(rs.getString("name"));
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    break;
                case 5:
                    try {
                        Statement stmt = conn.createStatement();

                        ResultSet rs = stmt.executeQuery("SELECT ABS((" +
                            "(SELECT cost FROM service S, ServiceListingIsARepairService R WHERE S.serviceId = R.serviceId AND R.name = 'Belt Replacement' AND S.model = 'Toyota' AND S.centerId = 30001)" + " + "
                            + "(SELECT cost FROM service S, Schedule S1 WHERE S.serviceId = S1.serviceId AND S1.scheduleType = 'A' AND S.model = 'Toyota' AND S.centerId = 30001))" + " - " +
                            "((SELECT cost FROM service S, ServiceListingIsARepairService R WHERE S.serviceId = R.serviceId AND R.name = 'Belt Replacement' AND S.model = 'Toyota' AND S.centerId = 30002)" + " + "
                            + "(SELECT cost FROM service S, Schedule S1 WHERE S.serviceId = S1.serviceId AND S1.scheduleType = 'A' AND S.model = 'Toyota' AND S.centerId = 30002))) AS diff FROM dual");

                        if (rs.next()) {
                            System.out.println(rs.getInt("diff"));
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    break;
                case 6:
                    try {
                        Statement stmt = conn.createStatement();


                        ResultSet rs = stmt.executeQuery("SELECT lastMaintenanceService, CASE WHEN lastMaintenanceService = 'A' THEN 'B' WHEN lastMaintenanceService = 'B' THEN 'C'" + 
                            " WHEN lastMaintenanceService = 'C' THEN 'A' END AS nextMaintenanceService FROM Vehicle WHERE vinNumber = '34KLE19D'");
                
                        if (rs.next()) {
                            System.out.println(rs.getString("nextMaintenanceService"));
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    break;
                case 7:
                    return;
            }
        }
    }
}
