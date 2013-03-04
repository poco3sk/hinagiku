# -*- coding: utf-8 -*-
module CategoriesHelper
  def link_for(category)
    links = [ link_to("修正", [ :edit, category ]) ]
    links << delete_link(category)
    links.join(" ")
  end
end
