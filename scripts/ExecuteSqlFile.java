import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class ExecuteSqlFile {

    public static void main(String[] args) throws Exception {
        if (args.length < 4) {
            System.err.println("Usage: ExecuteSqlFile <jdbcUrl> <username> <password> <sqlFile1> [sqlFile2] ...");
            System.exit(2);
        }
        String jdbcUrl = args[0];
        String username = args[1];
        String password = args[2];

        try (Connection connection = DriverManager.getConnection(jdbcUrl, username, password)) {
            connection.setAutoCommit(true);
            for (int i = 3; i < args.length; i++) {
                Path file = Path.of(args[i]);
                String sql = stripBom(Files.readString(file, StandardCharsets.UTF_8)).trim();
                if (sql.isEmpty()) {
                    continue;
                }
                try (Statement st = connection.createStatement()) {
                    st.execute(sql);
                }
                System.out.println("Executed file " + file);
            }
        }
    }

    private static String stripBom(String text) {
        if (!text.isEmpty() && text.charAt(0) == '\uFEFF') {
            return text.substring(1);
        }
        return text;
    }
}
