window.SiteFull ||= {}
window.SiteFull.Deployments ||= {}
window.SiteFull.Deployments.Status ||= {}

class SiteFull.Deployments.Status
  @dispatcher = null
  @channel = null
  @deployment_id

  constructor: (options = {}) ->
    host = options.host || 'localhost'
    port = options.port || '3001'
    channel = options.channel || 'deployments'
    @deployment_id = parseInt(options.deployment_id)
    @dispatcher = new WebSocketRails("#{host}:#{port}/websocket")
    @channel = @dispatcher.subscribe channel
    @restart_button = '.restart'

  trigger: ->
    @dispatcher.trigger 'deployments.created', deployment_id: @deployment_id

  init: (trigger) ->
    @trigger() if trigger

    $(document).on 'click', @restart_button, (e) =>
      e.preventDefault()
      e.stopPropagation()
      $('#deployment-information')
        .removeClass('running')
        .removeClass('failed')
        .removeClass('completed')
        .removeClass('instance-missing')
        .addClass('running')
        .find('.restart')
        .addClass('hidden')
      $('.status').find('pre').addClass('hidden')
      @trigger()

    @channel.bind 'progress', (data) =>
      if data.id == @deployment_id
        @$container ||= $('.status .panel-body')
        $element = @$container.find("##{data.key}")
        $element.removeClass('hidden')
        if $element.length == 0
          $element = $('<pre/>').prop('id', data.key)
          @$container.append $element
        $element.text(data.message)
        $element.prop('class', data.status)

    @channel.bind 'output', (data) =>
      if data.id == @deployment_id
        @next_wrap ||= true
        $container = $('.script-output')
        $container.show() unless $container.is(':visible')

        if /\r\n$/.exec(data.message)
          $('.panel-body', $container).append($('<pre/>').html(data.message))
        else
          wrapper = $('.panel-body pre:last-child', $container)
          if wrapper.length > 0
            last.html(data.message)
          else
            $('.panel-body', $container).append($('<pre/>').html(data.message))

        $('html, body').animate({
          scrollTop: $('.panel-body pre:last-child', $container).offset().top
        }, 100)

    @channel.bind 'status', (data) =>
      if data.id == @deployment_id
        @$deployment_container ||= $('#deployment-information')
        @$deployment_container
          .removeClass('running')
          .removeClass('failed')
          .removeClass('completed')
          .removeClass('instance-missing')
          .addClass(data.status)
        if data.status == 'completed' || data.status == 'running'
          $(@restart_button).addClass('hidden')
        else
          $(@restart_button).removeClass('hidden')

