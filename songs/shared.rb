haus_samps = "/Users/daniel/recording/haus_samples"
#
# Shared Sounds
#

define :animal_house do
  with_fx :gverb, damp: 0.98, pre_damp: 1, room: 9 do
    s = sample haus_samps, "house_stonemason", pan: 0.25, pan_slide: 2,
               start: 0.0236, finish: 0.9449, attack: 0.2205, decay: 0.5354, beat_stretch: 4, amp: 0.3,
               cutoff: 100
    control s, pan: -0.5
  end
end

#
# Shared Instruments
#

define :sub_bass_synth do |note, length, amp|
  use_synth :beep

  with_fx :flanger do

    with_fx :pan, pan: -0.3 do
      with_fx :band_eq, freq: 63, db: -5 do

        play note, amp: amp,
             attack: 0.1 * length, decay: 0.5 * length,  sustain: 0 * length, release: 0.375 * length,
             attack_level: 0.2,
             cutoff: 120, cutoff_slide: 0.75,
             depth: 0.75

        play note+7, amp: amp / 4.0,
             attack: 0.1 * length, decay: 0.5 * length, sustain: 0 * length, release: 0.375 * length,
             attack_level: (amp+0.1)/2.0,
             cutoff: 120, cutoff_slide: 0.75,
             depth: 0.75

        play note+12, amp: amp / 16.0,
             attack: 0.2 * length, decay: 0.5 * length, sustain: 0 * length, release: 0.375 * length,
             attack_level: (amp+0.1)/2.0,
             cutoff: 120, cutoff_slide: 0.75,
             depth: 0.75
      end
    end
  end


  in_thread do
    color '.big-haus', length / 2.0, 'sonic_blue'
    sleep length / 2.0
    color '.big-haus', length, 'haus_yellow'
  end
end

define :deep_house_bass do |note, duration|
  in_thread do

    #note = chord(:D2, :major).choose

    use_synth :beep

    adsr = {
      attack: 0.1,
      decay: 0.2,
      sustain: 0.7 * duration,
      release: 0.2 * duration
    }

    with_fx :reverb do

      use_tuning :equal
      play note, adsr, amp: 0.2
      play note - 12, adsr, amp: 0.1
      play note + 19, adsr, amp: 0.15

      sleep 0.1

      use_tuning :pythagorean
      play note, adsr, amp: 0.1
      play note - 12, adsr, amp: 0.2
      play note + 19, adsr, amp: 0.15


    end
  end
end

define :thorny_synth do |nt, duration|
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