var myLatLng
var marker

if(gon.latitude !== null){
  latitude = gon.latitude
}

if(gon.longitude !== null){
  longitude = gon.longitude
}

window.initMap = function (){
 myLatLng = {lat: latitude, lng: longitude}

let map = new google.maps.Map(document.getElementById('map'), {
center: myLatLng,
zoom: 16
  });

 marker = new google.maps.Marker();
 marker.setPosition(new google.maps.LatLng(latitude,longitude));
 marker.setMap(map);
}
