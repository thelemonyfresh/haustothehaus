haus_samps = "/Users/daniel/recording/haus_samples"

#
# Shared Sounds
#

define :haus do
  with_fx :gverb, damp: 0.98, pre_damp: 1, room: 9 do
    s = sample haus_samps, "house_stonemason", pan: 0.25, pan_slide: 2,
               start: 0.0236, finish: 0.9449, attack: 0.2205, decay: 0.5354, beat_stretch: 4, amp: 0.3,
               cutoff: 100
    control s, pan: -0.5
  end
  stop
end
