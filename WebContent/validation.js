
var l="http://localhost:8080/Survey_Version2.0/";

function validate_form(elem, message) 
{

	var e = elem.value.toString();
		if (e == null || e == "")
			{
				alert("Please Enter Survey Name");
				
				
				elem.focus();
				return false;
			} 
		else 
			{
		
			
			
		
		var numericExpression = /^[0-9]+$/;
		var alphaExp = /^[0-9a-zA-Z ]+$/;
		var message="";
	
		if(e.substring(0,1).match(numericExpression) || !e.match(alphaExp))
			{
			
			if(e.substring(0,1).match(numericExpression) )
				{
			message="*First Letter of Survey Name Can't Be Integer"+"\n";
				}
			if(!e.match(alphaExp))
				{
				message=message+"*Only Alphanumeric Characters are allowed";
				}
			alert(message);
			elem.focus();
			return false;
			}
		else
			{
			
			return true;
			}
		
		
			}
		
} 


function update_form() 
{
	//alert("hi");
	var alphaExp = /^[0-9a-zA-Z? ]+$/;
	var i,count=0;
	var a = /^[null]+$/;
	
	var question=document.getElementById("myquestion").value;
	var option1,option2,option3,option4,option5;
	option1=document.getElementById("myoption1").value;
	option2=document.getElementById("myoption2").value;
	option3=document.getElementById("myoption3").value;
	option4=document.getElementById("myoption4").value;
	option5=document.getElementById("myoption5").value;
	//alert(option1);

	
		if(option1.match(alphaExp) && !option1.match(a))
			{
			count++;
			}
		if(option2.match(alphaExp) && !option2.match(a))
		{
		count++;
		}
		if(option3.match(alphaExp) && !option3.match(a))
		{
		count++;
		}
		if(option4.match(alphaExp) && !option4.match(a))
		{
		count++;
		}
		if(option5.match(alphaExp) && !option5.match(a))
		{
		count++;
		}
		//alert(count);
		if(count>=2)
			{
			
			}
		else
			{
			alert("Please add atleast two options")
			return false;
			}
	
	if(question.match(alphaExp)  && !question.match(a) && !question.length==0 )
	{
	
	//alert("true");
	
	
	}
else
	{
	if(question=="null")
		{
		alert("Question can't be null");
		}
	else if(question.length==0 )
		{
		alert("Question can't be empty");
		}
	else
		{
	alert("Only AlphaNumeric Charactor allowed");
	}
	document.getElementById("myquestion").focus();
	return false;
	}

	
	if(option1.match(alphaExp)  || option1===null || option1.length==0 )
		{
		
		//alert("true");
		
		
		}
	else
		{
		alert("Only AlphaNumeric Charactor allowed");
		document.getElementById("myoption1").focus();
		return false;
		}

	if(option2.match(alphaExp)  || option2===null || option2.length==0 )
	{
	
	//alert("true");
	
	
	}
else
	{
	alert("Only AlphaNumeric Charactor allowed");
	document.getElementById("myoption2").focus();
	return false;
	}

	if(option3.match(alphaExp)  || option3===null || option3.length==0 )
	{
	
	//alert("true");
	
	
	}
else
	{
	alert("Only AlphaNumeric Charactor allowed");
	document.getElementById("myoption3").focus();
	return false;
	}

	if(option4.match(alphaExp)  || option4===null || option4.length==0 )
	{
	
	//alert("true");
	
	
	}
else
	{
	alert("Only AlphaNumeric Charactor allowed");
	document.getElementById("myoption4").focus();
	return false;
	}

	if(option5.match(alphaExp)  || option5===null || option5.length==0 )
	{
	
	//alert("true");
	
	
	}
else
	{
	alert("Only AlphaNumeric Charactor allowed");
	document.getElementById("myoption5").focus();
	return false;
	}
	//alert("hello");
	update_question_details();
return true;
	
}

function insert_form() 
{
	//alert("hi");
	var alphaExp = /^[0-9a-zA-Z? ]+$/;
	var i,count=0;
	var a = /^[null]+$/;
	var myoption=new Array();
	var option=new Array();
	question=document.getElementById("myquestion").value;
	 myoption=document.getElementsByName("option[]");
	 
	
	
	//alert(option.length);
	for(i=0;i<myoption.length;i++)
		{
		option[i]=myoption[i].value;
	//	alert(option[i]);
		}
	
	for(i=0;i<myoption.length;i++)
	{
	if(option[i].match(alphaExp) && !option[i].match(a))
		{
		count++;
		}
	}
	if(count>=2)
	{
	
	}
else
	{
	alert("Please add atleast two options")
	return false;
	}

	
	if(question.match(alphaExp)  && !question.match(a) && !question.length==0 )
	{
	
	//alert("true");
	
	
	}
else
	{
	if(question=="null")
		{
		alert("Question can't be null");
		}
	else if(question.length==0 )
		{
		alert("Question can't be empty");
		}
	else
		{
	alert("Only AlphaNumeric Charactor allowed");
	}
	document.getElementById("myquestion").focus();
	return false;
	}

	for(i=0;i<myoption.length;i++)
	{
		if(option[i].match(alphaExp)  || option[i]===null || option[i].length==0 )
		{
		
		//alert("true");
		
		
		}
	else
		{
		alert("Only AlphaNumeric Charactor allowed");
		myoption[i].focus();
		return false;
		}

	}
	
	add_question();
return true;
	
	
	//alert(option1);
}

function check_form() 
{
	//alert("hi");
	var checklist=new Array();
	var i,count=0;
	
	 checklist=document.getElementsByName("chk1");
	if(checklist.length>0)
		{
	 for(i=0;i<checklist.length;i++)
		 {
		 if(checklist[i].checked)
			 {
			 count=count+1;
			 }
		 }
	 if(count>0)
		 {
		 return true;
		 }
	 else
		 {
		 alert("Please Select Atleast One Option");
		 return false;
		 }
		}
	else{
		alert("Cannot Import. No questions to be added!");
		return false;
	}
	
	//alert(count);
}
var CheckboxCheckedImage = new Image();
var CheckboxUncheckedImage = new Image();



CheckboxCheckedImage.src = "images/checkbox_checked1.png";
CheckboxUncheckedImage.src = "images/checkbox_unchecked.png";

function CheckboxClicked(imageid,checkboxid) {
	// alert("hel");
var image = document.getElementById(imageid);
if(image.src == CheckboxCheckedImage.src) {
	 //alert("hel");
   image.src = CheckboxUncheckedImage.src;
   document.getElementById(checkboxid).checked = false;
   checkedAll();
   }
else {
   //alert("hell");
	image.src = CheckboxCheckedImage.src;
   document.getElementById(checkboxid).checked = true;
   checkedAll();
   
   }
return false;
}

checked=false;
function checkedAll () {
	//alert("hello");
	
//alert(document.getElementsByName("chk1").length);
//alert(document.getElementsByName("gag").length);
for (var i =1; i <= document.getElementsByName("chk1").length; i++){
	var image = document.getElementById("CheckboxImageID"+i);
	
	if(image.src == CheckboxCheckedImage.src) {
		   image.src = CheckboxUncheckedImage.src;
		   document.getElementById("chk"+i).checked = false;
		   }
		else {
		   image.src = CheckboxCheckedImage.src;
		   document.getElementById("chk"+i).checked = true;
	}
}


}

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

function show_surveys() {
	 //alert("hello");

	 var category=document.getElementById("category").value;
	// alert(category);
	 var l1=l + "databse_functions_calling"

	 // alert(category);
		$.ajax({
			type : 'POST',
			url : l1,
			data : "id="+13+"&category="+category,
			async : false,
			success : function(resp) {
				//alert(resp);
			//	document.write(resp);
		
				document.getElementById("delhi").innerHTML=resp;
			}
		}); //ajax
	


}
checked=false;
function checkedAllSurveys() {
	//alert("hello");
	var aa=new Array();
aa= document.getElementsByName("surveys_checkbox");
//alert(document.getElementsByName("chk").length);
	 if (checked == false)
          {
           checked = true
          }
        else
          {
          checked = false
          }
	for (var i =0; i < document.getElementsByName("surveys_checkbox").length; i++) 
	{
	 aa[i].checked = checked;
	// alert(aa[i].value);
	}
      }

function valDrop(){
	//alert(document.getElementById("userlist").value);
	if(document.getElementById("userlist").value=="")
		{
		alert("Please Select a User");
		document.getElementById("userlist").focus;
		return false;
		}
	
}


function validate_category()
{
	elem=document.getElementById("category_name");
	var e =elem.value;
	
	if (e == null || e == "")
	{
		alert("Please Enter Category Name");
		
		
		elem.focus();
		return false;
	} 
else 
	{

	
	

var numericExpression = /^[0-9]+$/;
var alphaExp = /^[0-9a-zA-Z ]+$/;
var message="";

if(e.substring(0,1).match(numericExpression) || !e.match(alphaExp))
	{
	
	if(e.substring(0,1).match(numericExpression) )
		{
	message="*First Letter of Survey Name Can't Be Integer"+"\n";
		}
	if(!e.match(alphaExp))
		{
		message=message+"*Only Alphanumeric Characters are allowed";
		}
	alert(message);
	

	elem.focus();
	return false;
	}
else
	{
	adding();
	return true;
	}


	}

}

