class ApiCaller
  attr_reader :data
  def initialize(zip)
    url = "http://api.openweathermap.org/data/2.5/weather?units=imperial&zip=#{zip},us"
    @data = JSON.parse(open(url).read)
  end
end
