class Ning< ActionController::Base
  
  attr_accessor :host, :network, :consumer, :client
  
  #def host
  #  @host
  #end
  #
  #def network
  #  @network
  #end
  
  
  def initialize(apikey)
    # connect to NING API
    
    
    @host = "external.ningapis.com"
    #@host = "localhost:81"
    @network = "mydeveloper"
    @baseUrl = "https://external.ningapis.com/xn/rest/mydeveloper/1.0/"
    #@baseUrl = "http://localhost:81/xn/rest/mydeveloper/1.0/"
    
    email = "maaq@gmx.de"
    password = "summsumm"
    
    self.login(email, password)
    data = self.call2("Photo/recent?xn_pretty=true&fields=image.url,title&count=2")
    Rails.logger.info(data)
    data = self.call2("User/recent?xn_pretty=true&fields=author")
    Rails.logger.info(data)
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
    Rails.logger.info("######" + sig)
    data = `curl -H 'Authorization: OAuth oauth_signature_method="PLAINTEXT",oauth_consumer_key="#{@oauthConsumerKey}",oauth_token="#{@oauthToken}",oauth_signature="#{sig}"' \
    '#{@baseUrl}#{url}'`
    return data
    
    
    
  end
  
  def buildSignature()
    sig = "64005976-973c-4725-92ec-b5493cd8ab9a&" + @oauthTokenSecret
    return sig
  end
  
  def call(url, method="GET", body='', token=nil, headers=nil, secure=false)
        ###
        ### Code copied from Ning Python API, try to port to ruby
        ###
        
        
        #if method.name == 'PLAINTEXT':
        #    secure = true
        #end
        #if secure:
            #protocol = self.SECURE_PROTOCOL
            protocol = "https://"
        #else:
        #    protocol = self.INSECURE_PROTOCOL

        #url = '%s%s/xn/rest/%s/1.0/%s' % (protocol, self.host, self.network, url)
        url1 = protocol + @host
        url2 =  "/xn/rest/" + @network + "/1.0/" + url
        logger.info("####***" + url1)
        logger.info("####***" + url2)
        us = Base64.encode64("maaq@gmx.de:summsumm")
        #pw = Base64.encode64("summsumm")
        logger.info("####***" + us)
        #logger.info("####***" + pw)
        #headers1=
        #binascii.b2a_base64('%s:%s' % (login, password)),
        #@consumer=OAuth::Consumer.new( 
        @consumer=OAuth::Consumer.new( 
            "0d7fc228-3365-4b89-94aa-b23ba30a8cef",
            "64005976-973c-4725-92ec-b5493cd8ab9a", {
          :site=>url1,
          :request_token_path=> url2
        })
        
        #logger.info(@consumer.key)
        #logger.info(@consumer.secret)
        #logger.info(@consumer.request_token_path)

        #@request_token=@consumer.get_request_token({
        # "Authorization" => 'Basic ' + us,
        # #:signature_method => "PLAINTEXT",
        # #'signature_method' => "PLAINTEXT",
        # 'oauth_callback' => 'Muh!'})
        
        # make the access token from your consumer
        #access_token = OAuth::AccessToken.new consumer

        # make a signed request!
        access_token.get(url)

        #self.client = oauth.Client(self.consumer, token)
        #if self.method is not None:
        #    self.client.set_signature_method(self.method)

        #resp, content = self.client.request(url, method, headers=headers,
        #    body=body)
        #if int(resp['status']) != 200:
        #    try:
        #        result = json.loads(content)
        #        if result:
        #            raise NingError(result['status'], result['reason'],
        #                result['code'], result['subcode'], result['trace'])
         #       else:
        #            raise NingError(int(resp['status']),
        #                "HTTP response %s and %s" % (resp, content))
        #    except ValueError:
        #        raise NingError(int(resp['status']),
        #            "HTTP response %s and %s" % (resp, content))#

        #return json.loads(content)
  end
  
  def post(path, body)
    
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
