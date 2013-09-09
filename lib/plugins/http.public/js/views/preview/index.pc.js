module.exports = function(fragment, block, element, text, parse, modifiers) {
    return fragment([ element("div", {}, [ text("  "), block({
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
    }), text(" ") ]) ]);
};