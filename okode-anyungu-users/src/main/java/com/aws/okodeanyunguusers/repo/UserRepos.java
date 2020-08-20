package com.aws.okodeanyunguusers.repos;

import com.aws.okodeanyunguusers.entities.User;

import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepos extends JpaRepository<User, String> {

}