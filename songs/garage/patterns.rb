define :entourage do
  in_thread do
    with_fx :compressor do
        gs1 = garage_door_opts({start: 0.4, finish: 0.44, attack: 0.01, release: 0.5})
        control gs1, pan: 0.8
      at 0.9 do
        gs1 = garage_door_opts({start: 0.423, finish: 0.45, attack: 0.075})
        control gs1, pan: 0.8
      end
      at 1.85 do
        gs1 = garage_door_opts({start: 0.45, finish: 0.47, cutoff_dec: 1, attack: 0.14, attack_level: 1.2})
        control gs1, pan: -0.5
      end
      at 4 do
        gs2 = garage_door_opts({start: 0.69, finish: 0.81, cutoff_dec: 1})
        control gs2, pan: -0.8
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

define :thorny_bass do
  s1 = 0.05
  s2 = 0.08
  f = 0.125

  in_thread do
    at [0,4] do
      bass_horn_opts({start: s1, finish: f})
      bass_horn_opts({start: s1, finish: f, rpitch: -7})
    end
    at [5.5,6.5] do
      bass_horn_opts({start: s2, finish: f})
      bass_horn_opts({start: s2, finish: f, rpitch: -3})
    end
  end
end

define :thorny_bass_times do |n|
  in_thread do
    n.times do
      thorny_bass
      sleep 8
    end
  end
end

define :very_thorny_bass do
  in_thread do

    thorny_bass_times(3)
    sleep 3*8
    at [4] do
      bass_horn_opts({start: 0.05, finish: 0.25, rpitch: -5})
    end
    at [1.5] do
      bass_horn_opts({start: 0.05, finish: 0.25, rpitch: -3})
    end
    at [6.5] do
      bass_horn_opts({start: 0.06, finish: 0.2, rpitch: -7})
    end
    sleep 8
  end
end

# live_loop :thorny_bass do
#   use_synth :pulse
#   co = 120
#   pw = 0.85
#   puts "pw=#{pw}"

#   with_fx :lpf, cutoff: co do
#     use_transpose -12

#     nts = ring(:C3, :Cs3, :E3, :E3, :F3, :G3, :F3)
#     lns = ring(2,1.5,1,0.5,1,1,1)
#     hds = ring(2,2,0.5,0.75, 1, 1, 1)
#     nts.each do |n|
#       hd = hds.tick(:holds)
#       play n,
#            attack: 0.05, attack_level: 1,
#            decay: 0.195*hd,
#            sustain: (0.2), sustain_level: 0.75,
#            release: 0.3*hd,
#            pulse_width: pw

#       sleep lns.tick(:lens)
#     end
#     nts1 = ring(:G3, :F3, :E3, :E3, :Cs3, :C3)
#     lns1 = ring(2,1.5,1,0.5,1,1)
#     hds1 = ring(2,2,0.5,0.75, 1, 1)
#     nts1.each do |n|
#       hd = hds1.tick(:holds1)
#       play n,
#            attack: 0.05, attack_level: 1,
#            decay: 0.2*hd,
#            sustain: 0.25*hd, sustain_level: 0.75,
#            release: 0.3*hd,
#            pulse_width: pw
#       sleep lns1.tick(:lens1)
#     end
#     sleep 1
#   end
# end