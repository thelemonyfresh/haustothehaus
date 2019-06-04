haus_samps = '/Users/daniel/recording/haus_samples'

#
# Patterns.
#

# entourage
# 8

define :entourage do |amt = get_bank_val_or_default(:garage_bank, 0)|
  falling_text 'garage door'

  in_thread do

    ph = ring_amt(ring(1,1,0.5,0.25),amt)
    pr = 1 - amt/2.5
    mx = ring_amt(ring(0,1,1,1,amt),amt)

    with_fx :slicer, phase: ph, probability: pr, mix: mx  do
      with_fx :level, amp: 0.7 do
        with_fx :compressor do
          gs1 = garage_door_opts(start: 0.4, finish: 0.44,
                                 attack: 0.01, release: 0.5,
                                 pan: -0.9, pan_slide: 1)
          control gs1, pan: 0.2
          at 0.9 do
            gs2 = garage_door_opts(start: 0.423, finish: 0.45,
                                   attack: 0.075,
                                   pan: -0.3, pan_slide: 2)
            control gs2, pan: 0.3
          end
          at 1.85 do
            gs3 = garage_door_opts(start: 0.45, finish: 0.47,
                                   attack: 0.14, attack_level: 1.2,
                                   pan: 0, pan_slide: 1)
            control gs3, pan: 0.7
          end
          at 4 do
            gs4 = garage_door_opts(start: 0.69, finish: 0.81,
                                   pan: 0.75, pan_slide: 4)
            control gs4, pan: -0.5
          end
        end
      end
    end

  end
end

# roses
# 1

define :roses_at do |amt = get_bank_val_or_default(:garage_bank, 0.5)|
  in_thread do
    falling_text 'roses'
  end

  amt = 0.65 + amt * 0.35
  in_thread do
    with_fx :reverb, room: 0.7165354 do
      chord(:D4,:major7, invert: 1).reverse.each do |nt|
        co = ring(80*amt,110*amt**2,100*amt**3,100*amt)
        with_fx :lpf, cutoff: co.tick do

          thorny_synth(nt,0.25)
        end
        sleep 0.25
      end
    end
  end
end

# bassment
# 16

define :bassment do |amt = get_bank_val_or_default(:garage_bank, 0)|
  nts = scale(:E2, :minor_pentatonic)

  falling_text 'bassment'

  in_thread do
    if amt < 0.05
      with_fx :level, amp: 0.6 do
        sub_bass_synth(nts[0], 16)
      end

      sleep 16

    elsif amt < 0.3
      with_fx :level, amp: 0.5 + amt do
        with_fx :slicer, phase: 1,
                pulse_width: 0.5,
                wave: 3,
                smooth: 0.0125,
                mix: amt/0.3 do
          sub_bass_synth(nts[0], 16)
        end
      end

      16.times do |n|
        sleep 0.5
        sub_bass_synth(nts[0], 0.4)
        sleep 0.5
      end
    elsif amt < 0.35
      16.times do |n|
        patt = knit(0, 15, 2, 1)
        bass_note = nts[patt.tick(:bassment_notes)]

        sleep 0.5
        sub_bass_synth(bass_note, 0.4)
        sleep 0.5
      end
    elsif amt < 0.55
      16.times do
        note_num = knit(0, 7, 2, 1, 0, 6, 4, 1, 2, 1).tick(:bassment_notes)
        puts nts[note_num]
        sleep 0.5
        sub_bass_synth(nts[note_num], 0.4)
        sleep 0.5
      end
    elsif amt < 0.755
      16.times do
        note_num = knit(0, 3, 2, 1, 0, 3, 4, 1, 0, 3, 2, 1, 0, 1, 5, 1, 3, 1, 2, 1, 1, 1).tick(:bassment_notes)
        puts nts[note_num]
        sleep 0.5
        sub_bass_synth(nts[note_num], 0.4)
        sleep 0.5
      end

    elsif amt < 0.95
      16.times do |n|
        div = [1, 2, 4, 8, 16][((amt - 0.8) * 50).to_i]
        puts div
        sleep 0.5
        sub_bass_synth(nts[0], 0.4) if n % div == 0
        sleep 0.5
      end

    end
  end
end

# windy melody
# 32

define :windy_melody do |amt = get_bank_val_or_default(:garage_bank, 0.5)|
  falling_text'windy'
  in_thread do
    nts = scale(:D, :minor_pentatonic, invert: 2)

    with_fx :slicer, phase: 0.25, mix: amt do
      3.times do
        2.times do |n|
          windy_synth(nts[3], 0.5)
          sleep 0.5
        end
        sleep 1
        windy_synth(nts[0], 2)
        sleep 6
      end
      windy_synth(nts[5], 2)
      sleep 2
      windy_synth(nts[1], 1)
      sleep 3
    end
  end
end

# windchimes
# 32

define :windchimes_at do |amt = get_bank_val_or_default(:garage_bank, 0)|
  in_thread do
    windchime_num(0)
    sleep 8
    windchime_num(1) if amt > 0.24
    sleep 8
    windchime_num(2) if amt > 0
    sleep 8
    windchime_num(0) if amt > 0.6
    sleep 8
  end
end