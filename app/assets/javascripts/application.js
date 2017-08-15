//= require jquery
//= require jquery_ujs
//= require photoswipe/photoswipe
//= require photoswipe/photoswipe-ui-default
//= require social-share-button
//= require_tree .

var openPhotoSwipe = function(projectID, index) {
  var pswpElement = document.querySelectorAll('.pswp')[0];
  
  $.get(`/portfolio/projects/${projectID}.json`, function(data) {
    var options = {
      index: index,
      history: false
    };
    
    var gallery = new PhotoSwipe(pswpElement, PhotoSwipeUI_Default, data, options);
    gallery.init();
  });
}

// Main menu on mobile devices
function toggleMenu() {
  var menu = document.getElementById('menu');
  if (menu.className === 'menu') {
    // Show mobile menu
    menu.className += ' responsive';
    
    // Prevent main content sroll
    $('html').css('overflow', 'hidden');
  } else {
    // Hide mobile menu
    menu.className = 'menu';
    
    // Make main content scrollable
    $('html').css('overflow', 'auto');
  }
}
