package com.dev.jsp.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "ts_users", schema = "public")
public class User {
    @Id
    
    
@GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long ts_id;

    private String ts_name;

	public Long getTs_id() {
		return ts_id;
	}

	public void setTs_id(Long ts_id) {
		this.ts_id = ts_id;
	}

	public String getTs_name() {
		return ts_name;
	}

	public void setTs_name(String ts_name) {
		this.ts_name = ts_name;
	}
    
    
}