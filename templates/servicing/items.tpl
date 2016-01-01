{extends file="_base.tpl"}
{block name=contents}
<div class="container">
  <form class="form-horizontal" role="form">
    <fieldset>
        <legend>New Serviceable Item</legend>
    <div class="row form-group">
        <label class="col-md-2 control-label" for="Item Name">Item Name</label>
        <div class="col-md-10">
        <input id="name" name="name" type="text" placeholder="Item name" class="form-control input-md" required>
        </div>
    </div>
    <div class="row form-group">
        <label class="col-md-2 control-label" for="location">Location</label>
        <div class="col-md-10">
          <select id="location" name="location" class="form-control" required>
            <option></option>
            {foreach item=site from=$sites}
            <optgroup label="{$site['site_name']}">
              {foreach item=location from=$locations}
              {if $location['site_name'] == $site['site_name']}
              <option value="{$location['location_id']}">{$location['location_name']}</option>
              {/if}
              {/foreach}
            </optgroup>
            {/foreach}
          </select>
      </div>
    </div>
    <div class="row form-group">
      <label class="col-md-2 control-label" for="type">Type</label>
      <div class="col-md-10">
        <select id="type" name="type" class="form-control" required>
          <option></option>
          {foreach item=type from=$types}
          <option value="{$type['type_id']}">{$type['type_name']}</option>
          {/foreach}
        </select>
    </div>
    </div>
    <div class="row form-group">
        <label class="col-md-2 control-label" for="contractor">Contract</label>
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
        <label class="col-md-2 control-label" for="interval">Interval</label>
        <div class="col-md-4">
          <select id="interval" name="interval" class="form-control" required>
          <option></option>
            {foreach item=interval from=$intervals}
            <option value="{$interval['intervals_id']}">{$interval['intervals_name']}</option>
            {/foreach}
          </select>
      </div>
          <label class="col-md-2 control-label" for="lastServiced">Last Serviced</label>
          <div class="col-md-4">
          <input id="lastServiced" name="lastServiced" type="date" placeholder="Date of last service" class="form-control input-md" required>
          </div>
    </div>
    <div class="row form-group">
      <div class="col-md-offset-2 col-md-10">
        <button type="submit" class="btn btn-primary">Add</button>
      </div>
    </div>
    </fieldset>
  </form>

  <form class="form-horizontal" role="form">
    <fieldset>
      <legend>Edit Serviceable Item</legend>
      <div class="row form-group">
        <label class="col-md-2 control-label" for="interval">Interval</label>
        <div class="col-md-9">
          <select data-placeholder="Choose a item to edit" id="editItem" name="editItem" class="form-control" required>
            <option></option>
            {foreach item=site from=$sites}
              <optgroup label="{$site['site_name']}">
              {foreach item=item from=$items}
                {if $item['site_name'] == $site['site_name']}
                <option value="{$item['item_id']}">{$item['item_name']}</option>
                {/if}
              {/foreach}
              </optgroup>
            {/foreach}
          </select>
        </div>
        <div class="col-md-1">
          <button class="btn btn-primary" disabled>Edit</button>
        </div>
      </div>
    </fieldset>
  </form>

  <form class="form-horizontal" role="form">
    <fieldset>
      <legend>Delete Serviceable Item</legend>
      <div class="row form-group">
        <label class="col-md-2 control-label" for="interval">Interval</label>
        <div class="col-md-9">
          <select data-placeholder="Choose a item to delete" id="deleteItem" name="deleteItem" class="form-control" required>
            <option></option>
            {foreach item=site from=$sites}
              <optgroup label="{$site['site_name']}">
              {foreach item=item from=$items}
                {if $item['site_name'] == $site['site_name']}
                <option value="{$item['item_id']}">{$item['item_name']}</option>
                {/if}
              {/foreach}
              </optgroup>
            {/foreach}
          </select>
        </div>
        <div class="col-md-1">
          <button class="btn btn-danger">Delete</button>
        </div>
      </div>
    </fieldset>
  </form>
</div>
{/block}
{block name="footerscripts"}
{literal}
<script>
  $("#editItem").chosen({allow_single_deselect: true})
  $("#deleteItem").chosen({allow_single_deselect: true})
</script>
{/literal}
{/block}
