package src.services;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class MechanicService {

    public static void handleview(Connection conn, int empID, int centerID, Scanner scanner) {
        // Stubbed Out for duplication
        int input = 0;
        do {
            System.out.println("Welcome to Mechanic View");
            System.out.println("----------------------");
            System.out.println("(1) View Schedule");
            System.out.println("(2) Request Time Off");
            System.out.println("(3) Request Swap");
            System.out.println("(4) View Swap Requests");
            System.out.println("(5) Exit");
            System.out.println("----------------------");
            System.out.print("Please enter a number:");

            input = scanner.nextInt();

            switch (input) {
                case 1:
                    viewSchedule(conn, empID, centerID);      
                    break;
                case 2:
                    requestTimeOff(conn, empID, centerID, scanner);                    
                    break;
                case 3:
                    requestSwap(conn, empID, centerID, scanner);  
                    break;
                case 4:
                    viewSwap(conn, empID, centerID, scanner);  
                    break;
                case 5:
                    break;
            }
        } while(input != 5);
    }

    public static void viewSchedule(Connection conn, int empID, int centerID) {
        System.out.println("Executing View Schedule");
        ResultSet rs = null;
        try {
        	Statement stmt = conn.createStatement();
        	
            rs = stmt.executeQuery("SELECT S.day, S.week, S.slot "
                                    + "FROM booked B, Mechanic M, Timeslot S "
                                    + "WHERE B.empId = M.empId AND S.slotId = B.slotId AND M.empId = " + empID + " AND M.centerId = " + centerID);
            
            if(!rs.next()){
                System.out.println("You currently have no work scheduled.");
                System.out.println("-------------------------------------");
            } else {
                System.out.println(" Slot | Day | Week ");
                
                do {
                    int slot =  rs.getInt("slot");
                    int day =  rs.getInt("day");
                    int week = rs.getInt("week");
                    System.out.printf("  %2d  | %2d  |  %2d  \n", slot, day, week);
                } while(rs.next());
                System.out.println("-------------------------------------");
            }
        } catch(SQLException e) {
            System.out.println("Error: " + e);
        }
    }

    public static void requestTimeOff(Connection conn, int empID, int centerID, Scanner scanner){
        int input = 0;
        ResultSet rs = null;
        do {        
            System.out.println("Time Off Request Menu");
            System.out.println("----------------------");
            System.out.println("(1) Request Time Off");
            System.out.println("(2) Exit");
            System.out.println("----------------------");
            System.out.print("Please enter a number:");

            input = scanner.nextInt();
            switch (input) {
                case(1):                    
                    try {
                        Statement stmt = conn.createStatement();
                        rs = stmt.executeQuery("SELECT COUNT(*) AS MechCount FROM Mechanic WHERE centerId = " + centerID);
                        rs.next();
                        int mechCount = rs.getInt("MechCount");
                        if(mechCount <= 3){
                            System.out.println("Too few Mechanics to allow time off.");
                            break;
                        }
                        System.out.print("Please enter the slot of your break start: ");
                        int startSlot = scanner.nextInt();
                        System.out.print("Please enter the day of your break start: ");
                        int startDay = scanner.nextInt();
                        System.out.print("Please enter the week of your break start: ");
                        int startWeek = scanner.nextInt();
                        System.out.print("Please enter the slot of your break end: ");
                        int endSlot = scanner.nextInt();
                        System.out.print("Please enter the day of your break end: ");
                        int endDay = scanner.nextInt();
                        System.out.print("Please enter the week of your break end: ");
                        int endWeek = scanner.nextInt();
                    	
                    	//Check constraint? 
                        rs = stmt.executeQuery("SELECT B.slotId FROM booked B, Timeslot S " + 
                                               "WHERE S.slotId = B.slotId AND " +
                                               "B.empId = "  + empID + " AND " +
                                               "B.centerId = "  + centerID + " AND " +
                                               "(" + 
                                               "(S.week > " + startWeek + ") OR " + "(S.week = " + startWeek + " AND S.day > " + startDay + ") OR " + "(S.week = " + startWeek + " AND S.day = " + startDay + " AND S.slot >= " + startSlot + ")" +
                                               ") AND (" +
                                               "(S.week < " + endWeek + ") OR " + "(S.week = " + endWeek + " AND S.day < " + endDay + ") OR " + "(S.week = " + endWeek + " AND S.day = " + endDay + " AND S.slot <= " + endSlot + ")" +
                                               ")");

                        if(rs.next()){
                            System.out.println("Unable to grant time off. You currently have  work scheduled.");
                            System.out.println("--------------------------------------------------------------");
                            break;
                        }

                        for(int i = startWeek; i <= endWeek; i++){
                            for(int j = 1; j <= 7; j++){
                                for(int k = 1; k <= 11; k++){
                                    if((i == startWeek && j < startDay) || (i == startWeek && j == startDay && k < startSlot)){
                                        continue;
                                    } else if((i == endWeek && j > endDay) || (i == endWeek && j == endDay && k > endSlot)){
                                        continue;
                                    } else {
                                        rs = stmt.executeQuery("SELECT S.slotId FROM Timeslot S " + 
                                               "WHERE S.week = " + i + " AND " +
                                               "S.day = " + j + " AND " +
                                               "S.slot = " + k);
                                        if(!rs.next()){
                                            System.out.println("Unable to find timeslot.");
                                            System.out.println("------------------------");
                                        } else {
                                            int slotId = rs.getInt("slotId");
                                            stmt.executeUpdate("INSERT INTO booked " +
                                                                "VALUES(" + slotId + ", " + empID + ", " + centerID +", '1')");
                                        }

                                    }
                                }
                            }
                        } 
                    } catch(SQLException e) {
                    System.out.println("Error: " + e);
                    }
                    break;
                case(2):
                    break;
            }
        }while(input != 2);
    }

    public static void requestSwap(Connection conn, int empID, int centerID, Scanner scanner){
        int input = 0;
        ResultSet rs = null;
        
        do {
            System.out.println("Swap Request Menu");
            System.out.println("----------------------");
            System.out.println("(1) Request Swap");
            System.out.println("(2) Exit");
            System.out.println("----------------------");
            System.out.print("Please enter a number:");

            input = scanner.nextInt();

            switch (input) {
                case 1:
                    try{
                        Statement stmt = conn.createStatement();
                        System.out.print("Please enter the slot of your swap start: ");
                        int startSlot = scanner.nextInt();
                        System.out.print("Please enter the day of your swap start: ");
                        int startDay = scanner.nextInt();
                        System.out.print("Please enter the week of your swap start: ");
                        int startWeek = scanner.nextInt();
                        System.out.print("Please enter the slot of your swap end: ");
                        int endSlot = scanner.nextInt();
                        System.out.print("Please enter the day of your swap end: ");
                        int endDay = scanner.nextInt();
                        System.out.print("Please enter the week of your swap end: ");
                        int endWeek = scanner.nextInt();

                        System.out.print("Please enter the employee id of the mechanic you would like to swap with: ");
                        int swapID = scanner.nextInt();

                        System.out.print("Please enter the slot of what you would like to take start: ");
                        int takeStartSlot = scanner.nextInt();
                        System.out.print("Please enter the day of what you would like to take  start: ");
                        int takeStartDay = scanner.nextInt();
                        System.out.print("Please enter the week of what you would like to take  start: ");
                        int takeStartWeek = scanner.nextInt();
                        System.out.print("Please enter the slot of what you would like to take  end: ");
                        int takeEndSlot = scanner.nextInt();
                        System.out.print("Please enter the day of what you would like to take  end: ");
                        int takeEndDay = scanner.nextInt();
                        System.out.print("Please enter the week of what you would like to take  end: ");
                        int takeEndWeek = scanner.nextInt();

                        //This needs to be modified
                        rs = stmt.executeQuery("SELECT MAX(referenceId) FROM swaps");
                        rs.next();
                        int maxId = rs.getInt("MAX(referenceId)");
                        maxId++;

                        rs = stmt.executeQuery("SELECT B.slotId FROM booked B, Timeslot S " + 
                                               "WHERE S.slotId = B.slotId AND " +
                                               "B.empId = "  + empID + " AND " +
                                               "B.centerId = "  + centerID + " AND " +
                                               "(" + 
                                               "(S.week > " + startWeek + ") OR " + "(S.week = " + startWeek + " AND S.day > " + startDay + ") OR " + "(S.week = " + startWeek + " AND S.day = " + startDay + " AND S.slot >= " + startSlot + ")" +
                                               ") AND (" +
                                               "(S.week < " + endWeek + ") OR " + "(S.week = " + endWeek + " AND S.day < " + endDay + ") OR " + "(S.week = " + endWeek + " AND S.day = " + endDay + " AND S.slot <= " + endSlot + ")" +
                                               ")");

                        //Ensures the requesting employee is booked for the time slot
                        if(!rs.next()){
                            System.out.println("Unable to request swap. You are not currently working during this time.");
                            System.out.println("-----------------------------------------------------------------------");
                            break;
                        }
                        
                        //Ensure the other employee is booked
                        rs = stmt.executeQuery("SELECT B.slotId FROM booked B, Timeslot S " + 
                                               "WHERE S.slotId = B.slotId AND " +
                                               "B.empId = "  + swapID + " AND " +
                                               "B.centerId = "  + centerID + " AND " +
                                               "(" + 
                                               "(S.week > " + takeStartWeek + ") OR " + "(S.week = " + takeStartWeek + " AND S.day > " + takeStartDay + ") OR " + "(S.week = " + takeStartWeek + " AND S.day = " + takeStartDay + " AND S.slot >= " + takeStartSlot + ")" +
                                               ") AND (" +
                                               "(S.week < " + takeEndWeek + ") OR " + "(S.week = " + takeEndWeek + " AND S.day < " + takeEndDay + ") OR " + "(S.week = " + takeEndWeek + " AND S.day = " + takeEndDay + " AND S.slot <= " + takeEndSlot + ")" +
                                               ")");
                        
                        if(!rs.next()){
                            System.out.println("Unable to request swap. Other employee is not working during the swap time.");
                            System.out.println("-----------------------------------------------------------------------");   
                            break;
                        }
                        
                        stmt.executeUpdate("INSERT INTO swaps (referenceId, startSlotId, endSlotId, takeStartSlotId, takeEndSlotId, askId, answerId, centerId, requestStatus)" + 
                                               "SELECT " + maxId + ", T1.slotId, T2.slotId, T3.slotId, T4.slotId, " + empID + ", " + swapID + ", " + centerID + ", 'pending' " +
                                               "FROM Timeslot T1, Timeslot T2, Timeslot T3, Timeslot T4 " + 
                                               "WHERE T1.slot = " + startSlot + " AND T1.day = " + startDay + " AND T1.week = " + startWeek + " AND " +
                                               "T2.slot = " + endSlot + " AND T2.day = " + endDay + " AND T2.week = " + endWeek + " AND " +
                                               "T3.slot = " + takeStartSlot + " AND T3.day = " + takeStartDay + " AND T3.week = " + takeStartWeek + " AND " +
                                               "T4.slot = " + takeEndSlot + " AND T4.day = " + takeEndDay + " AND T4.week = " + takeEndWeek);
                    } catch (Exception e) {
                        System.out.println("Error: " + e);
                    }
                    
                    break;
                case 2:
                    break;
            }
        } while (input != 2);
    }

    public static void viewSwap(Connection conn, int empID, int centerID, Scanner scanner){
        int input = 0;
        ResultSet rs = null;
        do {
            //Need to query the requested swaps
            try {
        	    Statement stmt = conn.createStatement();
                rs = stmt.executeQuery("SELECT S.referenceId, E.name, T1.slot AS slot1, T1.day AS day1, T1.week AS week1, T2.slot AS slot2, T2.day AS day2, T2.week AS week2, " +
                                       "T3.slot AS slot3, T3.day AS day3, T3.week AS week3, T4.slot AS slot4, T2.day AS day4, T4.week AS week4 " +
                                       "FROM swaps S, Timeslot T1, Timeslot T2, Timeslot T3, Timeslot T4, Employee E " +
                                       "WHERE S.answerId = " + empID + " AND " +
                                       "E.centerId = " + centerID + " AND " + 
                                       "S.requestStatus = 'pending' AND " +
                                       "E.empId = S.askId AND " + 
                                       "s.takeStartSlotId = T1.slotId AND s.takeEndSlotId = T2.slotId AND s.startSlotId = T3.slotId AND s.endSlotId = T4.slotId");

                if(!rs.next()){
                    System.out.println("No Pending Swaps.");
                    System.out.println("-----------------");
                } else {
                    System.out.println("Pending Swaps: ");
                    System.out.println(" Request ID |       Mechanic       | Start Slot |   End Slot(slot-day-week)   |   Swap Start | Swap End");
                    

                    do {
                        int requestId =  rs.getInt("referenceId");
                        String requestingMech = rs.getString("name");
                        int startSlot = rs.getInt("slot1");
                        int startDay = rs.getInt("day1");
                        int startWeek = rs.getInt("week1");
                        int endSlot = rs.getInt("slot2");
                        int endDay = rs.getInt("day2");
                        int endWeek = rs.getInt("week2");
                        int swapStartSlot = rs.getInt("slot3");
                        int swapStartDay = rs.getInt("day3");
                        int swapStartWeek = rs.getInt("week3");
                        int swapEndSlot = rs.getInt("slot4");
                        int swapEndDay = rs.getInt("day4");
                        int swapEndWeek = rs.getInt("week4");
                        System.out.printf("    %4d    | %20s |  %2d-%2d-%2d  |  %2d-%2d-%2d        | %2d-%2d-%2d   | %2d-%2d-%2d   \n", requestId, requestingMech, startSlot, startDay, startWeek, endSlot,endDay,endWeek,swapStartSlot,swapStartDay,swapStartWeek,swapEndSlot,swapEndDay,swapEndWeek);
                    } while(rs.next());
                    System.out.println("-------------------------------------");
                }
            } catch(SQLException e) {
                System.out.println("Error: " + e);
            }

            System.out.println("Swaps Menu: ");
            System.out.println("----------------------");
            System.out.println("(1) Manage Swap Request");
            System.out.println("(2) Exit");
            System.out.println("----------------------");
            System.out.print("Please enter a number:");

            input = scanner.nextInt();

            switch (input) {
                case 1:
                    try{
                        Statement stmt = conn.createStatement();
                        System.out.println("Please enter which Request ID to manage: ");
                        int choice = scanner.nextInt();
                        rs = stmt.executeQuery("SELECT S.referenceId, S.startSlotId, S.endSlotId, S.takeStartSlotId, S.takeEndSlotId, S.askId FROM swaps S WHERE S.referenceId = " + choice);
                        if(rs.next()){
                            int startSlot =  rs.getInt("startSlotId");
                            int endSlot = rs.getInt("endSlotId");
                            int askId = rs.getInt("askId");
                            int takeStartSlot =  rs.getInt("takeStartSlotId");
                            int takeEndSlot = rs.getInt("takeEndSlotId");
                            System.out.println("-----------------------------------------");
                            System.out.println("(1) Accept Swap");
                            System.out.println("(2) Reject Swap");
                            System.out.println("(3) Go Back");
                            int acceptRejectGoback = scanner.nextInt();
                            switch(acceptRejectGoback){
                                case 1:
                                    rs = stmt.executeQuery("SELECT COUNT(*) AS Hours FROM booked WHERE centerId = " + centerID + " AND empId = " + empID);
                                    rs.next();
                                    int currentHours = rs.getInt("Hours");
                                    if(currentHours + (endSlot - startSlot) > 50){
                                        System.out.println("Unable to accept swap. Hour limit reached.");
                                        break;
                                    }
                                    //Need to keep track of if one was accepted or rejected?
                                    stmt.executeUpdate("UPDATE swaps SET requestStatus = 'accepted' WHERE referenceId = " + choice);
                                    rs = stmt.executeQuery("SELECT * FROM serviceEvent S WHERE S.startSlotId = " + startSlot + " AND " +
                                                            "S.empId = " + askId + " AND " + 
                                                            "S.centerId = " + centerID);
                                    rs.next();
                                    String seValue = "(" + rs.getInt("customerId") + ", '" + rs.getString("vinNumber") + "', " +
                                                     centerID + ", '" + rs.getString("model") + "', " + rs.getInt("serviceId") + ", " +
                                                     rs.getInt("startSlotId") + ", " + empID + ", " + rs.getInt("invoiceId") + ")";
                                    
                                    stmt.executeUpdate("DELETE FROM serviceEvent S WHERE S.startSlotId >= " + startSlot + " AND S.startSlotId <= " + endSlot + " AND " +
                                                        "S.empId = " + askId + " AND " + 
                                                        "S.centerId = " + centerID);
                                    
                                    stmt.executeUpdate("UPDATE booked SET empId = " + empID + " WHERE booked.empId = " + askId + " AND booked.slotId >= " + startSlot +
                                                       " AND booked.slotId <= " + endSlot);
                                    stmt.executeUpdate("INSERT INTO serviceEvent values " + seValue);
                                    
                                    //Complete the swap by giving swap requestor the requested slots
                                    rs = stmt.executeQuery("SELECT * FROM serviceEvent S WHERE S.startSlotId = " + takeStartSlot + " AND " +
                                                            "S.empId = " + empID + " AND " + 
                                                            "S.centerId = " + centerID);
                                    rs.next();
                                    
                                    String seValue2 = "(" + rs.getInt("customerId") + ", '" + rs.getString("vinNumber") + "', " +
                                                     centerID + ", '" + rs.getString("model") + "', " + rs.getInt("serviceId") + ", " +
                                                     rs.getInt("startSlotId") + ", " + askId + ", " + rs.getInt("invoiceId") + ")";
                                    stmt.executeUpdate("DELETE FROM serviceEvent S WHERE S.startSlotId >= " + takeStartSlot + " AND S.startSlotId <= " + takeEndSlot + " AND " +
                                                        "S.empId = " + empID + " AND " + 
                                                        "S.centerId = " + centerID);
                                    
                                    stmt.executeUpdate("UPDATE booked SET empId = " + askId + " WHERE booked.empId = " + empID + " AND booked.slotId >= " + takeStartSlot +
                                                       " AND booked.slotId <= " + takeEndSlot);
                                    stmt.executeUpdate("INSERT INTO serviceEvent values " + seValue2);
                                    
                                    System.out.println("Schedules have been updated.");
                                    System.out.println("----------------------------");
                                    break;
                                case 2:
                                    //Need to keep track of if one was accepted or rejected?
                                    stmt.executeUpdate("UPDATE swaps SET requestStatus = 'rejected' WHERE referenceId = " + choice);
                                    System.out.println("Schedules were not updated.");
                                    System.out.println("---------------------------");
                                    break;
                                case 3:
                                    break;
                            }
                        } else {
                            System.out.println("This Request ID does not exist.");
                            System.out.println("-------------------------------");
                        }   
                    } catch (Exception e) {
                        System.out.println("Error: " + e);
                    }            
                    break;
                case 2:
                    break;
            }
        } while (input != 2);
    }
}
