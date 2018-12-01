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
