{include file="header.tpl" title="miNotes"}

<div>
    
    <div id="notes-list">
        <div id="notes-list-header" class="header">
            <span class="left">miNotes</span>
            <span class="right"><a href="index.php?action=new"><img src="images/CreateNote.png" alt="Create new note."></a></span>
        </div>
            {foreach from=$notes item=note}
            <div class="notes-list-item">
                <span class="notes-list-item-title"><a href="index.php?action=navigate&id={$note.id}" {if $note.id eq $ACTIVE_NOTE_ID}class='active'{/if}>{$note.content|strip_tags:20|truncate:20}</a></span>
                <span class="notes-list-item-timestamp">{$note.last_modified|date_format:"%b %d"}</span>
            </div>      
        {/foreach}
    </div>
    
    <div id="notepad">
        <div id="notepad-header" class="header">
            <span><a href="#" onclick = "submitIfContentIsAvailable()">
            Save</a></span>&nbsp;|&nbsp;<span><a href="index.php?action=delete">Delete</a></span>
            <span class="right">Fady Zaki</span>
        </div>
        <div>
            {foreach from=$notes item=note}
                {if $note.id eq $ACTIVE_NOTE_ID}
                <span id="timestamp">{$note.last_modified|date_format:"%B %d, %r"}</span>
                <form action="index.php" method="POST" id="updateForm">
                    <div id="tinymce-holder">
                        <textarea id="content" name="content"><p>{$note.content}</p></textarea>
                    </div>  
                    <input type="hidden" name="action" value="update"/>
                </form>
                {/if}
            {/foreach}
        </div>
    </div>
    <a class="w-inline-block social-share-btn fb" href="https://www.facebook.com/sharer/sharer.php?u=&t=" title="Share on Facebook" target="_blank" onclick="window.open('https://www.facebook.com/sharer/sharer.php?u=' + encodeURIComponent(document.URL) + '&t=' + encodeURIComponent(document.URL)); return false;">
    </a>
</div>

    <script type="text/javascript">
        function submitIfContentIsAvailable() {
            if(document.getElementById('updateForm') !== null) 
            {
                document.getElementById('updateForm').submit();
            }
            return false;
        }
    </script>

{include file="footer.tpl"}
