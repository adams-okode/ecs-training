package com.decoded.activities.repositories;

import com.decoded.activities.data.Activity;

import org.springframework.data.repository.CrudRepository;
import org.springframework.data.rest.core.annotation.RestResource;

@RestResource(exported = true)
public interface ActivityRepository extends CrudRepository<Activity, Long> {

}