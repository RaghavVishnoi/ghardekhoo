$(document).ready(function(){
  $('#search-retailer').on('keypress',function(e) {
    if(e.which == 13) {
        var search_value = $('#search-retailer').val();
        var category_id = $('#retailer_search_hidden_fields #category_id').val();
        var city = $('#retailer_search_hidden_fields #city').val();
        var state = $('#retailer_search_hidden_fields #state').val();
        start_spin('customer-list');
        $('#search_retailers_form #search_value').val(search_value);
        $('#search_retailers_form #category_id').val(category_id);
        $('#search_retailers_form #city').val(city);
        $('#search_retailers_form #state').val(state);
        $('#search_retailers_form').trigger('submit.rails');
    }
  });

  $('.close').click(function(){
    $('.posting').attr('style', 'display: none')
  });
});

function populateCity(state){
  var selectedState = state.value
  start_spin('retailer_state')
  $('#retailers_city_list_form #state_name').val(selectedState);
  $('#retailers_city_list_form').trigger('submit.rails')
}

function setLocation(city){
  var selectedCity = city.value
  var selectedState = $('#retailer_state').val();
  start_spin('retailer_state')
  $('#retailers_set_location_form #retailer_city_name').val(selectedCity);
  $('#retailers_set_location_form #retailer_state_name').val(selectedState);
  $('#retailers_set_location_form').trigger('submit.rails')
}

function scrollTop(){
    $("html, body").animate({ scrollTop: 0 }, "slow");
}

function discard_flash(){
  setTimeout(function() {
    $(".inner-box").fadeOut(5000);
  }, 3000);
}

function renderFlash(container, flash){
    $(container).html(flash);
    // $(container).find('.row').delay(3000).fadeOut('slow');
}

function clearFilter(){
  var search_value = "";
  var category_id = $('#retailer_search_hidden_fields #category_id').val();
  var city = $('#retailer_search_hidden_fields #city').val();
  var state = $('#retailer_search_hidden_fields #state').val();
  start_spin('customer-list');
  $('#search_retailers_form #search_value').val(search_value);
  $('#search_retailers_form #category_id').val(category_id);
  $('#search_retailers_form #city').val(city);
  $('#search_retailers_form #state').val(state);
  $('#search_retailers_form').trigger('submit.rails');
}

function applySubCategory(element){
  var sub_category_id = $(element).val();
  var search_value = $('#search-retailer').val();
  var category_id = $('#retailer_search_hidden_fields #category_id').val();
  var city = $('#retailer_search_hidden_fields #city').val();
  var state = $('#retailer_search_hidden_fields #state').val();
  start_spin('customer-list');
  $('#search_retailers_form #sub_category_id').val(sub_category_id);
  $('#search_retailers_form #search_value').val(search_value);
  $('#search_retailers_form #category_id').val(category_id);
  $('#search_retailers_form #city').val(city);
  $('#search_retailers_form #state').val(state);
  $('#search_retailers_form').trigger('submit.rails');
}

function searchBySubCategory(sub_category_id){
  var state = $('#states').val()
  var city = $('#cities').val()
  window.location = '/retailers/search?category_id=&state='+state+'&city='+city+'&sub_category_id='+sub_category_id
}

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
  start_spin('intro')
	$('#city_list_form').trigger('submit.rails');
}

function cityRetailers(city_name){
	state_code = $('#state-list select').val();
	$('#city_retailers_form #state_code').val(state_code)
	$('#city_retailers_form #city_name').val(city_name)
  start_spin('intro')
	$('#city_retailers_form').trigger('submit.rails')
}

function search_retailers(){
  category_id = $('#category-list #categories').val();
  state = $('#state-list #states').val();
  city = $('#city-list #cities').val();
  window.location = "/retailers/search?category_id="+category_id+"&state="+state+"&city="+city
}