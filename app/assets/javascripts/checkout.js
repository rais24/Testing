FIT.checkouts = ( function ($, Modernizr, FIT) {
    
    var methods = {

            init: function () {
                methods.filterDeliveryTimes();
                $('#order_delivery_time_delivery_date').change(methods.filterDeliveryTimes);
            },

            filterDeliveryTimes: function() {
                var currentDate = new Date();
                var selectedDate = new Date($('#order_delivery_time_delivery_date :selected').val());
                if (currentDate.getHours() > 9 && selectedDate.getDate() == (currentDate.getDate()+1)) {
                    var delivery_time_slot_list = $('#order_delivery_time_time_slot');
                    delivery_time_slot_list.find("option:contains('7am-9am')").remove();
                    delivery_time_slot_list.find("option:contains('9am-11am')").remove();
                    delivery_time_slot_list.find("option:contains('11am-1pm')").remove();
										delivery_time_slot_list.find("option:contains('1pm-3pm')").remove();
                }
                else {
                    $('#order_delivery_time_time_slot').empty()
                        .append("<option>7am-9am</option>")
                        .append("<option>9am-11am</option>")
                        .append("<option>11am-1pm</option>")
                        .append("<option>3pm-5pm</option>")
                        .append("<option>5pm-7pm</option>")
                        .append("<option>7pm-9pm</option>");
                }
            },

            actions: {

                show: {

                    init: function () {
                        // TODO: lazy loading
                        // Since this is a small image always and only on tables and desktop, use medium imgae,
                        // but don't create it at all if the viewport is small or medium
                       $('li.recipe-summary li.image noscript').each( function () {
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