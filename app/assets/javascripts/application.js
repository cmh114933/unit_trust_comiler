// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets

//= require jquery_ujs
//= require turbolinks

//= require js/flot/jquery.flot.js
//= require js/flot/jquery.flot.pie.js
//= require js/flot/jquery.flot.orderBars.js
//= require js/flot/jquery.flot.time.min.js
//= require js/flot/date.js
//= require js/flot/jquery.flot.spline.js
//= require js/flot/jquery.flot.stack.js
//= require js/flot/curvedLines.js
//= require js/flot/jquery.flot.resize.js

//= require js/progressbar/bootstrap-progressbar.min.js

//= require js/icheck/icheck.min.js

//= require js/moment/moment.min.js
//= require js/datepicker/daterangepicker.js

//= require js/chartjs/chart.min.js

//= require js/pace/pace.min.js

//= require  js/nprogress.js

//= require flash.js





$(document).ready(function(){


	$('.update_all').on("click", function(e){
		$('.update').each(function(){
			$(this).replaceWith("<img src=http://i.stack.imgur.com/FhHRx.gif alt=loading>")
		})

		$.ajax({
			type: 'POST',
			url: '/new_price_update',
			success: function(data){
				window.location.replace('/unit_trusts')
			}
		})
	});

	$('.update').on("click", function(){
		$(this).replaceWith("<img src=http://i.stack.imgur.com/FhHRx.gif alt=loading>")
		$.ajax({
			type: 'POST',
			url: '/single_price_update/'+$(this)[0].id,
			success: function(data){
				window.location.replace('/unit_trusts')
			}
		})
	});

	$('#date_search_btn').on("click",function(){
		$.ajax({
			type: 'POST',
			url: window.location.href  +'/search_history/'+ '?date=' + $('#ut_history_date').val(),
			success: function(data){

					$('#search_output').replaceWith("<tr id = search_output><td>" + data.date.split("T")[0] + "</td><td>" + data.price + "</td><td>" + data.num_units + "</td><td>" + Math.round(data.price * data.num_units*100)/100 + "</td></tr>" )
			}
		})
	})
})