var button = document.getElementById('article-search-btn');
var search_field = document.getElementById('q_action_text_rich_text_body_cont');
var search_card = document.getElementById('article-search-card');
button.addEventListener('click',(e) => {
  if(search_field.value == ""){
    if(document.querySelector('.balloon2')){
    }else{
      search_card.insertAdjacentHTML("afterbegin",
      `<div class="balloon2" id="balloon2" style="color:red">
      <p>検索文字を入力してください</p>
      </div>`);
    }
    e.preventDefault();
  };
});
