function start_spin(targetId){
    var opts = {
      lines: 13, // The number of lines to draw
      length: 15, // The length of each line
      width: 10, // The line thickness
      radius: 25, // The radius of the inner circle
      scale: 1, // Scales overall size of the spinner
      corners: 1, // Corner roundness (0..1)
      color: '#CCC', // CSS color or array of colors
      fadeColor: 'transparent', // CSS color or array of colors
      opacity: 0.25, // Opacity of the lines
      rotate: 0, // The rotation offset
      direction: 1, // 1: clockwise, -1: counterclockwise
      speed: 1, // Rounds per second
      trail: 60, // Afterglow percentage
      fps: 20, // Frames per second when using setTimeout() as a fallback in IE 9
      zIndex: 2e9, // The z-index (defaults to 2000000000)
      className: 'spinner', // The CSS class to assign to the spinner
      top: '50%', // Top position relative to parent
      left: '50%', // Left position relative to parent
      shadow: 'none', // Box-shadow for the lines
      position: 'absolute' // Element positioning
    };

    var target = document.getElementById(targetId);
    var spinner = new Spinner(opts).spin(target);
}

function stop_spin(){
    $('.spinner').remove();
}


function getCities(state){
	state_code = state.value
	$('#city_list_form #state_code').val(state_code);
	$('#city_list_form').trigger('submit.rails');
}

function cityRetailers(city_name){
	state_code = $('#state-list select').val();
	$('#city_retailers_form #state_code').val(state_code)
	$('#city_retailers_form #city_name').val(city_name)
  start_spin('categories-homepage')
	$('#city_retailers_form').trigger('submit.rails')
}