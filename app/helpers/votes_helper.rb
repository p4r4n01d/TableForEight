module VotesHelper

  # Button to vote for a restaurant or time
  # value: The numeric value associated with this button
  # i: The number of this button in sequence
  # type: What this button is for 
  def voteButton(value, i, type)
    str = "<button type=\"button\" class=\"btn btn-default\" ng-click=\"vote_process(#{@events.id}, #{@votes.id}, '#{type}#{i}', #{value})\">"
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
