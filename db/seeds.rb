# -*- coding: utf-8 -*-
table_names = %w( users tasks categories )

table_names.each do |table_name|
  path = Rails.root.join("db", "seeds", Rails.env, "#{table_name}.rb")
  if File.exists?(path)
    puts "Seeding #{table_name}..."
    require path
  end
end
