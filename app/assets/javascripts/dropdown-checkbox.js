function changeCategory(elementId){
	var elementIdAttr = elementId.attr('id')
	if(elementId.prop('checked') == true){
		$('.sub-'+elementIdAttr).each(function(){
			$(this).prop('checked', true)
		})
	}else{
		$('.sub-'+elementIdAttr).each(function(){
			$(this).prop('checked', false)
		})
	}
}