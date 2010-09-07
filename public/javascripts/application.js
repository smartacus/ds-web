// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function perform_search(search_string) {
    if (! $('search').hasClassName('clear')) {
	$('search').addClassName('clear');
    }
    if (! $('cancel').hasClassName('text')) {
	$('cancel').addClassName('text');
    }
    $('search').value = search_string;
}

function clear_search() {
    $('search').value = "";
    if ($('search').hasClassName('clear')) {
	$('search').removeClassName('clear');
    }
    if ($('cancel').hasClassName('text')) {
	$('cancel').removeClassName('text');
    }
}

function check_form_fields() {
    var fields = ["computer_mac_addr", "computer_cn", "computer_hostname", "computer_ard_field_1", "computer_ard_field_2", "computer_ard_field_3", "computer_ard_field_4"];

    fields.each(function(field) {
	if ($(field).value.length == 0) {
	    return false;
	}
    });

    return true;
}

function update_form_fields() {
    var fields = ["computer_mac_addr", "computer_cn", "computer_hostname", "computer_ard_field_1", "computer_ard_field_2", "computer_ard_field_3", "computer_ard_field_4"];
    var field_count = 0;

    fields.each(function(field) {
	if ($(field).value.length > 0) {
	    $(field).removeClassName('empty');
	    field_count++;
	}
	else {
	    if (!$(field).hasClassName('empty')) {
		$(field).addClassName('empty');
	    }
	}
    });

    if (field_count == fields.length) {
	$('computer_submit').disabled = false;
    }
    else {
	$('computer_submit').disabled = true;
    }
}
