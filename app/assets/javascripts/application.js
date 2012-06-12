// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .
// Array Remove - By John Resig (MIT Licensed)
Array.prototype.remove = function(from, to) {
      var rest = this.slice((to || from) + 1 || this.length);
        this.length = from < 0 ? this.length + from : from;
          return this.push.apply(this, rest);
};

function AutoScrollOnload() { var x = 0; var y = 0; window.scrollTo(x,y); }
function AddOnloadEvent(f) {
if(typeof window.onload != 'function') { window.onload = f; }
else { var cache = window.onload; window.onload = function() { if(cache) { cache(); } f(); }; }
}
AddOnloadEvent(AutoScrollOnload);
