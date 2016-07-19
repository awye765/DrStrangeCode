json.array!(@snippets) do |snippet|
  json.extract! snippet, :id, :name, :code
  json.url snippet_url(snippet, format: :json)
end
