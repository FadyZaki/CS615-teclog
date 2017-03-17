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
            <a class="icon" href="#" onclick = "return submitIfContentIsAvailable()"><img src="images/save.png" alt="Save Note"/></a>
            <a class="icon" href="index.php?action=delete"><img src="images/delete.png" alt="Delete Note"/></a>
            <a class="icon" href="http://www.facebook.com/share.php?u=<url>" onclick="return fbs_click()" target="_blank"><img src="images/fbShare.png" alt="Share on Facebook" rel="no-follow" /></a>
            <a class="icon" href="http://twitter.com/share?u=<url>" onclick="return twitter_click()" target="_blank" ><img src="images/twitterShare.png" alt="Share on Twitter"></a>
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

<script type="text/javascript">

</script>

    <script type="text/javascript">
        function submitIfContentIsAvailable() {
            if(document.getElementById('updateForm') !== null) 
            {
                document.getElementById('updateForm').submit();
            }
            return false;
        }

        function fbs_click() 
        {
            u=location.href;t=document.title;window.open('http://www.facebook.com/sharer.php?u='+encodeURIComponent(u)+'&t='+encodeURIComponent(t),'sharer','toolbar=0,status=0,width=626,height=436');return false;
        }

        function twitter_click() 
        {
            u=location.href;t=document.title;window.open('http://twitter.com/share?u='+encodeURIComponent(u)+'&t='+encodeURIComponent(t),'sharer','toolbar=0,status=0,width=626,height=436');return false;
        }
    </script>

{include file="footer.tpl"}
