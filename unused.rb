#
# 8

# define :garage_door do |amt = get_bank_val_or_default(:garage_amt, 0)|
#   falling_text 'garage door', 8

#   in_thread do

#     ph = ring_amt(ring(1,1,0.5,0.25),amt)
#     pr = 1 - amt/2.5 # better prob for 0.5+
#     mx = ring_amt(ring(0,1,1,1,0),amt)

#     with_fx :slicer, phase: ph, probability: pr, mix: mx  do
#       with_fx :level, amp: 0.7 do
#         with_fx :compressor do
#           gs1 = garage_door_opts(start: 0.4, finish: 0.44,
#                                  attack: 0.01, release: 0.5,
#                                  pan: -0.9, pan_slide: 1)
#           control gs1, pan: 0.2
#           rotate '.h.little-haus', 0.25, -15*(1-amt)
#           at 0.9 do
#             gs2 = garage_door_opts(start: 0.423, finish: 0.45,
#                                    attack: 0.075,
#                                    pan: -0.3, pan_slide: 2)
#             control gs2, pan: 0.3
#             rotate '.a.little-haus', 0.25, -15*(1-amt)
#           end
#           at 1.85 do
#             gs3 = garage_door_opts(start: 0.45, finish: 0.47,
#                                    attack: 0.14, attack_level: 1.2,
#                                    pan: 0, pan_slide: 1)
#             control gs3, pan: 0.7
#             rotate '.u.little-haus', 0.25, -15*(1-amt)
#           end
#           at 4 do
#             gs4 = garage_door_opts(start: 0.69, finish: 0.81,
#                                    pan: 0.75, pan_slide: 4)
#             control gs4, pan: -0.5
#             rotate '.h.little-haus', 0.5, 0
#             sleep 0.5
#             rotate '.a.little-haus', 0.5, 0
#             sleep 1.5
#             rotate '.u.little-haus', 0.5, 0
#           end
#         end
#       end
#     end
#   end
# end

# define :garage_door do |amt = get_bank_val_or_default(:garage_amt, 0)|
#   falling_text 'garage door', 8

#   in_thread do

#     sample '/Users/daniel/recording/haus_samples', 'garage_door',
#            rate: 1.0,
#            start: 0.146,
#            finish: 0.173

#     sleep 1
#     sample '/Users/daniel/recording/haus_samples', 'garage_door',
#            rate: 1.0,
#            start: 0.162,
#            finish: 0.1865
#     sleep 3
#     sample '/Users/daniel/recording/haus_samples', 'garage_door',
#            rate: 1.0,
#            start: 0.236,
#            finish: 0.264
#     sleep 3
#     sample '/Users/daniel/recording/haus_samples', 'garage_door',
#            rate: 1.0,
#            start: 0.255,
#            finish: 0.2695
#   end
# end


# roses
# 1

define :roses do |amt = get_bank_val_or_default(:garage_amt, 0.5)|
  in_thread do
    falling_text 'roses', 1
  end

  amt = 0.9 - amt * 0.4
  in_thread do
    with_fx :reverb, room: 0.7165354 do
      chord(:D4,:major7, invert: 2).reverse.each do |nt|
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

define :bassment do |amt = get_bank_val_or_default(:garage_amt, 0)|
  nts = scale(:F2, :minor_pentatonic)

  falling_text 'bassment', 16

notes = []
times = []
durations = []

  in_thread do
    case amt
    when 0..0.25
      with_fx :level, amp: 0.5 + 2*amt do
        with_fx :slicer, phase: 1, phase_offset: 0.5, pulse_width: 0.5, wave: 1, smooth: 0.1, mix: amt*3.9  do
          sub_bass_synth(nts[0], 16)
        end
      end
    when 0.25..0.45
      notes = knit(nts[0],15,nts[2],1)
      times = range(0.5,16.5,1)
      durations = ring(0.4)
    when 0.45..0.55
      notes = knit(nts[0],1,   nts[1],1,nts[3],2,       nts[0],3,nts[2],1)
      times =    ring(2.5, 3.5,6.5,7.5,12.5,  13.5,14.5,15.5)
      durations = knit(1,1, 0.5,4,             0.3,4)
    when 0.55..0.75
      notes = knit(nts[0],3,nts[1],1)
      times = ring(0,1.5,2.5,3.5)
      durations = knit(1,1,0.5,3)
    when 0.75..0.85
      notes = ring(nts[0])
      times = range(0.5,16,2)
      durations = ring(0.5)
    when 0.85..1
      notes = ring(nts[0])
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






define :tires do |amt = get_bank_val_or_default(:garage_amt, 0)|
  # shortest should be a simple 4x8 (2x2x8 diff at end, that resolves in last measure
  # longer melody section should tick through patterns,
  # numark middle knob should adjust key

  notes = []
  times = []
  durations = []

  case amt
  when 0.20..0.45
    notes = chord(:F3, :minor, invert: 1)
    times = ring(0,12)
    durations = ring(8,4)
  when 0.45..0.55
    notes = chord(:D3, :minor).reflect.stretch(2)
    times =     ring(0,1,   2,      4,   12,16,17,18, 20,  21,   27,     28.5,  31)
    durations = knit(0.5,2, 0.75,1, 5,1, 0.5,4,       1,1, 4,1,  0.75,1, 0.5,1, 0.25,1)
  when 0.55..0.8
    notes = chord(:D3, :minor).reverse.drop(1).stretch(2)
    puts notes
    times = ring(8,9.5,11,12.5) + ring(24,25.5,26.5,29)
    durations = knit(0.5,4) + knit(1,1,0.5,3)
  when 0.8..0.95
    notes = chord(:D3, :minor).reverse.drop(1).stretch(2)
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
    #with_fx :panslicer, mix: get_bank_or_default(:garage_amt_knob,100), mix_slide: 0.1, phase: 1.5 do |fx|
     with_fx :lpf, cutoff: get_bank_val_or_default(:garage_knob,0.75) do |fx|
      set(:garage_knob_fx, fx)
      set(:garage_knob_fx_param, :cutoff)
      play_synth_melody(:deep_haus_synth, melody)
    end
  end
end


# windchimes
# 32

define :windchimes do |amt = get_bank_val_or_default(:garage_amt, 0)|
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


# garage_door
# 32

define :garage_door_opener do
  falling_text "garage door opener", 32
  garage_door_opts({beat_stretch: 32})
end

define :garage_door_opts do |hsh|
  s = nil
  with_fx :lpf, cutoff: note(:E6) do
    with_fx :hpf, cutoff: note(:E3) do
      s = sample haus_samps, "garage_door", hsh
    end
  end
end



# rain
# 8


# windchimes

define :windchime_num do |n|
  sample haus_samps, 'bells.aif',
         beat_stretch: 32,
         onset: n
end
