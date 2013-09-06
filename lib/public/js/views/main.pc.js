module.exports = function(fragment, block, element, text, parse, modifiers) {
    return fragment([ element("h1", {}, [ text("Tests") ]), text(" "), block({
        html: {
            fn: function() {
                return this.ref("sections.preview").value();
            },
            refs: [ "sections.preview" ]
        }
    }) ]);
};