#### TOOLBOX ####

# VISUALIZATION HELPERS

define :viz do |type, selector, beats, val1|
  dur = 1000 * beats * 60/current_bpm
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
  color = '#5cc639'if color == 'sonic_green'
  color = '#3a62c1'if color == 'sonic_blue'
  color = '#f9de2a' if color == 'haus_yellow'

  viz 'color', selector, beats, color
end