module.exports = function(fragment, block, element, text, parse, modifiers) {
    return fragment([ element("div", {
        "class": [ "main-container" ]
    }, [ text(" "), element("div", {
        "class": [ "main-test-details" ]
    }, [ text(" "), block({
        html: {
            fn: function() {
                return this.ref("sections.logroll").value();
            },
            refs: [ "sections.logroll" ]
        }
    }), text(" ") ]), text(" "), element("div", {
        "class": [ "main-right-col" ]
    }, [ text(" "), block({
        html: {
            fn: function() {
                return this.ref("sections.status").value();
            },
            refs: [ "sections.status" ]
        }
    }), text(" "), block({
        html: {
            fn: function() {
                return this.ref("sections.findXPath").value();
            },
            refs: [ "sections.findXPath" ]
        }
    }), text(" "), element("div", {
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