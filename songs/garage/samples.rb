define :seem_to do
    sample '/Users/daniel/recording/haus_samples', 'indigo',
      rate: 1.03,
      start: 0.406,
      finish: 0.425
end

define :care do
  sample '/Users/daniel/recording/haus_samples', 'indigo',
    rate: 1,
    start: 0.43,
    finish: 0.4385
end

define :twang do
  sample '/Users/daniel/recording/haus_samples', 'indigo',
    rate: 1.0,
    start: 0.3472,
    finish: 0.3525
end

# help

define :help do
  sample '/Users/daniel/recording/haus_samples', 'indigo',
    rate: 1,
    start: 0.448,
    finish: 0.450
end

# yah
# 16

define :yah do
  in_thread do
    16.times do |n|
      sleep 0.5

      #with_fx :flanger, depth: range(0,8,1).mirror.tick, stereo_invert_wave: 1 do
      mx = range(0,0.8,0.125).mirror[n]
      puts mx
      with_fx :ixi_techno, res: 0.1, phase: 0.5, mix: mx do

        sample '/Users/daniel/recording/haus_samples', 'palmiers', amp: 1,
               attack: 0.025, decay: 0.1, sustain: 0.2, release: 0.2,
               cutoff: range(50,100,10).ramp.tick,
               rate: 1.0,
               start: 0.934,
               finish: 0.9395
        sleep 0.5
      end
    end
  end
  #end
end

define :du_garage do
  # du garage
  sample '/Users/daniel/recording/haus_samples', 'palmiers', amp: 1,
         rate: 1,
         start: 0.927,
         finish: 0.9773937007874016

  sample '/Users/daniel/recording/haus_samples', 'palmiers', amp: 1,
         rate: 1.546309,
         start: 0.511,
         finish: 0.5795039370078741
end

define :two_paths do
  2.times do
    with_fx :lpf, cutoff: range(60,120,10).mirror.tick do
      seem_to
      sleep 2.5
      care
      sleep 1.5
    end
  end
end