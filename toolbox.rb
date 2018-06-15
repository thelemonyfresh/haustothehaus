#### TOOLBOX ####

define :ramp_in do |meth, times|
  with_fx :level, amp: range(0,1,(1.0/times)).ramp.tick(:meth) do
    send :meth
  end
end


define :animation_haus do |name, num_beats|
  duration = (current_bpm * num_beats / 60.0)
  osc "/#{name}/#{duration}"
end