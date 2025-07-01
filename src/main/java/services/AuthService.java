/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this
 * license Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package services;

import dao.UserDao;
import model.User;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author VuNT13
 */
public class AuthService {
    public User checkLogin(String username, String password) {
        UserDao userDao = new UserDao();
        // Tìm user theo email (username)
        for (User user : userDao.selectAllUsers()) {
            if (user.getEmail().equals(username)) {
                // So sánh password đã mã hóa
                if (BCrypt.checkpw(password, user.getPassword())) {
                    return user;
                }
            }
        }
        return null;
    }

    public boolean register(String name, String phone, String address, String email, String password) {
        UserDao userDao = new UserDao();
        if (userDao.existsByEmail(email)) {
            return false; // Email đã tồn tại
        }
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        User user = new User(null, name, phone, address, email, hashedPassword);
        userDao.insertUser(user);
        return true;
    }
}
