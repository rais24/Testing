// Global FIT namespace for all Fitly objects
FIT = {
    initialized: false,
    params: {
        device: {
            hiDpi: false,
            relativeSize: 'xlarge'
        },
        userAgent: {
            mediaQueries: false
        }
    },
    bindings: []
};


// FIT.global contains all methods that need to be accessed throughout the application
FIT.global = ( function ($, Modernizr, FIT) {

    var methods = {

        init: function () {
            // Improve performance by caching persistent DOM objects once and reusing them
            // throughout the application
            FIT.domObjects = {
                body: $('body'),
                header: $('header'),
                headerNav: $('header nav'),
                headerNavContent: $('header nav ul.content'),
                main: $('main')
            };
            methods.responsiveModeSet();
            methods.hiResCheck();
            if ( FIT.params.device.relativeSize === 'small' || FIT.params.device.relativeSize === 'medium' ) {
                methods.headerNav();
            }
            methods.toTheTop();
            methods.validateForm();
        },

        bind: function (selector, event, callback) {
            selector.on(event, function (e) {
                callback(e);
            });
            FIT.bindings.push({
                selector: selector,
                event: event
            });
        },

        responsiveModeSet: function () {
            var windowWidth = $(window).width(),
                previousSize = FIT.params.device.relativeSize;
            if ( windowWidth >= 960 ) {
                FIT.params.device.relativeSize = 'xlarge';
            } else if ( windowWidth >= 740 ) {
                FIT.params.device.relativeSize = 'large';
            } else if ( windowWidth >= 480 ) {
                FIT.params.device.relativeSize = 'medium';
            } else {
                FIT.params.device.relativeSize = 'small';
            };
            $('html').removeClass('small medium large xlarge').addClass(FIT.params.device.relativeSize);
            if ( Modernizr.mq('only all') ) {
                FIT.params.userAgent.mediaQueries = true;
            } else {
                $.ajax({
                    url: '/assets/respond.min.js',
                    data: 'script'
                });
            };
            if ( previousSize !== FIT.params.device.relativeSize && FIT.initialized ) {
                for ( var i = 0; i < FIT.bindings.length; i+=1 ) {
                    FIT.bindings[i].selector.off(FIT.bindings[i].event);
                }
                FIT.bindings = [];
                $('[data-js="true"]').remove();
                FIT.immediate.init();
                FIT.init();
            }
        },

        viewportResizeCheck: function (namespace, callback) {
            var windowWidth = $(window).width(),
                delayCheckViewport = 0;
            //  If the browser is resized, check the viewport size after a slight delay and run the
            //  provided callback function.
            $(window).on('resize.' + namespace, function (e) {
                clearTimeout(delayCheckViewport);
                delayCheckViewport = setTimeout( function () {
                    if ( $(window).width() !== windowWidth ) {
                        windowWidth = $(window).width();
                        callback();
                    }
                }, 500);
            });
        },

        hiResCheck: function () {
            // Check for high dpi displays and provide CSS/JS hooks for them
            if ( Modernizr.mq('(min-resolution: 192dpi), (-webkit-min-device-pixel-ratio: 2), (min--moz-device-pixel-ratio: 2), (-o-min-device-pixel-ratio: 2/1), (min-device-pixel-ratio: 2), (min-resolution: 2dppx)') ) {
                $('html').addClass('hi-dpi');
                FIT.params.device.hiDpi = true;
            }
        },

        imageSize: function () {
            var $html = $('html'),
                viewportSize = 'medium',
                doResponsiveImg = true;

            if(methods.doResponsiveImg()) {
                if($html.hasClass('small')) {
                    viewportSize = 'small';
                } else if ($html.hasClass('medium')) {
                    viewportSize = 'medium';
                } else if ($html.hasClass('large') || $html.hasClass('xlarge')) {
                    viewportSize = 'large';
                }
            }

            return viewportSize;
        },

        headerNav: function () {
            var navMenu = FIT.domObjects.header.find('ul.content');
            FIT.domObjects.headerNav.append('<div id="menu-toggle" data-js="true">Main Menu</div>');
            methods.menu.init(FIT.domObjects.header, navMenu, $('#menu-toggle'), 'header-menu-open');
        },

        menu: {
            init: function (ancestor, menu, trigger, namespace) {
                ancestor.append('<div class="darken" data-js="true"></div>');
                ancestor.children('div.darken').on('click.menu', function (e) {
                    methods.menu.close(menu, $(this), namespace);
                });
                menu.addClass('menu');
                trigger.on('click', function (e) {
                    e.preventDefault();
                    methods.menu.open(ancestor, menu, namespace);
                });
            },
            open: function (ancestor, menu, namespace) {
                var darken = ancestor.children('div.darken');
                FIT.domObjects.body.addClass('menu-open' + ' ' + namespace);
                darken.addClass('on transitioning');
                menu.addClass('open');
                darken.on('click', function (e) {
                    methods.menu.close(menu, darken);
                });
                setTimeout( function () {
                    darken.removeClass('transitioning');
                }, 300);
            },
            close: function (menu, darken, namespace) {
                setTimeout( function () {
                    FIT.domObjects.body.removeClass('menu-open' + ' ' + namespace);
                }, 300);
                menu.removeClass('open');
                darken.addClass('transitioning');
                darken.removeClass('on');
                setTimeout( function () {
                    darken.removeClass('transitioning');
                }, 300);
            }
        },

        toTheTop: function () {
            FIT.global.bind($(window), 'scroll.toTheTop', function (e) {
                var scrollTop = document.documentElement.scrollTop || document.body.scrollTop,
                    height = document.documentElement.clientHeight;
                if ( scrollTop >= height * 1.5 && !$('#to-the-top').length ) {
                    FIT.domObjects.body.append('<a id="to-the-top" href="#" data-js="true">To the top</a>');
                    $('#to-the-top').on('click.toTheTop', function (e) {
                        e.preventDefault();
                        $('html, body').scrollTop(0);
                    });
                }
                if ( scrollTop < height * 1.5 ) {
                    $('#to-the-top').remove();
                }
            });
        },

        validateForm: function() {
            $('form:not("#stripeForm")').each(function() {
                $(this).validate({
                    highlight: function( element, errorClass, validClass ) {
                        $(element).parents('li.input').addClass(errorClass).removeClass(validClass).parents('form').addClass(errorClass);
                    },
                    unhighlight: function( element, errorClass, validClass ) {
                        $(element).parents('li.input').removeClass(errorClass).addClass(validClass);
                        if(!$('form').find('.error')) {
                            $('form').removeClass(errorClass);
                        }
                    }
                });
            });
            FIT.global.bind($('#stripeForm'), 'submit', function (e) {
                var $form = $(e.currentTarget);
                good = FIT.validate.stripeCheck();

                if(!good) {
                    e.preventDefault();
                    FIT.global.bind($('#stripeForm'), 'keyup', function (e) {
                        var $form = $(e.currentTarget);
                        FIT.validate.stripeCheck();
                    });
                    FIT.global.bind($('#stripeForm'), 'change', function (e) {
                        var $form = $(e.currentTarget);
                        FIT.validate.stripeCheck();
                    });
               }
            });
        },

        // This is only a switch for now can be removed if we go with this solution
        doResponsiveImg: function() {
            return false;
        }
    };

    return {
        init: methods.init,
        responsiveModeSet: methods.responsiveModeSet,
        viewportResizeCheck: methods.viewportResizeCheck,
        hiResCheck: methods.hiResCheck,
        imageSize: methods.imageSize,
        bind: methods.bind,
        menu: methods.menu,
        doResponsiveImg: methods.doResponsiveImg
    };

})(jQuery, Modernizr, FIT);