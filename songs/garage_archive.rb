run_file "/Users/daniel/recording/haustothehaus/toolbox.rb"
use_bpm 128
haus_samps = "/Users/daniel/recording/samples/haus/"

#
# SOUNDS
#

define :door_latch do |hsh|
  sample haus_samps, "door", hsh,
    beat_stretch: 2,
    lpf: 100
end

define :garage_door_full do
  garage_door({start: 0, finish: 1})
end

define :garage_door do |hsh|
  sample haus_samps, "door_garage", hsh
end

define :garage_door_mod do |hsh|
  sample haus_samps, "door_garage", hsh,
    lpf: (hsh[:cutoff_dec].nil? ?  -1 : hsh[:cutoff_dec]*130),
    pan: 0,
    pan_slide: 4
end

define :haus_bd do |i|
  return if i == 0
  sample :bd_haus, lpf: 100*i
  play 25,
    attack: 0.05,
    decay: 0.05,
    sustain: 0.07,
    release: 0.125,
    lpf: 100*i
end

define :big_horn do |hsh|
  sample haus_samps, "brown_horns", hsh, beat_stretch: 4,
    lpf: (hsh[:cutoff_dec].nil? ? 130 : hsh[:cutoff_dec]*130)
end

define :car_door_close do
  #takes 4 beats, door close on 4
  sample haus_samps, "car",start: 0.0929, finish: 0.17, amp: 2
end

define :car_door_hat do |hsh|
  sample haus_samps, "car", hsh,
    start: 0.171, finish: 0.169,
    sustain: 0.6,
    decay: 0.05,
    hpf: 50,
    amp: (hsh[:amp] || 2)
end

define :horn_bass do |hsh|
  with_fx :lpf, cutoff: 110 do
    with_fx :gverb, damp: 0.98, pre_damp: 1, room: 9 do
      sample haus_samps, "brown_horns", hsh, beat_stretch: 16,
        amp: 1,
        attack: 0.02,
        decay: 0.02,
        lpf: (hsh[:cutoff_dec].nil? ? 130 : hsh[:cutoff_dec]*130)
    end
  end
end

define :creaky_door do |hsh|
  sample haus_samps, "door_creak", hsh,
    amp: 10
end

define :animal_haus do
  with_fx :gverb, damp: 0.98, pre_damp: 1, room: 9 do
    sample haus_samps, "house_stonemason",
      start: 0.0236, finish: 0.9449, attack: 0.2205, decay: 0.5354, beat_stretch: 4, amp: 0.5,
      cutoff: 100
  end
end

define :shake_it_keys do |hsh|
  sample haus_samps, "haus_keys", beat_stretch: 16,
    start: 0.4567, finish: 0.5827
end

#
#
# PARTS
#
#

define :come_inside do |num_times|
  in_thread do
    num_times.times do
      pp(16, [
           [:creaky_door, [1,3], {start: 0.26, finish: 0.29, pan: -0.7}],
           [:creaky_door, [2,4], {start: 0.23, finish: 0.26, pan: 0.5}],
           [:creaky_door, [6.5,7.5], {start: 0.225, finish: 0.24, pan: -0.2}],
           [:creaky_door, [9], {start: 0.23, finish: 0.4}]
      ])
    end
  end
end

define :horny_bass_ramp do |num_bars|
  # 1 rep len 8
  in_thread do
    s1 = 0.05
    s2 = 0.08
    num_bars.times do |n|
      co = ((n/num_bars.to_f))
      pp(8, [
           [:horn_bass, [1,5],{start: s1, finish: 0.13, cutoff_dec: co}],
           [:horn_bass, [6.5],{start: s2, finish: 0.15, sustain: 0.2, decay: 0.05, cutoff_dec: co}],
           [:horn_bass, [7.5],{start: s2, finish: 0.15, sustain: 0.2, decay: 0.05, cutoff_dec: co}]
      ])
    end
  end
end

define :horny_bass_fade do |num_bars|
  # 1 rep len 8
  in_thread do
    num_bars.times do |n|
      amps = (1-(n/num_bars.to_f))
      pp(8, [
           [:horn_bass, [1,5],{start: 0.05, finish: 0.13, amp: amps}]
      ])
    end
  end
end

define :horny_bass do |num_bars|
  # 1 rep len 8
  s1 = 0.05
  s2 = 0.08
  in_thread do
    num_bars.times do |n|
      pp(8, [
           [:horn_bass, [1,5],{start: s1, finish: 0.125}],
           [:horn_bass, [6.5],{start: s2, finish: 0.125}],
           [:horn_bass, [7.5],{start: s2, finish: 0.125}]
      ])
    end
  end
end

define :blades_ramp do |num_bars|
  # 1 rep len 8
  in_thread do
    num_bars.times do |n|
      pp(8, [
           [:car_door_hat, [1.5,5.5,6.5], {amp: 2*(n/num_bars.to_f)}]
      ])
    end
  end
end

define :blades_mod do |num_bars|
  # 1 rep len 8
  in_thread do
    num_bars.times do
      pp(8, [
           [:car_door_hat, [1.5, 2.5, 4.5, 5.5, 6.5, 7.5], {}],
      ])
    end
  end
end

define :blades do |num_bars|
  # 1 rep len 8
  in_thread do
    num_bars.times do
      pp(8, [
           [:car_door_hat, [1.5, 2.5, 3.5, 4.5, 5.5, 6.5, 7.5], {}],
      ])
    end
  end
end

define :windward_ramp do |num_bars|
  # 1 rep len 16
  in_thread do
    num_bars.times do
      s = sample haus_samps, "wind_2", start: 0.005, finish: 0.0365, amp: 0.3, amp_slide: 12
      control s, amp: 1.5
      sleep 16
    end
  end
end

define :haus_keys do |num_bars|
  # 1 rep len 16
  in_thread do
    num_bars.times do
      sample haus_samps, "haus_keys", beat_stretch: 16
      sleep 16
    end
  end
end

define :jingle_haus do |hsh|
  # 1 rep len 4
  in_thread do
    sample haus_samps, "haus_keys", beat_stretch: 16,
      start: 0.1811, finish: 0.4016
  end
end

define :windward do |num_bars|
  # 1 rep len 16
  in_thread do
    num_bars.times do
      sample haus_samps, "wind_2", start: 0.005, finish: 0.04, attack: 2, sustain: 12, decay: 2
      sleep 16
    end
  end
end

define :entourage do |num_bars|
  # 1 rep len 8
  in_thread do
    num_bars.times do
      8.times do |n|
        if n%8 == 0
          gs1 = garage_door_mod({start: 0.4, finish: 0.45, cutoff_dec: 1})
          control gs1, pan: 0.8
        end
        if n%8 == 4
          gs2 = garage_door_mod({start: 0.69, finish: 0.81, cutoff_dec: 1})
          control gs2, pan: 0.8
        end
        sleep 1
      end
    end
  end
end

#
#
# SECTIONS
#
#


define :driveway do
  cue :driveway
  entourage(7)
  64.times do |n|
    haus_bd((n/90.0))
    if n == 32
      sample haus_samps, "car", beat_stretch: 32
    end
    if n == 60
      car_door_close
    end
    sleep 1
  end

  with_fx :echo, phase: 1, decay: 4, amp: 1.6 do
    5.times do |n|
      door_latch({start: 0.25, finish: 1, rate: 0.3*(n+1)})
      sleep 0.5
    end
  end
  sleep 5.5
end

define :walkway do
  cue :walkway

  96.times do |n|
    big_horn({cutoff_dec: (1-(n/128.0))}) if n%8 == 0
    windward_ramp(1) if n == 80
    haus_bd(1) if n < 87
    haus_bd(1-((n-86)/10.0)) if n > 86
      blades_ramp(7) if n == 32
      door_latch({start: 0.25, finish: 0.4, rate: 1}) if n%2 == 1
      entourage(8) if n == 32
      sleep 1
    end
  end

  define :doorstep_1 do
    cue :doorstep_1
    horny_bass(8)
    64.times do |n|
      blades_mod(4) if n == 32
      big_horn({}) if n%8 == 0
      haus_bd(1)
      door_latch({start: 0.25, finish: 0.4, rate: 1}) if n%2 == 1
      entourage(4) if n == 32
      sleep 1
    end
  end

  define :doorstep_2 do
    cue :doorstep_2
    blades(4)
    horny_bass(4)
    windward_ramp(2)
    entourage(4)
    32.times do |n|
      big_horn({}) if n%8 == 0
      haus_bd(1)
      door_latch({start: 0.25, finish: 0.4, rate: 1}) if n%2 == 1
      sleep 1
    end
  end

  define :go_away do
    cue :go_away
    horny_bass_ramp(16)
    blades_mod(16)
    come_inside(8)
    haus_keys(8)
    128.times do |n|
      # haus_bd(0.5)
      door_latch({start: 0.25, finish: 0.4, cutoff_dec: 1}) if n%2 == 1
      entourage(8) if n == 32
      if n%8 == 1
        s = ring(0,0.75,0,0.75).tick
        puts s, s+0.25
        big_horn({start: s, finish: s+0.25, cutoff_dec: 1})
      end

      sleep 1
    end
  end

  define :doorstep_fade do
    cue :doorstep_fade
    blades(3)
    windward(4)
    entourage(7)
    horny_bass_fade(4)
    64.times do |n|
      puts n
      haus_bd(1) if n < 62
      fs = knit(0.25,4,0.5,4,0.75,4)
      ss = knit(0,4,0.25,4,0.5,4)
      big_horn({start: ss.tick, finish: fs.tick, cutoff_dec: 1}) if (n%7 == 3 && n < 63)
      door_latch({start: 0.25, finish: 0.4, rate: 1}) if n%2 == 1
      sleep 1
    end
          pp(8, [
            [:creaky_door, [1,3], {start: 0.26, finish: 0.29, pan: -0.7}],
            [:creaky_door, [2,4], {start: 0.23, finish: 0.26, pan: 0.5}],
            [:creaky_door, [6.5,7.5], {start: 0.225, finish: 0.24, pan: -0.2}]
     ])
    sleep 2
  end

  define :doorstep_all_in do
    cue :doorstep_all_in
    horny_bass(4)
    windward_ramp(2)
    entourage(4)
    come_inside(2)
    32.times do |n|
      jingle_haus({amp: 1+(n/32)}) if n%8 == 4
    big_horn({}) if n%8 == 0
    haus_bd(1)
    door_latch({start: 0.25, finish: 0.4, rate: 1}) if n%2 == 1
    sleep 1
  end
  windward(1)
  pp(8,[
       [:creaky_door, [1], {start: 0.23, finish: 0.4}]
  ])
  sleep 8
end


#
#
# SONG
#
#
uncomment do
  garage_door_full
  sleep 16
  driveway
  walkway
  doorstep_1
  haus_bd(1)
  animal_haus
  sleep 4
  jingle_haus(1)
  4.times do
    haus_bd(1)
    sleep 1
  end
  go_away
  doorstep_2
  doorstep_fade
  doorstep_all_in
  windward(1)
  sleep 16
end
