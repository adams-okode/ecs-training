package com.aws.okodeanyunguusers.repo;

import com.aws.okodeanyunguusers.entities.User;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepos extends JpaRepository<User, String> {

}