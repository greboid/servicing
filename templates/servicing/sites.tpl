{extends file="_base.tpl"} {block name=contents}
<div class="container">
  <form id="deleteSite" class="form-horizontal" method="post" role="form">
    <fieldset>
      <legend>Add Site</legend>
    </fieldset>
    <div class="row form-group">
      <label class="col-md-2 control-label" for="Item Name">Site Name</label>
      <div class="col-md-10">
        <input id="name" name="name" type="text" placeholder="Site name" class="form-control input-md" required>
      </div>
    </div>
    <div class="row form-group">
      <div class="col-md-offset-2 col-md-10">
        <button id="addSite" name="addSite" type="submit" class="btn btn-primary">Add</button>
      </div>
    </div>
  </form>
  <form id="deleteSite" class="form-horizontal" method="post" role="form">
    <fieldset>
      <legend>Delete Site</legend>
      <div class="row form-group">
        <label class="col-md-2 control-label" for="site">Site</label>
        <div class="col-md-9">
          <select data-placeholder="Choose a site to delete" id="site" name="site" class="form-control" required>
            <option></option>
            {foreach item=site from=$sites}
            <option value="{$site['site_id']}">{$site['site_name']}</option>
            {/foreach}
          </select>
        </div>
        <div class="col-md-1">
          <button id="deleteSite" name="deleteSite" value="true" class="btn btn-danger">Delete</button>
        </div>
      </div>
    </fieldset>
  </form>
</div>
{/block} {block name="footerscripts"} {literal}
<script>
  $("#site").chosen({allow_single_deselect: true})
</script>
{/literal} {/block}
