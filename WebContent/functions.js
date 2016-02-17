
var l="http://localhost:8080/Survey_Version2.0/";//for employee id duplicacy validation
function validator() {
	document.getElementById('errName').innerHTML = "";
	document.getElementById('errId').innerHTML = "";
	document.getElementById('errEmail').innerHTML = "";
	document.getElementById('errPass').innerHTML = "";
	document.getElementById('errConfirm').innerHTML = "";
	// alert("Entered Validator!");
	var valid_name = document.forms["Form"]["empName"].value;
	// alert(valid_name);
	var valid_email = document.forms["Form"]["empEmail"].value;
	// alert(valid_email);
	var valid_ID = document.forms["Form"]["empId"].value;
	var valid_pass = document.forms["Form"]['empPass'].value;
	var valid_con_pass = document.forms["Form"]["confirmPass"].value;
	var atpos = valid_email.indexOf("@");
	var dotpos = valid_email.lastIndexOf(".");
	
	if (valid_name == null || valid_name == "") {
		// document.getElementById('comment').innerHTML = "<img
		// src='images/comment.png'/>";
		document.getElementById('errName').innerHTML = "<p class='triangle-right left'>Vacant Field! Please enter Employee Name</p>";
		return false;
	}

	else if (!valid_name.match(/^[a-zA-Z ]+$/)) {
		document.getElementById('errName').innerHTML = "<p class='triangle-right left'>Invalid Name. Only alphabets are allowed.</p>";
		return false;
	}else if(empIdDuplicacyCheck(valid_ID)==true){
			return false;
		}else {
			// x=empIdDuplicacyCheck(valid_ID);
			// alert(x);
			if (valid_email == null || valid_email == "") {
				document.getElementById('errEmail').innerHTML = "<p class='triangle-right2 left'>Please enter Email</p>";
				return false;
			} else if (atpos < 1 || dotpos < atpos + 2
					|| dotpos + 2 >= valid_email.length) {
				document.getElementById('errEmail').innerHTML = "<p class='triangle-right2 left'>Invalid email address</p>";
				return false;
			}
			// Password Validation
			else {
				if (valid_pass == null || valid_pass == "") {
					document.getElementById('errPass').innerHTML = "<p class='triangle-right3 left'>Please enter Password.</p>";
					return false;
				} else if(valid_pass.length<6){
					document.getElementById('errPass').innerHTML="<p class='triangle-right3 left'>Password less than 6 characters!</p>";
					return false;
				}else if (valid_con_pass == null || valid_con_pass == "") {
					document.getElementById('errConfirm').innerHTML = "<p class='triangle-right4 left'>Please Confirm Password.</p>";
					return false;
				} else if (valid_con_pass != valid_pass) {
					document.getElementById('confirmPass').value = "";
					document.getElementById('errConfirm').innerHTML = "<p class='triangle-right4 left'>Passwords do not match.</p>";
					return false;
				} else {
					return true;
				}

			}

		}


}

function fillRoleList() {
	var l1=l+"getcategory";
		// var id="fillRoleList"; //for recognizing the structure to be entered

	$.ajax({
			type : 'POST',
			url : l1,
			data : "id=" + 3,
			async : false,
			success : function(resp) {
				// alert(resp);
				$("#roleList").html(resp);

			}
		});

	}

function fillCategoryList() {
	// var id="fillCategoryList"; //for recognizing the structure to be entered
	// alert("entered category function");
var l2=l+"getcategory";
	$.ajax({
		type : 'POST',
		url : l2,
		data : "id=" + 1,
		async : false,
		success : function(resp) {
			// alert(resp);
			$("#categoryList").html(resp);

		}
	}); // ajax

	fillSurveyList();

}// fillCategoryList

function fillSurveyList() {
	var l3=l+"getcategory";
	var combo = document.getElementById("categoryList");
	if (combo.selectedIndex >= 0) {

		val = combo.options[combo.selectedIndex].value;
	}
	// alert(combo);
	$.ajax({
		type : 'POST',
		url : l3,
		data : "id=" + 2 + "&value=" + val+"&function_id="+0,
		async : false,
		success : function(resp) {
			// alert(resp);
			$("#surveyList").html(resp);
		}
	}); // ajax
}// fillSurveyList

function getSurvey() {
	var l4=l+"getcategory";
	// alert("entered!!");
	// var id="getSurvey"; //for recognizing the structure to be entered
	document.getElementById("field2").style.display = "block";

	var survName = document.getElementById("surveyList").value;
	var catName = document.getElementById("categoryList").value;
	//document.getElementById("surveyTitle").innerHTML = "<font face=\"lucida calligraphy\" size=\"24\">"
			//+ survName + "</font>";
	$.ajax({
		type : 'POST',
		url : l4,
		data : "id=" + 4 + "&survName=" + survName + "&catName=" + catName,
		async : false,
		success : function(resp) {
			// alert(resp);
			$("#qTable").html(resp);
		}
	}); // ajax
}

function dataDeleteUser() {
	document.getElementById("field2").style.display = "block";
	var val = document.getElementById("empList").value;
	var l5=l+"getcategory";
	$.ajax({
		type : 'POST',
		url :l5,
		data : "id=" + 5+"&selectedEmpId="+val,
		async : false,
		success : function(resp) {
			// alert(resp);
			$("#dTable").html(resp);
		}
	});// ajax

}// deleteUser

function deleteUser(empId) {var l6=l+"getcategory";
	var r = confirm("Are you sure you want to delete this user?");
	if (r == true) {
		$.ajax({
			type : 'POST',
			url : l6,
			data : "id=" + 6 + "&val1=" + empId + "&val2="
					+ document.getElementById("roleList").value,
			async : false,
			success : function(resp) {
				alert(resp);
				//$("#dTable").html(resp);
				
			}
		});
		fillEmpList();
		return false;
	} else
		return false;
}
function getBar(mylink) {
	var val = "newWindow";
	return window
			.open(
					mylink,
					val,
					'width=640,height=300,scrollbars=yes, resizable=yes,toolbar=no,directories=no,location=no,menubar=no,status=no,right=700,top=0');

}

function empIdDuplicacyCheck(valid_ID) {
	
	//alert("yyello!!!! " + valid_ID);
	if (valid_ID == null || valid_ID == "") {
		document.getElementById('errId').innerHTML = "<p class='triangle-right1 left'>Please enter Employee ID</p>";
		return true;
	}

	// Invalid ID
	else if (!valid_ID.match(/^[0-9]+$/)) {
		document.getElementById('errId').innerHTML = "<p class='triangle-right5 left'>Invalid ID. Only numeric values allowed</p>";
		return true;
	} else if (valid_ID.length < 4) {
		document.getElementById('errId').innerHTML = "<p class='triangle-right5 left'>Invalid ID. Length cannot be less than 4  characters</p>";
		return true;
	}else{
		var l7=l+"getcategory";
		var check;
		$.ajax({
		type : 'POST',
		url : l7,
		data : "id=" + 7 + "&empId=" + valid_ID,
		async : false,
		success : function(resp) {
			check = resp;
			//alert(resp);
		}
	});// Check for ID Duplicacy

	if (check == 1) {
		//alert("duplicacy");
		document.getElementById('errId').innerHTML = "<p class='triangle-right1 left'>Invalid ID. User with this ID already exists!</p>";
		return true;
	}else{
		document.getElementById('errId').innerHTML = "";
		return false;
	}
}
}

function loginValidate(time){
	var l8=l+"getcategory";
	alert(l8);
	var k;
	var username=document.getElementById("user_id").value;
	var pswd=document.getElementById("pswd_id").value;
	
	
	if (username == "" || pswd == "") {
		alert("if");
			if (username == "") {
				document.getElementById("f2_username_errorloc").innerHTML = "Empty Field-Username!";
				document.getElementById("f2_username_errorloc").focus();
			} else {

				document.getElementById("f2_username_errorloc").innerHTML = "";
			}

			if (pswd == "") {

				document.getElementById("f2_pswd_errorloc").innerHTML = "Empty Field-Password!";
				document.getElementById("f2_pswd_errorloc").focus()
			} else {
				document.getElementById("f2_pswd_errorloc").innerHTML = "";
			}
			
			return false;
		
	} else {
		//alert("gagan");
		//alert(document.getElementById("logonTime").value);
		/*	var string  = "id=" + 8
				+ "&username="
				+ document.getElementById("user_id").value
				+ "&password="
				+ document.getElementById("pswd_id").value
				+"&logonTime="+time ;
			alert(string);*/
			
					$.ajax({
						type : 'POST',
						url : l8,
						data : "id="
								+ 8
								+ "&username="
								+ document.getElementById("user_id").value
								+ "&password="
								+ document.getElementById("pswd_id").value
								+"&logonTime="+time,
								
						async : false,
						success : function(resp) {
							//alert(resp);
							k = resp;
						}
					});
					
			if (k!="") {
				alert("k = "+k);
				document.getElementById("f2_username_errorloc").innerHTML="Invalid username or password";
				document.getElementById("f2_pswd_errorloc").innerHTML = "";
				return false;
			} else {
				return true;
			}

		}
	}