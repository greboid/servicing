{extends file="_base.tpl"} {block name=contents}
<div class="container">
  <form class="form-horizontal" role="form">
    <fieldset>
      <legend>Add location</legend>
      <div class="row form-group">
          <label class="col-md-2 control-label" for="name">Location Name</label>
          <div class="col-md-10">
          <input id="name" name="name" type="text" placeholder="Location name" class="form-control input-md" required>
          </div>
      </div>
      <div class="row form-group">
        <label class="col-md-2 control-label" for="site">Location's site</label>
        <div class="col-md-10">
          <select data-placeholder="Choose a site" id="site" name="site" class="form-control" required>
            <option></option>
            {foreach item=site from=$sites}
            <option value="{$site['site_id']}">{$site['site_name']}</option>
            {/foreach}
          </select>
        </div>
      </div>
      <div class="row form-group">
        <div class="col-md-offset-2 col-md-10">
          <button id="addSite" name="addSite" type="submit" class="btn btn-primary">Add</button>
        </div>
      </div>
    </fieldset>
  </form>
  <form class="form-horizontal" role="form">
    <fieldset>
      <legend>Delete Location</legend>
      <div class="row form-group">
        <label class="col-md-2 control-label" for="location">Location</label>
        <div class="col-md-9">
          <select data-placeholder="Choose a location to delete" id="location" name="location" class="form-control" required>
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
        <div class="col-md-1">
          <button class="btn btn-danger" disabled>Delete</button>
        </div>
      </div>
  </form>
</div>
{/block} {block name="footerscripts"} {literal}
<script>
  $("#location").chosen({allow_single_deselect: true})
  $("#site").chosen({allow_single_deselect: true})
</script>
{/literal} {/block}
