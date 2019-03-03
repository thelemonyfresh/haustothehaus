
define :windy_synth do |note, length|
  with_fx :level, amp: 2 do
    with_fx :bpf, centre: note(note), res: 0.0001 do
      sample haus_samps, 'winds', finish: length * 0.0015235,
             attack: 0.125 * length, attack_level: 1.25, decay: 0.125 * length
    end
  end
end

define :sub_bass_synth do |note, length|
  use_synth :beep
  
  puts note
  note_bonus = [].include?(note)
  mp = 0.3
  play note, amp: mp,
       attack: 0.1 * length, attack_level: 0.2, decay: 0.5 * length, sustain: 0 * length, release: 0.375 * length,
       cutoff: 120, cutoff_slide: 0.75,
       depth: 0.75
  
  play note+7, amp: mp / 4.0,
       attack: 0.1 * length, attack_level: (mp+0.1)/2.0, decay: 0.5 * length, sustain: 0 * length, release: 0.375 * length,
       cutoff: 120, cutoff_slide: 0.75,
       depth: 0.75

  play note+12, amp: mp / 16.0,
       attack: 0.2 * length, attack_level: (mp+0.1)/2.0, decay: 0.5 * length, sustain: 0 * length, release: 0.375 * length,
       cutoff: 120, cutoff_slide: 0.75,
       depth: 0.75

  ##| play note + 3, amp: 0.1,
  ##|   attack: 0.1 * length, attack_level: 0.2, decay: 0.5 * length, sustain: 0 * length, release: 0.375 * length,
  ##|   cutoff: 120, cutoff_slide: 0.75,
  ##|   depth: 0.75

  ##| play note + 7, amp: 0.1,
  ##|   attack: 0.1 * length, attack_level: 0.2, decay: 0.5 * length, sustain: 0 * length, release: 0.375 * length,
  ##|   cutoff: 120, cutoff_slide: 0.75,
  ##|   depth: 0.75

  ##| use_synth :saw
  ##| play note, amp: 0.2,
  ##|   attack: 0.125 * length, attack_level: 0.2, decay: 0.25 * length, sustain: 0 * length, release: 0.25 * length,
  ##|   cutoff: 35, cutoff_slide: 0.75,
  ##|   depth: 0.75

  # use_synth :square
  # play note, amp: 0.1,
  #            attack: 0.0125 * length, decay: 0.25 * length, sustain: 0 * length, release: 0.25 * length,
  #            cutoff: 60, cutoff_slide: 0.75,
  #            depth: 0.75

  in_thread do
    color '.big-haus', length / 2.0, 'sonic_blue'
    sleep length / 2.0
    color '.big-haus', length, 'haus_yellow'
  end
end