# gravel_bd
# 0.5
define :gravel_bd do
  with_fx :reverb, mix: 0.2, room: 0.5, damp: 1 do
    with_fx :distortion, distort: 0.3 do
      sample :bd_haus, amp: 0.7, attack: 0.01, sustain: 0.1, release: 0.1
      with_fx :lpf, cutoff: 50 do
        with_fx :octaver, subsub_amp: 1, sub_amp: 1, super_amp: 0 do
          sample :drum_tom_mid_soft, amp: 1, start: 0.01,
                 attack: 0.001, attack_level: 1.25,
                 decay: 0.01,
                 sustain: 0,
                 release: 0.15
        end
      end
    end
  end
end

# # haus_keys
# # 0.5
define :haus_keys do
  #ech = 0 #spread(5,16).tick(:keys_echo) ? 1 : 0
  #ph = spread(7,16).tick(:keys_ph) ? 0.24 : 0.49

  with_fx :hpf, cutoff: 100 do
    with_fx :pan, pan: -0.5, amp: 1 do
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
    with_fx :pan, pan: 0.5, amp: 1 do
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
end