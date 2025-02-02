package com.umberto.uni_connect;

import org.modelmapper.ModelMapper;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.data.neo4j.config.EnableNeo4jAuditing;

@SpringBootApplication
@EnableNeo4jAuditing
public class UniConnectApplication {

	public static void main(String[] args) {
		SpringApplication.run(UniConnectApplication.class, args);
	}

	@Bean
	public ModelMapper modelMapper(){
		return new ModelMapper();
	}
}
