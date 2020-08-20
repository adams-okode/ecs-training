package com.decoded.activities.repositories;

import com.decoded.activities.data.Activity;

import org.springframework.data.jpa.repository.JpaRepository;

public interface ActivityRepository extends JpaRepository<Long, Activity> {

}