//= require jquery
//= require jquery_ujs
//= require social-share-button
//= require photoswipe
//= require_tree .

function toggleMenu() {
  var menu = document.getElementById('menu');
  if (menu.className === 'menu') {
      menu.className += ' responsive';
  } else {
      menu.className = 'menu';
  }
}
