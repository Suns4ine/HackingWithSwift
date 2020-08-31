var Action = function() {};

Action.prototype = {
    run: function(parameters) {
        parameters.complectionFunction({"URL": document.URL, "title": document.title});
    },
    finalize: function(parameters) {
    
    }
};

var ExtensionPreprocessingJS = new Action
