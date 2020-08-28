package com.decoded.notifications.repository;

import com.decoded.notifications.data.Notification;

import org.springframework.data.jpa.repository.JpaRepository;

public interface NotificationRepository extends JpaRepository<Notification, Long> {

}