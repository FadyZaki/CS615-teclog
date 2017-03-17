{include file="header.tpl" title="miNotes" Name="Fady Zaki"}

<div>
    

    <div id="notes-list">
        <div id="notes-list-header" class="header">
            <span class="left">miNotes</span>
            <!-- image link for creating new note-->
            <span class="right"><a href="index.php?action=new"><img src="images/CreateNote.png" alt="Create new note."></a></span>
        </div>
            <!-- iterating through notes and displaying the title of each note along with its last update date-->
            {foreach from=$notes item=note}
            <div class="notes-list-item">
                <span class="notes-list-item-title"><a href="index.php?action=navigate&id={$note.id}" {if $note.id eq $ACTIVE_NOTE_ID}class='active'{/if}>{$note.content|strip_tags:20|truncate:20}</a></span>
                <span class="notes-list-item-timestamp">{$note.last_modified|date_format:"%b %d"}</span>
            </div>      
        {/foreach}
    </div>
    
    <div id="notepad">
        <div id="notepad-header" class="header">
            <!-- image link for save a note-->
            <a class="icon" href="#" onclick = "return submitIfContentIsAvailable()"><img src="images/save.png" alt="Save Note"/></a>
            <!-- image link for delete a note-->
            <a class="icon" href="index.php?action=delete"><img src="images/delete.png" alt="Delete Note"/></a>
            <!-- image link for share a note on facebook -->
            <a class="icon" href="javascript:void(0)" onclick="javascript:genericSocialShare('http://www.facebook.com/sharer.php?url=')"><img src="images/fbShare.png" alt="Share on Facebook" ></a>
            <!-- image link for share a note on twitter -->
            <a class="icon" href="javascript:void(0)" onclick="javascript:genericSocialShare('http://twitter.com/share?url=')"><img src="images/twitterShare.png" alt="Share on Twitter"></a>
            <!-- image link for share a note on Google Plus -->
            <a class="icon" href="javascript:void(0)" onclick="javascript:genericSocialShare('https://plus.google.com/share?url=')"><img src="images/googleplusShare.png" alt="Share on GooglePlus"></a>
            <span class="right">Fady Zaki</span>
        </div>
        <div>
            <!-- iterating through all notes and displaying the content of the note that is currently active -->
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
        

        //This function is used to share the current note on the social media with the specified 'url'
         function genericSocialShare(url){         
            // A check is made before sharing a note to a database to make sure 
            //that the user has navigated to a certain note
            if (getURLParameter('action') == 'navigate') {
                window.open(url+encodeURIComponent(window.location.href),'sharer','toolbar=0,status=0,width=700,height=500');
            }
            return true;
        }


        //This function checks if actual content is available before submitting to the database
        function submitIfContentIsAvailable() {
            if(document.getElementById('updateForm') !== null) 
            {
                document.getElementById('updateForm').submit();
            }
            return false;
        }

        //This function is used to check if the url has the parameter specified in the function argument
        function getURLParameter(name) {
            return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search) || [null, ''])[1].replace(/\+/g, '%20')) || null;
        }
    </script>

{include file="footer.tpl"}
