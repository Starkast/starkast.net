# attribute getter
def get_attr(attribute, event)
  #  - name: "Arvika"
  #  - full_name: "Arvikafestivalen"
  #  - year: 2010
  #  - sets: [72157624561205186]
  #  - date: 20100728
  if attribute == "id"
    return event[0]
  else
    attributes = { "name" => 0, "full_name" => 1, "year" => 2, "sets" => 3, "date" => 4 }
    index = attributes[attribute]
    return event[1][index][attribute]
  end
end

def get_short_title(event)
  name = get_attr("name", event)
  year = get_attr("year", event)
  "#{name} #{year}"
end

def get_full_title(event)
  name = get_attr("full_name", event)
  year = get_attr("year", event)
  "#{name} #{year}"
end


#event = ["arvika2010", [{"name"=>"Arvika"}, {"full_name"=>"Arvikafestivalen"}, {"year"=>2010}, {"sets"=>[72157624561205186]}, {"date"=>20100728}]]
#p get_attr("sets", event)
