module.exports = function(fragment, block, element, text, parse, modifiers) {
    return fragment([ text("  "), element("div", {
        "data-bind": [ {
            show: {
                fn: function() {
                    return true;
                },
                refs: []
            }
        } ]
    }, [ text("  "), block({
        iframe: {
            fn: function() {
                return {
                    "class": "test-preview",
                    src: this.ref("location").value(),
                    onLoad: this.ref("_onIFrameLoad").value()
                };
            },
            refs: [ "location", "_onIFrameLoad" ]
        }
    }), text(" ") ]), text(" ") ]);
};