define :seem_to do
  with_fx :lpf, cutoff: range(60,120,10).mirror.tick do

    sample '/Users/daniel/recording/haus_samples', 'indigo',
      rate: 1.03,
      start: 0.406,
      finish: 0.425

  end
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
define :garage_band do
  with_fx :bpf, centre: range(60,120,10).mirror.tick, res: 0.01, res_slide: 4 do |bpf|
    control bpf, res: 0.1
    sample '/Users/daniel/recording/haus_samples', 'indigo',
      rate: 1.0,
      start: 0.049 ,
      finish: 0.1
  end
end

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
