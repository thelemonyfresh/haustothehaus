# Standard Incantations:
base_dir = "/Users/daniel/recording/talldan_sonicpi/"
run_file "#{base_dir}sample_player.rb"
run_file "#{base_dir}xtouch_knobs.rb"
run_file "/Users/daniel/recording/haustothehaus/toolbox.rb"
use_bpm 128
haus_samps = "/Users/daniel/recording/samples/haus/"

#
# Sounds
#



define :garage_door do |hsh|
  sample haus_samps, "door_garage", hsh
end

define :gravel_bd do |i|
  return if i == 0
  sample :bd_haus, lpf: 100*i
  play 25+7, amp: 0.7,
    attack: 0.5,
    decay: 0.07,
    sustain: 0.14,
    release: 0.1
  
  play 25,
    attack: 0.05,
    decay: 0.05,
    sustain: 0.07,
    release: 0.125,
    lpf: 100*i
end

define :entourage do |num_bars|
  # 1 rep len 8
  in_thread do
    with_fx :compressor, threshold: 0.5, amp: 1.5 do
      num_bars.times do
        8.times do |n|
          if n%8 == 0
            gs1 = garage_door_mod({start: 0.40, finish: 0.45, cutoff_dec: 1, rate: 0.95})
            control gs1, pan: 0.8
          end
          if n%8 == 4
            gs2 = garage_door_mod({start: 0.69, finish: 0.81, cutoff_dec: 1})
            control gs2, pan: 0.8
          end
          sleep 1
        end
      end
    end
  end
end

#
# SECTS
#

define :intro_full do
  garage_door({start: 0, finish: 1, rate: 0.9})
  sleep 32
  entourage(7)
  sample haus_samps, "car", beat_stretch: 32
  sleep 60
  with_fx :echo, phase: 1, decay: 4, amp: 1.6 do
    5.times do |n|
      door_latch({start: 0.25, finish: 1, rate: 0.3*(n+1)})
      sleep 0.5
    end
  end
  sleep 8
end

live_loop :gravel do
  gravel_bd(get(:knob_1_state))
  sleep 1
end

live_loop :intro do
  stop
  intro_full
  stop
end

live_loop  do
  
end


comment do
  garage_door_full
  sleep 16
  driveway
  walkway
  doorstep_1
  haus_bd(1)
  animal_haus
  sleep 4
  jingle_haus(1)
  4.times do
    haus_bd(1)
    sleep 1
  end
  go_away
  doorstep_2
  doorstep_fade
  doorstep_all_in
  windward(1)
  sleep 16
end

# stems



# let the grooves sink in a bit more, only a gradual change at a time, c.f. want you forever carl cox
# better use of repeating initialism of sample, end part of sample later
# off-beat melody part is more what I'm going for...



############ 2019 ##################

# Standard Incantation
base_dir = '/Users/daniel/src/talldan_sonicpi/'
load_snippets("#{base_dir}snippets/")
run_file "#{base_dir}xtouch_knobs.rb"
run_file "#{base_dir}samples.rb"


use_osc '10.232.254.197', 7400

# haustothehaus

haus_dir = '/Users/daniel/src/haustothehaus/'
haus_samps = '/Users/daniel/recording/haus_samples'
run_file "#{haus_dir}toolbox.rb"

#
# haustothehaus
#

use_bpm 130

### Garage

### INTRO ###

##| car
##| sleep 8
##| garage_door
##| sleep 8

##| entourage
##| sleep 8
##| entourage
##| car_door_close
##| sleep 8
##| 4.times do
##|   entourage
##|   car_door_close
##|   keys
##|   sleep 8
##| end

### END INTRO ###

### INTRO pt 2 ###

##| live_loop :out do
##|   with_fx :level, amp: get(:knob_1_state) do
##|     with_fx :slicer, phase: 1, probability: 1 do
##|       entourage
##|     end
##|   end

##|   with_fx :level, amp: get(:knob_2_state) do

##|     car_door_close
##|   end

##|   sleep 8
##| end

##| live_loop :gravel, sync: :out do
##|   gravel_bd
##|   sleep 0.5
##|   haus_keys
##|   sleep 0.5
##| end

##| live_loop :bass, sync: :out do
##|   with_fx :flanger do

##|     with_fx :pan, pan: -0.3 do
##|       with_fx :band_eq, freq: 63, db: -5 do
##|         with_fx :hpf, cutoff: note(:E2) do
##|           bassment_at(0.3)
##|         end

##|       end
##|     end

##|   end
##|   with_fx :pan, pan: 0.25 do
##|     with_fx :flanger, depth: 10 do
##|       jay_bassline
##|     end
##|   end


##|   sleep 16

##| end

### END INTRO pt 2 ###


### MAIN GROOVE ###


##| live_loop :groove_out, sync: :garage_groove do
##|   stop unless get(:garage_groove_playing)
  
##|   with_fx :level, amp: get(:knob_1_state) do
##|     with_fx :slicer, phase: 0.5, probability: 0.25 do
##|       entourage
##|     end
##|   end
  
##|   with_fx :level, amp: get(:knob_2_state) do
    
##|     car_door_close
##|   end
  
##|   sleep 8
##| end

##| live_loop :groove_gravel, sync: :groove_out do
##|   stop unless get(:garage_groove_playing)
  
##|   gravel_bd
##|   sleep 0.5
##|   #haus_keys if one_in 4
##|   sleep 0.5
##| end

##| live_loop :groove_bass, sync: :groove_out do
##|   stop unless get(:garage_groove_playing)
  
##|   with_fx :flanger do
    
##|     with_fx :pan, pan: -0.3 do
##|       with_fx :band_eq, freq: 63, db: -5 do
##|         with_fx :hpf, cutoff: note(:E2) do
##|           bassment_at(0.9)
##|         end
        
##|       end
##|     end
    
##|   end
##|   with_fx :pan, pan: 0.25 do
##|     with_fx :flanger, depth: 10 do
##|       #jay_bassline
##|     end
##|   end
  
##|   #thorny
  
  
##|   sleep 16
  
##| end


### END MAIN GROOVE ###


##| live_loop :out do
##|   with_fx :slicer, phase: 0.5, probability: 0.6  do
##|     entourage
##|   end

##|   #keys
##|   car_door_close
##|   #end

##|   #keys

##|   sleep 8
##| end

##| live_loop :gravel, sync: :out do
##|   puts scale(:E1, :minor_pentatonic)
##|   with_fx :level, amp: 0.7 do
##|     gravel_bd
##|   end
##|   sleep 0.5

##|   haus_keys
##|   sleep 0.5
##| end


##| live_loop :bass, sync: :out do
##|   with_fx :hpf, cutoff: 40, amp: 1 do
##|     jay_bassline
##|   end


##|   #bassment_at(0.3)
##|   # keep 0.4
##|   #bassment_at(0.4)

##|   thorny_at(0.3)
##|   sleep 16

##| end

#sharpen up around frequencies..


# garage_door, car_door_close, keys
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
