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

    s = play :C2, amp: 1, note_slide: 0.07,
             attack: 0.25, decay: 2, sustain: 8, release: 6,
             cutoff: 110, cutoff_slide: 8,
             divisor: 2,
             depth: 0.6, depth_slide: 16
    control s, depth: 1
    sleep 6
    control s, note: :F2
    sleep 2
    control s, note: :G1
    sleep 8
  end

end

define :thorny_bass_at do |amt|
  in_thread do
    use_synth :dpulse # work on this sound a bit -- should be more like the horns
    co = 130
    pw = 0.3

    with_fx :lpf, cutoff: co do
      use_transpose +12

      num_notes = (amt*7).round
      nts = ring(:C3, :Cs3, :E3, :E3, :F3, :G3, :F3).take(num_notes)
      lns = ring(2,1.5,1,0.5,1,1,1).take(num_notes)
      hds = ring(2,2,0.5,0.75, 1, 1, 1).take(num_notes)
      nts.each do |n|
        hd = hds.tick(:holds)
        horny_bass(n, hd)
        sleep lns.tick(:lens)
      end
      sleep (8 - lns.reduce(:+))

      num_notes1 = (amt*6).round
      nts1 = ring(:G3, :F3, :E3, :E3, :Cs3, :C3).take(num_notes1)
      lns1 = ring(2,1.5,1,0.5,1,1).take(num_notes1)
      hds1 = ring(2,2,0.5,0.75, 1, 1).take(num_notes1)

      nts1.each do |n|
        hd = hds1.tick(:holds1)
        horny_bass(n, hd)
        sleep lns1.tick(:lens1)
      end
      sleep (8 - lns1.reduce(:+))
    end
  end
end

define :thorny_bass do
  thorny_bass_at(1)
end