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
    @network = "mydeveloper"
    
    
    email = "test@example.com"
    password = "I<3Ning"
    
    self.login(email, password)
    
  end
  
  def login(login, password)
    self.call("Token", method="Post",headers={
         :Authorization => 'Basic %s'# %
        #  binascii.b2a_base64('%s:%s' % (login, password)),
       }, secure=true)
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
        #headers={
        # :Authorization => 'Basic ' + us
        #}
        #  binascii.b2a_base64('%s:%s' % (login, password)),
        #@consumer=OAuth::Consumer.new( 
        #    #"maaq@gmx.de",
        #    #"summsumm",{
        #    "0d7fc228-3365-4b89-94aa-b23ba30a8cef",
        #    "64005976-973c-4725-92ec-b5493cd8ab9a", {
        #  :schema=>headers,
        #  :site=>url1,
        #  :request_token_path=> url2
        #})
        
        #logger.info(@consumer.key)
        #logger.info(@consumer.secret)
        #logger.info(@consumer.request_token_path)

        #@request_token=@consumer.get_request_token

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
