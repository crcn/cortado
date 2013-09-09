module.exports = function(fragment, block, element, text, parse, modifiers) {
    return fragment([ element("div", {}, [ text(" "), element("iframe", {
        "class": [ "test-preview" ],
        src: [ {
            fn: function() {
                return this.ref("location").value();
            },
            refs: [ "location" ]
        } ],
        "data-bind": [ {
            onLoad: {
                fn: function() {
                    return this.call("_onIFrameLoad", []).value();
                },
                refs: [ "_onIFrameLoad" ]
            }
        } ]
    }, [ text(" ") ]), text(" ") ]) ]);
};