#### TOOLBOX ####

# FILE LOADERS

haus_samps = '/Users/daniel/recording/samples/haus/'

run_file '/Users/daniel/recording/haustothehaus/songs/garage/instruments.rb'
run_file '/Users/daniel/recording/haustothehaus/songs/garage/sounds.rb'
run_file '/Users/daniel/recording/haustothehaus/songs/garage/patterns.rb'

run_file '/Users/daniel/recording/haustothehaus/songs/foyer/instruments.rb'
run_file '/Users/daniel/recording/haustothehaus/songs/foyer/sounds.rb'
run_file '/Users/daniel/recording/haustothehaus/songs/foyer/patterns.rb'

# VISUALIZATION HELPERS

define :viz do |type, selector, beats, val1|
  dur = 1000 * beats * 60 / current_bpm
  osc "/#{dur}/#{selector}/#{type}/#{val1}"
end

define :flash do |selector, beats|
  viz 'flash', selector, beats, 0
end

define :pulse do |selector, beats|
  viz 'pulse', selector, beats, 0
end

define :rotate do |selector, beats, degrees|
  viz 'rotate', selector, beats, degrees
end

define :color do |selector, beats, color|
  color = '#d6117a' if color == 'sonic_pink'
  color = '#5cc639' if color == 'sonic_green'
  color = '#3a62c1' if color == 'sonic_blue'
  color = '#f9de2a' if color == 'haus_yellow'

  viz 'color', selector, beats, color
end

define :text do |text|
  viz 'text', '.above', 0, text
end

define :tick_key do
  %w[h a u s].pick(16).join
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
