jQuery(document).ready(function () {
    jQuery('.dialog.content').each(function () {
        var selector = '#' + this.id;
        var title = '';
        jQuery(selector).siblings().filter('.dialog.link').each(function () {
            title = jQuery(this).text();
            jQuery(this).click(function () {
              jQuery(selector).dialog('open');
            });
        });
        jQuery(selector).dialog({
            autoOpen: false,
            title: title,
            modal: true,
            height: 480,
            width: 640
        });
    });
});
