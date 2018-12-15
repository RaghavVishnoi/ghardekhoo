function getCities(state){
	state_code = state.value
	$('#city_list_form #state_code').val(state_code);
	$('#city_list_form').trigger('submit.rails');
}