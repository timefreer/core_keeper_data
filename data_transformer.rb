# frozen_string_literal: true

require 'json'

FILES = {
  items: './items.json'
}

def load_data(type)
  puts('Type must be FILES key') && return unless FILES.has_key?(type)

  $type = type
  $data = JSON.load_file(FILES[type])
end

def save_data!
  File.open(FILES[$type], 'w') do |file|
    file.write(JSON.pretty_generate($data))
  end
end

def delete_column(delete_column)
  delete_column_sym = delete_column.to_sym

  $data.each do |row|
    row.delete_if { |column, _| column.to_sym == delete_column_sym }
  end
end

def rename_column(current, new)
  current_string, new_string = [current, new].map(&:to_s)

  $data.each do |row|
    next unless row.has_key?(current_string)

    row.transform_keys!(current_string => new_string)
  end
end

load_data(:items)
rename_column(:type, :slot)
save_data!
