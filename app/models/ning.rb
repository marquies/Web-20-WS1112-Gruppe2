class Ning
  
  def initialize(apikey)
    # connect to NING API

    @baseUrl = "https://external.ningapis.com/xn/rest/mydeveloper/1.0/"
    #@baseUrl = "http://localhost:81/xn/rest/mydeveloper/1.0/"
    
    email = "maaq@gmx.de"
    password = "summsumm"
    
    self.login(email, password)
    #data = self.call2("Photo/recent?xn_pretty=true&fields=image.url,title&count=2")
    #Rails.logger.info(data)
  end
  
  def login(login, password)
    data = `curl -u #{login}:#{password} -d 'oauth_signature_method=PLAINTEXT&oauth_consumer_key=0d7fc228-3365-4b89-94aa-b23ba30a8cef&oauth_signature=64005976-973c-4725-92ec-b5493cd8ab9a%26'     'https://external.ningapis.com/xn/rest/mydeveloper/1.0/Token?xn_pretty=true'`
    Rails.logger.debug("**" + data)
    result = JSON.parse(data)
    
    @oauthToken = result["entry"]["oauthToken"]
    @oauthTokenSecret = result["entry"]["oauthTokenSecret"]
    @oauthConsumerKey = result["entry"]["oauthConsumerKey"]
    Rails.logger.debug("**Token: " + @oauthToken)
    
  end
  
  def call2(url)
    sig = self.buildSignature
    data = `curl -H 'Authorization: OAuth oauth_signature_method="PLAINTEXT",oauth_consumer_key="#{@oauthConsumerKey}",oauth_token="#{@oauthToken}",oauth_signature="#{sig}"' \
    '#{@baseUrl}#{url}'`
    return data
  end
  
  def buildSignature()
    sig = "64005976-973c-4725-92ec-b5493cd8ab9a&" + @oauthTokenSecret
    return sig
  end
  
  def users
    # sample data
    # FIXME: pull data from NING api
    #return [{:name => 'Robert', :location => 'Berlin'},
    #	   {:name => 'Christoph', :location => 'Hamburg'},
    #	   {:name => 'Mustafa', :location => 'Hamburg'},
    #	   {:name => 'Patrick', :location => 'Frankfurt'}]
    
    data = self.call2("User/alpha?xn_pretty=true&fields=author,fullName,location,iconUrl")
    Rails.logger.debug(data)
    result = JSON.parse(data)
    Rails.logger.info("*** Entry " +  result["entry"].to_s)
    return result["entry"]

  end
end
