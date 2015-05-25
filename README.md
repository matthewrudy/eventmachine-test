# eventmachine-test

## Start the Sleep server

    ruby sleep.rb

## Start the Real server

    ruby server.rb

## Benchmark it

    ab -n 100 -c 10 "http://0.0.0.0:4567/faraday"

    Concurrency Level:      10
    Time taken for tests:   10.251 seconds
    Complete requests:      100

    ab -n 100 -c 10 "http://0.0.0.0:4567/net_http"

    Concurrency Level:      10
    Time taken for tests:   10.165 seconds
    Complete requests:      100

## Todo

Compare em-synchrony
