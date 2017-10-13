// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require jquery3
//= require popper
//= require bootstrap-sprockets

$(window).scroll(function(){
    if ($(document).scrollTop() > 101){
        var t = document.getElementById("mainNav");
        t.classList.add("nav-shrink");
        var buttons =  document.getElementsByClassName("btn-size");
        for (var i = 0; i < buttons.length; i++) {
            var b = buttons[i];
            b.style.fontSize = "12px";
        }
    }
    else {
        var t = document.getElementById("mainNav");
        t.classList.remove("nav-shrink");
        var buttons =  document.getElementsByClassName("btn-size");
        for (var i = 0; i < buttons.length; i++) {
            var b = buttons[i];
            b.style.fontSize = "18px";
        }
    }
});


