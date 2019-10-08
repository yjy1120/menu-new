package util.dbhelper;
 
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
 
 
public class DBconn {
    private static Connection dbConn;
   
    public static Connection getConnection() throws ClassNotFoundException, SQLException{
               
        if(dbConn == null){        
           
            String driverName="com.mysql.jdbc.Driver";
            String url = "jdbc:mysql://:3306/knuser11?characterEncoding=UTF-8";
            String id = "";
            String pwd ="";
           
            Class.forName(driverName);     
            System.out.println("드라이버로드");
            dbConn = DriverManager.getConnection(url, id, pwd);
            System.out.println("DB연결성공!");
        }
       
       
        return dbConn;
    }   
    public static void close() throws SQLException{
        if(dbConn!=null){   
            System.out.println("conn닫기()");
            if(!dbConn.isClosed()){
                dbConn.close();
            }           
        } 
        dbConn = null;        
    }   
} 
