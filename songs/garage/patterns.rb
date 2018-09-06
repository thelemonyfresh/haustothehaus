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


define :sub_bass_at do |n|
  #this should be 64 beats long
  in_thread do
    #use_synth :beep
    use_synth :fm
    hd = 16
    chrds = [31, 35, 28, 27].map{ |n| n + 12 }.ring

    s = play chrds[(n > 0.2 ? 0 : 2)], amp: 0.5, amp_slide: 4, note_slide: 0.07,
      attack: 0.01, decay: 2, sustain: 8, release: 6,
      cutoff: 120, cutoff_slide: 0.75,
      depth: 0.75

    chrds.tick # this is a hack =(

    control s, amp: 0.75

    note_length = n > 0.7 ? 4 : 0.4
    color '.big-haus', 0.45, 'sonic_green' if  n > 0.2
    color '.big-haus', 4, 'sonic_pink' if n <= 0.2
    sleep 0.5
    2.times do
      unless (n > 0.7 || n <= 0.2)
        color '.big-haus', 0.7, 'haus_yellow'
        control s, cutoff: 10
      end
      sleep 0.75

      unless (n > 0.7 || n <= 0.2)
        color '.big-haus', 0.5, 'sonic_green'
        control s, cutoff: 110
      end
      sleep 0.75
    end
    control s, cutoff: 100
    sleep 1.5
    sleep 0.93

    control s, cutoff: 120

    if n < 0.4
      control s, amp: 0
      color '.big-haus', 4, 'haus_yellow'
    end

    puts n

    if n > 0.7
      control s, note: chrds.tick
      puts 'abt to be blue'
      color '.big-haus', 0.25, 'sonic_blue'
    end

    sleep 2
    if n > 0.4
      control s, note: chrds.tick
      color '.big-haus', 0.5, 'sonic_pink'
    end

    sleep 2

    color '.big-haus', 6, 'haus_yellow'
  end
end

define :sub_bass do
  sub_bass_at(0)
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