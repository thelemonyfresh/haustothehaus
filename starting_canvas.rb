# Standard Incantation
base_dir = '/Users/daniel/recording/talldan_sonicpi/'
load_snippets("#{base_dir}snippets/")
run_file "#{base_dir}xtouch_knobs.rb"
run_file "#{base_dir}samples.rb"

# osc
use_osc '10.1.10.123', 7400

# ############## #

# haustothehaus

haus_dir = '/Users/daniel/recording/haustothehaus/'
haus_samps = '/Users/daniel/recording/haus_samples'
run_file "#{haus_dir}toolbox.rb"

#
# haustothehaus
#

use_bpm 130

### Garage

# garage_door, car, entourage, car_door_close, keys
# gravel_bd, haus_keys, bassment
# thorny, bassment, windy_melody

### Foyer

# mat_bd, switcher, lights, leaky_door
# tile_bass

# #| live_loop :floor, sync: :gravel do
# #|   with_fx :level, amp: get(:knob_18_state) do
# #|     mat_bd
# #|   end
# #|   sleep 0.5
# #|   sleep 0.5
# #| end
