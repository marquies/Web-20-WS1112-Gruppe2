class Ning
  
  # TODO
  # Change Network to FernUni Network (Change URL and API Keys...)
  # Catch failed queries
  # Change Auth to login mask instead of hartcoded
  
  def initialize(apikey)
    # connect to NING API
    
    @baseUrl = "https://external.ningapis.com/xn/rest/fernuni/1.0/"
    @email = "rob@shadaim.de"
    @password = "bluppblupp"
    @key = "565fa2ad-02bc-4153-9a66-85793a1b015e"
    @secret = "77516875-df1e-4a72-96f9-5d2375c42f8b"
    
    self.login()
  end
  
  def login()
    curl_req = "curl -u #{@email}:#{@password} -d 'oauth_signature_method=PLAINTEXT&oauth_consumer_key=#{@key}&oauth_signature=#{@secret}%26' '#{@baseUrl}Token?xn_pretty=true'"

    Rails.logger.info(curl_req)
    data = `#{curl_req}`

    
    result = JSON.parse(data)
    @oauthToken = result["entry"]["oauthToken"]
    @oauthTokenSecret = result["entry"]["oauthTokenSecret"]
    @oauthConsumerKey = result["entry"]["oauthConsumerKey"]
  end
  
  def call2(url)
    data = `curl -H 'Authorization: OAuth oauth_signature_method="PLAINTEXT",oauth_consumer_key="#{@oauthConsumerKey}",oauth_token="#{@oauthToken}",oauth_signature="#{@secret}%26#{@oauthTokenSecret}"' \
    '#{@baseUrl}#{url}'`
    
    return data
  end
    
  def users
    data = self.call2("User/alpha?xn_pretty=true&fields=author,fullName,location,iconUrl&count=100")
    Rails.logger.debug(data)
    result = JSON.parse(data)
    Rails.logger.info("*** Entry " +  result["entry"].to_s)
    return result["entry"]
  end
end
