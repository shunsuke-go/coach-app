var marker
var myLatLng
var map_lat
var map_lng
window.initMap = function (){
 myLatLng = {lat: 35.68090045006303, lng: 139.76690798417752}
 map_lat = document.getElementById('article_map_latitude')
 map_lng = document.getElementById('article_map_longitude')
 marker = new google.maps.Marker();

let map = new google.maps.Map(document.getElementById('map'), {
center: myLatLng,
zoom: 11
});


google.maps.event.addListener(map, 'click', mylistener);

     //クリックしたときの処理
function mylistener(event){

  //markerの位置を設定
  //event.latLng.lat()でクリックしたところの緯度を取得
  marker.setPosition(new google.maps.LatLng(event.latLng.lat(), event.latLng.lng()));
  //marker設置
  marker.setMap(map);    
  console.log(event.latLng.lat(), event.latLng.lng());
  map_lat.value = event.latLng.lat();
  map_lng.value = event.latLng.lng();
 
}
}
function deleteMarker(){
marker.setMap(null);
map_lat.value = "";
map_lng.value = "";
}

