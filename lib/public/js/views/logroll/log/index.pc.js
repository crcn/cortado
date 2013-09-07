module.exports = function(fragment, block, element, text, parse, modifiers) {
    return fragment([ element("div", {
        "class": [ "log" ]
    }, [ text(" "), block({
        "if": {
            fn: function() {
                return this.ref("model.type").value() == "test";
            },
            refs: [ "model.type" ]
        }
    }, function(fragment, block, element, text, parse, modifiers) {
        return fragment([ text(" "), element("span", {
            "class": [ "log-test" ]
        }, [ text(" "), element("span", {
            "class": [ "log-status" ],
            "data-bind": [ {
                style: {
                    fn: function() {
                        return {
                            color: this.ref("checkColor").value()
                        };
                    },
                    refs: [ "checkColor" ]
                }
            } ]
        }, [ text(" "), block({
            html: {
                fn: function() {
                    return this.ref("checkText").value();
                },
                refs: [ "checkText" ]
            }
        }), text(" ") ]), text(" "), block({
            fn: function() {
                return this.ref("model.description").value();
            },
            refs: [ "model.description" ]
        }), text(" ") ]), text(" ") ]);
    }, function(fragment, block, element, text, parse, modifiers) {
        return fragment([ block({
            "else": {
                fn: function() {
                    return this.ref("model.type").value() == "error";
                },
                refs: [ "model.type" ]
            }
        }, function(fragment, block, element, text, parse, modifiers) {
            return fragment([ text(" "), element("span", {
                "class": [ "log-error" ]
            }, [ block({
                fn: function() {
                    return this.ref("model.description").value();
                },
                refs: [ "model.description" ]
            }) ]), text(" ") ]);
        }, function(fragment, block, element, text, parse, modifiers) {
            return fragment([ block({
                "else": {
                    fn: function() {
                        return true;
                    },
                    refs: []
                }
            }, function(fragment, block, element, text, parse, modifiers) {
                return fragment([ text(" "), element("span", {
                    "class": [ "log-verbose" ]
                }, [ block({
                    fn: function() {
                        return this.ref("model.description").value();
                    },
                    refs: [ "model.description" ]
                }) ]), text(" ") ]);
            }) ]);
        }) ]);
    }), text(" ") ]) ]);
};