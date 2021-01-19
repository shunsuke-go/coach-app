document.addEventListener('DOMContentLoaded', function() {
  var sidenav = document.querySelectorAll('.sidenav');
  var instances = M.Sidenav.init(sidenav,[]);
  var dropdown = document.querySelectorAll('.dropdown-trigger');
  var instances = M.Dropdown.init(dropdown,[]);
});
