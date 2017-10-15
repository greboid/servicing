{extends file="_base.tpl"}
{block name=contents}
<div class="container">

  <h3>Contractor List</h3>
  <form method="post">
    <table class="table table-striped table-hover table-bordered">
      <thead>
        <tr>
          <th>Contractor</th>
          <th>Number</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
      {foreach item=contractor from=$contractors}
      <tr>
        <td>
          {$contractor['contractor_name']}
        </td>
        <td>
          {$contractor['contractor_phone']}
        </td>
        <td>
          <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editContractorModal" data-id="{$contractor['contractor_id']}" data-name="{$contractor['contractor_name']}" data-phone="{$contractor['contractor_phone']}">Edit</button>
          <button type="submit" id="deleteContractor" name="deleteContractor" class="btn btn-danger" value="{$contractor['contractor_id']}">Delete</button>
        </td>
      </tr>
      {/foreach}
      </tbody>
    </table>
  </form>


  <form class="form-horizontal" role="form" method="POST">
    <fieldset>
      <legend>Add Contractor</legend>
      <div class="row form-group">
        <label class="col-md-2 control-label" for="items">Name</label>
        <div class="col-md-10">
          <input id="name" name="name" type="text" placeholder="Contractor name" class="form-control input-md" required>
        </div>
      </div>
      <div class="row form-group">
        <label class="col-md-2 control-label" for="items">Phone Number</label>
        <div class="col-md-10">
          <input id="number" name="number" type="tel" placeholder="Contractor number" class="form-control input-md" required>
        </div>
      </div>
      <div class="row form-group">
      <div class="col-md-1 col-md-offset-11">
       <button class="btn btn-primary btn-block" name="addContractor" type="submit">Add</button>
      </div>
     </div>
    </fieldset>
  </form>

  <div class="modal fade" id="editContractorModal" tabindex="-1" role="dialog" aria-labelledby="editContractorLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="editContractorLabel">Edit Contractor</h4>
        </div>
        <div class="modal-body">
          <form method="post" id="editContractorForm" class="form-horizontal">
            <fieldset>
              <input type="hidden" id="editContractorID" name="editContractorID" value="" />
              <div class="form-group">
                <label class="col-md-4 control-label" for="editContractorName">Name</label>
                <div class="col-md-4">
                <input id="editContractorName" name="editContractorName" placeholder="New Contractor name" class="form-control input-md" required type="text">
                </div>
              </div>
              <div class="form-group">
                <label class="col-md-4 control-label" for="editContractorPhone">Phone Number</label>
                <div class="col-md-4">
                <input id="editContractorPhone" name="editContractorPhone" placeholder="New Contractor phone number" class="form-control input-md" required type="text">
                </div>
              </div>
            </fieldset>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="editContractorCancel btn btn-primary" data-dismiss="modal">Cancel</button>
          <button type="submit" id="editContractor" name="editContractor" form="editContractorForm" class="editContractorButton btn btn-danger">Edit</button>
        </div>
      </div>
    </div>
  </div>


</div>
{/block}
{block name="footerscripts"}
{literal}
<script>
  $('#editContractorModal').on('show.bs.modal', function (event) {
    $(this).find('#editContractorID').val($(event.relatedTarget).data('id'))
    $(this).find('#editContractorName').val($(event.relatedTarget).data('name'))
    $(this).find('#editContractorPhone').val($(event.relatedTarget).data('phone'))
  })
  $("#contractor").chosen({allow_single_deselect: true})
  $("#deleteContractor").chosen({allow_single_deselect: true})
</script>
{/literal}
{/block}
