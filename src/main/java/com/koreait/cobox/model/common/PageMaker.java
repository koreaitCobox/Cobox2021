package com.koreait.cobox.model.common;

public class PageMaker {

	private int totalCount;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	private int displayPageNum = 10;
	private int page;
	private int perPageNum;

	public PageMaker(int page, int perPageNum) {
		this.page = page;
		this.perPageNum = perPageNum;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcData();
	}

	private void calcData() {
		double end_ = Math.ceil(page / (double) displayPageNum) * displayPageNum;
		if (end_ > Integer.MAX_VALUE) {
			endPage = Integer.MAX_VALUE;
		} else {
			endPage = (int) end_;
		}

		// System.out.println("Ha.... endpage " + endPage);
		startPage = (endPage - displayPageNum) + 1;
		// System.out.println("Ha.... startpage " + startPage);
		double endPage1 = Math.ceil(totalCount / (double) perPageNum);
		int tempEndPage = Integer.MAX_VALUE;
		if (endPage1 < Integer.MAX_VALUE) {
			tempEndPage = (int) endPage1;
		}
		if (endPage > tempEndPage) {
			endPage = tempEndPage;
		}

		prev = startPage == 1 ? false : true;
		// next = endPage * perPageNum >= totalCount ? false : true;
		next = startPage >= endPage ? false : true;

		// System.out.println("Start Page" + startPage);
		// System.out.println("End Page" + endPage);

	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getPerPageNum() {
		return perPageNum;
	}

	public void setPerPageNum(int perPageNum) {
		this.perPageNum = perPageNum;
	}
}