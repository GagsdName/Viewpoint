var l="http://localhost:8080/Survey_Version2.0/";

	function fillcategory() {
	var l1=l+"databse_functions_calling";
		//alert("gag");
		$.ajax({
			type : 'POST',
			url : l1,
			data : "id="+1,
			async : false,
			success : function(resp) {
			//alert(resp);
				$("#category").html(resp);
			
				
			}
		}); //ajax
	
	
		
	}//fillcategory
	
	function fillSurveyList() {  
		//alert("calling");
		var combo = document.getElementById("category");
	
		var val = "";
		if(combo.selectedIndex >= 0){
		
		val =combo.options[combo.selectedIndex].value;
		//alert(val);
		
		}
		//alert(val);
		var l2=l+"databse_functions_calling";
		$.ajax({
			type : 'POST',
			url : l2,
			data : "id="+2+"&value="+val,
			async : false,
			success : function(resp) {
				//alert(resp);
				$("#surveyname").html(resp);
			}
		}); //ajax
	}//fillSurveyList*/
	
	function fill_published_SurveyList() {  
		//alert("calling");
		var combo = document.getElementById("category");
	
		var val = "";
		if(combo.selectedIndex >= 0){
		
		val =combo.options[combo.selectedIndex].value;
		//alert(val);
		
		}
		//alert(val);	
		var l3=l+"databse_functions_calling"
		$.ajax({
			type : 'POST',
			url : l3,
			data : "id="+14+"&value="+val,
			async : false,
			success : function(resp) {
				//alert(resp);
				$("#surveyname").html(resp);
			}
		}); //ajax
	}//fillSurveyList*/