package com.aws.okodeanyunguusers.controllers;

@RestController
public class TalkToUsers {


    @GetMapping("/testUsers")
    public ResponseEntity<String> testUsers() {


        return new ResponseEntity<>("Success");

    }

}