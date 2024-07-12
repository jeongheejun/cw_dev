package com.dev.jsp.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.dev.jsp.entity.Board;

public interface BoardRepository extends JpaRepository<Board, Long> {

    @Query("SELECT b.ts_issueid, b.ts_system, b.ts_task_type, b.ts_state, b.ts_due_date, b.ts_submitter, u.ts_name "
            + "FROM Board b JOIN User u ON b.ts_submitter = u.ts_id "
            + "WHERE (:query IS NULL OR CAST(b.ts_issueid AS string) LIKE %:query% "
            + "OR CAST(b.ts_system AS string) LIKE %:query% "
            + "OR CAST(b.ts_task_type AS string) LIKE %:query% "
            + "OR CAST(b.ts_state AS string) LIKE %:query% "
            + "OR CAST(b.ts_due_date AS string) LIKE %:query% "
            + "OR u.ts_name LIKE %:query%) "
            + "AND (:issueid IS NULL OR CAST(b.ts_issueid AS string) LIKE %:issueid%) "
            + "AND (:system IS NULL OR CAST(b.ts_system AS string) LIKE %:system%) "
            + "AND (:taskType IS NULL OR CAST(b.ts_task_type AS string) LIKE %:taskType%) "
            + "AND (:state IS NULL OR CAST(b.ts_state AS string) LIKE %:state%) "
            + "AND (:submitter IS NULL OR u.ts_name LIKE %:submitter%) "
            + "AND (:dueDate IS NULL OR CAST(b.ts_due_date AS string) LIKE CONCAT('%', :dueDate, '%'))"
            + "AND (:startDateString IS NULL OR CAST(b.ts_due_date AS string) >= :startDateString) "
            + "AND (:endDateString IS NULL OR CAST(b.ts_due_date AS string) <= :endDateString)")
    Page<Object[]> searchBoard(
            @Param("query") String query,
            @Param("issueid") String issueid,
            @Param("system") String system,
            @Param("taskType") String taskType,
            @Param("state") String state,
            @Param("submitter") String submitter,
            @Param("dueDate") String dueDate,
            @Param("startDateString") String startDateString,
            @Param("endDateString") String endDateString,
            Pageable pageable);

    @Query("SELECT u.ts_id, u.ts_name, COUNT(b) as count FROM Board b JOIN User u ON b.ts_submitter = u.ts_id "
            + "WHERE (:submitter IS NULL OR u.ts_name LIKE %:submitter%) "
            + "AND (:startDateString IS NULL OR CAST(b.ts_due_date AS string) >= :startDateString) "
            + "AND (:endDateString IS NULL OR CAST(b.ts_due_date AS string) <= :endDateString)"
            + "GROUP BY u.ts_id, u.ts_name, b.ts_submitter "
            + "HAVING (:count IS NULL OR COUNT(b) = :count)")
    Page<Object[]> getAssigneeCounts(
            @Param("submitter") String submitter,
            @Param("count") Long count,
            @Param("startDateString") String startDateString,
            @Param("endDateString") String endDateString,
            Pageable pageable);
}
