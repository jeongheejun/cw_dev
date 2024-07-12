package com.dev.jsp.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.dev.jsp.repository.BoardRepository;

@Service
public class BoardService {

    @Autowired
    private BoardRepository repository;

    public Page<Object[]> searchBoard(String query, String issueid, String system, String taskType, String state, String dueDate, String submitter, LocalDate startDate, LocalDate endDate, PageRequest pageRequest) {
    	 System.out.println("Service received dueDate: " + dueDate);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String startDateString = (startDate != null) ? startDate.format(formatter) : null;
        String endDateString = (endDate != null) ? endDate.format(formatter) : null;
        System.out.println(startDateString);
        System.out.println(endDateString);
        System.out.println(dueDate+"???");
        System.out.println(taskType+"???");
       

        return repository.searchBoard(query, issueid, system, taskType, state, submitter, dueDate, startDateString, endDateString, pageRequest);
    }

    public Page<Object[]> getAssigneeCounts(String submitter, Long count, LocalDate startDate, LocalDate endDate, PageRequest pageRequest) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String startDateString = (startDate != null) ? startDate.format(formatter) : null;
        String endDateString = (endDate != null) ? endDate.format(formatter) : null;
        return repository.getAssigneeCounts(submitter, count, startDateString, endDateString, pageRequest);
    }
}
