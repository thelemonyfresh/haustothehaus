#### TOOLBOX ####

# VISUALIZATION HELPERS

define :viz do |type, selector, beats|
  dur = 1000 * beats * 60/current_bpm
  osc "/#{dur}/#{selector}/#{type}"
end

define :flash do |selector, beats|
  viz 'flash', selector, beats
end
