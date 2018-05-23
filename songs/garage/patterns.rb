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
    use_synth :beep
    hd = 16

    s = play :C2, amp: 1, note_slide: 0.07,
             attack: 0.01, decay: 2, sustain: 8, release: 6,
             cutoff: 110, cutoff_slide: 8,
             divisor: 2, depth: 0.6
    #control s, cutoff: 80
    sleep 6
    control s, note: :F2
    sleep 2
    control s, note: :G1
    sleep 8
  end

end

define :thorny_bass do
  in_thread do
    use_synth :dpulse
    co = 100
    pw = 0.3

    with_fx :lpf, cutoff: co do
      use_transpose -12

      nts = ring(:C3, :Cs3, :E3, :E3, :F3, :G3, :F3)
      lns = ring(2,1.5,1,0.5,1,1,1)
      hds = ring(2,2,0.5,0.75, 1, 1, 1)
      nts.each do |n|
        hd = hds.tick(:holds)
        horny_bass(n, hd)
        sleep lns.tick(:lens)
      end
      nts1 = ring(:G3, :F3, :E3, :E3, :Cs3, :C3)
      lns1 = ring(2,1.5,1,0.5,1,1)
      hds1 = ring(2,2,0.5,0.75, 1, 1)

      nts1.each do |n|
        hd = hds1.tick(:holds1)
        puts n

        if true #[:E3].include?(n)
          s = play n, attack: 0.05, attack_level: 1, decay: 0.2*hd, sustain: 0.25*hd, sustain_level: 0.75, release: 0.3*hd,
                   pulse_width: pw,
                   cutoff: 115, cutoff_slide: 2
          control s, cutoff: 95
        end

        sleep lns1.tick(:lens1)
      end

      sleep 1
    end
  end

end