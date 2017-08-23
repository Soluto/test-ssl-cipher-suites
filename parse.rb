require 'nokogiri'
require 'fileutils'

if (ARGV.length < 1)
    puts "missing host name"
    exit -1
end

host = ARGV[0]

system("nmap --script ssl-cert,ssl-enum-ciphers -p 443 -oX output.xml #{host} > /dev/null")

if ($? != 0)
    puts "nmap failed"
    exit 1
end

nmap_result = Nokogiri::XML(File.open("output.xml")) 

if (nmap_result.xpath("//port[@protocol='tcp' and  @portid='443']/state[@state='open']").empty? )
    state = nmap_result.xpath("//port[@protocol='tcp' and  @portid='443']/state")
    puts "Host state does not indicate success: #{state}"
    exit 1
end

ciphers = nmap_result.xpath("//table[@key='ciphers']/table")

found_weak_certificate = false

ciphers.each do |cipher|
    grade = cipher.xpath("elem[@key='strength']//text()").text
    name = cipher.xpath("elem[@key='name']//text()").text
    if (grade != 'A')
        puts "found weak certificate: #{name}, garde: #{grade}"
        found_weak_certificate = true
    end
end

FileUtils.rm("output.xml")

if found_weak_certificate 
    exit 1
end

