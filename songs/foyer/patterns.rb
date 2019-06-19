haus_samps = '/Users/daniel/recording/samples/haus/'

define :switcher do
  switcher_at(0)
end

define :switcher_at do |n|
  with_fx :echo, phase: 1, decay: 1, mix: n do
    lightswitch(1)
  end
end

define :lights do
  lights_at(0)
end

define :lights_at do |n|
  with_fx :krush, mix: n do
    lightswitch(1 - n)
  end
end

define :tile_bass do
  tile_bass_at(0)
end

# define :tile_bass_at do |n|
#   chrd = chord(:D2, :minor7)
#   in_thread do
#     at knit do
#     end
#     sleep 16
#   end
# end

define :doorbell do
  in_thread do
    with_fx :slicer, phase: 0.125, phase_slide: 8, wave: 1, amp_min: 0.5 do |sl|
      with_fx :compressor, threshold: 0.5, slope_above: 1, slope_below: 0.6 do
        with_fx :hpf, cutoff: note(:E4) do
          s = sample haus_samps, 'bells', amp: 1, amp_slide: 8, onset: 1,
                     attack: 0.125, attack_level: 1.25,
                     decay: 3, release: 0.5
          control sl, phase: 1
          control s, amp: 1.5
        end

      end
    end
  end
end
