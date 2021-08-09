package com.anand.springcicdjenkins;

import org.springframework.web.bind.annotation.RequestMapping;

public class SimpleController {

	@RequestMapping("/")
    public String index() {
        return "Greetings from spring-ci-cd-jenkins-k8s Spring Boot!";
    }
}
