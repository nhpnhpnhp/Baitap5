package vn.iotstar.service;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;
import vn.iotstar.entity.User;
import vn.iotstar.repository.UserRepository;

import java.sql.Date;
import java.util.Optional;

@Service
public class UserService {

    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public User login(String usernameOrEmail, String password) {
        if (usernameOrEmail == null || password == null) {
            return null;
        }
        Optional<User> found = userRepository.findByUserName(usernameOrEmail);
        if (found.isEmpty() && usernameOrEmail.contains("@")) {
            found = userRepository.findByEmail(usernameOrEmail);
        }
        if (found.isEmpty()) {
            return null;
        }
        User user = found.get();
        if (user.getPassWord() == null || !user.getPassWord().startsWith("$2")) {
            return null;
        }
        return BCrypt.checkpw(password, user.getPassWord()) ? user : null;
    }

    public boolean existsByUsername(String username) {
        return userRepository.existsByUserName(username);
    }

    public boolean existsByEmail(String email) {
        return userRepository.existsByEmail(email);
    }

    public User register(String username, String password, String email, String fullname, String phone) {
        User user = new User();
        user.setUserName(username);
        user.setEmail(email);
        user.setFullName(fullname);
        user.setPhone(phone);
        user.setPassWord(BCrypt.hashpw(password, BCrypt.gensalt()));
        user.setRoleid(5);
        user.setActive(true);
        user.setCreatedDate(new Date(System.currentTimeMillis()));
        return userRepository.save(user);
    }
}
