define :entourage do
  amp = range(0.125,1,0.125).ramp.tick(:entourage_amp)
  puts "amp: #{amp}"

  in_thread do
    with_fx :level, amp: amp do
      with_fx :compressor do
        gs1 = garage_door_opts({start: 0.4, finish: 0.44,
                                attack: 0.01, release: 0.5,
                                pan: -0.9})
        control gs1, pan: 0.3
        #rotate '.h.little-haus', 1, 5
        at 0.9 do
          gs1 = garage_door_opts({start: 0.423, finish: 0.45,
                                  attack: 0.075,
                                  pan: -0.3})
          control gs1, pan: 0
          #rotate '.h.little-haus', 1, -5
        end
        at 1.85 do
          gs1 = garage_door_opts({start: 0.45, finish: 0.47,
                                  attack: 0.14, attack_level: 1.2,
                                  pan: 0})
          control gs1, pan: 0.5
          #rotate '.h.little-haus', 2, -15
        end
        at 4 do
          gs2 = garage_door_opts({start: 0.69, finish: 0.81,
                                  pan: 1})
          #rotate '.h.little-haus', 2, 0
        end
      end
    end
  end

  amt = range(0.125,1,0.125).tick(:entourage_viz_amp)
  in_thread do
    3.times do |n|
        rotate '.h.little-haus', 1, -5*(n+1)*amt
        sleep 1
    end
    sleep 1
    rotate '.h.little-haus', 1, 5*amt
    sleep 1.5
    rotate '.h.little-haus', 1, 3*amt
    sleep 1
    rotate '.h.little-haus', 1, 0
    #rotate '.h.little-haus', 1, 10
    #rotate '.h.little-haus', 0.75, 7
    #rotate '.h.little-haus', 0.25, -1
    #rotate '.h.little-haus', 0.75, 10
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


define :sub_bass_at do |n|
 #this should be 64 beats long
  in_thread do
    #use_synth :beep
    use_synth :fm
    hd = 16
    chrds = [31, 35, 28, 27].map{ |n| n + 12 }

    s = play chrds.tick, amp: 0.7, amp_slide: 4, note_slide: 0.07,
             attack: 0.01, decay: 2, sustain: 8, release: 6,
             cutoff: 120, cutoff_slide: 0.75
    #rotate '.big-haus', 8, (chrds.look - 45)*-5
    sleep 0.5
    2.times do
      control s, cutoff: 10 unless n > 0.7
      sleep 0.75
      control s, cutoff: 130 unless n > 0.7
      sleep 0.75
    end
    control s, cutoff: 100
    sleep 1.5
    sleep 0.93
    control s, cutoff: 120
    control s, amp: 0 if n < 0.4
    control s, note: chrds.tick if n > 0.7
    #rotate '.big-haus', 8, (chrds.look - 46)*-5  if n > 0.7

    sleep 2
    control s, note: chrds.tick if n > 0.4
    #rotate '.big-haus', 8, (chrds.look - 46)*15  if n > 0.7
    sleep 2
    #rotate '.big-haus', 8, 0
  end
end

define :sub_bass do
  sub_bass_at(0.75)
end


define :thorny_at do |amt|
  use_synth :tb303
  amt = 0.6 + amt * 0.4

  in_thread do
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
      end
    end
  end

  in_thread do
    rotate '.u.little-haus', 0.25, -2*amt
    sleep 0.25
    rotate '.u.little-haus', 0.25, 0
    rotate '.s.little-haus', 0.25, -2*amt
    sleep 0.25
    rotate '.s.little-haus', 0.25, 0
  end
end

define :thorny do
  thorny_at(0.3)
end

# haus_keys_drop
#   three quick ones at the end