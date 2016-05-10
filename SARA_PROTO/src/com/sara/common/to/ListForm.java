package com.sara.common.to;

import java.util.List;

public class ListForm {
		
		private int 	startrow=1;
		private int		endrow=1;		//�������� ȭ���� ����
		private int 	pagenum=1;		//������������ȣ
		private int 	rowsize=3;		//ȭ�鿡 ������ �ٰ���
		private int 	startpage=1;		//����������
		private int 	endpage=1;		//��������
		private int		pagesize=2;		//ȭ�鿡 ������ ����������
		public void setPagesize(int pagesize) {
			this.pagesize = pagesize;
		}
		private int 	pagecount;		//������������
		private int 	dbcount;		//�ѷ��ڵ尹��	
		private List<?> 	list;

		public void setPagenum(int pagenum){
			this.pagenum=pagenum; //�ٷ� ���� 
		}
		
		public void setDbcount(int dbcount){
			this.dbcount=dbcount;
		}
		
		public void setRowsize(int rowsize){
			this.rowsize=rowsize; //�ٷ� ���� 
		}
		public int getPagenum(){
			return pagenum;
		}
		public int getStartrow(){
			return (getPagenum()-1)*getRowsize()+1;
		}
		public int getEndrow(){
			endrow= getStartrow()+getRowsize()-1;   
			
			if(endrow>getDbcount())
				endrow = getDbcount();
			return endrow;
		}
		public int getRowsize(){
			return rowsize;
		}
	
		public int getDbcount(){
			return dbcount;
		}
		public int getStartpage(){
			return getPagenum()-((getPagenum()-1)%getPagesize());
		}
		public int getEndpage(){
			endpage= getStartpage()+getPagesize()-1;
			if(endpage>getPagecount())
				endpage = getPagecount();
			return endpage;
		}
		public int getPagesize(){
			return pagesize;
		}
		public int getPagecount(){
			pagecount=(getDbcount()-1)/getRowsize()+1;
			return pagecount;	
		}
		public boolean isPrevious(){
			if(getStartpage()-getPagesize()>0)
				return true;
			else	return false;
		}
		public boolean isNext(){
			if(getStartpage()+getPagesize()<=getPagecount())
				return true;
			else 	return false;
		}
		public void setList(List<?> list){
			this.list=list;
		}
		public List<?> getList(){
			return list;
		}
	}

