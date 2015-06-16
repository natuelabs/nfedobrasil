require 'savon'
require_relative 'nfedobrasil/monkey_patches'
require_relative 'nfedobrasil/version'

module NfedoBrasil
  def self.client(config = {}, dev_mode = false)
    config = {
      wsdl: (dev_mode ?
        'https://dev.sistema.nfeplace.com.br/services/emissor?wsdl' :
        'https://sistema.nfeplace.com.br/services/emissor?wsdl'),
      ssl_verify_mode: :none
    }.merge config

    Savon.client config
  end
end
