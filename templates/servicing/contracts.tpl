{extends file="_base.tpl"}
{block name=contents}
<div class="container">
  <form class="form-horizontal" role="form">
    <fieldset>
      <legend>New Contract</legend>
      <div class="row form-group">
          <label class="col-md-2 control-label" for="contractor">Contractor</label>
          <div class="col-md-10">
            <select id="contractor" name="contractor" class="form-control" required>
              <option></option>
              {foreach item=contractor from=$contractors}
              <option
                {if $contractor['contract_end'] > {$smarty.now|date_format:'%Y-%m-%d'}}
                  class="bg-success"
                {else}
                  class="bg-danger"
                {/if}
              value="{$contractor['contractor_id']}">{$contractor['contractor_name']} (Ends: {$contractor['contract_end']})
              </option>
              {/foreach}
            </select>
        </div>
      </div>
      <div class="row form-group">
        <label class="col-md-2 control-label" for="lastServiced">Start</label>
        <div class="col-md-4">
          <input id="lastServiced" name="lastServiced" type="date" placeholder="Date of last service" class="form-control input-md" required>
        </div>
        <label class="col-md-1 control-label" for="lastServiced">End</label>
        <div class="col-md-5">
          <input id="lastServiced" name="lastServiced" type="date" placeholder="Date of last service" class="form-control input-md" required>
        </div>
      </div>
      <div class="row form-group">
        <label class="col-md-2 control-label" for="items">Items</label>
        <div class="col-md-10">
          <select data-placeholder="Choose the items in this contract" id="items" name="items" class="form-control" multiple required>
            <option></option>
            {foreach item=site from=$sites}
            <optgroup label="{$site['site_name']}">
              {foreach item=location from=$locations} {if $location['site_name'] == $site['site_name']}
              <option value="{$location['location_id']}">{$location['location_name']}</option>
              {/if} {/foreach}
            </optgroup>
            {/foreach}
          </select>
        </div>
      </div>
      <div class="row form-group">
        <label class="col-md-2 control-label" for="notes">Notes</label>
        <div class="col-md-10">
          <textarea class="form-control" id="notes" name="notes" placeholder="Notes" rows="3"></textarea>
        </div>
      </div>
      <div class="row form-group">
      <div class="col-md-11 col-md-offset-2">
       <button class="btn btn-primary " name="add" type="submit">Add</button>
      </div>
     </div>
    </fieldset>
  </form>

  <form class="form-horizontal" role="form">
    <fieldset>
      <legend>Edit Contract</legend>
      <div class="row form-group">
          <label class="col-md-2 control-label" for="contractor">Contract</label>
          <div class="col-md-10">
            <select id="contract" name="contract" class="form-control" required>
              <option></option>
              {foreach item=contract from=$contracts}
              <option
                {if $contract['contract_end'] > {$smarty.now|date_format:'%Y-%m-%d'}}
                  class="bg-success"
                {else}
                  class="bg-danger"
                {/if}
              value="{$contract['contractor_id']}">{$contract['contractor_name']} (Ends: {$contract['contract_end']})
              </option>
              {/foreach}
            </select>
        </div>
      </div>
      <div class="row form-group">
        <label class="col-md-2 control-label" for="lastServiced">End</label>
        <div class="col-md-4">
          <input id="lastServiced" name="lastServiced" type="date" placeholder="Date of last service" class="form-control input-md" disabled required>
        </div>
      </div>
      <div class="row form-group">
        <label class="col-md-2 control-label" for="items">Items</label>
        <div class="col-md-10">
          <select data-placeholder="Choose the items in this contract" id="items" name="items" class="form-control" disabled required>
            <option></option>
            {foreach item=site from=$sites}
            <optgroup label="{$site['site_name']}">
              {foreach item=location from=$locations} {if $location['site_name'] == $site['site_name']}
              <option value="{$location['location_id']}">{$location['location_name']}</option>
              {/if} {/foreach}
            </optgroup>
            {/foreach}
          </select>
        </div>
      </div>
      <div class="row form-group">
        <label class="col-md-2 control-label" for="notes">Notes</label>
        <div class="col-md-10">
          <textarea class="form-control" id="notes" name="notes" placeholder="Notes" rows="3" disabled></textarea>
        </div>
      </div>
      <div class="row form-group">
      <div class="col-md-11 col-md-offset-2">
       <button class="btn btn-primary " name="add" type="submit" disabled>Add</button>
      </div>
     </div>
    </fieldset>
  </form>

  <form class="form-horizontal" role="form">
    <fieldset>
      <legend>Delete Contract</legend>
      <div class="form-group">
        <label class="col-md-2 control-label" for="items">Contract</label>
        <div class="col-md-9">
          <select id="contract" name="contract" class="form-control" required>
            <option></option>
            {foreach item=contract from=$contracts}
            <option
              {if $contract['contract_end'] > {$smarty.now|date_format:'%Y-%m-%d'}}
                class="bg-success"
              {else}
                class="bg-danger"
              {/if}
            value="{$contract['contractor_id']}">{$contract['contractor_name']} (Ends: {$contract['contract_end']})
            </option>
            {/foreach}
          </select>
        </div>
      <div class="col-md-1">
       <button class="btn btn-danger" name="add" type="submit" disabled>Add</button>
      </div>
    </div>
    </fieldset>
  </form>
</div>
{/block}
{block name="footerscripts"}
{literal}
<script>
  $("#contractor").chosen({allow_single_deselect: true})
  $("#items").chosen({allow_single_deselect: true})
</script>
{/literal}
{/block}
