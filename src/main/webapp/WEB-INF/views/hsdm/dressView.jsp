<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script>
$(document).ready(function(){
	<c:choose>
		<c:when test="${empty wdDress}">
			alert("조회하신 상품이 존재하지 않습니다.");
			document.bbsForm.action = "/hsdm/dress";
			document.bbsForm.submit();
		</c:when>
	</c:choose>
	$("#btnList").on("click", function(){
		document.bbsForm.action = "/hsdm/dress";
		document.bbsForm.submit();
	});
	
	//드레스 담기 버튼 시작
	$("#chae").on("click",function(){
		if(confirm("해당 드레스를 장바구니에 담으시겠습니까?"))
		{
			//ajax통신 시작
			$.ajax({
			type:"POST",
			url:"/hsdm/dressRezProc",
			data:
			{
				dcCode: $("#dcCode").val(),
				dNo: $("#dNo").val()
			},
			datatype:"JSON",
			beforeSend:function(xhr){
				xhr.setRequestHeader("AJAX", "true");
			},
			success:function(response){
				if(response.code == 0)
				{
					alert("장바구니에 해당 상품을 담았습니다.");
					if(confirm("장바구니로 이동하시겠습니까?"))
					{
						location.href = "/user/wishlist";
					}
				}
				else if(response.code == 403)
				{
					alert("서버와의 연결 상태를 확인해주세요.");
				}
				else if(response.code == 502)
				{
					alert("장바구니에 이미 다른 드레스가 담겨 있습니다.");
					if(confirm("장바구니로 이동하시겠습니까?"))
					{
						location.href = "/user/wishlist";
					}
				}
				else
				{
					alert("장바구니에 상품을 담는 중 오류가 발생했습니다.");
				}
			},
			complete:function(data){
				icia.common.log(data);
			},
			error:function(xhr, status, error)
			{
				icia.common.error(error);
			}
			});
			//ajax통신 종료
		}
		
	});
	//드레스 담기 버튼 종료
	
});

function fn_view(dNo)
{
	document.bbsForm.dNo.value = dNo;
	document.bbsForm.searchType.value = $("#_searchType").val();
	document.bbsForm.searchValue.value = $("#_searchValue").val();
	document.bbsForm.action = "/hsdm/dressView";
	document.bbsForm.submit();
}   
</script>
</head> 
<body>
	<!-- 메뉴바 시작 -->
    	<jsp:include page="/WEB-INF/views/include/navigation.jsp" >
    	<jsp:param name="userName" value="${wdUser.userNickname}" />
    	</jsp:include>
	<!-- 메뉴바 종료 -->
<!-- ############################ 여기부터 내용 시작 ############################ -->
<section class="top">
	<div class="back"></div>
</section>
<c:if test="${!empty wdDress}">
<div class="big_title">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <h2><span>[드레스]</span> <c:out value="${wdDress.dcName}" /></h2>
             	<button type="button" id="btnList" class="listButton">
        			<img src="../resources/images/icons/leftButton.png" class="listIcon" alt="리스트" width="32" height="32">
        		</button>
            </div>
            <div class="col-lg-8 _detail">
                <span><c:out value="${wdDress.dcContent}" /></span>
            </div>
            <div class="col-lg-4">
                <ul  class="loc_li">
                    <li><i class="fa fa-map-marker"></i> <c:out value="${wdDress.dcLocation}" /></li>
                    <li><c:out value="${wdDress.dcNumber}" /></li>
                </ul>
            </div>
        </div>
    </div>
</div>

    <div class="ticket-details-page">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <div class="left-image">
                        <img src="../resources/images/dress/${wdDress.dImgname}" alt="">
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="com_detail">
                        <div class="right-content">
                            <h4><c:out value="${wdDress.dName}" /></h4>
                            <span><c:out value="${wdDress.dContent}" /></span>
                            <div class="det_price">
	                            <ul>
	                                <li class="dis_price">
	                            		<div class="discount"><c:out value="${wdDress.dDiscount}" />%</div>
		                                <div class="price"><fmt:formatNumber type="number" maxFractionDigits="3" value="${wdDress.dPrice}" /></div>
	                                </li>
	                            </ul>
	                            <div class="dis-price"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdDress.dPrice * (1-wdDress.dDiscount*0.01)}" />원</div>
                            </div>
                            <div class="banner">
                                <img src="../resources/images/tour.png" width="100%">
                            </div>
                            <div class="main-dark-button2"><a href="#" id="chae">이 드레스 담기</a></div>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-12">
                	<div class="det_navi">
                		<ul>
                			<li><a href=""><c:out value="${wdDress.dcName}" />의 다른 드레스 보기</a></li>
                			<li><a href="">이용 후기</a></li>
                		</ul>
                	</div>
                </div>
                
              <!-- 같은 샵 다른상품 보기 시작 -->
               	<!-- 드레스 3짜리로*4개 만들거임 -->
               	<!-- 01 -->
<c:if test="${!empty sameCom}">        
	<c:forEach var="wdDress" items="${sameCom}" varStatus="status">
               	<div class="col-lg-3">
                    <div class="ticket-item2" onclick="fn_view('${wdDress.dNo}')">
                        <div class="thumb1">
                            <img src="../resources/images/dress/${wdDress.dImgname}" alt="">
                        </div>
                        <div class="down-content dtbox">
                        	<div class="sd_title3">[<c:out value="${wdDress.dcName}" />] <c:out value="${wdDress.dName}" /></div>
                            <ul>
                                <li class="dis_price2"><span class="discount2"><c:out value="${wdDress.dDiscount}" />%</span> <span class="dis-price"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdDress.dPrice * (1-wdDress.dDiscount*0.01)}" />원</span></li>
                            </ul>
                        </div>
                    </div>
               	</div>    
     </c:forEach>
</c:if>
			<!-- 같은 샵 다른상품 보기 끝 -->
				<div class="col-lg-12" style="width: 100%; height: 1px; background:#eee; margin-top:50px;"></div>
            	<div class="alignleft2">
	             	<button type="button" id="btnList" class="listButton">
	        			<img src="../resources/images/icons/leftButton.png" class="listIcon" alt="리스트" width="32" height="32">
	        		</button>
            	</div>
            </div>
        </div>

	</div>
</c:if>

<form name="bbsForm" id="bbsForm" method="post">
   <input type="hidden" name="dNo" value="${dNo}" />
   <input type="hidden" name="searchType" value="${searchType}" />
   <input type="hidden" name="searchValue" value="${searchValue}" />
   <input type="hidden" name="curPage" value="${curPage}" />
</form>

<form name="dressRez" id="dressRez" method="post">
	<input type="hidden" name="dcCode" id="dcCode" value="${wdDress.dcCode }" />
	<input type="hidden" name="dNo" id="dNo" value="${dNo}" />
</form>

    
<!-- ############################ 여기까지 내용 끝 ############################ -->
	<!-- *** 욱채수정Footer 시작 *** -->
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	<!-- *** 욱채수정Footer 종료 *** -->
</body>
</html>