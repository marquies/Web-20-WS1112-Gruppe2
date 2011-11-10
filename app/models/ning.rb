class Ning
  def initialize(apikey)
    # connect to NING API
  end

  def users
    # sample data
    # FIXME: pull data from NING api
    return [{:name => 'Robert', :location => 'Berlin'},
    	   {:name => 'Christoph', :location => 'Hamburg'},
    	   {:name => 'Mustafa', :location => 'Hamburg'},
    	   {:name => 'Patrick', :location => 'Frankfurt'}]
  end
end
