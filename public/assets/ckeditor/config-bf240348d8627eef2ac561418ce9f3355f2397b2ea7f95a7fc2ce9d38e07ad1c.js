/*
Copyright (c) 2003-2011, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/
CKEDITOR.editorConfig=function(e){e.filebrowserBrowseUrl="/ckeditor/attachment_files",e.filebrowserFlashBrowseUrl="/ckeditor/attachment_files",e.filebrowserFlashUploadUrl="/ckeditor/attachment_files",e.filebrowserImageBrowseLinkUrl="/ckeditor/pictures",e.filebrowserImageBrowseUrl="/ckeditor/pictures",e.filebrowserImageUploadUrl="/ckeditor/pictures",e.filebrowserUploadUrl="/ckeditor/attachment_files",e.allowedContent=!0,e.filebrowserParams=function(){for(var e,t,i,o=document.getElementsByTagName("meta"),n=new Object,r=0;r<o.length;r++)switch((i=o[r]).name){case"csrf-token":e=i.content;break;case"csrf-param":t=i.content;break;default:continue}return t!==undefined&&e!==undefined&&(n[t]=e),n},e.addQueryString=function(e,t){var i=[];if(!t)return e;for(var o in t)i.push(o+"="+encodeURIComponent(t[o]));return e+(-1!=e.indexOf("?")?"&":"?")+i.join("&")},CKEDITOR.on("dialogDefinition",function(t){var i,o,n=t.data.name,r=t.data.definition;CKEDITOR.tools.indexOf(["link","image","attachment","flash"],n)>-1&&(o=null==(i=r.getContents("Upload")||r.getContents("upload"))?null:i.get("upload"))&&o.filebrowser&&o.filebrowser.params===undefined&&(o.filebrowser.params=e.filebrowserParams(),o.action=e.addQueryString(o.action,o.filebrowser.params))}),e.toolbar=[{name:"document",groups:["mode","document","doctools"],items:["Source"]},{name:"clipboard",groups:["clipboard","undo"],items:["Cut","Copy","Paste","PasteText","PasteFromWord","-","Undo","Redo"]},{name:"links",items:["Link","Unlink","Anchor"]},{name:"insert",items:["Image","Flash","Table","HorizontalRule","SpecialChar"]},{name:"paragraph",groups:["list","indent","blocks","align","bidi"],items:["NumberedList","BulletedList","-","Outdent","Indent","-","Blockquote","CreateDiv","-","JustifyLeft","JustifyCenter","JustifyRight","JustifyBlock"]},"/",{name:"styles",items:["Styles","Format","Font","FontSize"]},{name:"colors",items:["TextColor","BGColor","Maximize"]},{name:"basicstyles",groups:["basicstyles","cleanup"],items:["Bold","Italic","Underline","Strike","Subscript","Superscript","-","RemoveFormat"]}],e.toolbar_mini=[{name:"document",items:["Source","-","Preview"]},{name:"clipboard",groups:["undo"],items:["Undo","Redo"]},{name:"paragraph",groups:["list","indent","blocks","align","bidi"],items:["NumberedList","BulletedList","-","Outdent","Indent","-","Blockquote","-","JustifyLeft","JustifyCenter","JustifyRight","JustifyBlock"]},{name:"colors",items:["TextColor","BGColor"]},{name:"basicstyles",groups:["basicstyles","cleanup"],items:["Bold","Italic","Underline","Strike"]},{name:"insert",items:["Image","Table","HorizontalRule","Maximize"]},{name:"styles",items:["Styles","Format","Font","FontSize"]}],e.toolbar_short=[{name:"document",items:["Source","-","Preview"]},{name:"clipboard",groups:["undo"],items:["Undo","Redo"]},{name:"paragraph",groups:["list","indent","blocks","align","bidi"],items:["NumberedList","BulletedList","-","Outdent","Indent","-","Blockquote","-","JustifyLeft","JustifyCenter","JustifyRight","JustifyBlock"]},{name:"colors",items:["TextColor","BGColor"]},{name:"basicstyles",groups:["basicstyles","cleanup"],items:["Bold","Italic","Underline","Strike"]},{name:"insert",items:["HorizontalRule","Maximize"]},{name:"styles",items:["Styles","Format","Font","FontSize"]}]};