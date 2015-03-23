// FIT.immediate contains everything that should fire before the DOM is ready

FIT.immediate = ( function ($, Modernizr, FIT) {

    var methods = {

        init: function () {
            FIT.global.viewportResizeCheck('responsiveModeSet', FIT.global.responsiveModeSet);
            FIT.global.hiResCheck();
        }

    };

    return {
        init: methods.init
    };

})(jQuery, Modernizr, FIT);