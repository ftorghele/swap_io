class Hash
  require 'digest/sha1'

  def self.create_token(str)
    return if str.nil?
    time = Time.now.asctime
    token = str+"||"+time
    Digest::SHA1.hexdigest(token)
  end
end
