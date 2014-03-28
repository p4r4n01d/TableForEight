module VotesHelper

  def dateButton(value, i)
    str = "<button type=\"button\" class=\"btn btn-default\" ng-click=\"vote_process(#{@events.id}, #{@votes.id}, 'date#{i}', #{value})\">"
    spanClass = nil

    case value
      when -1
        str += "No"
        spanClass = "down"
      when 0
        str += "Maybe"
      when 1
        str += "Yes"
        spanClass = "up"
      end

    if !!spanClass
      str += "<span class=\"glyphicon glyphicon-thumbs-#{spanClass}\"></span>"
    end
    raw(str + "</button>")
  end

end
