<%
 response.setHeader("Cache-Control","no-cache"); //Forces caches to obtain a new copy of the page from the origin server
 response.setHeader("Cache-Control","no-store"); //Directs caches not to store the page under any circumstance
 response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
 response.setHeader("Pragma","no-cache"); //HTTP 1.0 backward compatibility
 
 
 if(session.getAttribute("RoleID")==null && session.getAttribute("EmployeeID")==null) //||!session.getAttribute("RoleID").toString().equals("USR131")||!session.getAttribute("RoleID").toString().equals("ADM121"))
 {
	 response.sendRedirect("login.jsp");
	 }else if(session.getAttribute("RoleID").toString().equals("SAD111")||session.getAttribute("RoleID").toString().equals("USR131")||session.getAttribute("RoleID").toString().equals("ADM121"))
	 {
int timeout = session.getMaxInactiveInterval();
response.setHeader("Refresh", timeout + "; URL =login.jsp");
%>
<%@page import="dbreflib.URL.*"%>
<script type="text/javascript" src="validation.js"></script>
<script type="text/javascript">


var CheckboxCheckedImage = new Image();
var CheckboxUncheckedImage = new Image();



CheckboxCheckedImage.src = "images/checkbox_checked.png";
CheckboxUncheckedImage.src = "images/checkbox_unchecked.gif";

function CheckboxClicked(imageid,checkboxid) {
var image = document.getElementById(imageid);
if(image.src == CheckboxCheckedImage.src) {
  image.src = CheckboxUncheckedImage.src;
  document.getElementById(checkboxid).checked = false;
  checkedAll();  
}
else {
  image.src = CheckboxCheckedImage.src;
  document.getElementById(checkboxid).checked = true;
  checkedAll();
  }
return false;
}

</script>
<link href="page.css" rel="stylesheet" type="text/css" />
<body>
       
       <%
       
       String category,surveyname,st,menu_display;
       int id,div_width=0,div_height=0;
       category=pageContext.findAttribute("category").toString();
       surveyname=pageContext.findAttribute("surveyname").toString();
      menu_display=pageContext.findAttribute("menu_display").toString();
       id=Integer.parseInt(pageContext.findAttribute("id").toString());
       if(menu_display.equals("active"))
       {%>
               <br><br><br><br>
               <%@ include file="menu.jsp" %>
               <% 
               div_width=1270;
               div_height=380;
       }
       else
       {
               div_width=1270;
               div_height=460;        
       }
       if(id==0)
       {
       
               response.sendRedirect("duplicateEntry.jsp");
               //out.println("hello");
       }
	else
	{
		String message;
		message=pageContext.findAttribute("message").toString().toUpperCase();
		//out.println("Category " +category+"Surveyname "+surveyname);
		out.println("");
		out.println("<label>"+message+"</label>");
		
	}
	%>

</body>
</html>
<script language="javascript">
fields = 2;
function addInput() {
	
if (fields != 5) {

id="'option"+(fields+1)+"'";


document.getElementById('text').innerHTML=document.getElementById('text').innerHTML+"<label>Option "+(fields+1)+"</label>"+"<input type='text'   name='option[]' /><br />";
fields += 1;
} else {
document.getElementById('text').innerHTML += "<br />Only 5 Options can be added.";
document.getElementById("add_input").disabled=true;


}
}

function reset_form() {
	//alert("hello");
	document.getElementById("myquestion").value="";
	 document.getElementById("text").innerHTML="";
	 fields=2;
	 document.getElementById("option1").value="";
	 document.getElementById("option2").value="";
	 document.getElementById("add_input").disabled=false;
	
	
	}
</script>


<html>
<head>
<title>Edit a Survey</title>
<script type="text/javascript" src="csspopup.js"></script>
<link href="popup.css" rel="stylesheet" type="text/css" />
</head>
<body>

	<div>
		<div id="blanket" style="display: none;"></div>





		<div id="popUpDiv" align="left"
			style="display: none; border: solid; border-color: #333333; width: 900px;height: 330px;position: absolute;">
			<a href="#" onClick="popup('popUpDiv');reset_form();"  style="border:0;position: absolute;margin-left: 885px;margin-top: -10;text-decoration:none;"><img alt="Close" src="images/cancel.gif" style="text-decoration: none;border: 0"></a>





						<form method="post" name="add_question_form">
				<table>
				 
				<tr ><label style="position: absolute;margin-left:63px;color:gray;"><b>Enter Question</b></label> </tr>
					<tr style="position: absolute;margin-left:54px;margin-top:14px">
						<td><textarea rows="6" cols="90" id="myquestion"></textarea></td>
					</tr>
					
	





					
					<tr style="position: absolute;margin-top:140px">
						<input type="button" onclick="addInput()" name="add_input" id="add_input" value="Add a Option"  style="margin-top: 140px;position: absolute;margin-left: 50px" />

<div id="text1" style="margin-top: 140px;position: absolute;margin-left: 160px">
<label>Option 1</label><input type='text' value='' name='option[]' id="option1" /><br />
<label>Option 2</label><input type='text' value='' name='option[]' id="option2" />
</div>
<div id="text" style="margin-top: 193px;position: absolute;margin-left: 160px">
</div>

					</tr>
					
					<tr>
					<td><input type="button" value="Add Question" style="height: 40px;margin-top:240px;margin-left:370px;" onclick="insert_form()" ></td>
					
					<td><input type="button" value="Reset" style="height: 40px;margin-top:240px;margin-left:0px;" onclick="reset_form();" ></td>
					</tr>
					

				</table>








				

			</form>

			<script type="text/javascript" src="jQuery.js"></script>


		</div>
	</div>
	
	
	<script type="text/javascript">
	//alert("Loading fillquestion script");
	
	  var myquestion,myoptio1,myoption2,myoption3,myoption4,myoption5;
var check;
	function fillQuestions() {
//alert("Inside Fillquestion");
var surveyname="<%=surveyname%>"; 
var category="<%=category%>";
//var message;

var l="<%=dbreflib.URL.url%>"+"databse_functions_calling"
			//alert("Surveyname "+surveyname);
			//alert("Category "+category);
			//alert("Calling Function");
			$.ajax({
				type : 'POST',
				url : l,
				data : "surveyname=" + surveyname + " &category=" + category + "&id=" + 3,
				async : false,
				success : function(resp) {
					
					
					//alert("Response "+resp);
					//alert("Original Response"+resp);
					//originalmessage=resp.toString();
				
					document.getElementById("myid").innerHTML=resp;
					//alert(resp);
					//alert("hi");
				}
			}); //ajax
		}//fillQuestions
		
		$.ajaxSetup ({
		    // Disable caching of AJAX responses
		    cache: false
		});

		
		$(document).ready(function(){
			//alert("filling");
			fillQuestions();
		   

		//document.getElementById("checkbutton").style.display="block";

		});
		
		
		
		   function add_question(){
			   var surveyname="<%=surveyname%>"; 
			   var category="<%=category%>";
			   var  i=0;
			// alert("surveyname "+surveyname+"categoryname"+category);
			 
		   myquestion=document.getElementById("myquestion").value;
		 //  var myoption=[null,null,null,null,null];
		var option=new Array();
		var myoption=new Array();
		 option=document.getElementsByName("option[]");
		 
		for(i=0;i<option.length;i++)
			{
			//alert(option[i].value)
			myoption[i]=option[i].value;
			}
		for(i=option.length;i<5;i++)
			{
			myoption[i]=null;
			}
		 
		
		myoption[5]=null;
		
		   for(i=0;i<5;i++)
			   {
			   if(myoption[i]=="" || myoption[i]=="null")
				   { 
				   for(j=i;j<5;j++)
					  {
					   myoption[j]=myoption[j+1];
					   }
					   
					  
				   i=i-1;
			   
				   }
			   }

		   var l="<%=dbreflib.URL.url%>"+"databse_functions_calling"
			
				$.ajax({
					type: 'POST',
					url: l,
					data: "myquestion="+myquestion+"&myoption1="+myoption[0]+" &myoption2="+myoption[1]+" &myoption3="+myoption[2]+" &myoption4="+myoption[3]+" &myoption5="+myoption[4]+" &surveyname="+surveyname+" &category="+category+"&id="+4,
					async: false,
					success:function(resp) {
						$("#response").html(resp);
						 alert(resp);
						 reset_form();
						 //alert("hello");
						 popup('popUpDiv');
						 
						 $(document).ready(function() {
								//alert("fillquestion firing");
								return fillQuestions();

							});
						
						
					}	
				}); 
		 
			}
		   
		   $(document).ready(function() {
				//alert("hi");
				check_survey_submission();

			});

		   
		   function check_survey_submission() {
			  // alert("checking");
		
			   var surveyname="<%=surveyname%>"; 
			   var category="<%=category%>";

			   var l="<%=dbreflib.URL.url%>"+"databse_functions_calling"
				$.ajax({
					type : 'POST',
					url : l,
					data : "id="+10+"&surveyname="+surveyname+"&category="+category,
					async : false,
					success : function(resp) {
					
						document.getElementById("myspace").innerHTML=resp;
					}
				}); //ajax
			
		   
		   
		   }
		   
		   function publish_survey() {
			  // alert("hello");
		//alert(has_question());
			if(has_question()==false){
			
				return false;
			}
		
			   var surveyname="<%=surveyname%>"; 
			   var category="<%=category%>";

			   var l="<%=dbreflib.URL.url%>"+"databse_functions_calling"
				$.ajax({
					type : 'POST',
					url :l,
					data : "id="+11+"&surveyname="+surveyname+"&category="+category,
					async : false,
					success : function(resp) {
					
						alert(resp);
					}
				}); //ajax
			
				check_survey_submission();
		   
		   }
		   
		   function unpublish_survey() {
			  // alert("hello");

			   var surveyname="<%=surveyname%>"; 
			   var category="<%=category%>";
          
			   var l="<%=dbreflib.URL.url%>"+"databse_functions_calling"
				$.ajax({
					type : 'POST',
					url :l,
					data : "id="+12+"&surveyname="+surveyname+"&category="+category,
					async : false,
					success : function(resp) {
					
						alert(resp);
					}
				}); //ajax
			
				check_survey_submission();
		   
		   }
		   
		function has_question() {
				  // alert("hello");
					
				  
				   var surveyname="<%=surveyname%>"; 
				   var category="<%=category%>";
				   var check;

				   var l="<%=dbreflib.URL.url%>"+"databse_functions_calling"
					$.ajax({
						type : 'POST',
						url :l,
						data : "id="+23+"&surveyname="+surveyname+"&category="+category,
						async : false,
						success : function(resp) {
					//	alert(resp);
						check=resp;
					
			
						}
					}); //ajax
					if(parseInt(check)==0)
					{
					alert("You can't publish a Survey with no Questions");
				return false;
					}
				else if(parseInt(check)==-1)
					{
					alert("SQL Exception");
					return false;
					}
					
			   
			   }
		   </script>
		   
		   
		   
<br><br>

<form name="question_bank" action="databse_functions_calling" method="post">
<input type=hidden value='<%=surveyname %>' name="surveyname">

<input type=hidden value='<%=category %>' name="category">
<input type=hidden value=6 name="id">
<input type="image" src="images/questionbank.png" id="questionbank"><label>Add Questions from Question Bank </label>
<p id="myspace">
</p>

</form>
<script type="text/javascript" src="dropdown_functions.js"></script>
<script type="text/javascript" >
$(document).ready(function(){
	//alert("hello doc");
	document.getElementById("select_target").style.display="none";
});




function delete_move(surveyname,category,flag) {
	aa= document.getElementsByName("chk1");
	var question_id="";
	var count=0;
	for (var i =0; i < document.getElementsByName("chk1").length; i++) 
	{
	if(aa[i].checked==true)
		 {

	question_id=question_id+aa[i].value+"-";
		 }

	}
	var l="<%=dbreflib.URL.url%>"+"databse_functions_calling";

	if(flag==0){		
		
		$.ajax({
			type : 'POST',
			url : l,
			data : "id="+8+"&surveyname="+surveyname+"&category="+category+"&question_id="+question_id,
			async : false,
			success : function(resp) {
			
				alert(resp);
			//alert(question_id.length);
			}
		}); //ajax

	fillQuestions();
	}

	else if(flag==1){
		//alert("entered");
		var targ_category=document.getElementById("category").options[document.getElementById("category").selectedIndex].value;
		var targ_survey=document.getElementById("target_survey").options[document.getElementById("target_survey").selectedIndex].value;
		//alert("entered");
		$.ajax({
			type : 'POST',
			url : l,
			data : "id="+22+"&targ_category="+targ_category+"&targ_survey="+targ_survey+"&curr_category="+category+"&curr_survey="+surveyname+"&question_id="+question_id,
			async : false,
			success : function(resp) {
				alert(resp);
				
			}
		}); //ajax
		fillQuestions();
	}


	}
	function fillTargetSurvey(surveyname){
		//alert("Target");
		var l="<%=dbreflib.URL.url%>"+"databse_functions_calling"
		$.ajax({
			type : 'POST',
			url : l,
			data : "id="+21+"&surveyname="+surveyname+"&category="+document.getElementById("category").options[document.getElementById("category").selectedIndex].value,
			async : false,
			success : function(resp) {
			
				//alert(resp);
				$("#target_survey").html(resp);
			}
		}); //ajax

		
	}

	function action_execute(){
		//alert("hii");
		aa=document.getElementsByName("chk1");
		var count=0;
		var x;
		for(x=0;x<aa.length;x++){
			if(aa[x].checked==true)
				count++;
		}
		
		if(count!=0){
		var dropdown= document.getElementById("action_type");
			
			if(dropdown.options[dropdown.selectedIndex].value=="Delete"){
				document.getElementById("select_target").style.display="none";
				var r=confirm("Are you sure you want to delete the selections?");
				if(r==true)
					delete_move('<%=surveyname%>','<%=category%>',0);
				else
					return false;
			}
			else if(dropdown.options[dropdown.selectedIndex].value=="Move"){
				//alert("entered");
				delete_move('<%=surveyname%>','<%=category%>',1);
				}
			
					
		}else{
			alert("No questions have been selected");
			return false;
		}
			
	}

	function action_choice(){
		var dropdown= document.getElementById("action_type");
		if(dropdown.options[dropdown.selectedIndex].value=="Delete"){
			document.getElementById("select_target").style.display="none";
		}else if(dropdown.options[dropdown.selectedIndex].value=="Move"){
			document.getElementById("select_target").style.display="block";
			fillcategory();
			fillTargetSurvey('<%=surveyname%>');
		}
	}

</script> 

<br>
<div id="select_target">
		<table>
			<tr>
				<td>Select Target Category</td>
				<td><select id="category"
					onchange="fillTargetSurvey('<%=surveyname%>')"></select></td>
			</tr>
			<tr>
				<td>Select Target Survey</td>
				<td><select id="target_survey"></select></td>
			</tr>

		</table>
	</div>
	<br><br><br>

<div id="myid" style="width:<%=div_width %>px; height:<%=div_height%>px;" >
</div>
	
	
	
	
<script type="text/javascript">

var CheckboxCheckedImage = new Image();
var CheckboxUncheckedImage = new Image();



CheckboxCheckedImage.src = "images/checkbox_checked.png";
CheckboxUncheckedImage.src = "images/checkbox_unchecked.gif";
function CheckboxClicked1(imageid,checkboxid) {
	var image = document.getElementById(imageid);
	if(image.src == CheckboxCheckedImage.src) {
	   image.src = CheckboxUncheckedImage.src;
	   document.getElementById(checkboxid).checked = false;
	   }
	else {
	   image.src = CheckboxCheckedImage.src;
	   document.getElementById(checkboxid).checked = true;
	   checkboxid.checked=checked;
	   }
	return false;
}
var CheckboxCheckedImage = new Image();
var CheckboxUncheckedImage = new Image();



CheckboxCheckedImage.src = "images/checkbox_checked.png";
CheckboxUncheckedImage.src = "images/checkbox_unchecked.gif";
checked=false;

function checkedAll(){
	if(document.getElementById("chk").checked==true){
		for (var i =1; i <= document.getElementsByName("chk1").length; i++){
			document.getElementById("chk"+i).checked = true;
		}//if for closing
	}//if closing
	else{
		for (var i =1; i <= document.getElementsByName("chk1").length; i++){
			document.getElementById("chk"+i).checked = false;
		}//else for closing
	}//else closed
}//checkedAll() closed
	</script>

	
	
</body>
</html>
<%} %>
