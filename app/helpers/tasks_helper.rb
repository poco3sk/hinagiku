# -*- coding: utf-8 -*-
module TasksHelper
  def link_for(task)
    links = [ link_to("修正", [ :edit, task ]) ]
    if task.done?
      links << link_to("戻す", [ :restart, task ], method: :put)
    else
      links << link_to("完了", [ :finish, task ], method: :put)
    end

    links << delete_link(task)
    links.join(" ")
  end
end
