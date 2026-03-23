import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class QueryTableCounts {
    public static void main(String[] args) throws Exception {
        if (args.length < 4) {
            System.err.println("Usage: QueryTableCounts <jdbcUrl> <username> <password> <schema> [table1 table2 ...]");
            System.exit(2);
        }
        String schema = args[3];
        try (Connection conn = DriverManager.getConnection(args[0], args[1], args[2])) {
            for (int i = 4; i < args.length; i++) {
                String table = args[i];
                String sql = "SELECT COUNT(1) AS cnt FROM " + schema + "." + table;
                try (Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
                    rs.next();
                    System.out.println(table + "," + rs.getLong("cnt"));
                }
            }
        }
    }
}
