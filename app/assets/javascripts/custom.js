$(document).ready(function(){
  $('#search-retailer').on('keypress',function(e) {
    if(e.which == 13) {
        var search_value = $('#search-retailer').val();
        var category_id = $('#retailer_search_hidden_fields #category_id').val();
        var city = $('#retailer_search_hidden_fields #city').val();
        var state = $('#retailer_search_hidden_fields #state').val();
        start_spinner('customer-list');
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

  $('.rate input').click(function(){
    var rating  = $('.rate input:checked').val();
    $('#new_retailer_product_review #retailer_product_review_rating').val(rating);
  })

  $('#new_user button').click(function(){
    start_spinner('new_user')
  })

});

function get_subcategories(element){
  var category = $(element).val();
  $('#subcategory_form #category_id').val(category);
  $('#subcategory_form #element_id').val('request-sub-category');
  start_spinner('content')
  $('#subcategory_form').trigger('submit.rails');
}

function populateCity(state){
  var selectedState = state.value
  start_spinner('retailer_state')
  $('#retailers_city_list_form #state_name').val(selectedState);
  $('#retailers_city_list_form').trigger('submit.rails')
}

function setLocation(city){
  var selectedCity = city.value
  var selectedState = $('#retailer_state').val();
  start_spinner('retailer_state')
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
  start_spinner('customer-list');
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
  start_spinner('customer-list');
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

function start_spinner(targetId){
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
      top: '25%', // Top position relative to parent
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
  $('#btn-filter').attr('disabled', 'disabled')
	state_code = state.value
	$('#city_list_form #name').val(state_code);
  start_spinner('categories-homepage')
	$('#city_list_form').trigger('submit.rails');
}

function cityRetailers(city_name){
	state_code = $('#state-list select').val();
	$('#city_retailers_form #state_name').val(state_code)
	$('#city_retailers_form #city_name').val(city_name)
  start_spinner('categories-homepage')
	$('#city_retailers_form').trigger('submit.rails')
}

function search_retailers(){
  if($('#action_type').val() == 'list'){
    start_spinner('customer-list');
  }else{
    start_spinner('category-container');
  }
  var category_ids = find_selected_categories().join(',')
  var state = $('#state-list #states').val();
  var city = $('#city-list #cities').val();
  var action_type = $('#action_type').val();
  var min_price = $('#min_price').val();
  var max_price = $('#max_price').val();
  var product_types = find_selected_types().join(',')
  var product_operations = find_selected_operations().join(',')
  var dealer_name = $('#dealer_name').val();
  $('#search_products_form #sub_category_id').val(category_ids)
  $('#search_products_form #city').val(city)
  $('#search_products_form #state').val(state)
  $('#search_products_form #min_price').val(min_price)
  $('#search_products_form #max_price').val(max_price)
  $('#search_products_form #product_types').val(product_types)
  $('#search_products_form #product_operations').val(product_operations)
  $('#search_products_form #dealer_name').val(dealer_name)
  $('#search_products_form #action_type').val(action_type)
  $('#search_products_form').trigger('submit.rails')
}

function find_selected_categories(){
  var selected_categories = []
  $('.sub-category').each(function(){
    if($(this).prop('checked') == true){
      selected_categories.push($(this).val());
    }
  })
  return selected_categories
}

function find_selected_types(){
  var selected_product_types = []
  $('.product-types-filter').each(function(){
    if($(this).prop('checked') == true){
      selected_product_types.push($(this).val());
    }
  })
  return selected_product_types
}

function find_selected_operations(){
  var selected_product_operations = []
  $('.product-operations-filter').each(function(){
    if($(this).prop('checked') == true){
      selected_product_operations.push($(this).val());
    }
  })
  return selected_product_operations
}

function resetFilter(){
  if($('#action_type').val() == 'list'){
    start_spinner('customer-list');
  }else{
    start_spinner('category-container');
  }
  resetSearchFields()
  var action_type = $('#action_type').val();
  $('#search_products_form #sub_category_id').val('')
  $('#search_products_form #city').val('')
  $('#search_products_form #state').val('')
  $('#search_products_form #min_price').val('')
  $('#search_products_form #max_price').val('')
  $('#search_products_form #product_types').val('')
  $('#search_products_form #product_operations').val('')
  $('#search_products_form #dealer_name').val('')
  $('#search_products_form #action_type').val(action_type);
  $('#search_products_form #operation').val('reset-filter')
  $('#search_products_form').trigger('submit.rails')
}

function resetSearchFields(){
  $('.dropdown-menu input').each(function(){
    $(this).prop('checked', false)
  })
  $('#states').val('').change();
  $('#cities').val('').change();
}

function setRetailerId(retailer_id){
  $('#retailerDetailsForm').text('')
  $('#userDetailsForm').attr('style', 'display: block;')
  $('#retailerDetailsModal #customer_retailer_id').val(retailer_id)
}