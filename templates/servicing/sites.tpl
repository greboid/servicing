{extends file="_base.tpl"} {block name=contents}
<div class="container">
  <form id="addSite" class="form-horizontal" method="post" role="form">
    <fieldset>
      <legend>Add Site</legend>
      <div class="form-group">
        <label class="col-md-2 control-label" for="Item Name">Site Name</label>
        <div class="col-md-9">
          <input id="name" name="name" type="text" placeholder="Site name" class="form-control input-md" required>
        </div>
        <div class="col-md-1">
          <button id="addSite" name="addSite" type="submit" class="btn btn-primary">Add</button>
        </div>
      </div>
    </fieldset>
  </form>

  <form id="editSite" class="form-horizontal" method="post" role="form">
    <fieldset>
      <legend>Edit Site</legend>
      <div class="row form-group">
        <label class="col-md-2 control-label" for="site">Site</label>
        <div class="col-md-9">
          <select data-placeholder="Choose a site to delete" id="editSite" name="editSite" class="form-control" required>
            <option></option>
            {foreach item=site from=$sites}
            <option value="{$site['site_id']}">{$site['site_name']}</option>
            {/foreach}
          </select>
        </div>
        <div class="col-md-1">
          <button id="deleteSite" name="deleteSite" value="true" class="btn btn-primary" disabled>Edit</button>
        </div>
      </div>
    </fieldset>
  </form>

  <form id="deleteSite" class="form-horizontal" method="post" role="form">
    <fieldset>
      <legend>Delete Site</legend>
      <div class="row form-group">
        <label class="col-md-2 control-label" for="site">Site</label>
        <div class="col-md-9">
          <select data-placeholder="Choose a site to delete" id="deleteSite" name="deleteSite" class="form-control" required>
            <option></option>
            {foreach item=site from=$sites}
            <option value="{$site['site_id']}">{$site['site_name']}</option>
            {/foreach}
          </select>
        </div>
        <div class="col-md-1">
          <button id="deleteSite" name="deleteSite" value="true" class="btn btn-danger" disabled>Delete</button>
        </div>
      </div>
    </fieldset>
  </form>
</div>
{/block} {block name="footerscripts"} {literal}
<script>
  $("#editSite").chosen({allow_single_deselect: true})
  $("#deleteSite").chosen({allow_single_deselect: true})
</script>
{/literal} {/block}
