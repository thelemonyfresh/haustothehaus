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
  in_thread do
    #use_synth :beep
    use_synth :fm
    hd = 16

    # 0.25, 0.25
    #  divisor: 0.25,
    #  depth: 0.25, depth_slide: 8
    s = play :C2, amp: 0.6, note_slide: 0.07,
             attack: 0.25, decay: 2, sustain: 8, release: 6,
             cutoff: 110, cutoff_slide: 8,
             divisor: 0.125, divisor_slide: 6,
             depth: 0.25, depth_slide: 8
    control s, depth: 2 #make this a controllable param relative to 1
    #control s, divisor: 0.25
    sleep 6
    control s, note: :F2
    sleep 2
    control s, depth: 0.25
    control s, note: :G1
    sleep 8
  end

end

define :thorny_melody_at do |amt|
  in_thread do
    use_synth :tb303

    nts = chord(:C4, :major7).take((amt*4).to_i)
    in_thread do
      nts.each do |n|
        play n, amp: 0.5,
             attack: 0.05, decay: 0.05, decay_level: 0.8, release: 0.25,
             res: 0.125, wave: 1, pulse_width: 0.4,
             cutoff: 100, cutoff_attack: 0.15
        sleep ring(1.5, 1,1.5,1).tick
      end
    end


    sleep 8
  end
end

define :thorny_melody do
  thorny_melody_at(1)
end