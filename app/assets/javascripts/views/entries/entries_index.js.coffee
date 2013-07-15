class Raffler.Views.EntriesIndex extends Backbone.View

  template: JST['entries/index']

  events: ->
    'submit #new_entry': 'createEntry'
 
  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @render, this)

  render: ->
    $(@el).html(@template(entries: @collection))
    @

  createEntry: (event) ->
    event.preventDefault()
    @collection.create({name: $('#new_entry_name').val()})
