package src.services;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class ManagerService {

    public static void handleview(Connection conn, int centerID, Scanner scanner) {
        int input = 0;
        do {
            System.out.println("Welcome to Manager View");
            System.out.println("----------------------");
            System.out.println("(1) Setup Store");
            System.out.println("(2) Add New Employee");
            System.out.println("(3) Logout");
            System.out.println("----------------------");
            System.out.print("Please enter a number:");

            input = scanner.nextInt();

            switch (input) {
                case 1:
                	//Travel to store setup method
                    setupStore(conn, centerID);
                    break;
                case 2:
                	//Travel to add employee method
                    addEmployees(conn, centerID);
                    break;
                case 3:
                    break;
            }
        } while(input > 3); //If anything besides 1, 2, or 3 is entered just re-prompt the user
        
    }
    
    public static void setupStore(Connection conn, int centerID) {
        int input = 0;
        Scanner scanner = new Scanner(System.in);
        do {
        	System.out.println("Setup Store");
            System.out.println("----------------------");
            System.out.println("(1) Add Employees");
            System.out.println("(2) Setup Operational Hours");
            System.out.println("(3) Setup Service Prices");
            System.out.println("(4) Go Back");
            System.out.println("----------------------");
            System.out.print("Please enter a number:");
            
            input = scanner.nextInt();
            
            switch (input) {
            case 1:
            	//Travel to add employee method
                addEmployees(conn, centerID);
                break;
            case 2:
            	//Travel to setup hours method
                setupOperationalHours(conn, centerID);
                break;
            case 3:
            	//Travel to setup prices method
            	setupServicePrices(conn, centerID);
                break;
            case 4:
            	//Go back to main manager screen
            	handleview(conn, centerID, scanner);
            	break;
        }
        } while (input > 4); //If anything other than 1, 2, 3, or 4 is entered re-prompt the user
            	
    }
    
    public static void addEmployees(Connection conn, int centerID) {
    	Scanner scanner = new Scanner(System.in);
    	//Get all the employee info from the user
    	System.out.println("Enter employee info:");
    	System.out.println("----------------------");
    	System.out.println("(A) Name");
    	String name = scanner.nextLine();
    	System.out.println("(B) Address");
    	String address = scanner.nextLine();
    	System.out.println("(C) Email Address");
    	String email = scanner.nextLine();
    	System.out.println("(D) Phone Number");
    	String phoneNumber = scanner.nextLine();
    	System.out.println("(E) Role");
    	String role = scanner.nextLine();
    	System.out.println("(F) Start Date");
    	String startDate = scanner.nextLine();
    	System.out.println("(G) Compensation");
    	String compensation = scanner.nextLine();
    	
    	int input = 0;
        
        do {
        	System.out.println("----------------------");
        	System.out.println("(1) Add");
            System.out.println("(2) Go Back");
            
            input = scanner.nextInt();
            
            switch (input) {
            case 1:
            	//If the entered role was for receptionist
            	if (role.toLowerCase().equals("receptionist")) {
            		//Print out the employee info for now
            		try {
						Statement stmt = conn.createStatement();
						
						ResultSet rs = stmt.executeQuery("SELECT MAX(empId) "
								+ "FROM Employee "
								+ "WHERE centerId = " + centerID);
						
						int empId = 1;
						if (rs.next()) {
							empId += rs.getInt("MAX(empId)");
						}

						stmt.executeUpdate("INSERT INTO Users "
								+ "VALUES('" + name.replaceAll(" ", "") + "', '"
								+ name.replaceAll(" ", "") + "')");
						
						stmt.executeUpdate("INSERT INTO Employee "
								+ "VALUES('" + name.replaceAll(" ", "") + "', " + empId 
								+ ", '" + name + "', '" + address + "', '" + email + "', '"
								+ phoneNumber + "', " + centerID + ")");
						
						stmt.executeUpdate("INSERT INTO Receptionist "
								+ "VALUES(" + empId + ", " + centerID + ", "
								+ compensation + ")");
					} catch (SQLException e) {
						e.printStackTrace();
					}
            		System.out.println("You are making a receptionist with name: " + name
            				+ " addresss: " + address + " email: " + email + " phone number: " +
            				phoneNumber + " start date: " + startDate + " compensation: " + compensation);
            		
            		//Travel back to the setup store screen
            		setupStore(conn, centerID);
            	//If the entered role was for mechanic
            	} else if (role.toLowerCase().equals("mechanic")) {
            		//Print out the employee info for now
            		try {
						Statement stmt = conn.createStatement();
						
						ResultSet rs = stmt.executeQuery("SELECT MAX(empId) "
								+ "FROM Employee "
								+ "WHERE centerId = " + centerID);
						
						int empId = 1;
						if (rs.next()) {
							empId += rs.getInt("MAX(empId)");
						}
						
						stmt.executeUpdate("INSERT INTO Users "
								+ "VALUES('" + name.replaceAll(" ", "") + "', '"
								+ name.replaceAll(" ", "") + "')");
						
						stmt.executeUpdate("INSERT INTO Employee "
								+ "VALUES('" + name.replaceAll(" ", "") + "', " + empId
								+ ", '" + name + "', '" + address + "', '" + email + "', '"
								+ phoneNumber + "', " + centerID + ")");
						
						stmt.executeUpdate("INSERT INTO Mechanic "
								+ "VALUES(" + empId + ", " + centerID + ")");
					} catch (SQLException e) {
						e.printStackTrace();
					}
            		System.out.println("You are making a mechanic with name: " + name
            				+ " addresss: " + address + " email: " + email + " phone number: " +
            				phoneNumber + " start date: " + startDate);
            		//Travel back to the setup store screen
            		setupStore(conn, centerID);
            	} else {
            		//Otherwise, print invalid role and re-prompt user for employee info
            		System.out.println("Invalid role");
            		addEmployees(conn, centerID);
            	}
            	break;
            case 2:
            	//Go back to setup store screen
            	setupStore(conn, centerID);
            	break;
            }
        } while ( input > 2); //If anything other than 1 or 2 is entered re-prompt the user
    }
    
    public static void setupOperationalHours(Connection conn, int centerID) {
    	Scanner scanner = new Scanner(System.in);
    	
    	//Get operational hours info from user
    	System.out.println("Enter operation hours info:");
    	System.out.println("----------------------------");
    	System.out.println("(A) Operational on Saturdays? (y/n)");
    	
    	String response = scanner.nextLine();
    	
    	int input = 0;
    	
    	do {
    		System.out.println("----------------------------");
        	System.out.println("(1) Setup Operational Hours");
            System.out.println("(2) Go Back");
            
            input = scanner.nextInt();
            
            switch (input) {
            case 1:
            	//If the user responded yes
            	if (response.toLowerCase().equals("y")) {
            		//Print out their response for now
            		try {
						Statement stmt = conn.createStatement();
						
						stmt.executeUpdate("UPDATE ServiceCenter "
								+ "SET openSaturday = 'y' "
								+ "WHERE centerId = " + centerID);
					} catch (SQLException e) {
						e.printStackTrace();
					}
            		System.out.println("You are setting the center to be open on Saturday");
            		//Go back to setup store screen
            		setupStore(conn, centerID);
            	} else if (response.toLowerCase().equals("n")) {
            		//Print out their response for now
            		try {
						Statement stmt = conn.createStatement();
						
						stmt.executeUpdate("UPDATE ServiceCenter "
								+ "SET openSaturday = 'n' "
								+ "WHERE centerId = " + centerID);
					} catch (SQLException e) {
						e.printStackTrace();
					}
            		System.out.println("You are setting the center to not be open on Saturday");
            		//Go back to setup store screen
            		setupStore(conn, centerID);
            	} else {
            		//Otherwise, print invalid response and re-prompt the user
            		System.out.println("Invalid y/n response");
            		addEmployees(conn, centerID);
            	}
            	break;
            case 2:
            	//Go back to setup store screen
            	setupStore(conn, centerID);
            	break;
            }            
    	} while (input > 2); //If anything but 1 or 2 is entered re-prompt the user
    	
    	
    }
    
    public static void setupServicePrices(Connection conn, int centerID) {
    	Scanner scanner = new Scanner(System.in);
    	
    	int input = 0;
    	
    	do {
    		System.out.println("Setup Service Prices");
            System.out.println("----------------------");
            System.out.println("(1) Setup Maintenance Service Prices");
            System.out.println("(2) Setup Repair Service Prices");
            System.out.println("(3) Go back");
            System.out.println("----------------------");
            System.out.print("Please enter a number:");
            
            input = scanner.nextInt();
            
            switch (input) {
            case 1:
            	//Travel to the maintenance price page
            	setupMaintenancePrices(conn, centerID);
            	break;
            case 2:
            	//Travel to the repair price page
            	setupRepairPrices(conn, centerID);
            	break;
            case 3:
            	//Go back to the store setup page
            	setupStore(conn, centerID);
            	break;
            }
    	} while (input > 3);
    	
    	
    }
    
    public static void setupMaintenancePrices(Connection conn, int centerID) {
    	Scanner scanner = new Scanner(System.in);
    	
    	//Get maintenance price info from user
    	System.out.println("Enter maintenance price info:");
    	System.out.println("-----------------------------");
    	System.out.println("(A1) Schedule A price for Honda");
    	int aPriceHonda = scanner.nextInt();
    	System.out.println("(A2) Schedule A price for Nissan");
    	int aPriceNissan = scanner.nextInt();
    	System.out.println("(A3) Schedule A price for Toyota");
    	int aPriceToyota = scanner.nextInt();
    	System.out.println("(B1) Schedule B price for Honda");
    	int bPriceHonda = scanner.nextInt();
    	System.out.println("(B2) Schedule B price for Nissan");
    	int bPriceNissan = scanner.nextInt();
    	System.out.println("(B3) Schedule B price for Toyota");
    	int bPriceToyota = scanner.nextInt();
    	System.out.println("(C1) Schedule C price for Honda");
    	int cPriceHonda = scanner.nextInt();
    	System.out.println("(C2) Schedule C price for Nissan");
    	int cPriceNissan = scanner.nextInt();
    	System.out.println("(C3) Schedule C price for Toyota");
    	int cPriceToyota = scanner.nextInt();
    	
    	int input = 0;
    	
    	do {
    		System.out.println("----------------------------");
        	System.out.println("(1) Setup Prices");
            System.out.println("(2) Go Back");
            
            input = scanner.nextInt();
            
            switch (input) {
            case 1:
            	//Print out the set schedule prices for now
            	try {
					Statement stmt = conn.createStatement();
					
					ResultSet rs = stmt.executeQuery("SELECT serviceId "
							+ "FROM Schedule "
							+ "WHERE scheduleType = 'A'");
					
					int schedAId = 0;
					if (rs.next()) {
						schedAId = rs.getInt("serviceId");
					}
					
					rs = stmt.executeQuery("SELECT serviceId "
							+ "FROM Schedule "
							+ "WHERE scheduleType = 'B'");
					
					int schedBId = 0;
					if (rs.next()) {
						schedBId = rs.getInt("serviceId");
					}
					
					rs = stmt.executeQuery("SELECT serviceId "
							+ "FROM Schedule "
							+ "WHERE scheduleType = 'C'");
					
					int schedCId = 0;
					if (rs.next()) {
						schedCId = rs.getInt("serviceId");
					}
					
					//Insert or update schedule A
					System.out.println("Hit Query");
					rs = stmt.executeQuery("SELECT * "
							+ "FROM service "
							+ "WHERE centerId = " + centerID + " AND serviceId = " + schedAId + " AND model = 'Honda'");
					
					if (rs.next()) {
						System.out.println("Hit Update: " + rs.getInt("serviceId") + " " + rs.getInt("centerId"));
						stmt.executeUpdate("UPDATE service "
								+ "SET cost = " + aPriceHonda + " "
								+ "WHERE centerId = " + centerID + " AND serviceId = " + schedAId + " AND model = 'Honda'");
					} else {
						System.out.println("Hit Insert");
						stmt.executeUpdate("INSERT INTO service "
								+ "VALUES('Honda', " + schedAId + ", " + centerID + ", " + aPriceHonda + ")");
					}
					
					rs = stmt.executeQuery("SELECT * "
							+ "FROM service "
							+ "WHERE centerId = " + centerID + " AND serviceId = " + schedAId + " AND model = 'Nissan'");
					
					if (rs.next()) {
						stmt.executeUpdate("UPDATE service "
								+ "SET cost = " + aPriceNissan + " "
								+ "WHERE centerId = " + centerID + " AND serviceId = " + schedAId + " AND model = 'Nissan'");
					} else {
						stmt.executeUpdate("INSERT INTO service "
								+ "VALUES('Nissan', " + schedAId + ", " + centerID + ", " + aPriceNissan + ")");
					}
					
					rs = stmt.executeQuery("SELECT * "
							+ "FROM service "
							+ "WHERE centerId = " + centerID + " AND serviceId = " + schedAId + " AND model = 'Toyota'");
					
					if (rs.next()) {
						stmt.executeUpdate("UPDATE service "
								+ "SET cost = " + aPriceToyota + " "
								+ "WHERE centerId = " + centerID + " AND serviceId = " + schedAId + " AND model = 'Toyota'");
					} else {
						stmt.executeUpdate("INSERT INTO service "
								+ "VALUES('Toyota', " + schedAId + ", " + centerID + ", " + aPriceToyota + ")");
					}
					
					//Insert or update schedule B
					rs = stmt.executeQuery("SELECT * "
							+ "FROM service "
							+ "WHERE centerId = " + centerID + " AND serviceId = " + schedBId + " AND model = 'Honda'");
					
					if (rs.next()) {
						stmt.executeUpdate("UPDATE service "
								+ "SET cost = " + bPriceHonda + " "
								+ "WHERE centerId = " + centerID + " AND serviceId = " + schedBId + " AND model = 'Honda'");
					} else {
						stmt.executeUpdate("INSERT INTO service "
								+ "VALUES('Honda', " + schedBId + ", " + centerID + ", " + bPriceHonda + ")");
					}
					
					rs = stmt.executeQuery("SELECT * "
							+ "FROM service "
							+ "WHERE centerId = " + centerID + " AND serviceId = " + schedBId + " AND model = 'Nissan'");
					
					if (rs.next()) {
						stmt.executeUpdate("UPDATE service "
								+ "SET cost = " + bPriceNissan + " "
								+ "WHERE centerId = " + centerID + " AND serviceId = " + schedBId + " AND model = 'Nissan'");
					} else {
						stmt.executeUpdate("INSERT INTO service "
								+ "VALUES('Nissan', " + schedBId + ", " + centerID + ", " + bPriceNissan + ")");
					}
					
					rs = stmt.executeQuery("SELECT * "
							+ "FROM service "
							+ "WHERE centerId = " + centerID + " AND serviceId = " + schedBId + " AND model = 'Toyota'");
					
					if (rs.next()) {
						stmt.executeUpdate("UPDATE service "
								+ "SET cost = " + bPriceToyota + " "
								+ "WHERE centerId = " + centerID + " AND serviceId = " + schedBId + " AND model = 'Toyota'");
					} else {
						stmt.executeUpdate("INSERT INTO service "
								+ "VALUES('Toyota', " + schedBId + ", " + centerID + ", " + bPriceToyota + ")");
					}
					
					//Insert or update schedule C
					rs = stmt.executeQuery("SELECT * "
							+ "FROM service "
							+ "WHERE centerId = " + centerID + " AND serviceId = " + schedCId + " AND model = 'Honda'");
					
					if (rs.next()) {
						stmt.executeUpdate("UPDATE service "
								+ "SET cost = " + cPriceHonda + " "
								+ "WHERE centerId = " + centerID + " AND serviceId = " + schedCId + " AND model = 'Honda'");
					} else {
						stmt.executeUpdate("INSERT INTO service "
								+ "VALUES('Honda', " + schedCId + ", " + centerID + ", " + cPriceHonda + ")");
					}
					
					rs = stmt.executeQuery("SELECT * "
							+ "FROM service "
							+ "WHERE centerId = " + centerID + " AND serviceId = " + schedCId + " AND model = 'Nissan'");
					
					if (rs.next()) {
						stmt.executeUpdate("UPDATE service "
								+ "SET cost = " + cPriceNissan + " "
								+ "WHERE centerId = " + centerID + " AND serviceId = " + schedCId + " AND model = 'Nissan'");
					} else {
						stmt.executeUpdate("INSERT INTO service "
								+ "VALUES('Nissan', " + schedCId + ", " + centerID + ", " + cPriceNissan + ")");
					}
					
					rs = stmt.executeQuery("SELECT * "
							+ "FROM service "
							+ "WHERE centerId = " + centerID + " AND serviceId = " + schedCId + " AND model = 'Toyota'");
					
					if (rs.next()) {
						stmt.executeUpdate("UPDATE service "
								+ "SET cost = " + cPriceToyota + " "
								+ "WHERE centerId = " + centerID + " AND serviceId = " + schedCId + " AND model = 'Toyota'");
					} else {
						stmt.executeUpdate("INSERT INTO service "
								+ "VALUES('Toyota', " + schedCId + ", " + centerID + ", " + cPriceToyota + ")");
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
            	//Then go back to setup service price page
            	setupServicePrices(conn, centerID);
            	break;
            case 2:
            	//Go back to setup service price page
            	setupServicePrices(conn, centerID);
            	break;
            }
    		
    	} while (input > 2); //If anything other than 1 or 2 is entered re-prompt the user
    	
    	
    }
    
    public static void setupRepairPrices(Connection conn, int centerID) {
    	Scanner scanner = new Scanner(System.in);
    	
    	try {
			Statement stmt = conn.createStatement();
			
			ResultSet rs = stmt.executeQuery("SELECT S.name, R.serviceId "
					+ "FROM ServiceListing S, ServiceListingIsARepairService R, service S2 "
					+ "WHERE (S.type = 'r' OR S.type = 'mr') AND R.name = S.name");
			
			HashMap<String, Integer> repairMap = new HashMap<String, Integer>();
			
			while(rs.next()) {
				repairMap.put(rs.getString("name"), rs.getInt("serviceId"));
			}
			
			for (Map.Entry<String, Integer> e : repairMap.entrySet()) {
				String name = e.getKey();
				int serviceID = e.getValue();
				
				System.out.println("Enter " + name + " price for Honda: ");
				int hondaPrice = scanner.nextInt();
				
				System.out.println("Enter " + name + " price for Nissan: ");
				int nissanPrice = scanner.nextInt();
				
				System.out.println("Enter " + name + " price for Toyota: ");
				int toyotaPrice = scanner.nextInt();
				
				rs = stmt.executeQuery("SELECT * "
						+ "FROM service "
						+ "WHERE serviceId = " + serviceID + " AND centerId = " + centerID + " AND model = 'Honda'");
				
				if (rs.next()) {
					stmt.executeUpdate("UPDATE service "
							+ "SET cost = " + hondaPrice
							+ " WHERE centerId = " + centerID + " AND serviceId = " + serviceID + " AND model = 'Honda'");
				} else {
					stmt.executeUpdate("INSERT INTO service "
							+ "VALUES('Honda', " + serviceID + ", " + centerID + ", " + hondaPrice + ")");
				}
				
				rs = stmt.executeQuery("SELECT * "
						+ "FROM service "
						+ "WHERE serviceId = " + serviceID + " AND centerId = " + centerID + " AND model = 'Nissan'");
				
				if (rs.next()) {
					stmt.executeUpdate("UPDATE service "
							+ "SET cost = " + nissanPrice
							+ " WHERE centerId = " + centerID + " AND serviceId = " + serviceID + " AND model = 'Nissan'");
				} else {
					stmt.executeUpdate("INSERT INTO service "
							+ "VALUES('Nissan', " + serviceID + ", " + centerID + ", " + nissanPrice + ")");
				}
				
				rs = stmt.executeQuery("SELECT * "
						+ "FROM service "
						+ "WHERE serviceId = " + serviceID + " AND centerId = " + centerID + " AND model = 'Toyota'");
				
				if (rs.next()) {
					stmt.executeUpdate("UPDATE service "
							+ "SET cost = " + toyotaPrice
							+ " WHERE centerId = " + centerID + " AND serviceId = " + serviceID + " AND model = 'Toyota'");
				} else {
					stmt.executeUpdate("INSERT INTO service "
							+ "VALUES('Toyota', " + serviceID + ", " + centerID + ", " + toyotaPrice + ")");
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	
    	int input = 0;

    	do {
    		System.out.println("----------------------------");
        	System.out.println("(1) Setup Prices");
            System.out.println("(2) Go Back");

            input = scanner.nextInt();

            switch (input) {
            case 1:
            	setupServicePrices(conn, centerID);
            	break;
            case 2:
            	setupServicePrices(conn, centerID);
            	break;
            }
    	} while (input > 2);
    	
    	
    }
}
