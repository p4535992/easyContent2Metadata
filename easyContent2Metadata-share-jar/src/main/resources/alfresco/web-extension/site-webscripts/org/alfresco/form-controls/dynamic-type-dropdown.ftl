<div class="form-field">

    <script type="text/javascript">//<![CDATA[
    YAHOO.util.Event.onAvailable("${fieldHtmlId}", function(){
        new selectTypes("${fieldHtmlId}");
    });

    function selectTypes(currentValueHtmlId) {
        this.currentValueHtmlId = currentValueHtmlId;
        var selectDocumentQName = Dom.get(this.currentValueHtmlId);
        this.register = function () {
            // Call webscript
            Alfresco.util.Ajax.jsonGet({
                url: Alfresco.constants.PROXY_URI + "/ec2m/dropdownlist/retrieveallDocumentQNames",
                successCallback: {
                    fn: this.updateTypeOptions,
                    scope: this
                },
                failureCallback: {
                    fn: function () {
                    },
                    scope: this
                }
            });
        };

        // Add options into <select>
        this.updateTypeOptions = function (res) {
            var result = Alfresco.util.parseJSON(res.serverResponse.responseText);
            if (result.documentQNames.length > 0) {
                var documentQNames = result.documentQNames;
                selectDocumentQName.options[selectDocumentQName.options.length] = new Option("", "", true, true);
                for (var i in documentQNames) {
                    var option = new Option(documentQNames[i].documentName, documentQNames[i].qname);
                    selectDocumentQName.options.add(option);
                }
            }
        };

        this.register();
    }
    //]]></script>

    <label for="${fieldHtmlId}">${field.label?html}:<#if field.mandatory><span class="mandatory-indicator">${msg("form.required.fields.marker")}</span></#if></label>
    <select id="${fieldHtmlId}" name="${field.name}" tabindex="0"
            <#if field.description??>title="${field.description}"</#if>
            <#if field.control.params.size??>size="${field.control.params.size}"</#if>
            <#if field.control.params.styleClass??>class="${field.control.params.styleClass}"</#if>
            <#if field.control.params.style??>style="${field.control.params.style}"</#if>
            <#if field.disabled  && !(field.control.params.forceEditable?? && field.control.params.forceEditable == "true")>disabled="true"</#if>>
    </select>
</div>