[![Build Status](https://travis-ci.org/Soluto/test-ssl-cipher-suites.svg?branch=master)](https://travis-ci.org/Soluto/test-ssl-cipher-suites) [![Dockerhub pulls](https://img.shields.io/docker/pulls/soluto/test-ssl-cipher-suites.svg)](https://hub.docker.com/r/soluto/test-ssl-cipher-suites)

# Test TLS Cipher Suites
A small ruby script that use [Nmap](https://nmap.org/) to test the TLS cipher suites used by a given host.
Nmap can be used to query all the cipher suites in use (see OWASP [testing guide](https://www.owasp.org/index.php/Testing_for_Weak_SSL/TLS_Ciphers,_Insufficient_Transport_Layer_Protection_(OTG-CRYPST-001)#Example_3._Checking_for_Certificate_information.2C_Weak_Ciphers_and_SSLv2_via_nmap) for TLS cipher suites), and rank them.
This script will run Nmap and process the output results - and will set the exit code to 1, if weak cipher suite (rank below A) found.
## Usage
You can run the script using the Docker image, by running:

`docker run omerl/test-ssl-cipher-suites ruby ./parse.rb hostname`.
