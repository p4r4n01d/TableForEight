`var win = typeof(window) === 'undefined' ? {} : window`
`var mod = typeof(module) === 'undefined' ? {} : module`
win.tableforeight = win.tableforeight || {}

win.angular.module('apis', ['ngResource'])

  .factory 'Events', ($resource) ->
    Events = $resource '/api/events',
      index: { method: 'GET', isArray: true },
      create: { method: 'POST' }

  .factory 'Event', ($resource) ->
    Event = $resource '/api/events/:event_id', { event_id: '@id' },
      new: { method: 'GET' },
      show: { method: 'GET' },
      update: { method: 'PUT' },
      destroy: { method: 'DELETE' }

  .factory 'Votes', ($resource) ->
			class Votes
				constructor: (events_id) ->
					@service = $resource '/api/events/:event_list_id/votes', {event_list_id: events_id}
				
				create: (attrs) ->
					new @service(vote: attrs).$save (vote) ->
						attrs.id = vote.id
					attrs
				
				all: ->
					@service.query()

  .factory 'Vote', ($resource) ->
    Vote = $resource '/api/votes/:vote_id', { vote_id: '@id' },
      index: { method: 'GET', isArray: true },
      new: { method: 'GET' },
      create: { method: 'POST' },
      show: { method: 'GET' },
      edit: { method: 'GET' },
      update: { method: 'PUT' },
      destroy: { method: 'DELETE' }

  .factory 'Places', ($resource) ->
    Vote = $resource '/api/places/:place_type', { place_type: '@type' },
      index: { method: 'GET', isArray: true }
