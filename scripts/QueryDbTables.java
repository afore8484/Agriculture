import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class QueryDbTables {

    public static void main(String[] args) throws Exception {
        if (args.length < 3) {
            System.err.println("Usage: QueryDbTables <jdbcUrl> <username> <password> [schema]");
            System.exit(2);
        }
        String schema = args.length >= 4 ? args[3] : "village_finance_ops";
        try (Connection conn = DriverManager.getConnection(args[0], args[1], args[2])) {
            String sql = """
                    SELECT n.nspname AS schema_name,
                           c.relname AS table_name,
                           r.rolname AS owner_name,
                           has_table_privilege(current_user, format('%I.%I', n.nspname, c.relname), 'INSERT') AS can_insert,
                           has_table_privilege(current_user, format('%I.%I', n.nspname, c.relname), 'UPDATE') AS can_update,
                           has_table_privilege(current_user, format('%I.%I', n.nspname, c.relname), 'DELETE') AS can_delete
                    FROM pg_class c
                    JOIN pg_namespace n ON n.oid = c.relnamespace
                    JOIN pg_roles r ON r.oid = c.relowner
                    WHERE c.relkind = 'r'
                      AND n.nspname = ?
                    ORDER BY c.relname
                    """;
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, schema);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        System.out.printf("%s,%s,%s,insert=%s,update=%s,delete=%s%n",
                                rs.getString("schema_name"),
                                rs.getString("table_name"),
                                rs.getString("owner_name"),
                                rs.getBoolean("can_insert"),
                                rs.getBoolean("can_update"),
                                rs.getBoolean("can_delete"));
                    }
                }
            }
        }
    }
}
