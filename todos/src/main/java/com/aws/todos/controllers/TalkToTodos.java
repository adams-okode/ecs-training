package ccom.aws.todos.controllers;


@RestController
public class TalkToTodos {

    @Autowired
    private RestTemplate restTemplate;


    @GetMapping("/testTodos")
    public ResponseEntity<String> testTodos() {


        return new ResponseEntity<>("Success");

    }


    @PostMapping("/postToUsers")
    public ResponseEntity<T> testToUsers() {


        RestTemplate restTemplate = new RestTemplate();

        
 
        String result = restTemplate.getForObject("http://users.ingress", String.class);


        
        System.out.println(result);




        // return new ResponseEntity<>("Success");

    }

}