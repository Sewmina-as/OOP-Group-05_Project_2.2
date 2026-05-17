package com.socialmedia.app.services;

import com.socialmedia.app.models.User;
import com.socialmedia.app.repositories.UserRepository;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    private final UserRepository userRepository;

    public UserService(UserRepository userRepository){
        this.userRepository = userRepository;
    }

    public User create(String email, String firstName, String lastName, String password){

        User user = new User();

        user.setEmail(email);
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setPassword(password);

        return userRepository.save(user);
    }

}
