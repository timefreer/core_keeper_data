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
  _delete_column_sym = delete_column.to_sym

  $data.each do |row|
    row.delete_if { |column, _| column.to_sym == _delete_column_sym }
  end
end

load_data(:items)
delete_column(:damage_per_second)
save_data!
