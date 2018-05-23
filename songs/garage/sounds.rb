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

define :big_horn do # possibly remove?
  with_fx :echo, phase: 2, decay: 3 do
    sample haus_samps, "brown_horns_2", beat_stretch: 4
  end
end

define :horny_bass do |note, len|
  use_synth :dpulse
  pw = 0.25
  s = play note, attack: 0.05, attack_level: 1, decay: 0.195*len, sustain: (0.2), sustain_level: 0.75, release: 0.3*len,
           pulse_width: pw, pulse_width_slide: 1*len,
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

define :creaky_door do

end

define :haus_keys do

end

define :windward do

end