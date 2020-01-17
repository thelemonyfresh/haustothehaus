haus_samps = "/Users/daniel/recording/haus_samples"

#
# Sounds.
#

# garage_door
# 32
define :garage_door do
  sample haus_samps, 'west_garage_door'
end

# gravel_bd
# 0.5
define :gravel_bd do
  with_fx :reverb, mix: 0.2, room: 0.5, damp: 1 do
    with_fx :distortion, distort: 0.3 do
      sample :bd_haus, attack: 0.01, sustain: 0.1, release: 0.1
      with_fx :lpf, cutoff: 50 do
        with_fx :octaver, subsub_amp: 1, sub_amp: 1, super_amp: 0 do
          sample :drum_tom_mid_soft, amp: 0, start: 0.01,
                 attack: 0.001, attack_level: 1.25,
                 decay: 0.01,
                 sustain: 0,
                 release: 0.15
        end
      end
      use_synth :beep
      play :D1, amp: 0.8,
           attack: 0.01, attack_level: 1.5,
           decay: 0.25,
           release: 0.3
      play :D0, amp: 0.2,
           attack: 0.01, attack_level: 1.5,
           decay: 0.25,
           release: 0.1
    end
  end

  #pulse %w(.h .a .u .s).map { |l| '.big-haus' + l }.ring.tick(:big), 0.75
end

# keys
# 4
define :keys do
  falling_text "keys", 6
  with_fx :reverb, room: 0.1, mix: 0.4, damp: 0.6  do
    sample haus_samps, "neu_haus_keys", start: 0.087, finish: 0.44, release: 1
  end
end

# # haus_keys
# # 0.5
define :haus_keys do
  ech = 0 #spread(5,16).tick(:keys_echo) ? 1 : 0
  ph = spread(7,16).tick(:keys_ph) ? 0.24 : 0.49

  with_fx :pan, pan: -0.5, amp: 0.85 do
    sample '/Users/daniel/recording/haus_samples', 'neu_haus_keys',
           rate: 2,
           start: 0.803,
           finish: 0.8895
    # numark_sampler_a(haus_samps, 'neu_haus_keys')

    sample '/Users/daniel/recording/haus_samples', 'neu_haus_keys',
           rate: 1,
           start: 0.2295,
           finish: 0.23884
  end
  with_fx :pan, pan: 0.5, amp: 0.75 do
    #numark_sampler_b(haus_samps, 'neu_haus_keys')
    sample '/Users/daniel/recording/haus_samples', 'neu_haus_keys',
           rate: 2,
           start: 0.2295,
           finish: 0.26884

    sample '/Users/daniel/recording/haus_samples', 'neu_haus_keys',
           rate: 1,
           start: 0.809,
           finish: 0.8195
  end
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

define :windchime do
  sample haus_samps, 'bells.aif',
         beat_stretch: 32
end