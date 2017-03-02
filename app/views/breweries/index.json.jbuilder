
json.array!(@breweries) do |brewery|
  json.extract! brewery, :id, :name
  json.year do
    json.name brewery.year
  end

  json.beerscount do
    json.beerscount brewery.beers.count
  end

  json.retired do
    json.retired @active_breweries.include? brewery
  end


end