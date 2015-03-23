FIT.init = function () {
    var here = {
            controller: $('body').attr('data-controller'),
            action: $('body').attr('data-action')
        };

    FIT.global.init();

    if ( FIT[here.controller] ) {
        FIT[here.controller].init();
        if ( FIT[here.controller]['actions'][here.action] ) {
            FIT[here.controller]['actions'][here.action].init();
        }
    }

    FIT.initialized = true;
}


// Call all methods that need to run immediately
FIT.immediate.init();

// Call the remainder of the framework. No need to use $(document).ready()
// anywhere in the framework because the entire framework is wrapped in this one.
$(document).ready( function () {
    FIT.init();
});