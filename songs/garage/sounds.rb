haus_samps = "/Users/daniel/recording/haus_samples"



define :gravel_bd do
  #puts note(:C1)
  use_synth :beep

  with_fx :band_eq, cutoff: note(:E3), db: -10 do
    sample :bd_haus, amp: 0.75, rate: 0.85
  end

  #mp = 0.4

  ##| play :E1, amp: mp,
  ##|   attack: 0.05, attack_level: 1,
  ##|   decay: 0.2,
  ##|   sustain: 0.07,
  ##|   release: 0.2

  ##| play 33, amp: mp / 4.0,
  ##|   attack: 0.05, attack_level: 1,
  ##|   decay: 0.2,
  ##|   sustain: 0.07,
  ##|   release: 0.2

  ##| play :E2, amp: mp / 8.0,
  ##|   attack: 0.05, attack_level: 1,
  ##|   decay: 0.2,
  ##|   sustain: 0.07,
  ##|   release: 0.2

  ##| play :E1, amp: 0.4,
  ##|   attack: 0.1, attack_level: 1.2,
  ##|   decay: 0.25,
  ##|   sustain: 0.1,
  ##|   release: 0.1

  pulse %w(.h .a .u .s).map { |l| '.big-haus' + l }.ring.tick(:big), 0.75
end


define :garage_door do
  #sample haus_samps, "garage_door", beat_stretch: 32, cutoff: 115
  garage_door_opts({beat_stretch: 32})
end

define :garage_door_opts do |hsh|
  with_fx :lpf, cutoff: note(:E6) do
    with_fx :hpf, cutoff: note(:E3) do
      sample haus_samps, "garage_door", hsh
    end
  end
end


define :car do
  sample haus_samps, "car"
end

define :car_door_close do
  falling_text "car door"
  #takes 8 beats, door close on 5
  in_thread do
    with_fx :reverb, room: 0.8 , mix: 0, mix_slide: 0.25, damp: 0.9 do |fx|
      sample haus_samps, "car",
             start: 0.1068, finish: 0.1695
      sleep 4
      control fx, mix: 0.3
    end
  end

  #if tick(:car_door_time) < 4
    rotate '.a.little-haus', 1, -5
    at 0.9 do
      rotate '.a.little-haus', 1, -10
    end
    at 1.85 do
      rotate '.a.little-haus', 1.75, -15
    end
    at 4 do
      rotate '.a.little-haus', 0.25, 0
    end
  #end

end

# take these out entirely?
# define :big_horn do
#   with_fx :echo, phase: 2, decay: 3, mix: 0.25 do
#     sample haus_samps, "brown_horns_2", attack: 1, beat_stretch: 4
#   end
# end

# define :horny_bass do |note, len|
#   use_synth :fm
#   pw = 0.25
#   s = play note, attack: 0.1*(1.0/len), attack_level: 1, decay: 0.195*len, sustain: 0.1, sustain_level: 0.75, release: 0.3*len,
#            divisor: 1.501, depth: 2,
#            #pulse_width: pw, pulse_width_slide: 1*len,
#            cutoff: 115, cutoff_slide: 2
#   control s, cutoff: 95
# end

# define :animal_house do
#   with_fx :gverb, damp: 0.98, pre_damp: 1, room: 9 do
#     s = sample haus_samps, "house_stonemason", pan: 0.25, pan_slide: 2,
#                start: 0.0236, finish: 0.9449, attack: 0.2205, decay: 0.5354, beat_stretch: 4, amp: 0.3,
#                cutoff: 100
#     control s, pan: -0.5
#   end
# end

define :keys do
  falling_text "keys"
  with_fx :reverb, room: 0.1, mix: 0.4, damp: 0.6  do
    sample haus_samps, "neu_haus_keys", start: 0.087, finish: 0.44, release: 1#, beat_stretch: 4, cutoff: 120
  end
end

define :haus_keys do
  pat = range(8,16,1) + [31, 32, 33, 41, 42]
  puts pat
  sample haus_samps, "neu_haus_keys", cutoff: 115, onset: pat.tick(:hk) #range(1,9,1).tick(:os)
  pulse '.little-haus.s', 0.25

  #flash %w(.h .a .u .s).map { |l| '.little-haus' + l }.ring.tick(:little), 0.5
end

define :wind do
  in_thread do
    sample haus_samps, 'winds', amp: 0.75, beat_stretch: 640, start: 0, finish: 0.1,
           attack: 8, attack_level: 1.2, decay: 8, release: 48
  end
end

define :windward_at do |amt|
  in_thread do
    with_fx :panslicer, phase: 1, wave: 3, pan_min: -0.5, pan_max: 0.75 do
      with_fx :rbpf, centre: note(:D6), res: 0.95, res_slide: 16 do |filter|
        sample haus_samps, 'winds', amp: 0.75,
               beat_stretch: 640, start: 0, finish: 0.05
        control filter, res: 0.5
        sleep 16
        control filter, res: 0.95
      end
    end

    sleep 16
  end

end

define :windward do
  windward_at(0.5)
end

define :rain do
  sample haus_samps, 'rain', beat_stretch: 276, finish: 0.23185
end

define :rain_opts do |hsh|
  sample haus_samps, 'rain', hsh
end
