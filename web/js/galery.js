var Gallery = new Class( {
  Implements: [Events, Options],
  options: {
    // Идентификатор контейнера для изображение большого размера
    origElementId: 'original',

    // Маска, для отбора элементов с уменьшенными изображениями
    thumbElementId: 'thumbnails',

    // Класс для выделения текущего уменьшенного изображения
    curThumbClass: 'active'
  },

  // Элемент, содержащий изображение большого размера
  orig: null,

  // Массив с элементами уменьшенных изображений
  thumbs: null,

  // Номер активного уменьшенного изображения (для него выводится увеличенное изображение)
  curNum: null,

  // Массив с предзагруженными большими изображениями
  preloadedOrigs: Array(),

  initialize: function(options) {
    this.setOptions(options);
    this.orig = $(this.options.origElementId);
    this.thumbs = $(this.options.thumbElementId).getElements('a');
    // Добавление обработчика на клик по уменьшенному изображению
    this.thumbs.each(function(el, index) {
      if (el.hasClass(this.options.curThumbClass)) {
        this.curNum = index;
        this.preloadedOrigs[index] = this.orig.getElement('img');
      }
      el.addEvent('click', this.click.bindWithEvent(this, index));
    }, this);
  },

  // Смена большого изображения при клики на уменьшенном изображении, предзагрузка
  click: function(e, thumbNum) {
    // Смена уменьшенного изображения
    if (this.curNum != thumbNum) {
      if (this.thumbs[this.curNum]) {
       this.thumbs[this.curNum].removeClass(this.options.curThumbClass);
      }
      this.curNum = thumbNum;
      if (this.thumbs[thumbNum]) {
        this.thumbs[thumbNum].addClass(this.options.curThumbClass);
        this.startPreload();
      }
    }

    return false;
  },

  // Загружает текущее фото + следующее, если они еще не загружены
  startPreload: function() {
    this.preload(
      this.thumbs.filter(function(item, index){
        return ((this.curNum <= index) && (index <= (this.curNum+1)))
      }.bind(this))
    );
  },

  // Фоновая загрузка больших фотографий. Загружаются +две фото, следующие за текущей
  preload: function(thumb4Preload) {
    thumb4Preload.each(function(el){
      var thumbNum = this.thumbs.indexOf(el);

      if (!this.preloadedOrigs[thumbNum]) {
        var url = this.thumbs[thumbNum].getElement('img').get('src').replace("thumbnail", "original")
        new Asset.image(url, {
          onload: function(img, origNum){
            this.preloadedOrigs[origNum] = img;
            if (origNum == this.curNum) {
              img.inject(this.orig.empty());
            }
          }.bindWithEvent(this, thumbNum)
        });
      } else if(thumbNum == this.curNum) {
        this.preloadedOrigs[thumbNum].inject(this.orig.empty());
      }
    }, this);
  }
});

