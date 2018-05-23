define :entourage do
  in_thread do
    with_fx :compressor do
      gs1 = garage_door_opts({start: 0.4, finish: 0.44,
                              attack: 0.01, release: 0.5,
                              pan: -0.9})
        control gs1, pan: 0.3
      at 0.9 do
        gs1 = garage_door_opts({start: 0.423, finish: 0.45,
                                attack: 0.075,
                                pan: -0.3})
        control gs1, pan: 0
      end
      at 1.85 do
        gs1 = garage_door_opts({start: 0.45, finish: 0.47,
                                attack: 0.14, attack_level: 1.2,
                                pan: 0})
        control gs1, pan: 0.5
      end
      at 4 do
        gs2 = garage_door_opts({start: 0.69, finish: 0.81,
                                pan: 1})
      end
    end
  end
end

define :entourage_times do |num_bars|
  # 1 rep len 8
  in_thread do
    num_bars.times do
      entourage
      sleep 8
    end
  end
end
