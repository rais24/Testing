FIT.recipes = ( function ($, Modernizr, FIT) {

    var methods = {

            init: function () {

            },

            actions: {

                index: {

                    init: function () {
                        $('#filters').append('<a class="edit-filters action primary" data-js="true" href="#">Filter your results</a>');
                        switch ( FIT.params.device.relativeSize ) {
                            case 'small':
                            case 'medium':
                                methods.actions.index.smediumFilterMenu();
                                break;
                            default:
                                methods.actions.index.largeFilterMenu();
                        }

                        // Append the recipe images
                        $('li.recipe a.recipe-image noscript').each( function () {
                            var viewport = FIT.global.imageSize();
                            $(this).closest('a').append('<img data-js="true" src="' + $(this).attr('data-' + viewport) + '">');
                        });

                        // lazy load images in at 110% from top of screen
                        // $('img').waypoint(function() {
                        //     var newSrc = $(this).attr('data-src');
                        //     $(this).attr('src', newSrc);
                        // }, {
                        //     offset: '110%',
                        //     triggerOnce: true
                        // });
                    },

                    smediumFilterMenu: function () {
                        var filters = $('#filters'),
                            form = $('#filter-form'),
                            fieldsets = form.children('div.fieldsets'),
                            fieldsetCount = fieldsets.children('fieldset').length;

                        // Set the default sizes and class names
                        fieldsets.css('width', fieldsetCount * 100 + '%');
                        fieldsets.children('fieldset').css('width', fieldsets.width()/fieldsetCount);
                        fieldsets.children('fieldset:first-child').addClass('current');

                        // Append the previous/next/cancel buttons and create bindings
                        form.append('<div id="previous-filter" class="filter-control inactive" data-js="true">Previous</div>');
                        $('#previous-filter').on('click', function (e) {
                            var currentFilter = fieldsets.children('fieldset.current');
                            if ( currentFilter.index() > 0 ) {
                                previousFilter = currentFilter.prev('fieldset');
                            } else {
                                previousFilter = fieldsets.children(':last-child');
                            }
                            previousFilterIndex = previousFilter.index();
                            if ( previousFilterIndex === 0 ) {
                                $('#previous-filter').addClass('inactive');
                            } else {
                                $('#previous-filter').removeClass('inactive');
                            }
                            $('#next-filter').removeClass('inactive');
                            fieldsets.css('left', previousFilterIndex * -100 + '%');
                            currentFilter.removeClass('current');
                            previousFilter.addClass('current');
                        });
                        form.append('<div id="next-filter" class="filter-control" data-js="true">Next</div>');
                        $('#next-filter').on('click', function (e) {
                            var currentFilter = fieldsets.children('fieldset.current');
                            if ( currentFilter.next('fieldset').length ) {
                                nextFilter = currentFilter.next('fieldset');
                            } else {
                                nextFilter = fieldsets.children(':first-child');
                            }
                            nextFilterIndex = nextFilter.index();
                            if ( nextFilterIndex === fieldsetCount-1 ) {
                                $('#next-filter').addClass('inactive');
                            } else {
                                $('#next-filter').removeClass('inactive');
                            }
                            $('#previous-filter').removeClass('inactive');
                            fieldsets.css('left', nextFilterIndex * -100 + '%');
                            currentFilter.removeClass('current');
                            nextFilter.addClass('current');
                        });
                        form.children('ul.actions').append('<li class="secondary" data-js="true"><input type="reset" id="close-filter" value="Cancel"></li>');
                        $('#close-filter').on('click', function (e) {
                            FIT.global.menu.close(form, filters.children('div.darken'), 'filter-menu-open');
                        });

                        // Initialize the filter menu
                        FIT.global.menu.init(filters, form, $('a.edit-filters, span.edit-filters'), 'filter-menu-open');

                        filters.children('div.darken').on('click', function (e) {
                            document.getElementById('filter-form').reset();
                        });
                    },

                    largeFilterMenu: function () {
                        var filters = $('#filters'),
                            form = $('#filter-form'),
                            fieldsets = form.children('div.fieldsets'),
                            fieldsetCount = fieldsets.children('fieldset').length;

                        fieldsets.children('fieldset').each( function () {
                            $(this).css('width', parseInt(form.width()/fieldsetCount));
                        });

                        form.children('ul.actions').append('<li class="secondary" data-js="true"><input type="reset" id="close-filter" value="Cancel"></li>');
                        $('#close-filter').on('click', function (e) {
                            FIT.global.menu.close(form, filters.children('div.darken'), 'filter-menu-open');
                        });

                        // Initialize the filter menu
                        FIT.global.menu.init(filters, form, $('a.edit-filters, span.edit-filters'), 'filter-menu-open');

                        filters.children('div.darken').on('click', function (e) {
                            document.getElementById('filter-form').reset();
                        });
                    }

                },

                show: {

                    init: function () {
                        $('#hero').append('<img data-js="true" src="' + $('#hero noscript').attr('data-' + FIT.params.device.relativeSize) + '">');

                        $('#shopping_cart_item_quantity').on('change', methods.actions.show.priceCalculator);

                        if ( $('#preparation').data('prepview') === 'on' ) {
                            methods.actions.show.prepview();
                        }                   
                    },

                    prepview: function () {
                        var prepview;

                        FIT.domObjects.body.append('<div id="prepview" data-js="true"><ul class="actions"><li class="print"><a class="recipe-print" class="action primary" href="javascript:window.print()">Print</a></li><li class="close"><a class="prepview-close" href="#">Close</a></li></ul></div>');
                        prepview = $('#prepview');
                        $('#hero img').clone().appendTo(prepview);
                        prepview.append('<div class="recipe-name">' + $('#hero h1').text() + '</div>');                        
                        prepview.append('<div id="stats">' + $('#summary .stats').html() + '</div>');
                        $("#preparation > p:gt(0)").clone().attr("id", "prepview_instr").appendTo(prepview);
                        prepview.append('<div class="measurements">' + $('#measurements').html() + '</div>');
                        prepview.append('<div class="instructions">' + $('#instructions').html() + '</div>');
                        prepview.append('<ul class="actions"><li class="print"><a class="recipe-print" class="action primary" href="javascript:window.print()">Print</a></li><li class="close"><a class="prepview-close" href="#">Close</a></li></ul>');

                        $('#hero, #preparation h2').append('<a class="prepview-open action primary" href="#" data-js="true">Prep view</a>');
                        $('#hero a.prepview-open, #preparation h2 a.prepview-open').on('click.prepviewopen', function (e) {
                            e.preventDefault();
                            $('html, body').scrollTop(0);
                            $('#prepview').addClass('on');
                        });

                        $('#prepview').addClass('on');

                        $('#prepview a.prepview-close').on('click.prepviewclose', function (e) {
                            e.preventDefault();
                            $('#prepview').removeClass('on');
                            $('html, body').scrollTop(0);
                        });
                    },

                    priceCalculator: function () {
                        var total_amount = $("#shopping_cart_item_quantity option:selected").attr("data");
                        $('#cart-form li.total span.price').text("$"+total_amount);
                    }

                }

            }

        };

    return {
        init: methods.init,
        actions: methods.actions
    }

})(jQuery, Modernizr, FIT);
