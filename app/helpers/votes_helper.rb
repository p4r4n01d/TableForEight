module VotesHelper

  def dateButton(value)
    str = "<button type=\"button\" class=\"btn btn-default\" ng-click=\"vote_process(#{@events.id}, #{@votes.id}, 'date#{i}', #{value})")\">"
    spanclass = nil

    case value
      when -1
        str += "No"
        spanclass = "down"
      when 0
        str += "Maybe"
      when 1
        str += "Yes"
        spanclass = "up"
      end
    
    str += text
    if !!spanClass
      str += <span class="glyphicon glyphicon-thumbs-#{spanclass}"></span>
    end
    raw(str + "</button>")
  end

end
