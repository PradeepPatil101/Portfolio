package src.services;

import java.util.Scanner;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class ReceptionistService {

    public static void handleview(Connection conn, int empID, int centerID, Scanner scanner) {
        // Stubbed Out for duplication
        int input = 0;
        do {
            System.out.println("Welcome to Receptionist View");
            System.out.println("----------------------");
            System.out.println("(1) Add New Customer Profile");
            System.out.println("(2) Find Customers with Pending Invoices");
            System.out.println("(3) Logout");
            System.out.println("----------------------");
            System.out.print("Please enter a number:");

            input = scanner.nextInt();

            switch (input) {
                case 1:
                    addNewCustomer(conn, empID, centerID, scanner);
                    break;
                case 2:
                    findCustomersWithPendingInvoices(conn, empID, centerID);
                    break;
                case 3:
                    break;
            }
        } while(input != 3);
    }

    public static void addNewCustomer(Connection conn, int empID, int centerID, Scanner scanner){
        System.out.println("Enter Customer Information: "); 
        scanner.nextLine();
        System.out.println("  Enter New Customer's user id: "); 
        String userId = scanner.nextLine();
        System.out.println("  Enter New Customer's password: "); 
        String password = scanner.nextLine();
        System.out.println("  Enter customerId: "); 
        String customerId = scanner.nextLine();
        System.out.println("  Enter Name: "); 
        String name = scanner.nextLine();
        System.out.println("  Enter Address: "); 
        String address = scanner.nextLine();
        System.out.println("  Enter Email: "); 
        String email = scanner.nextLine();
        System.out.println("  Enter Ph No: "); 
        String phoneNumber = scanner.nextLine();
        System.out.println("Vehicle Information: "); 
        System.out.println("  Enter Vin Number: "); 
        String vinNumber = scanner.nextLine();
        System.out.println("  Enter Manufacturer: "); 
        String manufacturer = scanner.nextLine();
        System.out.println("  Enter Vehicle Miles: "); 
        String miles = scanner.nextLine();
        //char lastMaintenanceService = 'A';
        System.out.println("  Enter Year: "); 
        String year = scanner.nextLine();
        System.out.println("(1) Confirm Adding New Customer\n(2) Go Back "); 
        int input = 0;
        input = scanner.nextInt();
        if(input == 1) {
	
	try{
		Statement stmt = conn.createStatement();			
		stmt.executeQuery("insert into Users values (\'" + userId + "\', \'" + password + "\')");
		stmt.executeQuery("insert into Customer values (\'" + userId + "\'," + customerId + " , \'"+ name +"\', \'"+ address +"\', \'"+ email +"\', \'"+ phoneNumber +"\', \'1\', "+ String.valueOf ( centerID )+")");
		stmt.executeQuery("insert into Vehicle values (\'" + vinNumber + "\', '"+ manufacturer +"\', "+ miles + ", "+ '0' + ", "+ year+")");
		stmt.executeQuery("insert into owns values("+ customerId +", \'"+ vinNumber +"\', "+ String.valueOf ( centerID ) +")");
		System.out.println("Successfully added new customer");
	}
	catch (Exception e){
		e.printStackTrace();
	}
        }
        else {
            return;
        }
        
    }
    
    public static void findCustomersWithPendingInvoices(Connection conn, int empID, int centerID) {
        try{

            Statement stmt = conn.createStatement();
                            
            ResultSet rs = stmt.executeQuery("select C.customerId, C.name, I.invoiceId, I.invoiceDate, I.bill \n"
                    + "from serviceEvent S, Invoice I, Customer C\n"
                    + "where S.invoiceId = I.invoiceId\n"
                    + "and S.customerId = C.customerId\n"
                    + "and S.centerId = C.centerId\n"
                    + "and I.paid = '0'\n"
                    + "and S.centerId = " + centerID);
            
            System.out.println("\n Customers with Pending Invoices: \n");
           while(rs.next()) {
               String customerId = rs.getString("customerId");
               String name = rs.getString("name");
               String invoiceId = rs.getString("invoiceId");
               String date = rs.getString("invoiceDate");
               float bill = rs.getFloat("bill");
               System.out.println("Id: "+customerId + " , Name: " + name + " , InvoiceId: " + invoiceId + " , InvoiceDate: " + date + " , Bill: " + String.valueOf(bill) );
           }
           System.out.println();
           
        }
        catch (Exception e){
            e.printStackTrace();

        }
        
    }

}
