package com.aws.todos.repos;

import org.springframework.data.jpa.repository.JpaRepository;

import com.aws.todos.entities.Todos;

public interface TodosRepo extends JpaRepository<Todos, String> {

}