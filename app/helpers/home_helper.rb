module HomeHelper

  def who_helper(labelTitle, spanClass, placeHolder, modelName)
    str = '<label class="control-label spacingAround letterSpacingFonts">' + labelTitle + "</label>\n"
    str += "<div class=\"input-group spacingAround\" id=\"#{modelName}_container\">\n"
  
    if !!spanClass
      str += "<span class=\"input-group-addon glyphicon glyphicon-#{spanClass}\"></span>\n"
    end
  
    fieldName = nil
    case modelName
      when "organiser_name"
        str += '<input type="text" '
      when "organiser_email"
        str += '<input type="email" '
      when "guest_list"
        str += '<textarea id="textarea" rows="6" cols="50" '
        fieldName = "textarea"
      end

      str += "id=\"#{modelName}\" class=\"form-control letterSpacingFonts\" placeholder=\"#{placeHolder}\" ng-model=\"#{modelName}\""

      if (!!fieldName)
        str += "></#{fieldName}>"
      else
        str += " />"
      end
      
      raw (str + "\n</div>\n")
  end

end
