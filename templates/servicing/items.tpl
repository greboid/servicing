{extends file="_base.tpl"}
{block name=contents}
<div class="container">

  <h3>Items List</h3>
  <form method="post">
    <table class="table table-striped table-hover table-bordered">
      <thead>
        <tr>
          <th>Name</th>
          <th>Location</th>
          <th>Site</th>
          <th>Type</th>
          <th>Interval</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
      {foreach item=item from=$items}
      <tr>
        <td>
          {$item['item_name']}
        </td>
        <td>
          {$item['location_name']}
        </td>
        <td>
          {$item['site_name']}
        </td>
        <td>
          {$item['type_name']}
        </td>
        <td>
          {$item['intervals_name']}
        </td>
        <td>
          <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editItemModal"
                data-id="{$item['item_id']}"
                data-name="{$item['item_name']}"
                data-location="{$item['item_location']}"
                data-type="{$item['item_type']}"
                data-interval="{$item['item_interval']}"
          >Edit</button>
          <button type="submit" id="deleteSite" name="deleteSite" class="btn btn-danger" value="{$item['item_id']}">Delete</button>
        </td>
      </tr>
      {/foreach}
      </tbody>
    </table>
  </form>

  <form class="form-horizontal" role="form" method="POST">
    <fieldset>
        <legend>New Serviceable Item</legend>
    <div class="row form-group">
        <label class="col-md-2 control-label" for="Item Name">Item Name</label>
        <div class="col-md-10">
        <input id="name" name="name" type="text" placeholder="Item name" class="form-control input-md" required>
        </div>
    </div>
    <div class="row form-group">
        <label class="col-md-2 control-label" for="location">Location</label>
        <div class="col-md-10">
          <select data-placeholder="Choose a location" id="location" name="location" class="form-control" required>
            <option></option>
            {foreach item=site from=$sites}
            <optgroup label="{$site['site_name']}">
              {foreach item=location from=$locations}
              {if $location['site_name'] == $site['site_name']}
              <option value="{$location['location_id']}">{$location['location_name']}</option>
              {/if}
              {/foreach}
            </optgroup>
            {/foreach}
          </select>
      </div>
    </div>
    <div class="row form-group">
      <label class="col-md-2 control-label" for="type">Type</label>
      <div class="col-md-10">
        <select data-placeholder="Choose a type" id="type" name="type" class="form-control" required>
          <option></option>
          {foreach item=type from=$types}
          <option value="{$type['type_id']}">{$type['type_name']}</option>
          {/foreach}
        </select>
    </div>
    </div>
    <div class="row form-group">
        <label class="col-md-2 control-label" for="interval">Interval</label>
        <div class="col-md-4">
          <select data-placeholder="Choose an interval" id="interval" name="interval" class="form-control" required>
          <option></option>
            {foreach item=interval from=$intervals}
            <option value="{$interval['intervals_id']}">{$interval['intervals_name']}</option>
            {/foreach}
          </select>
      </div>
          <label class="col-md-2 control-label" for="lastServiced">Last Serviced</label>
          <div class="col-md-4">
          <input id="lastServiced" name="lastServiced" type="date" placeholder="Date of last service" class="form-control input-md" required>
          </div>
    </div>
    <div class="row form-group">
      <div class="col-md-offset-11 col-md-1">
        <button id="addItem" name="addItem" type="submit" class="btn btn-primary btn-block">Add</button>
      </div>
    </div>
    </fieldset>
  </form>

  <div class="modal fade" id="editItemModal" tabindex="-1" role="dialog" aria-labelledby="editItemLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="editItemLabel">Edit Item</h4>
        </div>
        <div class="modal-body">
          <form method="post" id="editItemForm" class="form-horizontal">
            <fieldset>
              <input type="hidden" id="editItemID" name="editItemID" value="" />
              <div class="row form-group">
                  <label class="col-md-2 control-label" for="Item Name">Item Name</label>
                  <div class="col-md-10">
                  <input id="editItemName" name="editItemName" type="text" placeholder="Item name" class="form-control input-md" required>
                  </div>
              </div>
              <div class="row form-group">
                  <label class="col-md-2 control-label" for="location">Location</label>
                  <div class="col-md-10">
                    <select data-placeholder="Choose a location" id="editItemLocation" name="editItemLocation" class="form-control" required>
                      <option></option>
                      {foreach item=site from=$sites}
                      <optgroup label="{$site['site_name']}">
                        {foreach item=location from=$locations}
                        {if $location['site_name'] == $site['site_name']}
                        <option value="{$location['location_id']}">{$location['location_name']}</option>
                        {/if}
                        {/foreach}
                      </optgroup>
                      {/foreach}
                    </select>
                </div>
              </div>
              <div class="row form-group">
                <label class="col-md-2 control-label" for="type">Type</label>
                <div class="col-md-10">
                  <select data-placeholder="Choose a type" id="editItemType" name="editItemType" class="form-control" required>
                    <option></option>
                    {foreach item=type from=$types}
                    <option value="{$type['type_id']}">{$type['type_name']}</option>
                    {/foreach}
                  </select>
              </div>
              </div>
              <div class="row form-group">
                  <label class="col-md-2 control-label" for="interval">Interval</label>
                  <div class="col-md-10">
                    <select data-placeholder="Choose an interval" id="editItemInterval" name="editItemInterval" class="form-control" required>
                    <option></option>
                      {foreach item=interval from=$intervals}
                      <option value="{$interval['intervals_id']}">{$interval['intervals_name']}</option>
                      {/foreach}
                    </select>
                </div>
              </div>
              </fieldset>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-primary" data-dismiss="modal">Cancel</button>
          <button type="submit" id="editItem" name="editItem" form="editItemForm" class="editItemButton btn btn-danger">Edit</button>
        </div>
      </div>
    </div>
  </div>

</div>
{/block}
{block name="footerscripts"}
{literal}
<script>
  $('#editItemModal').on('show.bs.modal', function (event) {
    $(this).find('#editItemID').val($(event.relatedTarget).data('id'))
    $(this).find('#editItemName').val($(event.relatedTarget).data('name'))
    $(this).find('#editItemLocation').val($(event.relatedTarget).data('location'))
    $(this).find('#editItemType').val($(event.relatedTarget).data('type'))
    $(this).find('#editItemInterval').val($(event.relatedTarget).data('interval'))
  })
  $("#location").chosen({allow_single_deselect: true})
  $("#type").chosen({allow_single_deselect: true})
  $("#contractor").chosen({allow_single_deselect: true})
  $("#interval").chosen({allow_single_deselect: true})
  $("#deleteItem").chosen({allow_single_deselect: true})
</script>
{/literal}
{/block}
