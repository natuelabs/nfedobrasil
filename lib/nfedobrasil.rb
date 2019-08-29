require 'savon'
require_relative 'nfedobrasil/monkey_patches'
require_relative 'nfedobrasil/version'

module NfedoBrasil
  def self.client(config = {}, dev_mode = false)
    config = {
      wsdl: (dev_mode ?
        'https://nfeplacehl.e-datacenter.nddigital.com.br/services/tkemissor?wsdl' :
        'https://nfeplacesis.e-datacenter.nddigital.com.br/services/tkemissor?wsdl'),
      ssl_verify_mode: :none
    }.merge config

    Savon.client config
  end
end
