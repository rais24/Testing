$(function(){
  var svg = !!('createElementNS' in document && document.createElementNS('http://www.w3.org/2000/svg','svg').createSVGRect);
  if (!svg){
    $('body').addClass('no-svg');
    $('img').each(function(){
      var $this = $(this);
      var fp = $this.attr('src').split(".");
      var ext = fp.pop();
      if(ext.toLowerCase() == 'svg'){
        if($this.attr('data-svg-fallback') !== undefined){
          $this.attr('src', $this.attr('data-svg-fallback'));
          $this.removeAttr('data-svg-fallback');
        }else{
          $this.attr('src', fp.join('.')+'.png');
        }
      }
    });
  }else{ $('body').addClass('svg'); }
});