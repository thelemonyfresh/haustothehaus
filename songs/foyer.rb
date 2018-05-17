run_file "/Users/daniel/recording/haustothehaus/toolbox.rb"
haus_samps = "/Users/daniel/recording/samples/haus/"

use_bpm 115

# SOUNDS
define :switch do
  sample haus_samps, "lightswitch",
    start: 0.182,
    finish: 0.5,
    rate: 1.05,
    decay: 0.25
end

define :hh do
  sample :drum_cymbal_closed
end

define :bd do
  sample :bd_haus
end

define :door do |hsh|
  sample haus_samps, "door", hsh
end

# PARTS

live_loop :main do
  switcher(1)
  sleep 8
end


define :switcher do |bars|
  in_thread do
    bars.times do
      puts get[:knob1]
      door({rate: get[:knob1],
            amp: get[:knob2]
            })
      use_synth :fm
      play :D2, decay: 3, attack: 0.1, attack_level: 1.5, amp: 0.75
      switch
      pp(16,[
           [:hh,range(1.5,17,1)],
           [:bd,[1]]
      ])
    end
  end
end
