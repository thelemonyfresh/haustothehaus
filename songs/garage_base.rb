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

