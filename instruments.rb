#
# Shared Instruments
#

define :sub_bass_synth do |note, length|
  use_synth :fm

  amp = 1

  #with_fx :flanger do
  with_fx :pan, pan: -1 do
    # with_fx :band_eq, freq: 63, db: -5 do

    play note, amp: amp,
         attack: 0.1, decay: 0.5 * length,  sustain: 0 * length, release: 0.375 * length,
         attack_level: 1.1,
         #cutoff: 120, cutoff_slide: 0.75,
         depth: 0.75,
         pitch: 0.1

    play note+3, amp: amp / 2.0,
         attack: 0.01, decay: 0.5 * length, sustain: 0 * length, release: 0.375 * length,
         attack_level: (amp+0.1)/2.0,
         #cutoff: 120, cutoff_slide: 0.75,
         depth: 0.75,
         pitch: 0.1

    play note-2, amp: amp / 2.0,
         attack: 0.05, decay: 0.3 * length, sustain: 0.1*length, release: 0.2,
         depth: 1,
         pitch: 0.1
    #end
  end

  with_fx :pan, pan: 1 do
    # with_fx :band_eq, freq: 63, db: -5 do

    play note, amp: amp,
         attack: 0.01, decay: 0.5 * length,  sustain: 0 * length, release: 0.375 * length,
         attack_level: 0.2,
         cutoff: 120, cutoff_slide: 0.75,
         depth: 0.75,
         pitch: -0.1

    play note+3, amp: amp / 2.0,
         attack: 0.01, decay: 0.5 * length, sustain: 0 * length, release: 0.375 * length,
         attack_level: 1.2,
         cutoff: 120, cutoff_slide: 0.75,
         depth: 0.75,
         pitch: -0.1


    play note-2, amp: amp / 2.0,
         attack: 0.05, decay: 0.3 * length, sustain: 0.1*length, release: 0.2,
         depth: 1,
         pitch: 0.1
    #end
  end
end

define :deep_haus_synth do |note, duration|
  in_thread do

    amp = 1

    use_synth :beep

    adsr = {
      attack: 0.1,
      decay: 0.2,
      sustain: 0.7 * duration,
      release: 0.2 * duration
    }

    gap = (duration/4.0) * 60
    min = 80 - gap/2.0
    max = 80 + gap/2.0

    max = max > 125 ? 125 : max
    min = min < 25 ? 25 : min

    with_fx :level, amp: 0.85 do
      with_fx :reverb do
        with_fx :ixi_techno, cutoff_max: max, cutoff_min: min, phase: duration do
          use_tuning :equal
          play note, adsr, amp: amp/8.0, pan: 0.1

          sleep 0.1

          use_synth :tri
          use_tuning :pythagorean
          play note - 12, adsr, amp: amp/4.0, pan: -0.5
          play note + 19, adsr, amp: amp/16.0, pan: 0.3
        end
      end
    end
  end
end

define :thorny_synth do |nt, duration|
  use_synth :tb303
  s= nil

  with_fx :bpf, res: 0.5, centre: :D4, mix: 0.7 do
    s = play nt,
             attack: duration/5.0, decay: duration/5.0, sustain: duration/5.0, release: duration/5.0,
             res: 0.3, #0.9213,
             cutoff: 70, wave: 1,
             pulse_width: 0.05,
             pulse_width_slide: 0.25
  end

  control s, pulse_width: 0.01
end

define :windy_synth do |note, length|
  with_fx :level, amp: 2 do
    with_fx :bpf, centre: note(note), res: 0.0001 do
      sample haus_samps, 'winds', finish: length * 0.0015235,
             attack: 0.125 * length, attack_level: 1.25, decay: 0.125 * length
    end
  end
end
