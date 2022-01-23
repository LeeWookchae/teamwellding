<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style>
html, body{
  color:  #525252;
}
table{
  width:100%;
  border: 1px solid #c4c2c2;
}
table th, td{
  border-right: 1px solid #c4c2c2;
  border-bottom: 1px solid #c4c2c2;
  height: 4rem;
  padding: 10px;
}
table th{
  background-color: #e0e4fe;
  text-align: center;
  width: 200px;
}
input[type=text], input[type=password]{
  height:2rem;
  width: 100%;
  border-radius: .2rem;
  border: .2px solid rgb(204,204,204);
  background-color: rgb(246,246,246);
}
button{
  width: 5rem;
  margin-top: 1rem;
  border: .1rem solid rgb(204,204,204);
  border-radius: .2rem;
  /*box-shadow: 1px 1px #666;*/
}
button:active {
  background-color: rgb(186,186,186);
  box-shadow: 0 0 1px 1px #666;
  transform: translateY(1px);
}
</style>
<script type="text/javascript" src="../resources/js/jquery.colorbox.js"></script>
<script type="text/javascript" src="../resources/js/colorBox.js"></script>
<script>
$(document).ready(function(){
	$("#bTitle").focus();
});

function fn_eBoardUpdate()
{
	//내용확인
	if(icia.common.isEmpty($("#bTitle").val()))
	{
		alert("글 제목을 입력해주세요");
		$("#bTitle").focus();
		return;
	}
	
	if(icia.common.isEmpty($("#bContent").val()))
	{
		alert("글 내용을 입력해주세요");
		$("#bContent").focus();
		return;
	}
	
	//수정 취소
	if(!confirm("회원정보를 수정하시겠습니까?"))
	{
		//NO
		return;
	}
	
	var formData = {
			eBSeq: $("#bSeq").val(),
			adminId: $("#adminId").val(),
			eBTitle: $("#bTitle").val(),
			eBContent: $("#bContent").val()
	};
	
	//ajax통신
	icia.ajax.post({
		url: "/mng/eBoardUpdateProc",
		data: formData,
		success: function(res)
		{
			icia.common.log(res);
			
			if(res.code == 0)
			{
				alert("게시물이 수정되었습니다.");
				fn_colorbox_close(parent.fn_pageInit);
			}
			else if(res.code == -1)
			{
				alert("게시물 수정 중 오류가 발생하였숩니다.");
			}
			else if(res.code == 400)
			{
				alert("파라미터 값이 잘못되었습니다.");
			}
			else if(res.code == 404)
			{
				alert("게시물이 존재하지 않습니다.");
				///칼라박스 내용이 잘못됬다는거니까 칼라박스를 닫게하자
				fn_colorbox_close();
			}
		},
		complete: function(data)
		{
			icia.common.log(data);
		},
		error: function(xhr, status, error)
		{
			icia.common.error(error);
		}
	});
	
}

function fn_eBoardDelete()
{
	if(confirm("정말 삭제하시겠습니까?") == true)
	{
		$.ajax({
			type: "POST",
			url: "/mng/eBoardDelete",
			data:{
				bSeq: <c:out value="${eBoard.eBSeq}" />
			},
			datatype: "JSON",
			success: function(response)
			{
				if(response.code == 0)
				{
					alert("게시물이 삭제되었습니다.");
					fn_colorbox_close(parent.fn_pageInit);
				}
				else if(response.code == 400)
				{
					alert("파라미터값이 올바르지않습니다.");
				}
				else if(response.code == 404)
				{
					alert("게시물을 찾을 수 없습니다.");
					fn_colorbox_close();
				}
				else
				{
					alert("게시물 삭제 중 오류가 발생했습니다.");
					fn_colorbox_close();
				}
			},
			complete: function(data)
			{
				icia.common.log(data);
			},
			error: function(xhr, status, error)
			{
				icia.common.error(error);
			}
		});
	}
}
</script>
</head>
<body>

<div class="layerpopup" style="width:1123px; margin:auto; margin-top:5%;">
	<h1 style="font-size: 1.6rem; margin-top: 3rem; margin-bottom: 1.6rem; padding: .5rem 0 .5rem 1rem; background-color: #e0e4fe;">공지사항 게시글 수정</h1>
   <div class="layer-cont">
      <form name="regForm" id="regForm" method="post">
         <table>
            <tbody>
            	<tr>
                  <th scope="row">글 번호</th>
                  <td>
                  	${eBoard.eBSeq}
                     <input type="hidden" id="bSeq" name="bSeq" value="${eBoard.eBSeq}"/>
                  </td>
            	</tr>
               <tr>
                  <th scope="row">작성자</th>
                  <td>
                  	${eBoard.adminId}
                     <input type="hidden" id="adminId" name="adminId" value="${eBoard.adminId}"/>
                  </td>
               </tr>
               <tr>
                   <th scope="row">이미지</th>
                  <td>
                  	 <img src="/resources/board/${eBoard.eBImgName}">
                  </td>
               </tr>
               <tr>
                  <th scope="row">제목</th>
                  <td>
                     <input type="text" style="background-color: #fff;" id="bTitle" name="bTitle" value="${eBoard.eBTitle}"/>
                  </td>
               </tr>
               <tr>
                   <th scope="row">내용</th>
                  <td>
                  	 <textarea class="form-control" rows="3" name="bContent" id="bContent"style="ime-mode: active; resize: none; width:100%; float:left; height:76px; font-size:14px;" required>${eBoard.eBContent}</textarea>
                  </td>
               </tr>
               <tr>
                  <th scope="row">등록일</th>
                  <td>
                  ${eBoard.regDate}
                  </td>
               </tr>
            </tbody>
         </table>
      </form>
      <div class="pop-btn-area" style="float: right;">
         <button onclick="fn_eBoardUpdate()" class="btn-type01"><span>수정</span></button>
         <button onclick="fn_eBoardDelete()" class="btn-type01" style="margin-left: 1rem;"><span>삭제</span></button>
         <button onclick="fn_colorbox_close()" id="colorboxClose" class="btn-type01" style="margin-left: 1rem;"><span>닫기</span></button>
      </div>
   </div>

</div>


	<%@ include file="/WEB-INF/views/include/footer3.jsp" %>
</body>
</html>