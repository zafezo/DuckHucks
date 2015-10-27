json.array!(@events) do |event|
  json.extract! event, :id, :title, :description, :user_id
  json.url event_url(event, format: :json)
end
