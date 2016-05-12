package com.kgs7276.board.persistence;

import com.kgs7276.board.domain.MessageVO;

public interface MessageDAO {
	
	public void create(MessageVO message) throws Exception;
	
	public MessageVO read(Integer mid) throws Exception;
	
	public void update(Integer mid) throws Exception;

}
