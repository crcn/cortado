module.exports = function(fragment, block, element, text, parse, modifiers) {
    return fragment([ element("a", {
        href: [ "#" ],
        "data-bind": [ {
            onClick: {
                fn: function() {
                    return this.call("toggleFindXPath", []).value();
                },
                refs: [ "toggleFindXPath" ]
            }
        } ]
    }, [ text(" "), block({
        fn: function() {
            return this.ref("findXPath").value() ? "stop xpath inspector" : "start xpath inspector";
        },
        refs: [ "findXPath" ]
    }), text(" ") ]), text(" "), element("br", {}), text(" "), block({
        "if": {
            fn: function() {
                return this.ref("findXPath").value();
            },
            refs: [ "findXPath" ]
        }
    }, function(fragment, block, element, text, parse, modifiers) {
        return fragment([ text(" "), block({
            "if": {
                fn: function() {
                    return this.ref("bestXPath").value();
                },
                refs: [ "bestXPath" ]
            }
        }, function(fragment, block, element, text, parse, modifiers) {
            return fragment([ text(" Best XPath: "), element("input", {
                type: [ "input" ],
                disabled: [ "disabled" ],
                size: [ {
                    fn: function() {
                        return this.ref("bestXPath.length").value() || 20;
                    },
                    refs: [ "bestXPath.length" ]
                } ],
                value: [ {
                    fn: function() {
                        return this.ref("bestXPath").value();
                    },
                    refs: [ "bestXPath" ]
                } ]
            }), text(" ") ]);
        }, function(fragment, block, element, text, parse, modifiers) {
            return fragment([ block({
                "else": {
                    fn: function() {
                        return true;
                    },
                    refs: []
                }
            }, function(fragment, block, element, text, parse, modifiers) {
                return fragment([ text(" "), element("strong", {}, [ text("Click anywhere in the IFrame to find the best XPath.") ]), text(" ") ]);
            }) ]);
        }), text(" ") ]);
    }) ]);
};