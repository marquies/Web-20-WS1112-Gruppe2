class WelcomeController < ApplicationController
  def index
    @users = Ning.new('testkey').users
    
    respond_to do |format|
      format.html
      format.xml { render :xml => @users.to_xml }
      format.json { render :json => @users.to_json }
    end
    
    # FlickR
    # FlickRaw.api_key = "6d75efb86626ad52325d1b9ce94499ef"
    # FlickRaw.shared_secret = "f0f3111dbecaeffd"
    # 
    # # http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=7e821c3288da47d4585889fbd53b0bca&lat=48.13913&lon=11.58019&format=rest
    # 
    # @flickr = flickr.photos.search(:lat => 48.13913, :lon => 11.58019, :per_page => 6,:page => 1)
  end

end
