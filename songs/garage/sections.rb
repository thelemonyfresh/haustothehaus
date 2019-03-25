define :garage_intro do
  ##| car
  ##| sleep 8
  ##| garage_door
  ##| sleep 8

  ##| entourage
  ##| sleep 8
  ##| entourage
  ##| car_door_close
  ##| sleep 8
  ##| 4.times do
  ##|   entourage
  ##|   car_door_close
  ##|   keys
  ##|   sleep 8
  ##| end

  ### BD DROP AND BASS BUILD

  in_thread do
    4.times do
      with_fx :slicer, phase: 1 do
        entourage
      end

      car_door_close
      sleep 8
    end
  end

  in_thread do
    32.times do
      gravel_bd
      sleep 0.5
      haus_keys
      sleep 0.5
    end
  end

  in_thread do
    4.times do
      bassment_at(range(0, 0.4, 0.1).ramp.tick(:bassment_ramp))
      sleep 16
    end
  end
  sleep 4
  cue :garage_main

end
