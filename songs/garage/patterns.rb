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
# 32
define :path do
  in_thread do
    16.times do
      start = knit(0.0795, 2, 0.0845, 2, 0.0895, 2, 0.075, 2).tick(:palms) #0.075, 0.795, 0.81, 0.845, 0.87, 0.895, 0.945, 0.995
      len = 0.005
      with_fx :lpf, cutoff: range(70, 110, 5).mirror.tick do
        with_fx :echo , phase: 0.75 do
          sample '/Users/daniel/recording/haus_samples', 'palmiers',
                 rate: 1.0,
                 attack: 0.01, decay: 0.5, sustain: 0.25, release: 0.75,
                 start: start,
                 finish: start + len

        end
      end
      sleep 2
    end
  end
end
