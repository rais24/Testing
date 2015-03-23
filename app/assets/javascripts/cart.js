FIT.shopping_carts = ( function ($, Modernizr, FIT) {
    
    var methods = {

            init: function () {
                
            },

            actions: {

                show: {

                    init: function () {
                        // TODO: lazy loading
                        // Since this is a small image always and only on tables and desktop, use medium imgae,
                        // but don't create it at all if the viewport is small or medium
                        $('li.recipe-form li.image noscript').each( function () {
                            if(FIT.global.imageSize().indexOf('large') > -1 || !FIT.global.doResponsiveImg()) {
                                $(this).closest('li').append('<img data-js="true" src="' + $(this).attr('data-medium') + '">');
                            }
                        });
                    }

                },
                
                iesucks: function () {

                }

            }

        };

    return {
        init: methods.init,
        actions: methods.actions
    }

})(jQuery, Modernizr, FIT);