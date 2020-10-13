// JavaScript Document
$(document).ready(function() {
	var $GlobalSearch = $("#GlobalSearch");
	var search = function() {
		window.location = "/cf_client/accountmanager/03_vehicles/vehiclesearch.aspx?VehicleSearch=" + $("#SearchVehicles").val()
	}
	$GlobalSearch.keypress(function(e) {
		if (e.which == 13) { //Enter
			e.preventDefault();
			search();
		}
	});
	$("#GlobalSearchVehiclesButton").click(function(e) {
		e.preventDefault();
		search();
	});

});