{extends file="_base.tpl"} {block name=contents}
<div class="container">

  <h3>Site List</h3>
  <form method="post">
    <table class="table table-striped table-hover table-bordered">
      <thead>
        <tr>
          <th>Site</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
      {foreach item=site from=$sites}
      <tr>
        <td>
          {$site['site_name']}
        </td>
        <td>
          <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editSiteModal" data-id="{$site['site_id']}" data-data="{$site['site_name']}">Edit</button>
          <button type="submit" id="deleteSite" name="deleteSite" class="btn btn-danger" value="{$site['site_id']}">Delete</button>
        </td>
      </tr>
      {/foreach}
      </tbody>
    </table>
  </form>

  <form class="form-horizontal" method="post" role="form">
    <fieldset>
      <legend>Add Site</legend>
      <div class="form-group">
        <label class="col-md-2 control-label" for="Item Name">Site Name</label>
        <div class="col-md-9">
          <input id="name" name="name" type="text" placeholder="Site name" class="form-control input-md" required>
        </div>
        <div class="col-md-1">
          <button id="addSite" name="addSite" type="submit" class="btn btn-primary btn-block">Add</button>
        </div>
      </div>
    </fieldset>
  </form>

  <div class="modal fade" id="editSiteModal" tabindex="-1" role="dialog" aria-labelledby="editSiteLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="editSiteLabel">Edit Site</h4>
        </div>
        <div class="modal-body">
          <form method="post" id="editSiteForm" class="form-horizontal">
            <fieldset>
              <input type="hidden" id="editSiteID" name="editSiteID" value="" />
              <div class="form-group">
                <label class="col-md-4 control-label" for="editSiteName">Site Name</label>
                <div class="col-md-4">
                <input id="editSiteName" name="editSiteName" placeholder="New site name" class="form-control input-md" required type="text">
                </div>
              </div>
            </fieldset>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="editTypeCancel btn btn-primary" data-dismiss="modal">Cancel</button>
          <button type="submit" id="editSite" name="editSite" form="editSiteForm" class="editSiteButton btn btn-danger">Edit</button>
        </div>
      </div>
    </div>
  </div>

</div>
{/block} {block name="footerscripts"} {literal}
<script>
  $('#editSiteModal').on('show.bs.modal', function (event) {
    $(this).find('#editSiteName').val($(event.relatedTarget).data('data'))
    $(this).find('#editSiteID').val($(event.relatedTarget).data('id'))
  })
  $("#editSite").chosen({allow_single_deselect: true})
  $("#deleteSite").chosen({allow_single_deselect: true})
</script>
{/literal} {/block}
