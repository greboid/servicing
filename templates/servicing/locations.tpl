{extends file="_base.tpl"} {block name=contents}
<div class="container">

  <h3>Location List</h3>
  <form method="post">
    <table class="table table-striped table-hover table-bordered">
      <thead>
        <tr>
          <th>Location</th>
          <th>Site</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
      {foreach item=location from=$locations}
      <tr>
        <td>
          {$location['location_name']}
        </td>
        <td>
          {$location['site_name']}
        </td>
        <td>
          <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editLocationModal" data-id="{$location['location_id']}" data-data="{$location['location_name']}">Edit</button>
          <button type="submit" id="deleteLocation" name="deleteLocation" class="btn btn-danger" value="{$location['location_id']}">Delete</button>
        </td>
      </tr>
      {/foreach}
      </tbody>
    </table>
  </form>

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

  <div class="modal fade" id="editLocationModal" tabindex="-1" role="dialog" aria-labelledby="editLocationLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="editLocationLabel">Edit Location</h4>
        </div>
        <div class="modal-body">
          <form method="post" id="editLocationForm" class="form-horizontal">
            <fieldset>
              <input type="hidden" id="editLocationID" name="editLocationID" value="" />
              <div class="form-group">
                <label class="col-md-4 control-label" for="editLocationName">Location Name</label>
                <div class="col-md-4">
                <input id="editLocationName" name="editLocationName" placeholder="New location name" class="form-control input-md" required type="text">
                </div>
              </div>
            </fieldset>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="editLocationCancel btn btn-primary" data-dismiss="modal">Cancel</button>
          <button type="submit" id="editLocation" name="editLocation" form="editLocationForm" class="editLocationButton btn btn-danger">Edit</button>
        </div>
      </div>
    </div>
  </div>

</div>
{/block} {block name="footerscripts"} {literal}
<script>
  $('#editLocationModal').on('show.bs.modal', function (event) {
    $(this).find('#editLocationID').val($(event.relatedTarget).data('id'))
    $(this).find('#editLocationName').val($(event.relatedTarget).data('data'))
  })
  $("#deleteLocation").chosen({allow_single_deselect: true})
</script>
{/literal} {/block}
