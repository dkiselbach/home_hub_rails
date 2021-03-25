# frozen_string_literal: true

json.pagination do
  json.total_pages collection.total_pages
  json.total_count collection.total_count
  json.current_page collection.current_page
  json.next_page collection.next_page
end
