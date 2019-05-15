haus_samps = "/Users/daniel/recording/haus_samples"

define :windy_synth do |note, length|
  with_fx :level, amp: 2 do
    with_fx :bpf, centre: note(note), res: 0.0001 do
      sample haus_samps, 'winds', finish: length * 0.0015235,
             attack: 0.125 * length, attack_level: 1.25, decay: 0.125 * length
    end
  end
end
