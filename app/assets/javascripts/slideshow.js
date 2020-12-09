function slideShow(number_of_slides){
	//the slideshow code uses this to determine a few things. Make sure this is set correctly!			
	const NUMBER_OF_SLIDES = number_of_slides;

	//get the width of the side-scrollable area in the 'sldieshow' div and divide by NUMBER_OF_SLIDES so that the 
	//scrollLeft under setInterval knows by how much to scroll
	var slide_width = document.getElementById('slideshow').scrollWidth / NUMBER_OF_SLIDES; 

	//used as a reference for what slide to switch to in the coming setInterval()
	var slide_number = 1;		

	//sets which circle is highlighted depending on the integer fed into it
	var setCircle = function(input_circle){

		//set all circles to grey
		for(x=1;x <= NUMBER_OF_SLIDES; x++){
			$("#circle" + x).css({
				"background-color": "lightgrey"
			});	
		}
		
		//set a circle to be brown, based on input_circle
		$("#circle" + input_circle).css({
			"background-color": "brown"
		});
	}

	//initialy setting the first circle to be brown, before the slideshow starts manipulating them
	// setCircle(1);

	//every 4 seconds(excluding the 500ms slide effect), slide to the next image, and set the appropriate circle to be brown
	setInterval(function(){
		if (slide_number < NUMBER_OF_SLIDES){
			//move to next slide
			$("#slideshow").animate({
				scrollLeft: slide_width * slide_number
			},1000);					
			slide_number++;	
		}else{
			//go to the first slide
			$("#slideshow").animate({
				scrollLeft: 0
			},1000);
			slide_number = 1;
		}
		setCircle(slide_number);

	}, 5500);	
}

$(document).ready(function(){
  $('.customer-logos').slick({
      slidesToShow: 6,
      slidesToScroll: 1,
      autoplay: true,
      autoplaySpeed: 1500,
      arrows: false,
      dots: false,
      pauseOnHover: false,
      responsive: [{
          breakpoint: 768,
          settings: {
              slidesToShow: 4
          }
      }, {
          breakpoint: 520,
          settings: {
              slidesToShow: 3
          }
      }]
  });
});