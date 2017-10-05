{extends file="_base.tpl"}
{block name=contents}
<div class="container">
  <form class="form-horizontal" role="form" method="POST">
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
        <label class="col-md-2 control-label" for="lastServiced">Start</label>
        <div class="col-md-4">
          <input id="lastServiced" name="startDate" type="date" placeholder="Start of contract" class="form-control input-md" required>
        </div>
        <label class="col-md-1 control-label" for="lastServiced">End</label>
        <div class="col-md-5">
          <input id="lastServiced" name="endDate" type="date" placeholder="End of contract" class="form-control input-md" required>
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

  <form class="form-horizontal" role="form" method="POST">
    <fieldset>
      <legend>Delete Contract</legend>
      <div class="form-group">
        <label class="col-md-2 control-label" for="items">Contract</label>
        <div class="col-md-9">
          <select data-placeholder="Choose a contract" id="deleteContract" name="deleteContract" class="form-control" required>
            <option></option>
            {foreach item=contract from=$contracts}
            <option
              {if $contract['contract_end'] > {$smarty.now|date_format:'%Y-%m-%d'}}
                class="bg-success"
              {else}
                class="bg-danger"
              {/if}
            value="{$contract['contract_id']}">{$contract['contractor_name']} (Ends: {$contract['contract_end']})
            </option>
            {/foreach}
          </select>
        </div>
      <div class="col-md-1">
       <button class="btn btn-danger btn-block" name="delete" type="submit">Delete</button>
      </div>
    </div>
    </fieldset>
  </form>
</div>
{/block}
{block name="footerscripts"}
{literal}
<script>
  $("#contractor").chosen({allow_single_deselect: true})
  $("#editContract").chosen({allow_single_deselect: true})
  $("#deleteContract").chosen({allow_single_deselect: true})
  $("#items").chosen({allow_single_deselect: true})
</script>
{/literal}
{/block}
