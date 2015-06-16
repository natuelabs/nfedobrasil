# Add P12 support for savon
# Inspiration: https://gist.github.com/phaus/3313756
module Savon
  class GlobalOptions
    def ssl_plcs_file(ssl_plcs_file)
      @options[:ssl_plcs_file] = ssl_plcs_file
    end

    def ssl_plcs_password(ssl_plcs_password)
      @options[:ssl_plcs_password] = ssl_plcs_password
    end
  end

  class HTTPRequest
    def configure_ssl
      @http_request.auth.ssl.ssl_version   = @globals[:ssl_version]       if @globals.include? :ssl_version
      @http_request.auth.ssl.verify_mode   = @globals[:ssl_verify_mode]   if @globals.include? :ssl_verify_mode

      @http_request.auth.ssl.cert_key_file = @globals[:ssl_cert_key_file] if @globals.include? :ssl_cert_key_file
      @http_request.auth.ssl.cert_key      = @globals[:ssl_cert_key]      if @globals.include? :ssl_cert_key
      @http_request.auth.ssl.cert_file     = @globals[:ssl_cert_file]     if @globals.include? :ssl_cert_file
      @http_request.auth.ssl.cert          = @globals[:ssl_cert]          if @globals.include? :ssl_cert
      @http_request.auth.ssl.ca_cert_file  = @globals[:ssl_ca_cert_file]  if @globals.include? :ssl_ca_cert_file
      @http_request.auth.ssl.ca_cert       = @globals[:ssl_ca_cert]       if @globals.include? :ssl_ca_cert

      @http_request.auth.ssl.cert_key_password = @globals[:ssl_cert_key_password] if @globals.include? :ssl_cert_key_password

      if (@globals.include?(:ssl_plcs_file) and @globals.include?(:ssl_plcs_password))
        @http_request.auth.ssl.plcs_file @globals[:ssl_plcs_file], @globals[:ssl_plcs_password]
      end
    end
  end
end

module HTTPI
  module Auth
    class SSL
      def plcs_file(file, password)
        @pkcs12 = OpenSSL::PKCS12.new(File.read(file), password)
      end

      def cert
        if @pkcs12
          @cert ||= @pkcs12.certificate
        else
          @cert ||= (OpenSSL::X509::Certificate.new File.read(cert_file) if cert_file)
        end
      end

      def cert_key
        if @pkcs12
          @cert_key ||= @pkcs12.key
        else
          @cert_key ||= (OpenSSL::PKey.read(File.read(cert_key_file), cert_key_password) if cert_key_file)
        end
      end
    end
  end
end
