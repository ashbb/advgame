# test_snippet.rb
STDOUT.sync = true
require 'adv_game'

player = Actor.new "Loogink", "Ruby Lover Creature", 0
imp = Implementer.new player

print "> "
until (cmd = gets.chomp).empty?
  puts imp.move_actor_to(player, cmd)
  puts imp.look_at(player)
  print "\n> "
end
