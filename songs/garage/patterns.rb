haus_samps = '/Users/daniel/recording/haus_samples'

#
# Patterns.
#

# windy melody
# 32
define :windy_melody do |amt = get_bank_val_or_default(:garage_amt, 0.5)|
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

# path
# 8
define :path do
  # Cs, A, Fs, B -- Fminor, Dmaj, Bmaj
  in_thread do
    16.times do
      start = knit(0.0795, 2, 0.085, 2, 0.0895, 2, 0.075, 2).tick(:path_start) #0.075, 0.795, 0.81, 0.845, 0.87, 0.895, 0.945, 0.995
      finish = knit(0.085,2, 0.0895,2, 0.094,2, 0.079,2).tick(:path_finish)
      with_fx :echo , phase: 0.75, decay: 2 do
        #with_fx :nbpf, centre: range(80, 120, 5).mirror.tick, res: 0.1, amp: 0.5, mix: 0.5 do
        sample '/Users/daniel/recording/haus_samples', 'palmiers', amp: 1,
               rate: 1.0,
               start: start,
               finish: finish

      end
      #end
      sleep 2
    end
  end
end

# bushes
# 8
define :bushes do
  in_thread do
    use_synth :tb303

    #nts = knit(:Fs2, 1, :A2, 4, :Cs3, 2, :B2, 3)
    nts = knit(:Fs2, 5, :A2, 4, :Cs2, 1)
    32.times do |n|
      #puts n
      bangles = spread(5,16).tick(:spread)
      #puts bangles
      if bangles
        use_synth :tb303
        play nts.tick(:notes),
             amp: 0.2,
             pan: 0,
             attack: 0, decay: 0, sustain: 0, release: ring(0.25,0.35).tick(:len),
             cutoff: range(80,120,5).tick(:cutoff_ramp),
             cutoff_min: 50,
             res: range(0.82,0.98,0.1).mirror.tick(:res_ramp)
      end
      sleep 0.25
    end
  end
end


# inside
# 32
define :inside do
  path
  car
  in_thread do
    4.times do
      keys
     # windy_synth :B5, 8
      sleep 8
    end
  end
  in_thread do
    32.times do
      sleep 0.5
      sub_bass_synth knit(:Cs2,7,:Fs2,1).tick, 0.5
      sleep 0.5
    end
  end
end

# outside
# 32

define :garage_b do
  path
  haus_garage_door

  in_thread do
    4.times do
      car_door_close
      bushes
      sleep 8
    end
  end

  in_thread do
    4.times do
      sleep 0.5
      sub_bass_synth knit(:Cs2,3,:B2,1).tick, 0.5
      sleep 7.5
    end
  end
end

# upside down
# 32
define :upside_down do
  #???

  in_thread do
    4.times do
      windy_synth :B5, 8
      sleep 8
    end
  end
end