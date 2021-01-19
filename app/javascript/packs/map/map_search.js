var button = document.getElementById('search_btn');
var map_search = document.getElementById('map_search');
var map_card = document.getElementById('map_card');
//var balloon1 = document.getElementById('balloon1');

button.addEventListener('click',(e) => {
  
  if(map_search.value == ""){

    if(document.querySelector('.balloon1')){
    }else{
      map_card.insertAdjacentHTML("afterbegin",
      `<div class="balloon1" id="balloon1">
      <p>検索位置を入力してください</p>
      </div>`);
    }
    e.preventDefault();
  };
});
