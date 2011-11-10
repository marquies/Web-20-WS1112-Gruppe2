class WelcomeController < ApplicationController
  def index
    @users = Ning.new('testkey').users
  end

end
