define :sub_bass_synth do |note, length|
  use_synth :fm
  play note, amp: 0.4,
             attack: 0.125 * length, decay: 0.5 * length, sustain: 0 * length, release: 0.375 * length,
             cutoff: 120, cutoff_slide: 0.75,
             depth: 0.75

  use_synth :saw
  play note, amp: 0.3,
             attack: 0.125 * length, decay: 0.25 * length, sustain: 0 * length, release: 0.25 * length,
             cutoff: 35, cutoff_slide: 0.75,
             depth: 0.75

  use_synth :square
  play note, amp: 0.3,
             attack: 0.125 * length, decay: 0.25 * length, sustain: 0 * length, release: 0.25 * length,
             cutoff: 60, cutoff_slide: 0.75,
             depth: 0.75

  in_thread do
    color '.big-haus', length / 2.0, 'sonic_blue'
    sleep length / 2.0
    color '.big-haus', length, 'haus_yellow'
  end
end
