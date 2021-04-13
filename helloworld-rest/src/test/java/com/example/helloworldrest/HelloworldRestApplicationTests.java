package com.example.helloworldrest;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.Assert.assertEquals;

import com.example.helloworldrest.controller.*;

@SpringBootTest
class HelloworldRestApplicationTests {

	@Test
	void contextLoads() {
	}

	@Test
    public void testHelloworldController() {
        HelloworldController helloworldController = new HelloworldController();
        String result = helloworldController.hello();
        assertEquals(result, "Hello World!");
    }

}

