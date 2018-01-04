# TOOLBOX

#
# SAMPLE PLAYER
#

# usage:
#
#   pp(8,[
#      [:bass_drum, [1,1.5,3], {param_name: param_value}],
#      [:snare_drum, [2,4]],
#      [:hihat, range(1,5)]
#   ])
#
#

define :pp do |bts, insts|
  len = 0.125 # smallest increment value
  tot = (1/len)*bts
  
  # note time is CS indexing, not music
  range(0,(tot*len),len).each do |t|
    insts.each do |inst|
      # get times to play this inst: 1->0 etc.
      inst_times = inst[1].map{ |beat| ((beat-1)) }
      # play if it's an inst time
      if inst[2].nil?
        send(inst[0]) if inst_times.any?{|tim| tim == t}
      else
        send(inst[0],inst[2]) if inst_times.any?{|tim| tim == t}
      end
    end
    sleep len
  end
end

# FOR TESTING:
##| live_loop :player do
##|   p(8,[
##|       [:bass_drum,[1,1.5,3]],
##|       [:snare_drum,[2,4]],
##|       [:hihat, range(1,5)]
##|   ])
##| end

##| live_loop :test do
##|   sample :elec_blip
##|   sleep 1
##| end

##| define :bass_drum do
##|   sample :bd_haus
##| end

##| define :snare_drum do
##|   sample :drum_snare_hard
##| end

##| define :hihat do
##|   sample :drum_cymbal_soft
##| end


##| define :array_from_xtouch do |number_bts_across_keys|
##|   # get array of active lights from xtouch
##|   puts "array goes here"
##|   set :array_name, array
##|   return array
##| end