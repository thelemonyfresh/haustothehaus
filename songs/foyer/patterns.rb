haus_samps = "/Users/daniel/recording/samples/haus/"

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
    lightswitch(1-n)
  end
end

define :tile_bass do
  tile_bass_at(0)
end

define :tile_bass_at do |n|
  chrd = chord(:D2, :minor7)
  in_thread do
    tile(chrd[0], 4)

    sleep 4
    tile(chrd[1], 3) if n > 0.24
    sleep 4
    tile(chrd[3], 4) if n > 0.49
    sleep 6

    sleep 2
  end
end