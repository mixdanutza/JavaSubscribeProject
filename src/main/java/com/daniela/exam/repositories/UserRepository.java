package com.daniela.exam.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.daniela.exam.models.Role;
import com.daniela.exam.models.User;

@Repository
public interface UserRepository extends CrudRepository<User, Long> {
	User findByUsername(String username);
	User findByFirstName(String firstName);
	List<User> findByRolesContains(Role role);
}
