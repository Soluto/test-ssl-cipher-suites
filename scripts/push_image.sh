docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD 
docker tag local/test-ssl-cipher-suites soluto/test-ssl-cipher-suites:$TRAVIS_BUILD_NUMBER
docker push soluto/test-ssl-cipher-suites:$TRAVIS_BUILD_NUMBER 
docker tag local/test-ssl-cipher-suites soluto/test-ssl-cipher-suites:latest
docker push soluto/test-ssl-cipher-suites:latest 
docker logout 