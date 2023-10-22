package src.services;

import java.sql.Connection;
import java.util.ArrayList;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;
import java.util.Map;
import java.util.HashMap;

public class CustomerService {

    public static void handleview(Connection conn, int centerID, int customerID, Scanner scanner) {
        // Stubbed Out for duplication
        ArrayList<Integer> cart = new ArrayList<Integer>();
        Map<Integer, String> cartWithName = new HashMap<Integer, String>();
        
        int input = 0;
        do {
            System.out.println("Welcome to Customer View");
            System.out.println("----------------------");
            System.out.println("(1) View and Update Profile");
            System.out.println("(2) View and Schedule Service");
            System.out.println("(3) Invoices");
            System.out.println("(4) Logout");
            System.out.println("----------------------");
            System.out.print("Please enter a number:");

            input = scanner.nextInt();

            switch (input) {
                case 1:
                    viewProfile(conn, centerID, customerID);
                    break;
                case 2:
                    viewServices(conn, centerID, customerID, cart, cartWithName, customerID);
                    break;
                case 3:
                    invoices(conn, centerID, customerID);
                    break;
                case 4:
                    break;
            }
        } while(input != 4);
        
    }

    public static void viewProfile(Connection conn, int centerID, int customerID){
        Scanner scanner = new Scanner(System.in);
        int input = 0;
        do {
        System.out.println("Customer Profile Page");
        System.out.println("---------------------");
        System.out.println("(1) View Profile");
        System.out.println("(2) Add Car");
        System.out.println("(3) Delete Car");
        System.out.println("(4) Go Back");
        System.out.println("---------------------");
        System.out.print("Please enter a number:");
        input = scanner.nextInt();
        switch (input) {
                case 1:
                    System.out.println("Viewing Profile Information");
                    System.out.println("---------------------------");
					try {
						Statement stmt = conn.createStatement();
						
						ResultSet rs = stmt.executeQuery("SELECT C.name, O.vinNumber, V.manufacturer, "
								+ "V.miles, V.lastMaintenanceService, V.year "
								+ "FROM Customer C, owns O, Vehicle V "
								+ "WHERE C.customerId = " + customerID + " AND C.centerId = " + 
								centerID + " AND C.customerId = O.customerId AND C.centerId = "
								+ "O.centerId AND O.vinNumber = V.vinNumber");
						
						while (rs.next()) {
							String name = rs.getString("name");
							String vinNumber = rs.getString("vinNumber");
							String manufacturer = rs.getString("manufacturer");
							int miles = rs.getInt("miles");
							String lastMaintenanceService = rs.getString("lastMaintenanceService");
							int year = rs.getInt("year");
							
							System.out.println("Customer ID: " + customerID);
							System.out.println("Name: " + name);
							System.out.println("Vin Number: " + vinNumber);
							System.out.println("Manufacturer: " + manufacturer);
							System.out.println("Miles: " + miles);
							System.out.println("Last Maintenance Service: " + lastMaintenanceService);
							System.out.println("Year: " + year);
							System.out.println();
						}
						
					} catch (SQLException e) {
						e.printStackTrace();
					}
					
					input = 0;
					
					while (input != 1) {
						System.out.println("(1) Go Back");
	                    System.out.println("-----------");
	                    input = scanner.nextInt();
					}
                    break;
                case 2:
                	Scanner newScan = new Scanner(System.in);
                    System.out.println("Adding Car");
                    System.out.println("----------");
                    System.out.println("Please enter the VIN of the car:");
                    String vin = newScan.nextLine();
                    System.out.println("Please enter the manufacturer of the car:");
                    String manufacturer = newScan.nextLine();
                    System.out.println("Please enter the current milage of the car:");
                    int milage = newScan.nextInt();
                    System.out.println("Please enter the year of the car:");
                    int year = newScan.nextInt();
                   
                    int saveOrCancel = 0;
                    boolean exit = false;
                    
                    while (!exit) {
                    	System.out.println("-----------------");
                    	System.out.println("(1) Save Information");
                        System.out.println("(2) Cancel");
                        System.out.println("----------");
                        System.out.print("Please enter a number:");
                        saveOrCancel = newScan.nextInt();
                        if(saveOrCancel == 1) {
                            try {
								Statement stmt = conn.createStatement();
								
								stmt.executeUpdate("INSERT INTO Vehicle "
										+ "VALUES('" + vin + "', '" + manufacturer + "', " +
										milage + ", '0', " + year + ")");
								
								stmt.executeUpdate("INSERT INTO owns "
										+ "Values(" + customerID + ", '" + vin + "', " + centerID + ")");
								
								exit = true;
							} catch (SQLException e) {
								e.printStackTrace();
							}
                        } else if (saveOrCancel == 2) {
                        	exit = true;
                        }
                    }
                    input = 4;
                    break;
                case 3:
                    System.out.println("Deleting Car");
					try {
						Statement stmt = conn.createStatement();
						
						ResultSet rs = stmt.executeQuery("SELECT O.vinNumber, V.manufacturer, "
								+ "V.miles, V.year "
								+ "FROM owns O, Vehicle V "
								+ "WHERE O.customerId = " + customerID + " AND O.centerId = " + centerID
								+ " AND O.vinNumber = V.vinNumber");
						
						while (rs.next()) {
							String vinNumber = rs.getString("vinNumber");
							String manf = rs.getString("manufacturer");
							int miles = rs.getInt("miles");
							int yr = rs.getInt("year");
							

		                    System.out.println("-------------");
							System.out.println("Vin Number: " + vinNumber);
							System.out.println("Manufacturer: " + manf);
							System.out.println("Miles: " + miles);
							System.out.println("Year: " + yr);
							System.out.println();
						}
					} catch (SQLException e) {
						e.printStackTrace();
					}
					
					Scanner newScanner = new Scanner(System.in);
                    System.out.println("Please enter the VIN of the car to delete:");
                    String vinDelete = newScanner.nextLine();
					try {
						Statement stmt2 = conn.createStatement();
						stmt2.executeUpdate("DELETE FROM Vehicle "
								+ "WHERE vinNumber = '" + vinDelete + "'");
					} catch (SQLException e) {
						e.printStackTrace();
					}
					input = 4;
                    break;
                case 4:
                    break;
            }        
        } while(input != 4);
    }

    public static void viewServices(Connection conn, int centerID, int userID, ArrayList<Integer> cart, Map<Integer, String> cartWithName, int customerID){
        Scanner scanner = new Scanner(System.in);
        int input = 0;
        do {
            System.out.println("Service Scehdule Page");
            System.out.println("---------------------");
            System.out.println("(1) View Service History");
            System.out.println("(2) Schedule Service");
            System.out.println("(3) Go Back");
            System.out.println("---------------------");
            System.out.print("Please enter a number:");
            input = scanner.nextInt();

            switch (input) {
                case 1:
                    System.out.println("---------------------");
                    System.out.println("(1) Show History");
                    System.out.println("(2) Go Back");
                    System.out.println("---------------------");
                    System.out.print("Please enter a number:");
                    int view = scanner.nextInt();
                    
                    if(view == 1){
                        try {
                        Statement stmt = conn.createStatement();
                        
                        ResultSet rs = stmt.executeQuery("select E.serviceId, E.vinNumber, S.cost, Emp.name, E.startSlotId, Ser.time, T.week, T.day, T.slot\n"
                                + "from serviceEvent E, service S, Employee Emp, Vehicle V, Services Ser, Timeslot T \n"
                                + "where E.empId = Emp.empId\n"
                                + "and E.vinNumber = V.vinNumber\n"
                                + "and E.serviceId = Ser.serviceId\n"
                                + "and T.slotId = E.startSlotId\n"
                                + "and E.customerId = " + String.valueOf(userID) + "\n"
                                + "and E.centerId = " + String.valueOf(centerID) + "\n"
                                + "and S.centerId = " + String.valueOf(centerID) + "\n"
                                + "and S.model = V.manufacturer\n"
                                + "and E.serviceId = S.serviceId");
                        
                        System.out.println("\n ServiceHistory \n");
                       while(rs.next()) {
                           int serviceId = rs.getInt("serviceId");
                           String type = "";
                           if(serviceId==113) {
                               type = "Schedule A";
                           }
                           else if(serviceId == 114) {
                               type = "Schedule B";
                           }
                           else if(serviceId == 115) {
                               type = "Schedule C";
                           }
                           else if(serviceId == 108 || serviceId == 112) {
                               type = "Maintenance and Repair";
                           }
                           else {
                               type = "repair";
                           }
                           
                           String vin = rs.getString("vinNumber");
                           String cost = rs.getString("cost");
                           String name = rs.getString("name");
                           int startSlotId = rs.getInt("startSlotId");
                           int time = rs.getInt("time");
                           int week = rs.getInt("week");
                           int day = rs.getInt("day");
                           int slot = rs.getInt("slot");
                           
                           String startDate = "Week: " + String.valueOf(week) + ", Day: " + String.valueOf(day) + ", Slot: " + String.valueOf(slot);
                           String endDate = "Week: " + String.valueOf(week) + ", Day: " + String.valueOf(day) + ", Slot: " + String.valueOf(slot+time);
                           System.out.println("Service id: "+ String.valueOf(serviceId) + " | vin:" + vin + " | type:" +type + " | cost:"+ cost + " | Mechanic Name:" + name + " | startDate:" + startDate + " | endDate:" +endDate);
                       }
                       System.out.println();
                       
                    }
                    catch (Exception e){
                        e.printStackTrace();

                    }
                    }
                    break;
                case 2:
                    scheduleServices(conn, centerID, userID, cart, cartWithName, customerID);
                    break;
                case 3:
                    break;
            }
        } while(input != 3);
    }

    public static void scheduleServices(Connection conn, int centerID, int userID, ArrayList<Integer> cart, Map<Integer, String> cartWithName, int customerID){
        Scanner scanner = new Scanner(System.in);
        int input = 0;
        int repairChoice = 0;
        int serviceId = 0;
        String serviceNameForCart = "";
        System.out.println("Please enter the VIN of the car to service:");
        String vin = scanner.next();
        System.out.println("Please enter the milage of the car to service:");
        int milage = scanner.nextInt();
        do {
            System.out.println("---------------------");
            System.out.println("(1) Add Schedule Maintenance");
            System.out.println("(2) Add Schedule Repair");
            System.out.println("(3) View Cart and Select Schedule Time");
            System.out.println("(4) Go Back");
            System.out.println("---------------------");
            System.out.print("Please enter a number:");
            input = scanner.nextInt();
            int choice;
            switch(input){
                case 1:
                	String nextService = "A";
					try {
						Statement stmt = conn.createStatement();
						
						ResultSet rs = stmt.executeQuery("SELECT "
								+ "CASE "
								+ "WHEN lastMaintenanceService = 'A' THEN 'B' "
								+ "WHEN lastMaintenanceService = 'B' THEN 'C' "
								+ "WHEN lastMaintenanceService = 'C' THEN 'A' "
								+ "WHEN lastMaintenanceService = '0' THEN 'A' "
								+ "END AS nextService "
								+ "FROM Vehicle "
								+ "WHERE vinNumber = '" + vin + "'");
						
						if (rs.next()) {
							nextService = rs.getString("nextService");
						}
					} catch (SQLException e) {
						e.printStackTrace();
					}
					
					System.out.println("Next Eligible Service: " + nextService);
                    
                    System.out.println("---------------------");
                    System.out.println("(1) Accept and Add to Cart");
                    System.out.println("(2) Decline and Go Back");
                    System.out.println("---------------------");
                    System.out.print("Please enter a number:");
                    choice = scanner.nextInt();
                    serviceNameForCart = "Schedule ";
                    if(choice == 1){
                        if (nextService.equals("A")) {
                        	serviceId = 113;
                        	serviceNameForCart += "A";
                        } else if (nextService.equals("B")) {
                        	serviceId = 114;
                        	serviceNameForCart += "B";
                        } else {
                        	serviceId = 115;
                        	serviceNameForCart += "C";
                        }
                        cart.add(serviceId);
                        cartWithName.put(serviceId, serviceNameForCart);
                    }
                    break;
                case 2:
                    String serviceName = "Schedule ";
                    do {
                        serviceId = 0;
                        System.out.println("---------------------");
                        System.out.println("(1) Engine Services");
                        System.out.println("(2) Exhaust Services");
                        System.out.println("(3) Electrical Services");
                        System.out.println("(4) Transmission Services");
                        System.out.println("(5) Tire Services");
                        System.out.println("(6) Heating and AC Services");
                        System.out.println("(7) Go Back");
                        System.out.println("---------------------");
                        System.out.print("Please enter a number:");
                        choice = scanner.nextInt();

                        if(choice == 1){
                            System.out.println("(1) Belt Replacement");
                            System.out.println("(2) Engine Repair");
                            System.out.println("---------------------");
                            System.out.print("Please enter a number:");
                            repairChoice = scanner.nextInt();
                            if(repairChoice == 1) {
                                serviceId = 101;
                                serviceNameForCart = "Belt Replacement";
                            }
                            else{
                                serviceId = 102;
                                serviceNameForCart = "Engine Repair";
                            }
                        } else if(choice == 2){
                            System.out.println("(1) Exhaust Repair");
                            System.out.println("(2) Muffler Repair");
                            System.out.println("---------------------");
                            System.out.print("Please enter a number:");
                            repairChoice = scanner.nextInt();
                            if(repairChoice == 1) {
                                serviceId = 103;
                                serviceNameForCart = "Exhaust Repair";
                            }
                            else{
                                serviceId = 104;
                                serviceNameForCart = "Muffler Repair";
                            }
                        } else if(choice == 3){
                            System.out.println("(1) Alternator Repair");
                            System.out.println("(2) Power Lock Repair");
                            System.out.println("---------------------");
                            System.out.print("Please enter a number:");
                            repairChoice = scanner.nextInt();
                            if(repairChoice == 1) {
                                serviceId = 105;
                                serviceNameForCart = "Alternator Repair";
                            }
                            else{
                                serviceId = 106;
                                serviceNameForCart = "Power Lock Repair";
                            }
                        } else if(choice == 4){
                            System.out.println("(1) Axle Repair");
                            System.out.println("(2) Brake Repair");
                            System.out.println("---------------------");
                            System.out.print("Please enter a number:");
                            repairChoice = scanner.nextInt();
                            if(repairChoice == 1) {
                                serviceId = 107;
                                serviceNameForCart = "Axle Repai";
                            }
                            else{
                                serviceId = 108;
                                serviceNameForCart = "Brake Repair";
                            }
                        } else if(choice == 5){
                            System.out.println("(1) Tire Balancing");
                            System.out.println("(2) Wheel Alignment");
                            System.out.println("---------------------");
                            System.out.print("Please enter a number:");
                            repairChoice = scanner.nextInt();
                            if(repairChoice == 1) {
                                serviceId = 109;
                                serviceNameForCart = "Tire Balancing";
                            }
                            else{
                                serviceId = 110;
                                serviceNameForCart = "Wheel Alignment";
                            }
                        } else if(choice == 6){
                            System.out.println("(1) Compressor Repair");
                            System.out.println("(2) Evaporator Repair");
                            System.out.println("---------------------");
                            System.out.print("Please enter a number:");
                            repairChoice = scanner.nextInt();
                            if(repairChoice == 1) {
                                serviceId = 111;
                                serviceNameForCart = "Compressor Repair";
                            }
                            else{
                                serviceId = 112;
                                serviceNameForCart = "Evaporator Repair";
                            }
                        } else if(choice == 7){
                            break;
                        }
                        if(serviceId != 0) {
                            cart.add(serviceId);
                            cartWithName.put(serviceId, serviceNameForCart);
                        }
                        
                    } while (choice != 7);
                    break;
                case 3:
                    System.out.println("View Cart and Select Time");
                    System.out.println("-------------------------");
                    System.out.println("Cart: ");
                    ArrayList<String> cartString = new ArrayList<String>();
                    for(int i = 0; i < cart.size(); i++) {
                        System.out.println(cartWithName.get(cart.get(i)));
                    }
                    
                    System.out.println("(1) Proceed to Scheduling");
                    System.out.println("(2) Go Back");
                    System.out.println("---------------------");
                    System.out.print("Please enter a number:");
                    choice = scanner.nextInt();
                    if(choice == 1){
                        //TODO Display the possible service times and allow
                        //user to select one. Then go back to customer landing page
                        int time = 0;
                        try {
                            Statement stmt = conn.createStatement();
                            for(int i = 0; i < cart.size(); i++) {
                                ResultSet rs = stmt.executeQuery("SELECT * FROM Services WHERE serviceId = " + cart.get(i));
                                if(rs.next()){
                                    time += rs.getInt("time");
                                } else {
                                    System.out.println("Error selecting service!");
                                }
                            }
                            ResultSet rs = stmt.executeQuery("select T.slotId, T.week, T.day, T.slot from Timeslot T, Timeslot T2\n"
                                    + "where T2.slotId - T.slotId = " + String.valueOf(time) + "\n"
                                    + "and T2.day = T.day\n"
                                    + "and T2.week = T.week\n"
                                    + "and T.slotId not in\n"
                                    + "( \n"
                                    + "select B.slotId from booked B\n"
                                    + ")\n"
                                    + "and T2.slotId not in\n"
                                    + "( \n"
                                    + "select B.slotId from booked B\n"
                                    + ") order by T.slotId");
                            if(!rs.next()){
                                System.out.println("No Time Slots Available.");
                                break;
                            }
                            System.out.println("Time Slot Selection starting");
                            System.out.println(" Slot ID |  Slot  |  Day  |  Week  ");
                        
                            do{
                                int slotId = rs.getInt("slotId");
                                int slot = rs.getInt("slot");
                                int day = rs.getInt("day");
                                int week = rs.getInt("week");
                                System.out.printf(" %7d |  %4d  |  %3d  |  %4d  \n", slotId, slot, day, week);
                            }while(rs.next());
                            System.out.println("");
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                        System.out.println("Enter slotId of Desired Timeslot: ");
                        int selectedId = scanner.nextInt();
                        try {
                        Statement stmt = conn.createStatement();
                        
                        ResultSet rs = stmt.executeQuery("select empId\n"
                                + "from\n"
                                + "(\n"
                                + "select M.empId, count(B.slotId) as count from booked B right join Mechanic M on B.empId = M.empId\n"
                                + "where M.centerId = "+ centerID +"\n"
                                + "group by M.empId\n"
                                + ")\n"
                                + "where count = \n"
                                + "(\n"
                                + "select min(count)\n"
                                + "from\n"
                                + "(\n"
                                + "select M.empId, count(B.slotId) as count from booked B right join Mechanic M on B.empId = M.empId\n"
                                + "where M.centerId = "+ centerID +"\n"
                                + "group by M.empId\n"
                                + ")\n"
                                + ")\n");
                        int empId = 0;
                        if(rs.next()) {
                            empId = rs.getInt("empId");
                        }
                        
                        for(int i = 0; i < time; i++){
                            stmt.executeUpdate("insert into booked values (" + String.valueOf(selectedId + i) + ", "+ empId +","+ centerID +", '0')");
                        }
                        
                        rs = stmt.executeQuery("select manufacturer from Vehicle where vinNumber = '"+ vin +"'");
                        String manf ="";
                        if(rs.next()) {
                            manf = rs.getString("manufacturer");
                        }
                        int cost = 0;
                        int elapsedTime = 0;
                        for (int i  = 0; i < cart.size(); i++) {
                            rs = stmt.executeQuery("select max(invoiceId) as id from Invoice");
                            int invoiceId = 0;
                            if(rs.next()) {
                                invoiceId = rs.getInt("id") + 1;
                            }
                            rs = stmt.executeQuery("select cost from Service where model = '"+ manf +"' and centerId = "+ centerID +" and serviceId = "+ cart.get(i) +"");
                            if(rs.next()) {
                                cost = rs.getInt("cost");
                            }
                            stmt.executeUpdate("insert into Invoice values ("+ (invoiceId) +", "+ cost +", '0', NULL)");
                            stmt.executeUpdate("insert into ServiceEvent values ("+ customerID +", '"+ vin+"', "+centerID+", '"+ manf +"', "+ cart.get(i) +", "+(selectedId+elapsedTime) + " ,"+empId+", "+invoiceId+")");
                            rs = stmt.executeQuery("select time from Services where serviceId = "+cart.get(i)+"");
                            if(rs.next()) {
                                elapsedTime += rs.getInt("time");
                            }
                            
                        }
                        
                        
                        System.out.println("Successfully Booked!");
                        }
                        catch(SQLException e) {
                            e.printStackTrace();
                        }
                        input = 4;
                    }
                    break;
                case 4:
                    break;
            }
        } while(input != 4);
    }

    public static void invoices(Connection conn, int centerID, int customerID){
        Scanner scanner = new Scanner(System.in);
        int input = 0;
        
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = null;
            do {
                System.out.println("Invoices");
                rs = stmt.executeQuery("SELECT I.invoiceId, I.paid FROM serviceEvent S, Invoice I WHERE " +
                                       "S.customerId = " + customerID + " AND I.invoiceId = S.invoiceId AND S.centerId = " + centerID );
                if(rs.next()){
                    System.out.println("Invoices: ");
                    System.out.println("---------------");
                    System.out.println("  ID  |  PAID  ");
                    System.out.println("---------------");
                    do {
                        int invoiceId = rs.getInt("invoiceId");
                        String paid = rs.getString("paid");
                        //TODO this may need to be modified
                        if(paid.equals("1")){
                            System.out.printf("  %2d  |  YES  \n", invoiceId);
                            System.out.println("---------------");
                        } else {
                            System.out.printf("  %2d  |  NO  \n", invoiceId);
                            System.out.println("---------------");
                        }
                    } while (rs.next());
                }
                System.out.println("----------------------");
                System.out.println("(1) View Invoice Details");
                System.out.println("(2) Pay Invoice");
                System.out.println("(3) Go Back");
                System.out.println("----------------------");
                System.out.print("Please enter a number:");

                input = scanner.nextInt();

                switch(input){
                    case 1:
                        System.out.print("Please enter an invoice id (-1 to quit):");
                        int invoiceID = scanner.nextInt();
                        System.out.println(" Invoice ID | Customer ID | VIN Number | Date (Day-Week) | Service Id | PAID | Mechanic ID |  Service Cost | Total Cost ");
                        System.out.println("------------------------------------------------------------------------------------------------------------------------");
                        
                        while(invoiceID != -1){
                            //TODO type?
                            rs = stmt.executeQuery("SELECT I.invoiceId, S.customerId, S.vinNumber, T.day, T.week, S.serviceId, " +
                                                    "I.paid, S.empId, Serv.cost, I.bill " +
                                                    "FROM Invoice I, serviceEvent S, Timeslot T, service Serv " +
                                                    "WHERE I.invoiceId = " + invoiceID + " AND " +
                                                    "S.InvoiceId = I.invoiceId AND S.startSlotId = T.slotId AND " +
                                                    "S.serviceId = Serv.serviceID AND S.model = Serv.model AND " +
                                                    "Serv.centerId = " + centerID);
                            if(rs.next()) {
                                int invId = rs.getInt("invoiceId");
                                int custId = rs.getInt("customerId");
                                String vin = rs.getString("vinNumber");
                                int day = rs.getInt("day");
                                int week = rs.getInt("week");
                                int mech = rs.getInt("empId");
                                int servId = rs.getInt("serviceId");
                                String paid = rs.getString("paid");
                                float servCost = rs.getFloat("cost");
                                float totalCost = rs.getFloat("bill");
                                System.out.printf(" %10d | %11d | %10s |      %2d-%2d     | %10d |  %1s | %11s |  %10.2f | %8.2f \n", invId, custId, vin, day, week, servId, paid, mech, servCost, totalCost);
                            } else {
                                System.out.println("This invoice id does not exist.");
                                
                            }
                            System.out.print("Please enter an invoice id (-1 to quit):");
                            invoiceID = scanner.nextInt();
                            System.out.println(" Invoice ID | Customer ID | VIN Number | Date (Day-Week) | Service Id | PAID | Mechanic ID |  Service Cost | Total Cost ");
                            System.out.println("------------------------------------------------------------------------------------------------------------------------");
                        }
                        break;
                    case 2:
                        int choice = 0;
                        do {
                            System.out.print("Please enter an invoice id (or enter -1 then 2):");
                            int invoicePay = scanner.nextInt();
                            rs = stmt.executeQuery("SELECT * FROM Invoice WHERE Invoice.invoiceId = " + invoicePay);
                            if(rs.next()) {
                                System.out.println("----------------------");
                                System.out.println("(1) Pay Invoice");
                                System.out.println("(2) Go Back");
                                System.out.println("----------------------");
                                System.out.print("Please enter a number:");
                                choice = scanner.nextInt();
                                if(choice == 1){
                                    rs = stmt.executeQuery("SELECT * FROM Invoice WHERE Invoice.invoiceId = " + invoicePay +
                                                            " AND Invoice.paid = '0'");
                                    if(rs.next()){
                                        stmt.executeUpdate("UPDATE Invoice SET paid = '1' WHERE invoiceId = " + invoicePay);
                                        System.out.println("This invoice has been paid.");
                                        System.out.println("---------------------------");
                                    } else {
                                        System.out.println("----------------------------------");
                                        System.out.println("This invoice has already been paid.");
                                        System.out.println("-----------------------------------");
                                    }
                                }
                            } else {
                                System.out.println("----------------------------------");
                                System.out.println("No invoice with this ID was found.");
                                System.out.println("-----------------------------------");
                            }
                        } while (choice != 2);
                        break;
                    case 3:
                        break;
                }
            } while (input != 3);
        } catch (Exception e) {
            System.out.println("Error :" + e);
        }
    }
}
