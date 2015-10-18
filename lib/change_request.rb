class ChangeRequest

  include Mention
  
  def initialize(cr_number, redis_instance)
    @name = cr_number
    @redis = redis_instance
  end

  def name
    @name
  end
  
  def synopsis
  end
  
  def filed_against
  end
  
  def priority
  end
  
  def url
    Lita.config.handlers.rational_change.base_url + CGI::escape(@name) 
  end 

end