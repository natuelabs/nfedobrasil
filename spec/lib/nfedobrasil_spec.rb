require 'spec_helper'

describe NfedoBrasil do
  describe '#client' do
    subject { NfedoBrasil.client({ssl_plcs_file: File.dirname(__FILE__) + '/../support/certificate.p12', ssl_plcs_password: 'nughee1O'}) }

    it 'returns a Savon client' do
      expect(subject).to be_a Savon::Client
      expect(subject.globals[:wsdl]).to match(/https:\/\/sistema/)
    end

    it 'fails because cert is invalid' do
      expect{subject.operations}.to raise_error(HTTPI::SSLError)
    end
  end

  describe 'dev mode' do
    subject { NfedoBrasil.client({ssl_plcs_file: File.dirname(__FILE__) + '/../support/certificate.p12', ssl_plcs_password: 'nughee1O'}, true) }

    it 'handles dev mode properly' do
      expect(subject.globals[:wsdl]).to match(/https:\/\/dev.sistema/)
    end
  end
end
