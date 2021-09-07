json.array! @users do |user|
  json.call(
    user,
    :id, :email, :admin, :name, :confirmed_at
  )
end
