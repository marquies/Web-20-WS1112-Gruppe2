class WelcomeController < ApplicationController
  def index
    #ning = Ning.new('foo')
    @users = Ning.new('testkey').users
    

    respond_to do |format|
      format.html
      format.xml { render :xml => @users.to_xml }
      format.json { render :json => @users.to_json }
    end
  end

end
