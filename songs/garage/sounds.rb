haus_samps = "/Users/daniel/recording/haus_samples"

#
# Sounds.
#

# gravel
# 0.5

define :gravel_bd do
  use_synth :beep

  with_fx :band_eq, cutoff: note(:E3), db: -10 do
    sample :bd_haus, amp: 0.75, rate: 0.85
  end

  pulse %w(.h .a .u .s).map { |l| '.big-haus' + l }.ring.tick(:big), 0.75
end

# keys
# 4

define :keys do
  falling_text "keys", 6
  with_fx :reverb, room: 0.1, mix: 0.4, damp: 0.6  do
    sample haus_samps, "neu_haus_keys", start: 0.087, finish: 0.44, release: 1
  end
end

# haus_keys
# 0.5

define :haus_keys do
  pat = range(8,16,1) + [31, 32, 33, 41, 42]
  sample haus_samps, "neu_haus_keys", cutoff: 115, onset: pat.tick(:hk)
  pulse '.little-haus.s', 0.25
end

# garage_door
# 32

define :garage_door_opener do
  falling_text "garage door opener", 32
  garage_door_opts({beat_stretch: 32})
end

define :garage_door_opts do |hsh|
  s = nil
  with_fx :lpf, cutoff: note(:E6) do
    with_fx :hpf, cutoff: note(:E3) do
      s = sample haus_samps, "garage_door", hsh
    end
  end
  s
end

# car
# n/t

define :car do
  sample haus_samps, "car"
end

# car_door_close
# 8

define :car_door_close do
  # door close on 5
  at 4 do
    falling_text "car door", 2
  end

  in_thread do
    with_fx :reverb, room: 0.8 , mix: 0, mix_slide: 0.25, damp: 0.9 do |fx|
      sample haus_samps, "car",
             start: 0.1068, finish: 0.1695
      sleep 4
      control fx, mix: 0.3
    end
  end
end

# rain
# 8

define :rain do |amt = get_bank_val_or_default(:garage_bank, 0.5)|
  seed = range(0,0.5,0.05).choose
  s = sample haus_samps, 'rain', amp: amt,
             start: seed + 0.19, finish: seed + 0.22
end

define :windchime_num do |n|
  sample haus_samps, 'bells.aif',
         beat_stretch: 32,
         onset: n
end
