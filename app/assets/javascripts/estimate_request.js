// File loader
var fileInput = document.getElementById('estimate_request_document');
var filenameContainer = document.getElementById('click-area');

if (fileInput && filenameContainer) {
  fileInput.addEventListener('change', function() {
    filenameContainer.innerText = fileInput.value.split('\\').pop() || 'Click to load your file ...';
  });
}
