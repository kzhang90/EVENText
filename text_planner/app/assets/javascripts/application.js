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
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require angular/angular
//= require_tree .
$(document).ready(function() {
  console.log('ready');

  // $("#search_me").on("ajax:success", function(e,data,status,xhr) {
  //   console.log(data);
  //   for (var i = 0; i<data.length; i++) {
  //     // append
  //     $('#api-results').append("<p>"+data[i]+"<p>");
  //   }

    // "data" is the json
    // works with xhr too. what is xhr?
    // make a div in the erb file and append to it, 
  // });


  // add something for bookmarks so the page doesn't reload
});