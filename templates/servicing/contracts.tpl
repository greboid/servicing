{extends file="_base.tpl"}
{block name=contents}
<div class="container">

  <h3>Contract List</h3>
  <form method="post">
    <table class="table table-striped table-hover table-bordered">
      <thead>
        <tr>
          <th>Contractor</th>
          <th>Start</th>
          <th>End</th>
          <th>Notes</th>
          <th>Items</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        {foreach item=contract from=$contracts}
        <tr>
          <td>
            {$contract['contractor_name']}
          </td>
          <td>
            {$contract['contract_start']}
          </td>
          <td>
            {$contract['contract_end']}
          </td>
          <td>
            {$contract['contract_notes']}
          </td>
          <td>
            {foreach item=item from=$contract['contract_items'] name=contracts}
              {$item['item_name']}{if not $smarty.foreach.contracts.last}, {/if}
            {/foreach}
          </td>
          <td>
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editContractModal"
                data-id="{$contract['contract_id']}"
                data-contractor="{$contract['contractor_id']}"
                data-start="{$contract['contract_start']}"
                data-end="{$contract['contract_end']}"
                data-notes="{$contract.contract_notes}"
                data-items="{strip}[
                {foreach item=item from=$contract['contract_items'] name=contracts}
                {$item['item_id']}{if not $smarty.foreach.contracts.last},{/if}
                {/foreach}]
                {/strip}"
                >
              Edit</button>
            <button type="submit" name="deleteContract" class="btn btn-danger" value="{$contract['contract_id']}">Delete</button>
          </td>
        </tr>
        {/foreach}
      </tbody>
    </table>
  </form>

  <form class="form-horizontal" method="POST">
    <fieldset>
      <legend>New Contract</legend>
      <div class="row form-group">
        <label class="col-md-2 control-label" for="contractor">Contractor</label>
        <div class="col-md-10">
          <select data-placeholder="Choose a contractor" id="contractor" name="contractor" class="form-control" required>
            <option></option>
            {foreach item=contractor from=$contractors}
            <option value="{$contractor['contractor_id']}">
              {$contractor['contractor_name']}
            </option>
            {/foreach}
          </select>
        </div>
      </div>
      <div class="row form-group">
        <label class="col-md-2 control-label" for="startDate">Start</label>
        <div class="col-md-4">
          <input id="startDate" name="startDate" type="date" placeholder="Start of contract" class="form-control input-md" required>
        </div>
        <label class="col-md-1 control-label" for="endDate">End</label>
        <div class="col-md-5">
          <input id="endDate" name="endDate" type="date" placeholder="End of contract" class="form-control input-md" required>
        </div>
      </div>
      <div class="row form-group">
        <label class="col-md-2 control-label" for="items">Items</label>
        <div class="col-md-10">
          <select data-placeholder="Choose the items in this contract" id="items" name="items[]" class="form-control" multiple>
            <option></option>
            {foreach item=item from=$items}
            <option value="{$item['item_id']}">{$item['item_name']}</option>
            {/foreach}
          </select>
        </div>
      </div>
      <div class="row form-group">
        <label class="col-md-2 control-label" for="notes">Notes</label>
        <div class="col-md-10">
          <textarea class="form-control" id="notes" name="notes" placeholder="Notes" rows="3"></textarea>
        </div>
      </div>
      <div class="row form-group">
        <div class="col-md-1 col-md-offset-11">
          <button class="btn btn-primary btn-block" name="add" type="submit">Add</button>
        </div>
      </div>
    </fieldset>
  </form>

  <div class="modal fade" id="editContractModal" tabindex="-1" role="dialog" aria-labelledby="editContractLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="editContractLabel">Edit Contract</h4>
        </div>
        <div class="modal-body">
          <form method="post" id="editContractForm" class="form-horizontal">
            <fieldset>
              <input type="hidden" id="editContractID" name="editContractID" value="" />
              <div class="row form-group">
                <label class="col-md-2 control-label" for="editContractor">Contractor</label>
                <div class="col-md-10">
                  <select data-placeholder="Choose a contractor" id="editContractor" name="editContractor" class="form-control" required>
                    <option></option>
                    {foreach item=contractor from=$contractors}
                    <option value="{$contractor['contractor_id']}">
                      {$contractor['contractor_name']}
                    </option>
                    {/foreach}
                  </select>
                </div>
              </div>
              <div class="row form-group">
                <label class="col-md-2 control-label" for="editStartDate">Start</label>
                <div class="col-md-4">
                  <input id="editStartDate" name="editStartDate" type="date" placeholder="Start of contract" class="form-control input-md" required>
                </div>
                <label class="col-md-1 control-label" for="editEndDate">End</label>
                <div class="col-md-5">
                  <input id="editEndDate" name="editEndDate" type="date" placeholder="End of contract" class="form-control input-md" required>
                </div>
              </div>
              <div class="row form-group">
                <label class="col-md-2 control-label" for="items">Items</label>
                <div class="col-md-10">
                  <select data-placeholder="Choose the items in this contract" id="editItems" name="editItems[]" class="form-control" multiple>
                    <option></option>
                    {foreach item=item from=$items}
                    <option value="{$item['item_id']}">{$item['item_name']}</option>
                    {/foreach}
                  </select>
                </div>
              </div>
              <div class="row form-group">
                <label class="col-md-2 control-label" for="editNotes">Notes</label>
                <div class="col-md-10">
                  <textarea class="form-control" id="editNotes" name="editNotes" placeholder="Notes" rows="3"></textarea>
                </div>
              </div>
            </fieldset>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="editContractCancel btn btn-primary" data-dismiss="modal">Cancel</button>
          <button type="submit" id="editContract" name="editContract" form="editContractForm" class="editContractButton btn btn-danger">Edit</button>
        </div>
      </div>
    </div>
  </div>

</div>
{/block}
{block name="footerscripts"}
{literal}
<script>
$('#editContractModal').on('show.bs.modal', function (event) {
  $(this).find('#editContractID').val($(event.relatedTarget).data('id'));
  $(this).find('#editContractor').val($(event.relatedTarget).data('contractor'));
  $(this).find('#editStartDate').val($(event.relatedTarget).data('start'));
  $(this).find('#editEndDate').val($(event.relatedTarget).data('end'));
  $(this).find('#editNotes').val($(event.relatedTarget).data('notes'));
  $(this).find('#editItems').val($(event.relatedTarget).data('items'));
  $(this).find('#editItems').trigger("chosen:updated");
})
$("#contractor").chosen({ allow_single_deselect: true })
$("#items").chosen({ allow_single_deselect: true })
$("#editContractor").chosen({ allow_single_deselect: true })
$("#editItems").chosen({ allow_single_deselect: true })
</script>
{/literal}
{/block}
