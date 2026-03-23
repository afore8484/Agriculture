import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class QueryTableColumns {

    public static void main(String[] args) throws Exception {
        if (args.length < 4) {
            System.err.println("Usage: QueryTableColumns <jdbcUrl> <username> <password> <schema> [table1 table2 ...]");
            System.exit(2);
        }
        String schema = args[3];
        try (Connection conn = DriverManager.getConnection(args[0], args[1], args[2])) {
            String sql = """
                    SELECT table_name, column_name, data_type
                    FROM information_schema.columns
                    WHERE table_schema = ?
                    ORDER BY table_name, ordinal_position
                    """;
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, schema);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        String table = rs.getString("table_name");
                        if (args.length > 4) {
                            boolean matched = false;
                            for (int i = 4; i < args.length; i++) {
                                if (table.equalsIgnoreCase(args[i])) {
                                    matched = true;
                                    break;
                                }
                            }
                            if (!matched) {
                                continue;
                            }
                        }
                        System.out.printf("%s,%s,%s%n", table, rs.getString("column_name"), rs.getString("data_type"));
                    }
                }
            }
        }
    }
}
