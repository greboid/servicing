{extends file="_base.tpl"} {block name=contents}
  <div class="container">

  <h3>Type List</h3>
  <form method="post">
    <table class="table table-striped table-hover">
      <thead>
        <tr>
          <th>Type</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
      {foreach item=type from=$types}
      <tr>
        <td>
          {$type['type_name']}
        </td>
        <td>
          <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editTypeModal" data-id="{$type['type_id']}" data-data="{$type['type_name']}">Edit</button>
          <button type="submit" id="deleteType" name="deleteType" class="btn btn-danger" value="{$type['type_id']}">Delete</button>
        </td>
      </tr>
      {/foreach}
      </tbody>
    </table>
  </form>

  <form class="form-horizontal" method="post">
    <fieldset>
      <legend>Add Type</legend>
      <div class="form-group">
        <label class="col-md-2 control-label" for="newTypeName">Type Name</label>
        <div class="col-md-9">
          <input id="newTypeName" name="newTypeName" type="text" placeholder="Type name" class="form-control input-md" required>
        </div>
        <div class="col-md-1">
          <button id="addSite" name="addType" type="submit" class="btn btn-primary btn-block">Add</button>
        </div>
      </div>
    </fieldset>
  </form>

  <div class="modal fade" id="editTypeModal" tabindex="-1" role="dialog" aria-labelledby="editTypeLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="editTypeLabel">Edit Type</h4>
        </div>
        <div class="modal-body">
          <form method="post" id="editTypeForm" class="form-horizontal">
            <fieldset>
              <input type="hidden" id="editTypeID" name="editTypeID" value="" />
              <div class="form-group">
                <label class="col-md-4 control-label" for="editTypeName">Type Name</label>
                <div class="col-md-4">
                <input id="editTypeName" name="editTypeName" placeholder="New type name" class="form-control input-md" required type="text">
                </div>
              </div>
            </fieldset>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="editTypeCancel btn btn-primary" data-dismiss="modal">Cancel</button>
          <button type="submit" id="editType" name="editType" form="editTypeForm" class="editTypeButton btn btn-danger">Edit</button>
        </div>
      </div>
    </div>
  </div>

</div>

{/block} {block name="footerscripts"} {literal}
<script>
  $('#editTypeModal').on('show.bs.modal', function (event) {
    $(this).find('#editTypeName').val($(event.relatedTarget).data('data'))
    $(this).find('#editTypeID').val($(event.relatedTarget).data('id'))
  })
  $("#editType").chosen({allow_single_deselect: true})
  $("#deleteType").chosen({allow_single_deselect: true})
</script>
{/literal} {/block}
