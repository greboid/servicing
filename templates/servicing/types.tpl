{extends file="_base.tpl"} {block name=contents}
<div class="container">
  <form class="form-horizontal" method="post" role="form">
    <fieldset>
      <legend>Add Type</legend>
      <div class="form-group">
        <label class="col-md-2 control-label" for="Type Name">Type Name</label>
        <div class="col-md-9">
          <input id="name" name="name" type="text" placeholder="Type name" class="form-control input-md" required>
        </div>
        <div class="col-md-1">
          <button id="addSite" name="addType" type="submit" class="btn btn-primary btn-block">Add</button>
        </div>
      </div>
    </fieldset>
  </form>

  <form class="form-horizontal" method="post" role="form">
    <fieldset>
      <legend>Delete Type</legend>
      <div class="row form-group">
        <label class="col-md-2 control-label" for="site">Site</label>
        <div class="col-md-9">
          <select data-placeholder="Choose a type to delete" id="deleteType" name="deleteType" class="form-control" required>
            <option></option>
            {foreach item=type from=$types}
            <option value="{$type['type_id']}">{$type['type_name']}</option>
            {/foreach}
          </select>
        </div>
        <div class="col-md-1">
          <button class="btn btn-danger btn-block">Delete</button>
        </div>
      </div>
    </fieldset>
  </form>
</div>
{/block} {block name="footerscripts"} {literal}
<script>
  $("#editType").chosen({allow_single_deselect: true})
  $("#deleteType").chosen({allow_single_deselect: true})
</script>
{/literal} {/block}
