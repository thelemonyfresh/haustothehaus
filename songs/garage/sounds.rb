haus_samps = "/Users/daniel/recording/samples/haus/"

define :gravel_bd do
  use_synth :beep
  nt = note(:C1)
  sample :bd_haus, amp: 0.8
 # # play nt + 7, amp: 0.75,
 #       attack: 0.01,
 #       decay: 0.1,
 #       sustain: 0.1,
 #       release: 0.2

 # play nt - 3, amp: 1,
       # attack: 0.025,
       # decay: 0.2

  play nt, amp: 0.6,
       attack: 0.1, attack_level: 1.2,
       decay: 0.25,
       sustain: 0.07,
       release: 0.2

 # play nt+5, amp: 0.5,
       # attack: 0.005, attack_level: 0.7,
       # sustain: 0.15, release: 0.15
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
         start: 0.1079, finish: 0.16945
end

define :bass_horn do
  bass_horn_opts({})
end

define :bass_horn_opts do |hsh|
#  with_fx :lpf, cutoff: 110 do
   with_fx :gverb, damp: 0.95, pre_damp: 0.9, room: 9, dry: 0.5 do
      sample haus_samps, "brown_horns", hsh, amp: 0.8, rate: 0.2#, beat_stretch: 16
   end
 # end
end

define :big_horn do
  sample haus_samps, "brown_horns_2", beat_stretch: 4
end

define :horny_bass do |len|

  play n,
       attack: 0.05, attack_level: 1,
       decay: 0.195*len,
       sustain: (0.2), sustain_level: 0.75,
       release: 0.3*len,
       pulse_width: pw
end

define :animal_house do
  with_fx :gverb, damp: 0.98, pre_damp: 1, room: 9 do
    sample haus_samps, "house_stonemason",
           start: 0.0236, finish: 0.9449, attack: 0.2205, decay: 0.5354, beat_stretch: 4, amp: 0.5,
           cutoff: 100
  end
end