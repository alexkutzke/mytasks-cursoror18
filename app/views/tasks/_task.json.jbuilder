json.extract! task, :id, :name, :done, :list_id, :created_at, :updated_at
json.url task_url(task, format: :json)
