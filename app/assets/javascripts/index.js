FIT.signup = ( function ($, Modernizr, FIT) {
    
    var methods = {

            init: function () {
                
            },

            actions: {

                index: {

                    init: function () {
                        FIT.global.bind($(window), 'scroll.index', function (e) {
                            var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
                            if ( scrollTop >= 100 && !FIT.domObjects.header.hasClass('full') ) {
                                FIT.domObjects.header.addClass('full');
                            }
                            if ( scrollTop < 100 && FIT.domObjects.header.hasClass('full') ) {
                                FIT.domObjects.header.removeClass('full');
                            }
                        });
                    }

                }

            }

        };

    return {
        init: methods.init,
        actions: methods.actions
    }

})(jQuery, Modernizr, FIT);