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
  in_thread do
    tile(:D2, 12)
    sleep 16
    ch = chord(:D2, :major7).reverse.tick(:tile_bass_notes)
    4.times do
      tile(ch, 2) if one_in(8-(n*7))
      sleep 2
    end
  end
end