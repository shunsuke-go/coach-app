document.addEventListener('DOMContentLoaded', function() {
  var sidenav = document.querySelectorAll('.sidenav');
  var instances = M.Sidenav.init(sidenav,[]);
  var dropdown = document.querySelectorAll('.dropdown-trigger');
  var instances = M.Dropdown.init(dropdown,[]);

  var alert = document.getElementById('alert');
  alert_remove = function(){
    if(alert != null){
    alert.remove()    
  }            
}
  setTimeout(alert_remove,2000);
});
