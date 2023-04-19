package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import gdu.mskim.MskimRequestMapping;
import gdu.mskim.RequestMapping;
import model.ReleaseCard;

@WebServlet(urlPatterns = {"/release/*"},
initParams = {@WebInitParam(name="view", value="/view/")}
		)
public class ReleaseController extends MskimRequestMapping{

	@RequestMapping("list")
	public String list(HttpServletRequest request, HttpServletResponse response) {

		String url = "https://www.luck-d.com/home/";
		
		String t = "";
		String q = "";
		
		String t_ = request.getParameter("t");		// 상품명
		String q_ = request.getParameter("q");		// 검색어
		
		if(t_ != null  && !t_.equals("")) t=t_;
		if(q_ != null  && !q_.equals("")) q=q_;
		
		Document doc = null;
		try {
			doc = Jsoup.connect(url).get();
		} catch (IOException e) {
			e.printStackTrace();
		}

		Elements releaseCards = doc.select("div.release_card");
		List<ReleaseCard> list = new ArrayList<>();

		for (Element releaseCard : releaseCards) {
			ReleaseCard rc = new ReleaseCard();
			rc.setAgentsite(releaseCard.selectFirst(".agentsite_name").text()); // 발매 사이트 이름 가져오기
			rc.setThumbnailUrl(releaseCard.select("div.product_thumb > img").attr("src"));	// 썸네일
			rc.setProductName(releaseCard.select("li.release_product_name > span.text").text());	// 상품명
			rc.setReleaseTime(releaseCard.select("li.release_time > span.text").text());	// 발매일자
			rc.setAdditionalInfo(releaseCard.select("li span.text span.additional_info").text());	//발매방법
			
			switch(t) {
				case "name" : 
					if(!rc.getProductName().contains(q)) continue;
					break;
				case "location" : 
					if(!rc.getAgentsite().contains(q)) continue;
					break;
			}
			
			String detailLink = releaseCard.select("div.release_btn_layer > a").attr("href");
			String result = "";
			for (int i = 0; i < detailLink.length(); i++) {
				char c = detailLink.charAt(i);
				if (Character.isDigit(c)) {
					result += c;
				}
			}

			rc.setNo(result);	// 상세정보
			list.add(rc);
		}

		int pageNum = 1;
		try{
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}catch (NumberFormatException e) {}

		int limit = 8;	// 한 페이지에 보여질 게시물 건 수
		int cardCnt = list.size();	// 신발 수
		int maxPage = (int)((double)cardCnt/limit +0.95);
		int startPage = pageNum-(pageNum-1)%5;
		int endPage = startPage + 4;

		if(endPage > maxPage) endPage = maxPage;

		request.setAttribute("list", list);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("cardCnt", cardCnt);
		request.setAttribute("maxPage", maxPage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);

		return "release/list";
	}
}
