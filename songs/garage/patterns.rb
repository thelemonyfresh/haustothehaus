haus_samps = '/Users/daniel/recording/haus_samples'

#
# Patterns.
#

# entourageq
# 8

define :garage_door do |amt = get_bank_val_or_default(:garage, 0)|
  falling_text 'garage door', 8

  in_thread do

    ph = ring_amt(ring(1,1,0.5,0.25),amt)
    pr = 1 - amt/2.5
    mx = ring_amt(ring(0,1,1,1,0),amt)

    with_fx :slicer, phase: ph, probability: pr, mix: mx  do
      with_fx :level, amp: 0.7 do
        with_fx :compressor do
          gs1 = garage_door_opts(start: 0.4, finish: 0.44,
                                 attack: 0.01, release: 0.5,
                                 pan: -0.9, pan_slide: 1)
          control gs1, pan: 0.2
          at 0.9 do
            gs2 = garage_door_opts(start: 0.423, finish: 0.45,
                                   attack: 0.075,
                                   pan: -0.3, pan_slide: 2)
            control gs2, pan: 0.3
          end
          at 1.85 do
            gs3 = garage_door_opts(start: 0.45, finish: 0.47,
                                   attack: 0.14, attack_level: 1.2,
                                   pan: 0, pan_slide: 1)
            control gs3, pan: 0.7
          end
          at 4 do
            gs4 = garage_door_opts(start: 0.69, finish: 0.81,
                                   pan: 0.75, pan_slide: 4)
            control gs4, pan: -0.5
          end
        end
      end
    end
  end
end

# roses
# 1

define :roses do |amt = get_bank_val_or_default(:garage, 0.5)|
  in_thread do
    falling_text 'roses', 1
  end

  amt = 0.65 + amt * 0.35
  in_thread do
    with_fx :reverb, room: 0.7165354 do
      chord(:D4,:major7, invert: 1).reverse.each do |nt|
        co = ring(80*amt,110*amt**2,100*amt**3,100*amt)
        with_fx :lpf, cutoff: co.tick do

          thorny_synth(nt,0.25)
        end
        sleep 0.25
      end
    end
  end
end

# bassment
# 16

define :bassment do |amt = get_bank_val_or_default(:garage, 0)|
  nts = scale(:D2, :minor_pentatonic)

  falling_text 'bassment', 16

notes = []
times = []
durations = []

  in_thread do
    case amt
    when 0..0.25
      with_fx :level, amp: 0.6 do
        with_fx :slicer, phase: 1, phase_offset: 0.25, pulse_width: 0.5, wave: 3, mix: 1 do
          sub_bass_synth(nts[0], 16)
        end
      end
    when 0.25..0.45
      notes = knit(:D2,15,:G2,1)
      times = range(0.5,16.5,1)
      durations = ring(0.4)
    when 0.45..0.55
      notes = knit(:D2,1,   :F2,1,:A2,2,       :D2,3,:G2,1)
       times =    ring(2.5, 3.5,6.5,7.5,12.5,  13.5,14.5,15.5)
      durations = knit(1,1, 0.5,4,             0.3,4)
    when 0.55..0.75
      notes = knit(:D2,3,:F2,1)
      times = ring(0,1.5,2.5,3.5)
      durations = knit(1,1,0.5,3)
    when 0.75..0.85
      notes = ring(:D2)
      times = range(0.5,16,2)
      durations = ring(0.5)
    when 0.85..1
      notes = ring(:D2)
      times = range(0.5,16,4)
      durations = ring(0.5)
    end
      melody = {
        notes: notes,
        times: times,
        durations: durations
      }

    play_synth_melody(:sub_bass_synth, melody)
  end
end

define :tires do |amt = get_bank_val_or_default(:garage, 0)|
  # shortest should be a simple 4x8 (2x2x8 diff at end, that resolves in last measure
  # longer melody section should tick through patterns,
  # numark middle knob should adjust key

  notes = []
  times = []
  durations = []

  case amt
  when 0.25..0.45
    notes = chord(:D3, :major, invert: 1)
    times = ring(0,12)
    durations = ring(8,4)
  when 0.45..0.55
    notes = chord(:D3, :major).reflect.stretch(2)
    times =     ring(0,1,   2,      4,   12,16,17,18, 20,  21,   27,     28.5,  31)
    durations = knit(0.5,2, 0.75,1, 5,1, 0.5,4,       1,1, 4,1,  0.75,1, 0.5,1, 0.25,1)
  when 0.55..0.8
    notes = chord(:D3, :major).reverse.drop(1).stretch(2)
    puts notes
    times = ring(8,9.5,11,12.5) + ring(24,25.5,26.5,29)
    durations = knit(0.5,4) + knit(1,1,0.5,3)
  when 0.8..0.95
    notes = chord(:D3, :major).reverse.drop(1).stretch(2)
    times =     ring(4,   12,16, 21,  31)
    durations = knit(5,1, 0.5,2, 4,1, 0.25,1)
  end

  melody = {
    notes: notes,
    times: times,
    durations: durations
  }

  melody_1 = {
    notes: ring(:D4) + chord(:D4, :major).reflect,
    times: ring(1,2,4,5.5,7,9,11,13,14),
    durations: ring(0.5,0.25,1.5)
  }

  max = ring_amt(ring(60,80,100,120),amt)
  min = ring_amt(ring(40,30,20,10),amt)

  in_thread do
    #with_fx :panslicer, mix: get_bank_val_or_default(:garage_knob,100), mix_slide: 0.1, phase: 1.5 do |fx|
     with_fx :lpf, cutoff: get_bank_val_or_default(:garage_knob,0.75) do |fx|
      set(:garage_knob_fx, fx)
      set(:garage_knob_fx_param, :cutoff)
      play_synth_melody(:deep_haus_synth_dev, melody)
    end
  end
end

# windy melody
# 32

define :windy_melody do |amt = get_bank_val_or_default(:garage, 0.5)|
  in_thread do
    nts = scale(:D, :minor_pentatonic, invert: 2)

    with_fx :slicer, phase: 0.25, mix: amt do
      3.times do
        falling_text 'windy', 8
        2.times do |n|
          windy_synth(nts[3], 0.5)
          sleep 0.5
        end
        sleep 1
        windy_synth(nts[0], 2)
        sleep 6
      end
      windy_synth(nts[5], 2)
      sleep 2
      windy_synth(nts[1], 1)
      sleep 3
    end
  end
end

# windchimes
# 32

define :windchimes do |amt = get_bank_val_or_default(:garage, 0)|
  # chord(:D3, :major).repeat.drop_last(2).tick
  # DEAD
  in_thread do
    windchime_num(0) if amt < 0.75
    sleep 8
    windchime_num(1) if amt > 0.24
    sleep 8
    windchime_num(2) if amt > 0.45
    sleep 8
    windchime_num(0) if amt > 0.1
    sleep 8
  end
end