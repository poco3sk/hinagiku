# -*- coding: utf-8 -*-
module ApplicationHelper
  def delete_link(obj)
    link_to "削除", obj, method: :delete, confirm: "本当に削除しますか？"
  end
end
