define :entourage do
  in_thread do
    with_fx :compressor do
      gs1 = garage_door_opts({start: 0.4, finish: 0.44,
                              attack: 0.01, release: 0.5,
                              pan: -0.9})
        control gs1, pan: 0.3
      at 0.9 do
        gs1 = garage_door_opts({start: 0.423, finish: 0.45,
                                attack: 0.075,
                                pan: -0.3})
        control gs1, pan: 0
      end
      at 1.85 do
        gs1 = garage_door_opts({start: 0.45, finish: 0.47,
                                attack: 0.14, attack_level: 1.2,
                                pan: 0})
        control gs1, pan: 0.5
      end
      at 4 do
        gs2 = garage_door_opts({start: 0.69, finish: 0.81,
                                pan: 1})
      end
    end
  end
end

define :entourage_times do |num_bars|
  # 1 rep len 8
  in_thread do
    num_bars.times do
      entourage
      sleep 8
    end
  end
end


define :sub_bass do
 #this should be 64 beats long
  # define at that has just 1 beat of sub bass
  in_thread do
    #use_synth :beep
    use_synth :fm
    hd = 16
    chrd = chord(:Fs1, :major)
    chrd1 = chord(:Fs2, :major)

    # 0.25, 0.25
    #  divisor: 0.25,
    #  depth: 0.25, depth_slide: 8
    s = play chrd1[0], amp: 0.8, note_slide: 0.07,
             attack: 0.25, decay: 2, sustain: 8, release: 6,
             cutoff: 110, cutoff_slide: 8,
             divisor: 0.125, divisor_slide: 6,
             depth: 0.25, depth_slide: 8
    control s, depth: 2 #make this a controllable param relative to 1
    #control s, divisor: 0.25
    sleep 6
    control s, note: chrd1[1]
    sleep 2
    control s, depth: 0.25
    control s, note: chrd[1]
    sleep 8
  end

end

define :thorny_at do |amt|
  use_synth :tb303
  amt = 0.6 + amt * 0.4

  in_thread do
    puts get(:knob_15_state)
    puts get(:knob_16_state)

    with_fx :bpf, res: 0.4251968 do
      with_fx :reverb, room: 0.7165354 do
        arr = []
        [28, 15, 35, 19].each do |n|
          coa = [100*amt,
                 100*(amt**3),
                 100,
                 100*amt**2]
          co = coa.ring.tick

          play n, attack: 0.0445, decay: 0.0445, sustain: 0.0445, release: 0.0445, res: 0.9213, cutoff: co, wave: 1, pulse: 0.1102, center: 28
          sleep 0.25
        end
        puts arr

        # XTOUCH
        ##| attack: 0.25*l, decay: 0.25*l, sustain: 0.25*l, release: 0.25*l,
        ##| res: 0.9+0.1*get(:knob_18_state),
        ##| cutoff: 100,
        ##| wave: 1,
        ##| pulse: get(:knob_17_state),
        ##| center: nt

      end
    end
  end
end

define :thorny do
  thorny_at(1)
end

# haus_keys_drop
#   three quick ones at the end