FIT.validate = ( function ($, Modernizr, FIT) {
	var methods = {
		init: function() {
			methods.clearMarkup();
		},

		checkRequired: function($form) {
			var good = true;

			methods.init();
			$form.find('input').each(function() {
				if($(this).hasClass('required')) {
					if($(this).val() === '') {
						methods.highlightMarkup($(this));
						good = false; 
					}
				}
			});

			return good;
		},

		highlightMarkup: function($input) {
			$input.parents('li.input').addClass('error').parents('form').addClass('error');
		},

		generateMarkup: function($input, errorMsg) {
			markup = '<label for="'+$input.attr('id')+'" class="error">'+errorMsg+'</div>';
			$input.parents('li').find('label.error').remove();
			$input.parents('li').append(markup);
		},

		clearMarkup: function($input) {
			if($input === undefined) {
				$('.error').removeClass('error');
				$('label.error').remove();
			} else {
				$input.parent('li').removeClass('error');
				$input.parent('li').find('label.error').remove();
			}
		},

		checkCard: function() {
			var cardNum = $('#card_number').val(),
				isGood = false;

			if(!Stripe.card.validateCardNumber($('#card_number').val())) {
				methods.highlightMarkup($('#card_number'));
				methods.generateMarkup($('#card_number'),'This is an invalid card number.');
			} else {
				isGood = true;
				methods.clearMarkup($('#card_number'));
			}

			return isGood;
		},
		
		checkExpDate: function() {
			var cardMonth = $('#card_month').val(),
				cardYear = $('#card_year').val(),
				isGood = false; 

			if(!Stripe.card.validateExpiry(cardMonth, cardYear)) {
				methods.highlightMarkup($('#card_month'));
				methods.generateMarkup($('#card_month'),'This is an invalid expiration date.');
			} else {
				isGood = true;
				methods.clearMarkup($('#card_month'));
			}

			return isGood;
		},

		checkCVC: function() {
			var cardCode = $('#card_code').val(),
				isGood = false;

			if(!Stripe.card.validateCVC(cardCode)) {
				methods.highlightMarkup($('#card_code'));
				methods.generateMarkup($('#card_code'),'This is an invalid CVC.');
			} else {
				isGood = true;
				methods.clearMarkup($('#card_code'));
			}

			return isGood;
		},

		stripeCheck: function() {
			var isGood = false;

			isGood = methods.checkCard();
			isGood = methods.checkExpDate();
			isGood = methods.checkCVC();

			return isGood;
		}
	};

    return {
    	check: methods.checkRequired,
    	stripeCheck: methods.stripeCheck
    }
})(jQuery, Modernizr, FIT);