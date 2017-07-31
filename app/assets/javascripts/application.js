//= require jquery
//= require jquery_ujs
//= require photoswipe/photoswipe
//= require photoswipe/photoswipe-ui-default
//= require social-share-button
//= require_tree .

var openPhotoSwipe = function() {
  var pswpElement = document.querySelectorAll('.pswp')[0];
  
  // Build items array
  var items = [{
      src: 'https://www.appdev.academy/uploads/images/31/regular_image.png',
      w: 800,
      h: 676
    }, {
      src: 'https://www.appdev.academy/uploads/images/32/regular_image.png',
      w: 800,
      h: 676
    }
  ];
  
  // Define options (if needed)
  var options = {
    // optionName: 'option value'
    // for example:
    index: 0 // start at first slide
  };
  
  // Initializes and opens PhotoSwipe
  var gallery = new PhotoSwipe(pswpElement, PhotoSwipeUI_Default, items, options);
  gallery.init();
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

$(document).ready(function() {
  document.getElementById('btn').onclick = openPhotoSwipe;
});
