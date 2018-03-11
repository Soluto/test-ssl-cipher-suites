require 'nokogiri'
require_relative '../parse.rb'
 
describe '#process_nmap_response' do
  it 'should return 0 if no weak ciphers found' do
    nmap_result = Nokogiri::XML(File.open("./spec/helpers/good_ciphers.xml")) 
    expect(process_nmap_response(nmap_result)).to eq 0
  end

  it 'should return 1 if no FS ciphers found' do
    nmap_result = Nokogiri::XML(File.open("./spec/helpers/good_ciphers_no_fs.xml")) 
    expect(process_nmap_response(nmap_result)).to eq 1
  end

  it 'should return 2 if weak ciphers found' do
    nmap_result = Nokogiri::XML(File.open("./spec/helpers/weakciphers.xml")) 
    expect(process_nmap_response(nmap_result)).to eq 2
  end

  it 'should return 3 if host is unreachable' do
    nmap_result = Nokogiri::XML(File.open("./spec/helpers/unreachable_host.xml")) 
    expect(process_nmap_response(nmap_result)).to eq 3
  end
end