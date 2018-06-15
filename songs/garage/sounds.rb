haus_samps = "/Users/daniel/recording/samples/haus/"

define :gravel_bd do
  use_synth :beep
  nt = note(:C1)
  sample :bd_haus, amp: 0.8

  play nt, amp: 0.6,
       attack: 0.1, attack_level: 1.2,
       decay: 0.25,
       sustain: 0.07,
       release: 0.2

  play :G1, amp: 0.4,
       attack: 0.1, attack_level: 1.2,
       decay: 0.25,
       sustain: 0.1,
       release: 0.1

  in_thread do
    osc "/logo/big-show"
    sleep 0.5
    osc "/logo/big-hide"
    sleep 0.5
  end
end

define :garage_door do
  sample haus_samps, "garage_door"
end

define :garage_door_opts do |hsh|
  sample haus_samps, "garage_door", hsh
end

define :car do
  sample haus_samps, "car"
end

define :car_door_close do
  #takes 8 beats, door close on 5

  sample haus_samps, "car",
         start: 0.10795, finish: 0.16945
end

define :big_horn do
  with_fx :echo, phase: 2, decay: 3, mix: 0.25 do
    sample haus_samps, "brown_horns_2", attack: 1, beat_stretch: 4
  end
end

define :horny_bass do |note, len|
  use_synth :fm
  pw = 0.25
  s = play note, attack: 0.1*(1.0/len), attack_level: 1, decay: 0.195*len, sustain: 0.1, sustain_level: 0.75, release: 0.3*len,
           divisor: 1.501, depth: 2,
           #pulse_width: pw, pulse_width_slide: 1*len,
           cutoff: 115, cutoff_slide: 2
  control s, cutoff: 95
end

define :animal_house do
  with_fx :gverb, damp: 0.98, pre_damp: 1, room: 9 do
    sample haus_samps, "house_stonemason",
           start: 0.0236, finish: 0.9449, attack: 0.2205, decay: 0.5354, beat_stretch: 4, amp: 0.5,
           cutoff: 100
  end
end

define :keys do
  sample haus_samps, "keyring", beat_stretch: 8
end

define :haus_keys do
  sample haus_samps, "keyring", onset: tick(:os)
  in_thread do
    osc "/logo/little-show"
    sleep 0.25
    osc "/logo/little-hide"
    sleep 0.75
  end
end

define :windward do

end

#drop down to just creaky door and keys
define :creaky_door do

end