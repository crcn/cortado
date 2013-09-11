module.exports = function(fragment, block, element, text, parse, modifiers) {
    return fragment([ text(" "), element("a", {
        href: [ "#" ],
        "data-bind": [ {
            onClick: {
                fn: function() {
                    return this.ref("showPreview").value(!this.ref("showPreview").value());
                },
                refs: [ "showPreview" ]
            }
        } ]
    }, [ text(" "), block({
        fn: function() {
            return this.ref("showPreview").value() ? "hide preview" : "show preview";
        },
        refs: [ "showPreview" ]
    }), text(" ") ]), text(" "), element("div", {
        "data-bind": [ {
            show: {
                fn: function() {
                    return this.ref("showPreview").value();
                },
                refs: [ "showPreview" ]
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