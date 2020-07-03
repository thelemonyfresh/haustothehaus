haus_samps = "/Users/daniel/recording/haus_samples"

define :garage_door do |current_time = nil|
  if !current_time.nil? && current_time % 32 == 0
    with_fx :flanger, mix: 0.6, phase: 8, delay: 5 do
      sample haus_samps, "west_garage_door", amp: 0.8
    end
  end
end

define :keys do |current_time = nil|
  if current_time.nil? || current_time % 16 == 0
    with_fx :reverb, room: 0.1, mix: 0.4, damp: 0.6  do
      sample haus_samps, "neu_haus_keys", amp: 1.5, start: 0.087, finish: 0.44, release: 1
    end
  end
end

define :car do |current_time = nil|
  if current_time.nil? || current_time % 32 == 0
    sample haus_samps, "car"
  end
end

define :car_door_close do |current_time = nil|
  if current_time.nil? || current_time % 8 == 0
  # door close on 5

  in_thread do
    with_fx :reverb, room: 0.8 , mix: 0, mix_slide: 0.25, damp: 0.9 do |fx|
      sample haus_samps, "car",
             start: 0.1068, finish: 0.1695
      sleep 4
      control fx, mix: 0.3
    end
  end
  end
end

define :windchime do |current_time = nil|
  if current_time.nil? || current_time % 32 == 0

    sample haus_samps, 'bells.aif',
           beat_stretch: 32
  end
end

define :windy_melody do |current_time = nil|
  if current_time.nil? || current_time % 4 == 0
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
end

define :path do |current_time = nil|
  if current_time.nil? || current_time % 4 == 0
    # Cs, A, Fs, B -- Fminor, Dmaj, Bmaj
    in_thread do
      16.times do
        start = knit(0.0795, 2, 0.085, 2, 0.0895, 2, 0.075, 2).tick(:path_start)
        #0.075, 0.795, 0.81, 0.845, 0.87, 0.895, 0.945, 0.995
        finish = knit(0.085,2, 0.0895,2, 0.094,2, 0.079,2).tick(:path_finish)
        with_fx :echo , phase: 0.75, decay: 2 do
          sample '/Users/daniel/recording/haus_samples', 'palmiers', amp: 1,
                 rate: 1.0,
                 start: start,
                 finish: finish

        end
        sleep 2
      end
    end
  end
end

define :bushes do |current_time = nil|
  if current_time.nil? || current_time % 4 == 0
    in_thread do
      use_synth :tb303
      puts look
      nts = knit(:Fs2, 5, :A2, 4, :Cs2, 1)
      32.times do |n|
        bangles = spread(5,16).tick(:spread)
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
end

# sub-bass synth line

# wind should be underneath, heavily down and eq'd to fill in the separate parts
