# Microblog

[![Build Status](https://travis-ci.org/BenMusch/microblog.svg?branch=master)](https://travis-ci.org/BenMusch/microblog)

This is a twitter-like application developed for CS4550

GitHub: [benmusch/microblog](https://github.com/benmusch/microblog)
Website: [microblog.benmuschol.com](http://microblog.benmuschol.com)

Assignment 5 expected behavior:
 - A like/unlike button shows on the message list and view page, including the
   like count of the post
 - The button is disabled for non-logged in users
 - Ideally, there would be more security to prevent users from POSTing to the
   server to like a post with a user_id that isn't the current_user. Right now
   this is just enforced on the front-end
 - Ideally, the implementation would've shown the users that liked the post

The deploy script is in `bin/deploy`. It requires the `$SERVER_IP` and the
`$PASSWORD` env vars. It it run via Codeship every time there is a commit to
master.

NGINX/Systemd files are in /config
