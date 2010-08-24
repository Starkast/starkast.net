# attribute getter
def get_attr(attribute, event)
  #  - name: "Arvika"
  #  - full_name: "Arvikafestivalen"
  #  - year: 2010
  #  - sets: [72157624561205186]
  #  - date: 20100728
  #  - vimeo: [13657050]
  if attribute == "id"
    return event[0]
  else
    attributes = { "name" => 0, "full_name" => 1, "year" => 2, "sets" => 3, "date" => 4, "vimeo_album" => 5 }
    index = attributes[attribute]
    return event[1][index][attribute]
  end
end

def array_to_hash(array)
  hash = {}
  array.each do |element|
    hash.merge!(element)
  end
  return hash
end

def has_attribute(attribute, event)
  return array_to_hash(event[1]).has_key?(attribute)
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

#event = ["arvika2010", [{"name"=>"Arvika"}, {"full_name"=>"Arvikafestivalen"}, {"year"=>2010}, {"sets"=>[72157624561205186]}, {"date"=>20100715}, {"vimeo"=>[13657050]}]]
#event = ["arvika2010", [{"name"=>"Arvika"}, {"full_name"=>"Arvikafestivalen"}, {"year"=>2010}, {"sets"=>[72157624561205186]}, {"date"=>20100728}]]
#p has_attribute("vimeo", event)
#p get_attr("sets", event)
