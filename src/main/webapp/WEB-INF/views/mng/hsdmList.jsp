<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style>
*, ::after, ::before {
   box-sizing: unset;
}
.table-hover th, td{
   border: 1px solid #c4c2c2;
   text-align: center;
}

.sel{
   background: #f5a4aa;
}
</style>
<script>
 var hsdmCheck = 1;
 $(function(){
     $("#hall").show();
     $("#studio").hide();
     $("#dress").hide();
     $("#makeup").hide(); 
 });
function fn_search()
{
   document.searchForm.curPage.value = "1"; //검색한단 이야기는 첨부터 한다는 뜻이라 1부터
   document.searchForm.action = "/mng/userList";
   document.searchForm.submit();
}

function fn_paging(curPage)
{
   document.searchForm.curPage.value = curPage; //매개변수로 받은 현재페이지를 가져옴
   document.searchForm.action = "/mng/userList";
   document.searchForm.submit();
}

function classChange(id){
      document.getElementById('id1').classList.remove('sel');
      document.getElementById('id2').classList.remove('sel');
      document.getElementById('id3').classList.remove('sel');
      document.getElementById('id4').classList.remove('sel');
      //id.setAttribute('class','sel');
      document.getElementById(id.id).className += ' sel';

       if($('#id1').hasClass('sel')){
           hsdmCheck = 1;
           $("#hall").show();
           $("#studio").hide();
           $("#dress").hide();
           $("#makeup").hide();
        }
       else if($('#id2').hasClass('sel')){
           hsdmCheck = 2;
           $("#studio").show();
           $("#hall").hide();
           $("#dress").hide();
           $("#makeup").hide();
        }
       else if($('#id3').hasClass('sel')){
           hsdmCheck = 3;
           $("#dress").show();
           $("#studio").hide();
           $("#hall").hide();
           $("#makeup").hide();
        }
       else if($('#id4').hasClass('sel')){
           hsdmCheck = 4;
           $("#makeup").show();
           $("#studio").hide();
           $("#dress").hide();
           $("#hall").hide();
        }
}
</script>
</head>
<body id="school_list">
   
   <jsp:include page="/WEB-INF/views/include/adminNav.jsp" >
       <jsp:param name="userName" value="${wdAdmin.admName}" />
       </jsp:include>
       
<div class="container">
    <div class="row" style="width: 100%;">
       <div class="col-lg-12" style="width:100%; height:20px;"></div>
 <!-- /////////////////////////////////////////// --> 
      <div class="col-lg-12">
         <div class="hsdm_nav">
                <ul class="hsdm_menu">
                    <li class="hsem_li sel" id="id1" onclick="classChange(this)"><a class="hsem_a" href="javascript:void(0)">웨딩홀</a></li>
                    <li class="hsem_li" id="id2" onclick="classChange(this)"><a class="hsem_a" href="javascript:void(0)">스튜디오</a></li>
                    <li class="hsem_li" id="id3" onclick="classChange(this)"><a class="hsem_a" href="javascript:void(0)">드레스</a></li>
                    <li class="hsem_li" id="id4" onclick="classChange(this)"><a class="hsem_a" href="javascript:void(0)">메이크업</a></li>
                </ul>  
         </div>
      </div>
      <!-- 홀 시작 -->
      <div class="col-lg-12" width="100%">
      <div id="hall">
         <ul>
            <li class="wdhth">
               <div class="wdhtitle" style="width:10%;"><p>웨딩홀명</p></div><!-- whName -->
               <div class="wdhtitle" style="width:17%;"><p>웨딩홀설명</p></div><!-- whContent -->
               <div class="wdhtitle" style="width:12%;"><p>주소</p></div><!-- WHLocation -->
               <div class="wdhtitle" style="width:9%;"><p>전화번호</p></div><!-- whNumber -->
               <!-- div class="wdhtitle" style="width:7%;"><p>대표이미지명</p></div>< HImgName -->
               <div class="wdhtitle" style="width:8%;"><p>홀명</p></div><!-- HName -->
               <div class="wdhtitle" style="width:7%;"><p>홀대관비</p></div><!-- HPrice -->
               <div class="wdhtitle" style="width:5%;"><p>1인당식비</p></div><!-- HFood -->
               <div class="wdhtitle" style="width:5%;"><p>최소인원</p></div><!-- HMin -->
               <div class="wdhtitle" style="width:5%;"><p>최대수용인원</p></div><!-- HMax -->
               <div class="wdhtitle" style="width:16%;"><p>설명</p></div><!-- HContent -->
               <div class="wdhtitle" style="width:5%;"><p>할인율</p></div><!-- hDiscount -->
            </li>
            <c:forEach var="hallList" items="${hList}" varStatus="status">
            <li class="wdhtd">
               <div class="wdhcon" style="width:10%;"><p>${hallList.whName }</p></div>
               <div class="wdhcon" style="width:17%;"><p>${hallList.whContent}</p></div>
               <div class="wdhcon" style="width:12%;"><p>${hallList.WHLocation }</p></div>
               <div class="wdhcon" style="width:9%;"><p>${hallList.whNumber }</p></div>
               <!-- div class="wdhcon" style="width:7%;"><p>${hallList.HImgName }</p></div -->
               <div class="wdhcon" style="width:8%;"><p>${hallList.HName }</p></div>
               <div class="wdhcon" style="width:7%;"><p>${hallList.HPrice }</p></div>
               <div class="wdhcon" style="width:5%;"><p>${hallList.HFood }</p></div>
               <div class="wdhcon" style="width:5%;"><p>${hallList.HMin }</p></div>
               <div class="wdhcon" style="width:5%;"><p>${hallList.HMax }</p></div>               
               <div class="wdhcon" style="width:16%;"><p>${hallList.HContent }</p></div>
               <div class="wdhcon" style="width:5%;"><p>${hallList.hDiscount }</p></div>
            </li>
            </c:forEach>
         </ul>

         <div class="row">
              <div class="col-lg-10" style="left:43%;">
                <div class="pagination">
               <ul class="pagination justify-content-center">
                  <c:if test="${!empty hPaging}">
                     <c:if test="${hPaging.prevBlockPage gt 0}">   <!-- prevBlockPage이 0 보다 크냐 -->
                     <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${hPaging.prevBlockPage})">이전</a></li>
                     </c:if>
                     <c:forEach var="i" begin="${hPaging.startPage}" end="${hPaging.endPage}">
                        <c:choose>
                           <c:when test="${i ne curPage}">
                              <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${i})">${i}</a></li>
                           </c:when>
                           <c:otherwise>
                              <li class="page-item active"><a class="page-link" href="javascript:void(0)" style="cursor:default">${i}</a></li>
                           </c:otherwise>
                        </c:choose>
                     </c:forEach>
                     <c:if test="${hPaging.nextBlockPage gt 0}">         
                        <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${hPaging.nextBlockPage})">다음</a></li>
                     </c:if>       
                  </c:if> 
               </ul>
                  </div>
              </div>
              
	         <div class="col-lg-1">
	            <div>
	               <form id="subscribe" action="" method="get">
	                  <div class="row" style="width: 100%;">
	                     <div class="col-lg-12">
	                           <button type="button" id="btnWrite" class="hsdm_btn">추가</button>
	                     </div>
	                  </div>
	               </form>
	            </div>
	         </div>
	        </div>
	        
         </div>
      </div>
      <!-- 홀 끝 -->
      <!-- 스튜디오 시작 -->
      <div class="col-lg-12" width="100%">
      <div id="studio">
         <ul>
            <li class="wdhth">
               <div class="wdhtitle" style="width:14%;"><p>스튜디오명</p></div><!-- sName -->
               <div class="wdhtitle" style="width:18%;"><p>주소</p></div><!-- sLocation -->
               <div class="wdhtitle" style="width:12%;"><p>전화번호</p></div><!-- sNumber -->
               <div class="wdhtitle" style="width:9%;"><p>스튜디오 가격</p></div><!-- sPrice -->
               <div class="wdhtitle" style="width:9%;"><p>대표이미지명</p></div><!-- sImgname -->
               <div class="wdhtitle" style="width:32%;"><p>스튜디오설명</p></div><!-- sContent -->
               <div class="wdhtitle" style="width:5%;"><p>할인율</p></div><!-- sDiscount -->
            </li>
            <c:forEach var="studioList" items="${sList}" varStatus="status">
            <li class="wdhtd">
               <div class="wdhcon" style="width:14%;"><p>${studioList.sName }</p></div>
               <div class="wdhcon" style="width:18%;"><p>${studioList.sLocation }</p></div>
               <div class="wdhcon" style="width:12%;"><p>${studioList.sNumber }</p></div>
               <div class="wdhcon" style="width:9%;"><p>${studioList.sPrice }</p></div>
               <div class="wdhcon" style="width:9%;"><p>${studioList.sImgname }</p></div>
               <div class="wdhcon" style="width:32%;"><p>${studioList.sContent }</p></div>
               <div class="wdhcon" style="width:5%;"><p>${studioList.sDiscount }</p></div>
            </li>
            </c:forEach>
         </ul>

         <div class="row">
              <div class="col-lg-10" style="left:43%;">
                <div class="pagination">
               <ul class="pagination justify-content-center">
                  <c:if test="${!empty hPaging}">
                     <c:if test="${hPaging.prevBlockPage gt 0}">   <!-- prevBlockPage이 0 보다 크냐 -->
                     <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${hPaging.prevBlockPage})">이전</a></li>
                     </c:if>
                     <c:forEach var="i" begin="${hPaging.startPage}" end="${hPaging.endPage}">
                        <c:choose>
                           <c:when test="${i ne curPage}">
                              <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${i})">${i}</a></li>
                           </c:when>
                           <c:otherwise>
                              <li class="page-item active"><a class="page-link" href="javascript:void(0)" style="cursor:default">${i}</a></li>
                           </c:otherwise>
                        </c:choose>
                     </c:forEach>
                     <c:if test="${hPaging.nextBlockPage gt 0}">         
                        <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${hPaging.nextBlockPage})">다음</a></li>
                     </c:if>       
                  </c:if> 
               </ul>
                  </div>
              </div>
              
	         <div class="col-lg-1">
	            <div>
	               <form id="subscribe" action="" method="get">
	                  <div class="row" style="width: 100%;">
	                     <div class="col-lg-12">
	                           <button type="button" id="btnWrite" class="hsdm_btn">추가</button>
	                     </div>
	                  </div>
	               </form>
	            </div>
	         </div>
	        </div>
              
         </div>
      </div>
      <!-- 스튜디오 끝 -->
      <!-- 드레스 시작 -->
      <div class="col-lg-12" width="100%">
      <div id="dress">
         <ul>
            <li class="wdhth">
               <div class="wdhtitle" style="width:9%;"><p>드레스샵 이름</p></div><!-- dcName -->
               <div class="wdhtitle" style="width:13%;"><p>주소</p></div><!-- dcLocation -->
               <div class="wdhtitle" style="width:8%;"><p>전화번호</p></div><!-- dcNumber -->
               <div class="wdhtitle" style="width:16%;"><p>업체설명</p></div><!-- dcContent -->
               <div class="wdhtitle" style="width:15%;"><p>드레스명</p></div><!-- dName -->
               <div class="wdhtitle" style="width:8%;"><p>드레스 이미지명</p></div><!-- dImgname -->
               <div class="wdhtitle" style="width:8%;"><p>가격</p></div><!-- dPrice -->
               <div class="wdhtitle" style="width:17%;"><p>드레스설명</p></div><!-- dContent -->
               <div class="wdhtitle" style="width:5%;"><p>할인율</p></div><!-- dImgname -->
            </li>
            <c:forEach var="dressList" items="${dList}" varStatus="status">
            <li class="wdhtd">
               <div class="wdhcon" style="width:9%;"><p>${dressList.dcName }</p></div>
               <div class="wdhcon" style="width:13%;"><p>${dressList.dcLocation }</p></div>
               <div class="wdhcon" style="width:8%;"><p>${dressList.dcNumber }</p></div>
               <div class="wdhcon" style="width:16%;"><p>${dressList.dcContent }</p></div>
               <div class="wdhcon" style="width:15%;"><p>${dressList.dName }</p></div>
               <div class="wdhcon" style="width:8%;"><p>${dressList.dImgname }</p></div>
               <div class="wdhcon" style="width:8%;"><p>${dressList.dPrice }</p></div>
               <div class="wdhcon" style="width:17%;"><p>${dressList.dContent }</p></div>
               <div class="wdhcon" style="width:5%;"><p>${dressList.dDiscount }</p></div>
            </li>
            </c:forEach>
         </ul>

         <div class="row">
              <div class="col-lg-10" style="left:43%;">
                <div class="pagination">
               <ul class="pagination justify-content-center">
                  <c:if test="${!empty hPaging}">
                     <c:if test="${hPaging.prevBlockPage gt 0}">   <!-- prevBlockPage이 0 보다 크냐 -->
                     <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${hPaging.prevBlockPage})">이전</a></li>
                     </c:if>
                     <c:forEach var="i" begin="${hPaging.startPage}" end="${hPaging.endPage}">
                        <c:choose>
                           <c:when test="${i ne curPage}">
                              <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${i})">${i}</a></li>
                           </c:when>
                           <c:otherwise>
                              <li class="page-item active"><a class="page-link" href="javascript:void(0)" style="cursor:default">${i}</a></li>
                           </c:otherwise>
                        </c:choose>
                     </c:forEach>
                     <c:if test="${hPaging.nextBlockPage gt 0}">         
                        <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${hPaging.nextBlockPage})">다음</a></li>
                     </c:if>       
                  </c:if> 
               </ul>
                  </div>
              </div>
              
	         <div class="col-lg-1">
	            <div>
	               <form id="subscribe" action="" method="get">
	                  <div class="row" style="width: 100%;">
	                     <div class="col-lg-12">
	                           <button type="button" id="btnWrite" class="hsdm_btn">추가</button>
	                     </div>
	                  </div>
	               </form>
	            </div>
	         </div>
	        </div>
              
         </div>
      </div>
      <!-- 드레스 끝 -->
      <!-- 메이크업 시작 -->
      <div class="col-lg-12" width="100%">
      <div id="makeup">
         <ul>
            <li class="wdhth">
               <div class="wdhtitle" style="width:13%;"><p>메이크업샵 이름</p></div><!-- mName -->
               <div class="wdhtitle" style="width:18%;"><p>주소</p></div><!-- mLocation -->
               <div class="wdhtitle" style="width:12%;"><p>전화번호</p></div><!-- mNumber -->
               <div class="wdhtitle" style="width:8%;"><p>대표이미지명</p></div><!-- mImgName -->
               <div class="wdhtitle" style="width:10%;"><p>기본가격</p></div><!-- mPrice -->
               <div class="wdhtitle" style="width:24%;"><p>설명</p></div><!-- mContent -->
               <div class="wdhtitle" style="width:9%;"><p>추가인원당 가격</p></div><!-- mPlus -->
               <div class="wdhtitle" style="width:5%;"><p>할인율</p></div><!-- mDiscount -->
            </li>
            <c:forEach var="makeupList" items="${mList}" varStatus="status">
            <li class="wdhtd">
               <div class="wdhcon" style="width:13%;"><p>${makeupList.mName }</p></div>
               <div class="wdhcon" style="width:18%;"><p>${makeupList.mLocation }</p></div>
               <div class="wdhcon" style="width:12%;"><p>${makeupList.mNumber }</p></div>
               <div class="wdhcon" style="width:8%;"><p>${makeupList.mImgName }</p></div>
               <div class="wdhcon" style="width:10%;"><p>${makeupList.mPrice }</p></div>
               <div class="wdhcon" style="width:24%;"><p>${makeupList.mContent }</p></div>
               <div class="wdhcon" style="width:9%;"><p>${makeupList.mPlus }</p></div>
               <div class="wdhcon" style="width:5%;"><p>${makeupList.mDiscount }</p></div>
            </li>
            </c:forEach>
         </ul>

         <div class="row">
              <div class="col-lg-10" style="left:43%;">
                <div class="pagination">
               <ul class="pagination justify-content-center">
                  <c:if test="${!empty hPaging}">
                     <c:if test="${hPaging.prevBlockPage gt 0}">   <!-- prevBlockPage이 0 보다 크냐 -->
                     <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${hPaging.prevBlockPage})">이전</a></li>
                     </c:if>
                     <c:forEach var="i" begin="${hPaging.startPage}" end="${hPaging.endPage}">
                        <c:choose>
                           <c:when test="${i ne curPage}">
                              <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${i})">${i}</a></li>
                           </c:when>
                           <c:otherwise>
                              <li class="page-item active"><a class="page-link" href="javascript:void(0)" style="cursor:default">${i}</a></li>
                           </c:otherwise>
                        </c:choose>
                     </c:forEach>
                     <c:if test="${hPaging.nextBlockPage gt 0}">         
                        <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${hPaging.nextBlockPage})">다음</a></li>
                     </c:if>       
                  </c:if> 
               </ul>
                  </div>
              </div>
              
	         <div class="col-lg-1">
	            <div>
	               <form id="subscribe" action="" method="get">
	                  <div class="row" style="width: 100%;">
	                     <div class="col-lg-12">
	                           <button type="button" id="btnWrite" class="hsdm_btn">추가</button>
	                     </div>
	                  </div>
	               </form>
	            </div>
	         </div>
	        </div>
              
      </div>
      </div>
      <!-- 메이크업 끝 -->

         

      

  </div>
</div>
	<%@ include file="/WEB-INF/views/include/footer3.jsp" %>
</body>
</html>