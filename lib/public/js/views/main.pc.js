module.exports = function(fragment, block, element, text, parse, modifiers) {
    return fragment([ element("div", {
        "class": [ "main-container" ]
    }, [ text(" "), element("div", {
        "class": [ "main-test-details" ]
    }, [ text(" ") ]), text(" "), element("div", {
        "class": [ "main-right-col" ]
    }, [ text(" "), element("div", {
        "class": [ "main-test-info" ]
    }, [ text(" Success: "), element("strong", {}, [ block({
        fn: function() {
            return this.ref("successCount").value();
        },
        refs: [ "successCount" ]
    }) ]), text(" Failure: "), element("strong", {}, [ block({
        fn: function() {
            return this.ref("failureCount").value();
        },
        refs: [ "failureCount" ]
    }) ]), text(" Duration: "), element("strong", {}, [ block({
        fn: function() {
            return this.ref("duration").value();
        },
        refs: [ "duration" ]
    }) ]), text(" ") ]), text(" "), element("div", {
        "class": [ "main-preview" ]
    }, [ text(" "), block({
        html: {
            fn: function() {
                return this.ref("sections.preview").value();
            },
            refs: [ "sections.preview" ]
        }
    }), text(" ") ]), text(" ") ]), text(" ") ]) ]);
};