// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require_tree .
//= require jquery
//= require jquery_ujs

// Cell groups
$(document).ready(function(){
    $('#create_cg_button').on('click', function(){
      $('#overlay_box').show();
    });

    $('.close').on('click', function(){
      $('#overlay_box').hide();
    });
});

$(function(){
    $("form").submit(function(event){
      event.preventDefault();
  
      var action = $(this).attr('action');
      var method = $(this).attr('method');

      var name = $(this).find('#cell_group_name').val();
      var gender = $(this).find('#cell_group_gender_male').val();
      var female = $(this).find('#cell_group_gender_female').val();
      if (gender == undefined) {
        gender = female;
      }

  
      $.ajax({
        method: method,
        url: action,
        data: { name: name, gender: gender }
      });

  
    });
  });