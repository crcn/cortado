module.exports = function(fragment, block, element, text, parse, modifiers) {
    return fragment([ element("div", {
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
            return this.ref("testDuration").value();
        },
        refs: [ "testDuration" ]
    }) ]), text(" ") ]) ]);
};