# adv_on_shoes.rb
require 'adv_game.rb'
require 'creature.rb'

player = Actor.new "Loogink", "Ruby Lover Creature", 0
imp = Implementer.new player

Shoes.app :width => 420, :height => 550, :title => 'Adventure Game v0.4' do
  @pos = [50, 50],  [150, 50],  [250, 50],  [350, 50],
         [50, 150], [150, 150], [250, 150], [350, 150],
                    [250, 250]            , [350, 250]
  
  fill gold.to_s..coral.to_s
  rect :width => 400, :height => 300, :left => 10, :top => 10, :curve => 10
  stroke white
  strokewidth 4
  
  rects = @pos.collect{|x, y| rect x, y, 30, 30, :curve => 15, :fill => green}
  [0, 8].each{|n| rects[n].style :fill => red; rects[n].style :curve  => 5}
  @star = star 365, 265, 5, 10.0, 5.0, :fill => gold, :stroke => gold
  
  x, y = @pos[player.position]
  @avatar = creature '../imgs/loogink.png', x, y

  s =<<-EOS
You must travel through the old mine (from The Entrance to The Exit). \
You may issue the command n to move to the north. \
You may likewise move in other directions by issuing the commands \
e (east ) or s (south) or w (west). \
You may also issue the command l to look at your current location. \
And g to get the Treasure Star.
The commands are not case sensitive. \
These are the only commands that the program will accept. \
The game ends after you get the Treasure Star \
and find your way to The Exit and issue the l command there.
EOS

  @msg = para s, :left => 0, :top => 320, :width => 420
  
  keypress do |k|
    case k
      when 'n', 'e', 's', 'w'
        @msg.text = imp.move_actor_to(player, k.to_sym) + "\n" + imp.look_at(player)
        @avatar.glide(@pos[player.position], :line => true) unless @avatar.playing?
      when 'l'
        @msg.text = imp.look_at player
        if @msg.text =~ /The Exit/ and !@star
          alert 'You have won the game! What an accomplishment!'
          exit
        elsif  @msg.text =~ /The Exit/ and @star
          @msg.text = 'Oops, you need to get a tresure star...'
        end
      when 'g'
        @msg.text = imp.look_at player
        if @msg.text =~ /Treasure Room/ and @star
          @avatar.add_star
          @star.remove
          @star = false
          @msg.text = 'You have gotten the treasure star!'
        else
          @msg.text = 'There is not the treasure star in this room.'
        end
      else
        @msg.text = 'I do not understand that command.'
    end
  end
end
