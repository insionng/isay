﻿/*
Copyright 2012, KISSY UI Library v1.30rc
MIT Licensed
build time: Oct 9 23:22
*/
/**
 * Add indent and outdent command identifier for KISSY Editor.
 * @author yiminghe@gmail.com
 */
KISSY.add("editor/plugin/outdent/cmd", function (S, Editor, dentUtils) {
    var addCommand = dentUtils.addCommand;
    var checkOutdentActive = dentUtils.checkOutdentActive;
    return {
        init:function (editor) {
            addCommand(editor, "outdent");
            var queryCmd = Editor.Utils.getQueryCmd("outdent");
            if (!editor.hasCommand(queryCmd)) {
                editor.addCommand(queryCmd, {
                    exec:function (editor) {
                        var selection = editor.getSelection();
                        if (selection && !selection.isInvalid) {
                            var startElement = selection.getStartElement();
                            var elementPath = new Editor.ElementPath(startElement);
                            return checkOutdentActive(elementPath);
                        }
                    }
                });
            }
        }
    };

}, {
    requires:['editor', '../dent-utils/cmd']
});
