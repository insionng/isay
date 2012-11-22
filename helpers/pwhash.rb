#coding: utf-8
require 'digest/md5'
require 'openssl'

module Pwhash
  #生成指定长度随机大小写英文数字混合字符串
  def self.rand_str(len)
    rand_indxes = (0...len).collect{|i| rand(62)}
    [*(0..9),*('a'..'z'),*('A'..'z')].values_at(*rand_indxes).join
  end

  #加密密码
  def self.encrypt(password,salt=nil)
    if salt==nil
        salt=self.rand_str(8)
    end

    result = password.encode('UTF-8')

    10.times do
        result =Digest::MD5.hexdigest(OpenSSL::HMAC.hexdigest('sha256',result,salt))
    end
    salt + result
  end

  #验证密码
  def self.validate(hashed,input_password)
    hashed == self.encrypt(input_password, salt=hashed[0,8])
  end
end
#hashed=Pwhash.encrypt('密码是支持中文的！')
#puts hashed
#puts Pwhash.validate(hashed, '密码是支持中文的！')
