document.querySelectorAll('.myUL').forEach(el => el.style.display = 'none');
var newList = document.createElement('ul');
newList.classList.add('myUL');
newList.style.clear = 'both';
newList.style.maxWidth = '1200px';
newList.style.margin = 'auto';
newList.style.display = 'flex';
newList.style.flexWrap = 'wrap';
newList.style.justifyContent = 'center';
newList.style.paddingInlineStart = '0px';
document.querySelectorAll('.display').forEach(el => {
  var clone = el.cloneNode();
  clone.style.paddingInlineStart = '0px !important';
  newList.appendChild(clone);
});
document.querySelector('.list-container').appendChild(newList);