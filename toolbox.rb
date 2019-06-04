#### TOOLBOX ####

# FILE LOADERS

haus_samps = '/Users/daniel/recording/haus_samples'

run_file '/Users/daniel/src/haustothehaus/songs/garage/instruments.rb'
run_file '/Users/daniel/src/haustothehaus/songs/garage/sounds.rb'
run_file '/Users/daniel/src/haustothehaus/songs/garage/patterns.rb'

run_file '/Users/daniel/src/haustothehaus/songs/foyer/instruments.rb'
run_file '/Users/daniel/src/haustothehaus/songs/foyer/sounds.rb'
run_file '/Users/daniel/src/haustothehaus/songs/foyer/patterns.rb'

# VISUALIZATION HELPERS

define :viz do |type, selector, beats, val1, val2|
  dur = 1000 * beats * 60.0 / current_bpm
  osc "/#{dur}/#{selector}/#{type}/#{val1}/#{val2}"
end

define :flash do |selector, beats|
  viz 'flash', selector, beats, 0, ''
end

define :pulse do |selector, beats|
  viz 'pulse', selector, beats, 0, ''
end

define :rotate do |selector, beats, degrees|
  viz 'rotate', selector, beats, degrees, ''
end

define :color do |selector, beats, color|
  color = '#d6117a' if color == 'sonic_pink'
  color = '#5cc639' if color == 'sonic_green'
  color = '#3a62c1' if color == 'sonic_blue'
  color = '#f9de2a' if color == 'haus_yellow'

end

define :text do |text|
  viz 'text', '.above', 0, text, ''
end

define :falling_text do |text|
  viz 'falling_text', '', 8, text, '#d6117a'
end

define :tick_key do
  %w[h a u s].pick(16).join
end

#
# Helper methods
#

# give ring and amount between 0 and 1, it chooses

define :ring_amt do |rng, amt|
  length = rng.length
  rng[(length * amt).to_i]
end

# use like set(:garage, :A)

define :get_bank_val_or_default do |key,default|
  bank = get(key)
  puts "here"
  puts bank
  puts get(bank)
  return default if bank.nil?
  get(bank)
end

# play_synth_melody

#
# melody: hash like...
# {
#   notes: ring(:C,:A,:D...),
#   times: ring(1,2,1,1,...),
#   durations: ring(0.5, 0.5, 0.25,...)
# }

define :play_synth_melody do |synth, melody|
  in_thread do
    at melody[:times] do |time|
      time_index = melody[:times].index(time)
      send(synth, melody[:notes][time_index], melody[:durations][time_index])
    end
    sleep melody[:times].max
  end
end

#
# Ramp patterns.
#

define :ground_up do
  knit(0.1, 1, 0.25, 2, 0.9, 1)
end

define :ground_down do
  knit(0.1, 1, 0.5, 1, 0.9, 1)
end

define :sunrise do
  range(0, 1, 0.25)
end
