{extends file="_base.tpl"} {block name=contents}
<div class="container">
  <form class="form-horizontal" role="form" method="POST">
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
        <div class="col-md-offset-11 col-md-1">
          <button id="addLocation" name="addLocation" type="submit" class="btn btn-primary btn-block">Add</button>
        </div>
      </div>
    </fieldset>
  </form>

  <form class="form-horizontal" role="form" method="POST">
    <fieldset>
      <legend>Delete Location</legend>
      <div class="row form-group">
        <label class="col-md-2 control-label" for="location">Location</label>
        <div class="col-md-9">
          <select data-placeholder="Choose a location to delete" id="deleteLocation" name="deleteLocation" class="form-control" required>
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
          <button type="submit" class="btn btn-danger btn-block">Delete</button>
        </div>
      </div>
  </form>
</div>
{/block} {block name="footerscripts"} {literal}
<script>
  $("#deleteLocation").chosen({allow_single_deselect: true})
  $("#editLocation").chosen({allow_single_deselect: true})
  $("#site").chosen({allow_single_deselect: true})
</script>
{/literal} {/block}
