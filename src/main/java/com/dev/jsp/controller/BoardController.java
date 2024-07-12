package com.dev.jsp.controller;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dev.jsp.service.BoardService;

@Controller
public class BoardController {

    @Autowired
    private BoardService service;

    @GetMapping("/board")
    public String getAllBoard(Model model) {
        model.addAttribute("boards", null);
        return "board";
    }

    @GetMapping("/board/search")
    public String searchBoard(
            @RequestParam("query") String query,
            @RequestParam(value = "issueid", required = false) String issueid,
            @RequestParam(value = "system", required = false) String system,
            @RequestParam(value = "taskType", required = false) String taskType,
            @RequestParam(value = "state", required = false) String state,
            @RequestParam(value = "dueDate", required = false) String dueDate,
            @RequestParam(value = "submitter", required = false) String submitter,
            @RequestParam(value = "startDate", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam(value = "endDate", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate,
            @RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "size", defaultValue = "5") int size,
            @RequestParam(value = "sortField", defaultValue = "ts_issueid") String sortField,
            @RequestParam(value = "sortDir", defaultValue = "asc") String sortDir,
            Model model) {

        Sort sort = Sort.by(sortField);
        sort = sortDir.equals("asc") ? sort.ascending() : sort.descending();
        Page<Object[]> searchBoards = service.searchBoard(query, issueid, system, taskType, state, dueDate, submitter, startDate, endDate, PageRequest.of(page, size, sort));
        model.addAttribute("searchBoards", searchBoards.getContent());
        model.addAttribute("totalPages", searchBoards.getTotalPages());
        model.addAttribute("currentPage", page);
        model.addAttribute("sortField", sortField);
        model.addAttribute("sortDir", sortDir);
        return "board"; // Return the same view as getAllBoard
    }

    @GetMapping("/board/sort")
    @ResponseBody
    public Page<Object[]> sortBoard(
            @RequestParam("query") String query,
            @RequestParam(value = "issueid", required = false) String issueid,
            @RequestParam(value = "system", required = false) String system,
            @RequestParam(value = "taskType", required = false) String taskType,
            @RequestParam(value = "state", required = false) String state,
            @RequestParam(value = "dueDate", required = false) String dueDate,
            @RequestParam(value = "submitter", required = false) String submitter,
            @RequestParam(value = "startDate", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam(value = "endDate", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate,
            @RequestParam("page") int page,
            @RequestParam("size") int size,
            @RequestParam(value = "sortField", defaultValue = "ts_issueid") String sortField,
            @RequestParam(value = "sortDir", defaultValue = "asc") String sortDir) {

        Sort sort = Sort.by(sortField);
        sort = sortDir.equals("asc") ? sort.ascending() : sort.descending();
        System.out.println("Received params: " + query + ", " + issueid + ", " + system + ", " + taskType + ", " + state + ", " + dueDate + ", " + submitter + ", " + startDate + ", " + endDate + ", " + page + ", " + size + ", " + sortField + ", " + sortDir);
        System.out.println(dueDate + "ddd");
        return service.searchBoard(query, issueid, system, taskType, state, dueDate, submitter, startDate, endDate, PageRequest.of(page, size, sort));
    }

    @GetMapping("/board/assigneeCounts")
    @ResponseBody
    public Page<Object[]> getAssigneeCounts(@RequestParam(value = "page", defaultValue = "0") int page,
                                            @RequestParam(value = "size", defaultValue = "5") int size,
                                            @RequestParam(value = "sortField", defaultValue = "ts_submitter") String sortField,
                                            @RequestParam(value = "sortDir", defaultValue = "asc") String sortDir,
                                            @RequestParam(value = "submitter", required = false) String submitter,
                                            @RequestParam(value = "count", required = false) Long count,
                                            @RequestParam(value = "startDate", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
                                            @RequestParam(value = "endDate", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
        Sort sort = Sort.by(sortField);
        sort = sortDir.equals("asc") ? sort.ascending() : sort.descending();
        return service.getAssigneeCounts(submitter, count, startDate, endDate, PageRequest.of(page, size, sort));
    }
}
