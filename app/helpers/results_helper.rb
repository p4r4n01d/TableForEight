module ResultsHelper

  # Button to vote for a restaurant or time
  # value: The numeric value associated with this button
  # i: The number of this button in sequence
  # type: What this button is for 
  def results_voteButton(value, i, type)
    
    templating = ""
    spanClass = nil
    case value
      when -1
        title = "No"
        spanClass = "down"
        templating = "notgoing"
        id = "no"
      when 0
        title = "Not sure"
        templating = "maybe"
        id ="maybe"
        spanClass = "up"
      when 1
        title = "Yes"
        spanClass = "up"
        templating = "going"
        id = "yes"
      end

    str = "<button type=\"button\" id=\"#{type}btn#{id}#{i}\" data-container=\"body\""
    str += " data-toggle=\"popover\" data-trigger=\"hover\" data-placement=\"bottom\""

    str += " class=\"btn btn-default btn-sm\" data-content=\"None\" data-original-title=\"#{title}:\">\n"

    str += "{{ #{type}#{i}#{templating} }}\n"

    if !!spanClass
      str += "<span class=\"glyphicon glyphicon-thumbs-#{spanClass}\"></span>\n"
    end
    raw(str + "</button>")
  end
  
  def prettyPrintDate(date)
    date.strftime("%I:%M %p on %a, %d %b %Y")
  end
end
