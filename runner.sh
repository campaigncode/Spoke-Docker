#!/bin/bash

node ./build/server/server &
npm run prod-job-handler &
npm run prod-message-sender-01 &
npm run prod-message-sender-234 &
npm run prod-message-sender-56 &
npm run prod-message-sender-789 &
npm run prod-incoming-message-handler &

wait -n