{extends file="_base.tpl"}
{block name=contents}
<div class="container">
  <form class="form-horizontal" role="form" method="POST">
    <fieldset>
      <legend>New Contractor</legend>
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
       <button class="btn btn-primary btn-block" name="add" type="submit">Add</button>
      </div>
     </div>
    </fieldset>
  </form>

  <form class="form-horizontal" role="form" method="POST">
    <fieldset>
      <legend>Delete Contractor</legend>
      <div class="form-group">
        <label class="col-md-2 control-label" for="items">Contractor</label>
        <div class="col-md-9">
          <select data-placeholder="Choose a contractor" id="deleteContractor" name="deleteContractor" class="form-control" required>
            <option></option>
            {foreach item=contractor from=$contractors}
            <option value="{$contractor['contractor_id']}">
              {$contractor['contractor_name']}
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
  $("#editContractor").chosen({allow_single_deselect: true})
  $("#deleteContractor").chosen({allow_single_deselect: true})
  $("#items").chosen({allow_single_deselect: true})
</script>
{/literal}
{/block}
