package com.dev.jsp.repository;

import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

public interface BoardRepositoryCustom {
    Page<Object[]> searchBoard(String query, PageRequest pageRequest, Map<String, String> filters);
}
