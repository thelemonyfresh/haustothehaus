haus_samps = "/Users/daniel/recording/haus_samples"

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

  pulse %w(.h .a .u .s).map { |l| '.big-haus' + l }.ring.tick(:big), 0.75
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
         start: 0.1068, finish: 0.1695
  if tick(:car_door_time) < 4
    rotate '.a.little-haus', 1, 5
    at 0.9 do
      rotate '.a.little-haus', 1, -5
    end
    at 1.85 do
      rotate '.a.little-haus', 1.75, -15
    end
    at 4 do
      rotate '.a.little-haus', 0.25, 0
    end
  end

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
    s = sample haus_samps, "house_stonemason", pan: 0.25, pan_slide: 2,
           start: 0.0236, finish: 0.9449, attack: 0.2205, decay: 0.5354, beat_stretch: 4, amp: 0.5,
           cutoff: 100
    control s, pan: -0.5
  end
end

define :keys do
  sample haus_samps, "keyring", beat_stretch: 8
end

define :haus_keys do
  with_fx :tanh, mix: range(0, 1, 0.125).ramp.tick(:haus_keys_ramp) do
    with_fx :compressor, threshold: 0.9, slope_above: 1, slope_below: 0.8 do
      sample haus_samps, "keyring", onset: range(0,8,1).tick(:os)
    end
  end
  pulse '.little-haus.s', 0.25

  #flash %w(.h .a .u .s).map { |l| '.little-haus' + l }.ring.tick(:little), 0.5
  end

define :windward_at do |amt|
  #with_fx :pitch_shift, pitch: -4*12, pitch_dis: 0.01, time_dis: 0.1 do
  with_fx :whammy, transpose: -3*12 do
    sample haus_samps, 'winds', amp: amt,
           start: 0.0, finish: 0.1, beat_stretch: 640,
           attack: 8, decay: 16, sustain: 16, release: 16
  end
end

define :windward do
  windward_at(0.5)
end
