{* External dependencies: flowjs/flow.js, jQuery *}

<textarea name="{$name}" data-rid="{$rid}" {raw $html}>{$value}</textarea>

{inline_js}
<script>
    if (!$('[data-tinymce-script]').length) {
        $('body').append($(document.createElement('script')).attr('data-tinymce-script', '').attr('src', '{$.assets_public_path('Editor/editor/tinymce.min.js', 'modules')}'));
    }
    if (!$('[data-jquery-tinymce-script]').length) {
        $('body').append($(document.createElement('script')).attr('data-jquery-tinymce-script', '').attr('src', '{$.assets_public_path('Editor/editor/jquery.tinymce.min.js', 'modules')}'));
    }
    $('[data-rid="{$rid}"]').tinymce({
        language: '{$lang}',
        plugins: [
            'advlist autolink link image lists charmap print preview hr anchor pagebreak spellchecker',
            'searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime image imagetools media nonbreaking',
            'save table contextmenu directionality emoticons template paste textcolor autoresize'
        ],
        relative_urls: false,
        file_browser_callback: function(field_name, url, type, win) {
            window.file_browser_window = win;
            window.file_browser_field = field_name;
            window.file_browser_url = url;
            window.file_browser_type = type;

            $('<a/>').attr('href', "{url route="editor:index"}?field=" + field_name + "&url=" + url).modal();
            return false;
        },
        images_upload_handler: function(blobInfo, success, failure){
            var xhr, formData;
            xhr = new XMLHttpRequest();
            xhr.withCredentials = false;
            xhr.open('POST','{url route="editor:changed"}');
            xhr.onload = function() {
                var json;
                if (xhr.status != 200) {
                    failure('HTTP Error: ' + xhr.status);
                    return;
                }
                json = JSON.parse(xhr.responseText);
                success(json.url);
            };
            formData = new FormData();
            formData.append('file', blobInfo.blob(), blobInfo.filename());
            xhr.send(formData);
        }
    });
</script>
{/inline_js}