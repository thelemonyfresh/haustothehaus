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


# louder, more prominent at peak
# define :garage_band do
#   with_fx :bpf, centre: range(60,120,10).mirror.tick, res: 0.01, res_slide: 4 do |bpf|
#     control bpf, res: 0.1
#     sample '/Users/daniel/recording/haus_samples', 'indigo',
#       rate: 1.0,
#       start: 0.049 ,
#       finish: 0.1
#   end
# end

define :gong_a do
  sample '/Users/daniel/recording/haus_samples', 'indigo',
    rate: 1.0,
    start: 0.172,
    finish: 0.205
end


# help
define :help do
  sample '/Users/daniel/recording/haus_samples', 'indigo',
    rate: 1,
    start: 0.448,
    finish: 0.450
end

define :palms do
  start = knit(0.0795, 2, 0.0845, 2, 0.0895, 2, 0.075, 2).tick(:palms) #0.075, 0.795, 0.81, 0.845, 0.87, 0.895, 0.945, 0.995
  len = 0.005
  #puts start
  #puts start + len
  with_fx :lpf, cutoff: range(70, 110, 5).mirror.tick do
    with_fx :echo , phase: 0.75 do
      sample '/Users/daniel/recording/haus_samples', 'palmiers',
             rate: 1.0,
             attack: 0.01, decay: 0.5, sustain: 0.25, release: 0.75,
             start: start,
             finish: start + len

    end
  end
end

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
  sample '/Users/daniel/recording/haus_samples', 'palmiers', amp: 0,
         rate: 1,
         start: 0.927,
         finish: 0.9773937007874016

  sample '/Users/daniel/recording/haus_samples', 'palmiers', amp: 0,
         rate: 1.546309,
         start: 0.511,
         finish: 0.5795039370078741
end

define :two_paths do

end