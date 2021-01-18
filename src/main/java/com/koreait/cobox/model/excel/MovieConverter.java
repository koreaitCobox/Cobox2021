package com.koreait.cobox.model.excel;
/*엑셀을읽어들여 자바의 POJO형태로 변환하는 용도*/

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Component;

import com.koreait.cobox.model.domain.Genre;
import com.koreait.cobox.model.domain.Movie;
@Component
public class MovieConverter {
	
	public List convertFormFile(String path) {		
			List<Movie> movieList = new ArrayList<Movie>();
			FileInputStream fis=null;
			try {
				fis=new FileInputStream(path);
				//엑셀파일 제어 객체 생성
				XSSFWorkbook book=new XSSFWorkbook(fis);
				
				//파일접근했으니 시트에 접근
				XSSFSheet sheet= book.getSheetAt(0); //첫번째 시트에 접근
				//이중 반복문의 횟수를 구하기
				int rowCount=sheet.getPhysicalNumberOfRows();
				for(int i=1;i<rowCount;i++) {
					Movie movie=new Movie();
					
					XSSFRow row=sheet.getRow(i);
					
					for(int a=0;a<row.getPhysicalNumberOfCells();a++) {
						XSSFCell cell = row.getCell(a);
						
						if(a==0) {//movie_name
							movie.setMovie_name(cell.getStringCellValue());
						}else if(a==1) {//rating_id
							movie.setRating_id((int)cell.getNumericCellValue());
						}else if(a==2) {//director
							movie.setDirector(cell.getStringCellValue());
						}else if(a==3) {//actor
							movie.setActor(cell.getStringCellValue());
						}else if(a==4) {//release
							movie.setRelease(cell.getStringCellValue());
						}else if(a==5) {//장르
							String [] genre=cell.getStringCellValue().split(",");
							List genreList = new ArrayList();
							for(String mgenre:genre) {
								Genre obj=new Genre();
								obj.setGenre_name(mgenre);
								genreList.add(obj);
							}
							movie.setGenreList(genreList);
						}else if(a==6) {//story
							movie.setStory(cell.getStringCellValue());
						}else if(a==7) {//poster
							movie.setPoster(cell.getStringCellValue());
						}
					}
					movieList.add(movie);
					}
				
			} catch (IOException e) {
				
				e.printStackTrace();
			}finally {
				if(fis!=null) {
					try {
						fis.close();
					} catch (Exception e) {
						
						e.printStackTrace();
					}
				}
			}
			
			
			return movieList;
		}
	}
	

