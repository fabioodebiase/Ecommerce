package com.DAO;
import com.connection.ConnectionDB;
import com.entities.Utente;

import java.sql.*;
public class UtenteDAO {
    static ConnectionDB connessione = new ConnectionDB();

    public static void registraUtente(String username, String email, String password){
        String sql = "INSERT INTO Utenti (username, email, password ) VALUES (?,?,?)";

        try(Connection conn = connessione.connessioneDB()){
            if (conn != null){
                PreparedStatement preparedStatement = conn.prepareStatement(sql);
                preparedStatement.setString(1, username);
                preparedStatement.setString(2, email);
                preparedStatement.setString(3, password);
                preparedStatement.executeUpdate();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static boolean findUtente(String username, String email) {
        String sql = "SELECT * FROM Utenti WHERE username = ? OR email = ?";
        try(Connection conn = connessione.connessioneDB()){
            if (conn != null){
                PreparedStatement preparedStatement = conn.prepareStatement(sql);
                preparedStatement.setString(1,username);
                preparedStatement.setString(2,email);

                ResultSet rs = preparedStatement.executeQuery();
                while (rs.next()){
                    return true;
                }
            }
        } catch (SQLException e){
            throw new RuntimeException(e);
        }
        return false;
    }

    public static boolean controlloLogin(String username, String email, String password){
        String sql = "SELECT * FROM Utenti WHERE username = ? OR email = ? AND password = ?";
        try(Connection conn = connessione.connessioneDB()){
            if (conn != null){
                PreparedStatement preparedStatement = conn.prepareStatement(sql);
                preparedStatement.setString(1,username);
                preparedStatement.setString(2,email);
                preparedStatement.setString(3,password);
                ResultSet rs = preparedStatement.executeQuery();
                while (rs.next()){
                    return true;
                }
            }
        } catch(SQLException e){
            throw  new RuntimeException(e);
        }
        return false;
    }

    public static Utente getUtenteByUsername(String username, String email){
        Utente utente = null;
        String sql = "SELECT * FROM Utenti WHERE username = ? OR email = ?";
        try(Connection conn = connessione.connessioneDB()){
            if (conn != null){
                PreparedStatement preparedStatement = conn.prepareStatement(sql);
                preparedStatement.setString(1,username);
                preparedStatement.setString(2,email);
                ResultSet rs = preparedStatement.executeQuery();
                while (rs.next()){
                    utente = new Utente();
                    utente.setIdUtente(rs.getInt("id"));
                    utente.setUsername(rs.getString("username"));
                    utente.setEmail(rs.getString("email"));
                    utente.setPassword(rs.getString("password"));

                }
            }
        } catch(SQLException e){
            throw new RuntimeException(e);
        }
        return utente;
    }
}
