#!/usr/bin/env ruby

puts "reviewing files..."
`find dotfiles -type f`.split(/\s+/).each do |file|
  canonical_name = file.sub(/^dotfiles\//, "")
  puts "  checking: #{canonical_name}"

  diff = `diff $HOME/#{canonical_name} dotfiles/#{canonical_name}`
  if diff != ""
    puts "    updating"
    `cp $HOME/#{canonical_name} dotfiles/#{canonical_name}`
  end
end

# TODO: find a means of syncing new files in vim config
