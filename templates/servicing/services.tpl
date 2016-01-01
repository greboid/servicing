{extends file="_base.tpl"}
{block name=contents}
<div class="container">
  <div class="row">
      <div class="col-md-12">
        <ul class="nav nav-tabs">
          {foreach name=sites from=$sites key=siteID item=siteData}
          <li {if $smarty.foreach.sites.first}class="active"{/if} ><a data-toggle="tab" href="#site-{$siteID}">{$siteData['name']}</a></li>
          {/foreach}
        </ul>
        <div id="site-tabs" class="tab-content">
          {foreach name=sites from=$sites key=siteID item=siteData}
          <div id="site-{$siteID}" class=" tab-pane fade in row {if $smarty.foreach.sites.first}active{/if}">
            <div class="col-md-12">
              <table class='table table-striped table-hover table-bordered'>
                <thead>
                  <tr>
                    <th>Item</th>
                    <th>Location</th>
                    <th>Type</th>
                    <th>Contractor</th>
                    <th>Interval</th>
                    <th>Last Serviced</th>
                    <th>Next Due</th>
                    <th>Contact Ends</th>
                    <th>Actions</th>
                  </tr>
                </thead>
                {foreach name=siteData from=$siteData['data'] key=key item=value}
                  <tr>
                    <td>{$value['item_name']}</td>
                    <td>{$value['location']}</td>
                    <td>{$value['item_type']}</td>
                    <td><a class="contractorLink" data-phone="{$value['contractorPhone']}" data-name="{$value['contractorName']}" data-notes="{$value['contractNotes']}" href="#">{$value['contractorName']}</a></td>
                    <td>{$value['intervalName']}</td>
                    <td class="{if $value['lastService'] == '1970-01-01'}danger{else}info{/if}">

                        {$value['lastService']|date_format:"%d/%m/%y"}
                      </a>
                    </td>
                    <td class="{if $value['daysUntilService'] <= 0}danger{elseif $value['daysUntilService'] <= 60 }warning{else}success{/if}">{$value['nextService']|date_format:"%d/%m/%y"}</td>
                    <td class="{if $value['contractLeft'] <= 0}danger{elseif $value['contractLeft'] <= 60 }warning{else}success{/if}">{$value['contractEnd']}</td>
                    <td>
                      <button class="btn btn-success btn-sm" data-toggle="modal" data-target="#updateServiceModal" data-id="{$value['ID']}" data-lastService="{$value['lastService']}">Add service</button>
                      <button class="btn btn-primary btn-sm" data-toggle="modal" data-target="#viewServiceModal" data-id="{$value['ID']}" data-history="{$value['service_history']}">Service History</button>
                    </td>
                  </tr>
                {/foreach}
              </table>
            </div>
          </div>
          {/foreach}
        </div>
  	</div>
  </div>
  <div class="modal" id="updateServiceModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">Update Service Date</h4>
        </div>
        <div class="modal-body">
          <form method="post" id="updateServiceForm" class="form-horizontal" role="form">
            <input type="hidden" id="newServiceID" name="newServiceID" value="">
            <div class="row form-group">
                <label class="col-md-3 control-label" for="Item Name">New Service Date</label>
                <div class="col-md-9">
                <input id="newServiceDate" name="newServiceDate" type="date" placeholder="New service Date" class="form-control input-md" required>
                </div>
            </div>
            <div class="row form-group">
                <label class="col-md-3 control-label" for="Item Name">Service Notes</label>
                <div class="col-md-9">
                <textarea rows="10" id="newServiceNotes" name="newServiceNotes" type="text" placeholder="Enter notes about service" class="form-control input-md"></textarea>
                </div>
            </div>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <button form="updateServiceForm" type="submit" class="btn btn-primary">Update</button>
        </div>
      </div>
    </div>
  </div>
  <div class="modal" id="viewServiceModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">Service History</h4>
        </div>
        <div class="modal-body">
          <pre id="serviceHistory"></pre>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
</div>
{/block}
{block name="footerscripts"}
{literal}
<script>
  $('#viewServiceModal').on('show.bs.modal', function (event) {
    $(this).find('#serviceHistory').text($(event.relatedTarget).data('history'))
  })
  $('#updateServiceModal').on('show.bs.modal', function (event) {
    $(this).find('#newServiceID').val($(event.relatedTarget).data('id'))
    $(this).find('#newServiceDate').val('')
  })
  $('.contractorLink').click(function () {
    swal({
    title: "Contractor: " + $(this).data('name'),
    text: "Number: " + $(this).data('phone') + "<br/>" + "Notes: " + $(this).data('notes'),
    html: true,
    animation: false
  })
  })
</script>
{/literal}
{/block}
