package com.daniela.exam.services;



import java.util.List;


import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.daniela.exam.models.Role;
import com.daniela.exam.models.User;
import com.daniela.exam.repositories.RoleRepository;
import com.daniela.exam.repositories.UserRepository;

@Service
public class UserService {
	private UserRepository userRepository;
	private RoleRepository roleRepository;
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	public UserService(UserRepository userRepository, RoleRepository roleRepository, BCryptPasswordEncoder bCryptPasswordEncoder) {
		this.userRepository=userRepository;
		this.roleRepository=roleRepository;
		this.bCryptPasswordEncoder=bCryptPasswordEncoder;
	}

	//Create user with USER ROLE
	public void saveWithUserRole(User user) {
		user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
		user.setRoles(roleRepository.findByName("ROLE_USER"));
		userRepository.save(user);
	}
	
	//Create user with ADMIN ROLE
	public void saveUserWithAdminRole(User user) {
		user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
		user.setRoles(roleRepository.findByName("ROLE_ADMIN"));
		userRepository.save(user);
	}
	
	//Get user from DB by username
	public User findByUsername(String username) {
		return userRepository.findByUsername(username);
	}
	
	//Check if there are any users in DB if yes return true
	public Boolean isAdmin() {
		Role role=roleRepository.findByName("ROLE_ADMIN").get(0);
		System.out.println(role.getName());
		if(userRepository.findByRolesContains(role).size()>0) {
			return true;
		}else {
			return false;
		}
	}
	
	//Get all users
	public List<User> allUser(){
		return (List<User>) userRepository.findAll();
	}
	
	public Role findRoleByName(String name) {
		return roleRepository.findByName(name).get(0);
	}
	
	public void deleteUser(Long id) {
		userRepository.delete(id);
	}
	
	public User getUserById(Long id) {
		return userRepository.findOne(id);
	}
	
	public void makeUserAdmin(User user) {
		user.setRoles(roleRepository.findByName("ROLE_ADMIN"));
		userRepository.save(user);
	}
	public List<User> findAll() {
		return (List<User>) userRepository.findAll();
	}
	public void updateUser(User currentUser) {
		userRepository.save(currentUser);
		
	}
}
