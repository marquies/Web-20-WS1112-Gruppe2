class Ning
  
  attr_accessor :host, :network, :consumer, :client
  
  def initialize(apikey)
    # connect to NING API
    @consumer=OAuth::Consumer.new( "0d7fc228-3365-4b89-94aa-b23ba30a8cef","64005976-973c-4725-92ec-b5493cd8ab9a
", {
        :site=>"external.ningapis.com"
    })
    
    @host = "external.ningapis.com"
    @network = "foo"
    
    
    email = "test@example.com"
    password = "I<3Ning"
    
    self.login(email, password)
    
  end
  
  def login(login, password)
    self.call("Token", method="Post",headers={
         #'Authorization': 'Basic %s' %
        #  binascii.b2a_base64('%s:%s' % (login, password)),
       }, secure=true)
  end
  
  def call(url, method="GET", body='', token=nil, headers=nil,
        secure=false)
        ###
        ### Code copied from Ning Python API, try to port to ruby
        ###
        
        
        #if self.method.name == 'PLAINTEXT':
        #    secure = true
        #end
        #if secure:
        #    protocol = self.SECURE_PROTOCOL
        #else:
        #    protocol = self.INSECURE_PROTOCOL

        #url = '%s%s/xn/rest/%s/1.0/%s' % (protocol, self.host, self.network, url)
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
