function showMessage (messsage) {
    alert(message);
    return message;
}
window.showMessage = showMessage;

$(function() {
	var Frames = {
		body: $('body'),
		frames: $('#frames'),
		frame: $('.frame'),

		init: function() {
			this.body.on('click', '[data-nav-frame]', this.navigate);
		},

		show: function(name) {
			this.frames.attr('data-frame', name);
		},

		navigate: function(event) {
			var self = Frames;

			self.show(this.dataset.navFrame);
		}
	};

	var MainFrame = {
		frame: $('#main'),
		islandsFrame: $('#islands-frame'),
		islands: $('#islands'),
		island: $('#islands .island'),
		islandNav: $('#islands-frame .island-nav'),

		profileButton: $('#profile-button'),

		slideWidth: $('#islands-frame').width(),
		touchStartX: undefined,
		touchMoveX: undefined,
		moveX: undefined,
		index: 0,
		longTouch: undefined,

		init: function() {
			this.islandNav.on('click', this.navClick);

			this.islands.on('touchstart', this.slideStart);
			this.islands.on('touchmove', this.slideMove);
			this.islands.on('touchend', this.slideEnd);
		},

		navClick: function(event) {
			var self = MainFrame;

			var value = parseInt(this.dataset.navIndex);

			self.index = Math.max(0, Math.min(self.island.length - 1, self.index + value));

			self.islands.addClass('transition');
			self.islands[0].style.transform = 'translateX(-' + (self.index * self.slideWidth) + 'px)';
			self.islands[0].style.webkitTransform = 'translateX(-' + (self.index * self.slideWidth) + 'px)';
  
            var message = { "index":self.index };
            window.webkit.messageHandlers.NAME.postMessage(message);
		},

		slideStart: function(event) {
			var self = MainFrame;

			self.longTouch = false;

			(function(self) {
				setTimeout(function() {
					self.longTouch = true;
				}, 250);
			})(self);

			self.touchStartX = event.originalEvent.touches[0].pageX;

			self.islands.removeClass('transition');
		},

		slideMove: function(event) {
			var self = MainFrame;

			self.touchMoveX = event.originalEvent.touches[0].pageX;

			self.moveX = self.index * self.slideWidth + (self.touchStartX - self.touchMoveX);

			if (self.moveX < self.slideWidth * (self.island.length - 1)) {
				self.islands[0].style.transform = 'translateX(-' + self.moveX + 'px)';
				self.islands[0].style.webkitTransform = 'translateX(-' + self.moveX + 'px)';
			}
		},

		slideEnd: function(event) {
			var self = MainFrame;

			var absMove = Math.abs(self.index * self.slideWidth - self.moveX);

			if (absMove > self.slideWidth / 2 || self.longTouch === false) {
				if (self.moveX > self.index * self.slideWidth && self.index < (self.island.length - 1)) {
					self.index++;
				} else if (self.moveX < self.index * self.slideWidth && self.index > 0) {
					self.index--;
				}
			}

			self.islands.addClass('transition');
			self.islands[0].style.transform = 'translateX(-' + (self.index * self.slideWidth) + 'px)';
			self.islands[0].style.webkitTransform = 'translateX(-' + (self.index * self.slideWidth) + 'px)';
		}
	};

	var ProfileFrame = {
		frame: $('#profile'),

		init: function() {
		}
	};

	Frames.init();

	ProfileFrame.init();
	MainFrame.init();
});
