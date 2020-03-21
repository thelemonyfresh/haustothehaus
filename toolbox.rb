#### TOOLBOX ####

# FILE LOADERS

haus_samps = '/Users/daniel/recording/haus_samples'

run_file '/Users/daniel/src/haustothehaus/songs/garage/instruments.rb'
run_file '/Users/daniel/src/haustothehaus/songs/garage/sounds.rb'
run_file '/Users/daniel/src/haustothehaus/songs/garage/patterns.rb'
run_file '/Users/daniel/src/haustothehaus/songs/garage/samples.rb'

run_file '/Users/daniel/src/haustothehaus/songs/foyer/instruments.rb'
run_file '/Users/daniel/src/haustothehaus/songs/foyer/sounds.rb'
run_file '/Users/daniel/src/haustothehaus/songs/foyer/patterns.rb'

run_file "/Users/daniel/src/talldan_sonicpi/numark_sampler.rb"

# VISUALIZATION HELPERS


define :viz do |message, beats, val1=nil, val2=nil|
  dur = 1000 * beats * 60.0 / current_bpm
  puts message
  puts beats
  puts val1
  osc message, dur, val1, val2
end

define :blink do |selector, beats|
  viz '/blink', beats, selector
end

define :gif do |filename, beats|
  viz '/gif', beats, filename
end

define :pulse do |selector, beats|
  viz '/pulse', beats, selector
end

# define :flash do |selector, beats|
#   viz 'flash', selector, beats, 0, ''
# end

# define :pulse do |selector, beats|
#   viz 'pulse', selector, beats, 0, ''
# end

# define :rotate do |selector, beats, degrees|
#   viz 'rotate', selector, beats, degrees, ''
# end

# define :color do |selector, beats, color|
#   color = '#d6117a' if color == 'sonic_pink'
#   color = '#5cc639' if color == 'sonic_green'
#   color = '#3a62c1' if color == 'sonic_blue'
#   color = '#f9de2a' if color == 'haus_yellow'
#   viz 'color', selector, beats, color, ''
# end

# define :text do |text|
#   viz 'text', '.above', 0, text, ''
# end

# define :falling_text do |text, duration|
#   viz 'falling_text', '', duration, text, '#d6117a'
# end

# define :cue_position do |new_total, bank|
#   viz 'cue_position', bank, 0, new_total, ''
# end

# define :tick_key do
#   %w[h a u s].pick(16).join
# end

#
# Helper methods
#

# give ring and amount between 0 and 1, it chooses

define :ring_amt do |rng, amt|
  length = rng.length
  rng[(length * amt).to_i]
end

# use like set(:garage, :A)

define :get_bank_val_or_default do |key, default|
  val = get(key)
  return default if val.nil?
  val
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
  end
end

[[:two,2],[:four,4],[:eight,8],[:sixteen,16],[:thirty_two,32]].each do |n|
  define n[0] do |&block|
    in_thread do
      n[1].times do

        block.call
      end
    end
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
