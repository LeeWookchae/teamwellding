package com.icia.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icia.common.util.StringUtil;
import com.icia.web.model.Paging;
import com.icia.web.model.Response;
import com.icia.web.model.WDAdmin;
import com.icia.web.model.WDAdminUser;
import com.icia.web.model.WDUser;
import com.icia.web.service.WDAdminService;
import com.icia.web.service.WDAdminUserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;
import com.icia.web.util.JsonUtil;

@Controller("wdAdminIndexController")
public class WDAdminIndexController 
{
	private static Logger logger = LoggerFactory.getLogger(WDAdminIndexController.class);
	
	@Autowired
	private WDAdminService wdAdminService;
	
	@Autowired
	private WDAdminUserService wdAdminUserService;
	
	//쿠키명
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	private static final int LIST_COUNT = 10;
	private static final int PAGE_COUNT = 10;
	
	@RequestMapping(value="/mng/login") ///manager/index =>>로그인페이지!!
	@ResponseBody
	public Response<Object> mngIndex(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String adminId = HttpUtil.get(request, "userId");
		String admPwd = HttpUtil.get(request, "userPwd");
		System.out.println("탓어용~~~~~~~~~~~~~~");
		if(!StringUtil.isEmpty(adminId) && !StringUtil.isEmpty(admPwd)) 
		{
			WDAdmin admin = wdAdminService.wdAdminSelect(adminId);
			
			if(admin != null)
			{
				if(StringUtil.equals(admin.getAdmPwd(), admPwd))
				{
					if(StringUtil.equals(admin.getStatus(), "Y"))
					{
						CookieUtil.addCookie(response, "/", -1, AUTH_COOKIE_NAME, CookieUtil.stringToHex(adminId));
						System.out.println("쿠키"+CookieUtil.stringToHex(adminId));
						ajaxResponse.setResponse(0, "Success"); // 로그인 성공
					}
					else
					{
						ajaxResponse.setResponse(403, "Not Found"); // 정지된 아이디!
					}
				}
				else
				{
					ajaxResponse.setResponse(-1, "Passwords do not match"); // 비밀번호 불일치
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "Not Found"); // 사용자 정보 없음 (Not Found)
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request"); // 파라미터가 올바르지 않음 (Bad Request)
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[WDAdminIndexController]/mng/login \n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		return ajaxResponse;
	}
	
	@RequestMapping(value="/mng/userList")
	public String userList(Model model,HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		String status = HttpUtil.get(request, "status"); //변수명에 대한 값을 읽어오기!
		//검색타입 (1:회원아이디, 2:회원명)
		String searchType = HttpUtil.get(request, "searchType");
		String searchValue = HttpUtil.get(request, "searchValue");
		
		//이건 유저테이블 유저 객체
		WDAdminUser wdAdminUser = new WDAdminUser();
		//이건 리스트 객체
		List<WDAdminUser> userList = null;
		
		//닉네임 달려구
		WDAdmin wdAdmin = wdAdminService.wdAdminSelect(cookieUserId);
		
		//현재페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		//총 게시물 수
		long totalCount = 0;
		//페이징객체
		Paging paging = null;
		
		//매개변수로 받은 status 먼저 셋팅
		wdAdminUser.setStatus(status);
		
		//서치타입과 서치밸유 값이 비어있는지 체크
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
		{
			if(StringUtil.equals(searchType, "1"))
			{
				wdAdminUser.setUserId(searchValue);
			}
			else if(StringUtil.equals(searchType, "2"))
			{
				wdAdminUser.setUserId(searchValue);
			}
			else
			{
				searchType = "";
				searchValue = "";
			}
		}
		else
		{
			searchType = "";
			searchValue = "";
		}
		
		totalCount = wdAdminUserService.wdAdmUserListCount(wdAdminUser);
		
		if(totalCount > 0) {
			paging = new Paging("/mng/userList", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			
			paging.addParam("status", status);
			paging.addParam("searchType", searchType);
			paging.addParam("searchValue", searchValue);
			paging.addParam("curPage", curPage);
			
			//User객체에 스타트로우,엔드로우 보내기
			wdAdminUser.setStartRow(paging.getStartRow());
			wdAdminUser.setEndRow(paging.getEndRow());
			
			//유저 리스트 가져옴 (검색했으면 검색된 값을만)
			userList = wdAdminUserService.wdAdmUserList(wdAdminUser);
		}
		//list객체에 넣을거! 모델객체사용
		model.addAttribute("userList", userList);
		model.addAttribute("wdAdmin",wdAdmin);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("status", status);
		model.addAttribute("curPage", curPage);
		model.addAttribute("paging", paging);
		
		
		return "/mng/userList";
	}
}