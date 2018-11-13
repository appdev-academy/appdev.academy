//= require jquery
//= require jquery_ujs
//= require social-share-button
//= require_tree .

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
