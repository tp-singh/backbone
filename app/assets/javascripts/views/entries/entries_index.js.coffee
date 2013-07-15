class Raffler.Views.EntriesIndex extends Backbone.View

  template: JST['entries/index']

  events: ->
    'submit #new_entry': 'createEntry'
    'click .delete_entry': 'destroyEntry'

  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @render, this)
    @collection.on('remove', @render, this)

  render: ->
    $(@el).html(@template(entries: @collection))
    @

  createEntry: (event) ->
    event.preventDefault()
    attributes = {name: $('#new_entry_name').val()}
    @collection.create attributes,
      wait: true
      success: ->
        $('#new_entry')[0].reset()
      error: @handleError
  
  destroyEntry: (event) ->
    event.preventDefault()
    model = @collection.get(event.target.id)
    model.destroy()

  handleError: (entry, response) ->
    if response.status = 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages
