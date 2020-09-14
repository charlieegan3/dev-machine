#!/usr/bin/env ruby

require "json"

count = JSON.parse(`./hcloud server list -o json`).size

fail "unexpected instance running" if count > 0
