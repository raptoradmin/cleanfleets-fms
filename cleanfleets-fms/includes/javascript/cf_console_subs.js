// JavaScript Document
$(document).ready(function() {
	var $GlobalSearch = $("#GlobalSearch");
	var search = function() {
		window.location = "/cf_console/accountmanager/03_vehicles/vehiclesearch.aspx?VehicleSearch=" + $("#SearchVehicles").val()
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

function validatePSIPMonth(source, args) {
	// finds checkbox by searching upwards in the heirarchy to the closest table (since each group is its own table)
	// then searches downwards in heirarchy to find all inputs with the filter of :checkbox
	// checks to see if checkbox property of "checked" is present and if so then validate month dropdown.
	var $el = $(source).closest('table').find('input:checkbox');
	if ($el.prop('checked')) {
		args.IsValid = args.Value != 'None';
	}
	else {
		args.IsValid = true;
	}
}