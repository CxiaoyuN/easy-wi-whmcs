<div class="alert alert-info">
    <strong>{$easy_wi_lang.lendServerStatusCheck}</strong>
</div>

<div id="tabsEasyWi">
    <ul class="nav nav-tabs">
        <li id="tab1nav" class="active"><a href="#tab-easy-wi-1">{$easy_wi_lang.lendServerList}</a></li>
        {if $lendStatusGame || $lendGame}
            <li id="tab2nav"><a href="#tab-easy-wi-2">{$easy_wi_lang.games}</a></li>
        {/if}
        {if $lendStatusVoice || $lendVoice}
            <li id="tab3nav"><a href="#tab-easy-wi-3">{$easy_wi_lang.voice}</a></li>
        {/if}
    </ul>

    <div id="tab-easy-wi-1" class="tab-content-easy-wi">
        <h3>{$easy_wi_lang.games}</h3>
        <table class="table table-striped table-bordered table-hover">
            <thead>
            <tr>
                <th>{$easy_wi_lang.ip}:{$easy_wi_lang.port}</th>
                <th>{$easy_wi_lang.slots}</th>
                <th>{$easy_wi_lang.gameName}</th>
                <th>{$easy_wi_lang.gamesAvailable}</th>
                <th>{$easy_wi_lang.availableIn}</th>
            </tr>
            </thead>
            <tbody>
            {foreach name=outer item=server from=$lendStatusGlobal.gameserver}
                <tr>
                    <td>{$server.ip}:{$server.port} ({$server.queryName})</td>
                    <td>{$server.usedslots}/{$server.slots}</td>
                    <td>{$server.runningGame}</td>
                    <td>{', '|implode:$server.games}</td>
                    <td>{$server.timeleft}</td>
                </tr>
            {/foreach}
            </tbody>
        </table>
    
        <h3>{$easy_wi_lang.voice}</h3>
        <table class="table table-striped table-bordered table-hover">
            <thead>
            <tr>
                <th>{$easy_wi_lang.ip}:{$easy_wi_lang.port}</th>
                <th>{$easy_wi_lang.slots}</th>
                <th>{$easy_wi_lang.availableIn}</th>
            </tr>
            </thead>
            <tbody>
            {foreach name=outer item=server from=$lendStatusGlobal.voiceserver}
                <tr>
                    <td>{$server.ip}:{$server.port}</td>
                    <td>{$server.usedslots}/{$server.slots}</td>
                    <td>{$server.timeleft}</td>
                </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
	<br>
    <div id="tab-easy-wi-2" class="tab-content-easy-wi">
        {if $lendStatusGame && $lendStatusGame->nextfree eq 0 && $gameServerFree gt 0}
            <form method="post" action="lendserver.php" class="form-horizontal">
                <input type="hidden" name="type" value="gs">
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="inputPassword">{$easy_wi_lang.available}</label>
                    <div class="col-sm-6">
                        {$gameServerFree}/{$gameServerTotal}
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="inputGame">{$easy_wi_lang.gameName}</label>
                    <div class="col-sm-6">
                        <select name="game" id="inputGame" class="form-control">
                            {foreach name=outer item=option from=$gameTypeSelect}
                                <option>{$option}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="inputSlots">{$easy_wi_lang.slots}</label>
                    <div class="col-sm-6">
                        <select name="slots" id="inputSlots" class="form-control">
                            {foreach name=outer item=option from=$gameSlotSelect}
                                <option>{$option}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="inputTime">{$easy_wi_lang.lendTime}</label>
                    <div class="col-sm-6">
                        <select name="time" id="inputTime" class="form-control">
                            {foreach name=outer item=option from=$gameTimeSelect}
                                <option>{$option}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="inputRconPassword">RCON {$easy_wi_lang.password}</label>
                    <div class="col-sm-6">
                        <input type="text" id="inputRconPassword" name="rcon" value="{$lendStatusGame->rcon}" required="required" class="form-control" required="required" pattern="^[a-zA-Z0-9]{literal}{1,50}{/literal}+$">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="inputPassword">{$easy_wi_lang.password}</label>
                    <div class="col-sm-6">
                        <input type="text" id="inputPassword" name="password" value="{$lendStatusGame->password}" required="required" class="form-control" required="required" pattern="^[a-zA-Z0-9]{literal}{1,50}{/literal}+$">
                    </div>
                </div>
                <div class="form-group">
                    <div class="text-center">
                        <button type="submit" name="msettings" class='btn btn-primary'><i class="fa fa-star-o"></i> {$easy_wi_lang.lend}</button>
                    </div>
                </div>
            </form>
        {elseif $lendGame->status eq "started" || $lendGame->status eq "stillrunning"}
            <h3>{$easy_wi_lang.lendgames}</h3>
                <table class="table table-striped table-bordered table-hover">
                    <thead>
                    <tr>
                        <th>{$easy_wi_lang.ip}:{$easy_wi_lang.port}</th>
                        <th>{$easy_wi_lang.slots}</th>
                        <th>{$easy_wi_lang.lendTime}</th>
                        <th>RCON {$easy_wi_lang.password}</th>
                        <th>{$easy_wi_lang.password}</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>{$lendGame->ip}:{$lendGame->port}</td>
                        <td>{$lendGame->slots}</td>
                        <td>{$lendGame->lendtime}</td>
                        <td>{$lendGame->rcon}</td>
                        <td>{$lendGame->password}</td>
                    </tr>
                    </tbody>
                </table>
        {else}
            <div class="alert">
                <strong>{$easy_wi_lang.lendAllGameTaken}</strong>
            </div>
        {/if}
    </div>
    <div id="tab-easy-wi-3" class="tab-content-easy-wi">
        {if $lendVoice->status == "started" || $lendVoice->status == "stillrunning"}
            <div>
                <table class="table table-striped table-bordered table-hover">
                    <thead>
                    <tr>
                        {if $lendVoice->dns ne ""}
                            <th>{$easy_wi_lang.dns}</th>
                        {else}
                            <th>{$easy_wi_lang.ip}:{$easy_wi_lang.port}</th>
                        {/if}
                        <th>{$easy_wi_lang.slots}</th>
                        <th>{$easy_wi_lang.lendTime}</th>
                        <th>{$easy_wi_lang.password}</th>
                        <th>Token</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        {if $lendVoice->dns ne ""}
                            <td><a href="ts3server://{$lendVoice->dns}?password={$lendVoice->password}">{$lendVoice->dns}</a></td>
                        {else}
                            <td><a href="ts3server://{$lendVoice->ip}:{$lendVoice->port}?password={$lendVoice->password}">{$lendVoice->ip}:{$lendVoice->port}</a></td>
                        {/if}
                        <td>{$lendVoice->slots}</td>
                        <td>{$lendVoice->lendtime}</td>
                        <td>{$lendVoice->password}</td>
                        <td>{$lendVoice->token}</td>
                    </tr>
                    </tbody>
                </table>
            </div>
        {elseif $lendStatusVoice && $lendStatusVoice->nextfree eq 0 && $voiceServerFree gt 0}
            <form method="post" action="lendserver.php" class="form-horizontal">
                <input type="hidden" name="type" value="vo">
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="inputPassword">{$easy_wi_lang.available}</label>
                    <div class="col-sm-6">
                        {$voiceServerFree}/{$voiceServerTotal}
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-4 control-label" for="inputSlots">{$easy_wi_lang.slots}</label>
                    <div class="col-sm-6">
                        <select name="slots" id="inputSlots" class="form-control">
                            {foreach name=outer item=option from=$voiceSlotSelect}
                                <option>{$option}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="inputTime">{$easy_wi_lang.lendTime}</label>
                    <div class="col-sm-6">
                        <select name="time" id="inputTime" class="form-control">
                            {foreach name=outer item=option from=$voiceTimeSelect}
                                <option>{$option}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="inputPassword">{$easy_wi_lang.password}</label>
                    <div class="col-sm-6">
                        <input type="text" id="inputPassword" name="password" value="{$lendStatusVoice->password}" required="required" class="form-control" required="required" pattern="^[a-zA-Z0-9]{literal}{1,50}{/literal}+$">
                        
                    </div>
                </div>
                <div class="form-group">
                    <div class="text-center">
                        <button type="submit" name="msettings" class='btn btn-primary'><i class="fa fa-star-o"></i> {$easy_wi_lang.lend}</button>
                    </div>
                </div>
            </form>
        {else}
            <div class="alert">
                <strong>{$easy_wi_lang.lendAllVoiceTaken}</strong>
            </div>
        {/if}
    </div>
</div>

{literal}
    <script>
        jQuery(document).ready(function(){
            // Tabs Changer
            // ===============================
            //Default Action
            jQuery(".tab-content-easy-wi").hide(); //Hide all content
            if (jQuery(location).attr('hash').substr(1)!="") {
                var activeTab = jQuery(location).attr('hash');
                jQuery("ul").find('li').removeClass('open');
                jQuery("ul.nav li").removeClass("active"); //Remove any "active" class
                jQuery(activeTab+"nav").addClass("active");
                jQuery(activeTab).show();
            } else {
                jQuery("#tabsEasyWi ul.nav .nav-tabs li:first").addClass("active").show(); //Activate first tab
                jQuery(".tab-content-easy-wi:first").show(); //Show first tab content
            }

            //On Click Event
            jQuery("#tabsEasyWi ul.nav li").click(function() {
                jQuery("ul").find('li').removeClass('open');
                jQuery("ul.nav li").removeClass("active"); //Remove any "active" class
                jQuery(this).addClass("active"); //Add "active" class to selected tab
                var activeTab = jQuery(this).find("a").attr("href"); //Find the rel attribute value to identify the active tab + content
                if (activeTab.substr(0,1)=="#" && activeTab.substr(1)!="") { //Determine if a tab or link
                    jQuery(".tab-content-easy-wi").hide(); //Hide all tab content
                    jQuery(activeTab).fadeIn(); //Fade in the active content
                    return false;
                } else {
                    return true; // If link allow redirect
                }
            });
        });
    </script>
{/literal}
