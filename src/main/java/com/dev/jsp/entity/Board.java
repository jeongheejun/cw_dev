package com.dev.jsp.entity;

import java.time.LocalDate;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "usr_a1", schema = "public")
public class Board {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ts_issueid;

	private Integer ts_system;
	private Integer ts_task_type;
	private Integer ts_state;
	private LocalDate ts_due_date;
	private Integer ts_submitter;

	public Long getTs_issueid() {
		return ts_issueid;
	}

	public void setTs_issueid(Long ts_issueid) {
		this.ts_issueid = ts_issueid;
	}

	public Integer getTs_system() {
		return ts_system;
	}

	public void setTs_system(Integer ts_system) {
		this.ts_system = ts_system;
	}

	public Integer getTs_task_type() {
		return ts_task_type;
	}

	public void setTs_task_type(Integer ts_task_type) {
		this.ts_task_type = ts_task_type;
	}

	public Integer getTs_state() {
		return ts_state;
	}

	public void setTs_state(Integer ts_state) {
		this.ts_state = ts_state;
	}

	public LocalDate getTs_due_date() {
		return ts_due_date;
	}

	public void setTs_due_date(LocalDate ts_due_date) {
		this.ts_due_date = ts_due_date;
	}

	public Integer getTs_submitter() {
		return ts_submitter;
	}

	public void setTs_submitter(Integer ts_submitter) {
		this.ts_submitter = ts_submitter;
	}

	@Override
	public String toString() {
		return "Board [ts_issueid=" + ts_issueid + ", ts_system=" + ts_system + ", ts_task_type=" + ts_task_type
				+ ", ts_state=" + ts_state + ", ts_due_date=" + ts_due_date + ", ts_submitter=" + ts_submitter + "]";
	}

	
}
