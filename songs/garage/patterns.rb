define :entourage do
  amp = range(0.125,1,0.125).ramp.tick(:entourage_amp)
  puts "amp: #{amp}"

  in_thread do
    with_fx :level, amp: amp do
      with_fx :compressor do
        gs1 = garage_door_opts({start: 0.4, finish: 0.44,
                                attack: 0.01, release: 0.5,
                                pan: -0.9, pan_slide: 1})
        control gs1, pan: 0.2
        #rotate '.h.little-haus', 1, 5
        at 0.9 do
          gs1 = garage_door_opts({start: 0.423, finish: 0.45,
                                  attack: 0.075,
                                  pan: -0.3, pan_slide: 1})
          control gs1, pan: 0.3
          #rotate '.h.little-haus', 1, -5
        end
        at 1.85 do
          gs1 = garage_door_opts({start: 0.45, finish: 0.47,
                                  attack: 0.14, attack_level: 1.2,
                                  pan: 0, pan_slide: 1})
          control gs1, pan: 0.7
          #rotate '.h.little-haus', 2, -15
        end
        at 4 do
          gs2 = garage_door_opts({start: 0.69, finish: 0.81,
                                  pan: 0.75, pan_slide: 4})
          control gs2, pan: -0.5
          #rotate '.h.little-haus', 2, 0
        end
      end
    end
  end

  amt = range(0.125,1,0.125).tick(:entourage_viz_amp)

  if tick(:entourage_viz_length) < 8
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

define :ground_up do
  knit(0.1,1,0.25,2,0.9,1)
end

define :ground_down do
  knit(0.1,1,0.5,1,0.9,1)
end

define :sunrise do
  range(0,1,0.25)
end

define :thorny_at do |base_amt|
  use_synth :tb303
  amt = 0.6 + base_amt * 0.4

  in_thread do
    with_fx :bpf, res: 0.4251968 do
      with_fx :reverb, room: 0.7165354 do
        arr = []
        [28, 15, 35, 19].each_with_index do |n,i|
          coa = [100*amt,
                 100*(amt**3),
                 100,
                 100*amt**2]
          co = coa.ring.tick

          p = (n%2 == 0 ) ? 1 : -1
          play n, pan: p,
               attack: 0.0445, decay: 0.0445, sustain: 0.0445, release: 0.0445,
               res: 0.9213, cutoff: co, wave: 1, pulse: 0.1102, center: 28
          sleep 0.25
        end
      end
    end
  end

  in_thread do
    colors = %w(sonic_green sonic_blue sonic_pink).ring

    color '.little-haus.h', 0.25, colors[(base_amt*2.9).to_i] if base_amt > 0.1
    sleep 0.25
    color '.little-haus.a', 0.25, colors[(base_amt*2.9).to_i] if base_amt > 0.4
    sleep 0.25
    color '.little-haus.u', 0.25, colors[(base_amt*2.9).to_i]
    sleep 0.25
    color '.little-haus.s', 0.25, colors[(base_amt*2.9).to_i] if base_amt > 0.6
    sleep 0.25

    sleep 2
    color '.little-haus', 2, 'haus_yellow'
  end
end

define :thorny do
  thorny_at(0)
end

# haus_keys_drop
#   three quick ones at the end

define :bassment do
  bassment_at(0)
end


define :bassment_at do |amt|
  nts = scale(:E2, :minor_pentatonic)

  in_thread do
    if amt < 0.05
      sub_bass_synth(nts[0], 16)
      sleep 16

    elsif amt < 0.255
      with_fx :slicer, phase: 1, pulse_width: 0.5, wave: 3, smooth: 0.0125 do
        sub_bass_synth(nts[0], 16)
      end

      16.times do |n|
        sleep 0.5
        sub_bass_synth(nts[0], 0.5)
        sleep 0.5
      end
    elsif amt < 0.35
      16.times do |n|
        patt = knit(0,15, 2,1)
        bass_note = nts[patt.tick(:bassment_notes)]

        sleep 0.5
        sub_bass_synth(bass_note, 0.5)
        sleep 0.5
      end
    elsif amt < 0.55
      16.times do
        note_num = knit(0,7, 2,1, 0,6, 4,1, 1,1).tick(:bassment_notes)
        puts nts[note_num]
        sleep 0.5
        sub_bass_synth(nts[note_num], 0.5)
        sleep 0.5
      end
    elsif amt < 0.755
      16.times do
        note_num = knit(0,3, 2,1, 0,3, 4,1, 0,3, 2,1, 0,1, 5,1, 3,1, 2,1, 1,1).tick(:bassment_notes)
        puts nts[note_num]
        sleep 0.5
        sub_bass_synth(nts[note_num], 0.5)
        sleep 0.5
      end

    elsif amt < 0.95
      16.times do |n|
        div = [1,2,4,8,16][((amt - 0.8)*50).to_i]
        puts div
        sleep 0.5
        sub_bass_synth(nts[0], 0.5) if n%div == 0
        sleep 0.5
      end

    end
  end
end
