#### TOOLBOX ####

# VISUALIZATION HELPERS

define :viz do |type, selector, beats, amount1|
  dur = 1000 * beats * 60/current_bpm
  osc "/#{dur}/#{selector}/#{type}/#{amount1}"
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

define :translate_x do |selector, beats, pos|
  viz 'translateX', selector, beats, pos
end