haus_samps = "/Users/daniel/recording/haus_samples/"

define :lightswitch do |length|
  sample haus_samps, "lightswitch", start: 0.202-(0.02*length), finish: 0.2+(0.3*length), rate: 1.05, decay: 0.25
end

define :leaky_door do # try breaking it down with the bitrate effect
  with_fx :compressor, amp: 1.5 do
    sample haus_samps, "leaky_door.aif", beat_stretch: 16, attack: 0.25, decay: 3.75, sustain: 11.75, decay: 0.25
  end
end

define :mat_bd do
  sc = scale(:D1, :major_pentatonic)
  sample :bd_haus, amp: 0.6
  use_synth :beep
  use_synth :beep
  play sc[0], amp: 0.3,
       attack: 0.1, attack_level: 1.2,
       decay: 0.3,
       sustain: 0.07,
       release: 0.3

  use_synth :fm
  play sc[2], amp: 0.5,
       attack: 0.25, attack_level: 0.75,
       decay: 0.1,
       sustain: 0,
       release: 0.1
  in_thread do
    color '.big-haus', 0.25, 'sonic_blue'
    sleep 0.75
    color '.big-haus', 0.75, 'haus_yellow'
  end
end

define :bells do
  sample haus_samps, 'bells.aif', beat_stretch: 32
end