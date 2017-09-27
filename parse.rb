require 'nokogiri'
require 'fileutils'

if (ARGV.length < 1)
    puts "missing host name"
    exit -1
end

host = ARGV[0]

puts "running nmap scan"

system("nmap --script ssl-enum-ciphers -p 443 -Pn -oX output.xml #{host} > /dev/null")

if ($? != 0)
    puts "nmap failed"
    exit 1
end

nmap_result = Nokogiri::XML(File.open("output.xml")) 
puts nmap_result
if (nmap_result.xpath("//port[@protocol='tcp' and  @portid='443']/state[@state='open']").empty? )
    state = nmap_result.xpath("//port[@protocol='tcp' and  @portid='443']/state")
    puts "Host state does not indicate success: #{state}"
    exit 1
end

ciphers = nmap_result.xpath("//table[@key='ciphers']/table")

found_weak_cipher = false
found_fs_ciphers = false

ciphers.each do |cipher|
    grade = cipher.xpath("elem[@key='strength']//text()").text
    name = cipher.xpath("elem[@key='name']//text()").text
    if (grade != 'A')
        puts "found weak certificate: #{name}, garde: #{grade}"
        found_weak_cipher = true
    end

    if (name.include?('ECDHE') || name.include?("DHE"))
        found_fs_ciphers = true
    end
end

FileUtils.rm("output.xml")

#Apple ATS require at least one FS ciphers, otherwise the connections blocked
if  !found_fs_ciphers
    puts "no FS ciphers found"
    exit 1
end

if found_weak_cipher
    exit 1
end

