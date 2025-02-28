# Clear existing data (optional but useful for development)
EventLocation.destroy_all
Event.destroy_all
User.destroy_all
Role.destroy_all

# Create roles
roles = %w[admin participant organizer companion]
roles.each { |role| Role.find_or_create_by(name: role) }
puts "Roles created: #{roles.join(', ')}"

# Create an admin user
admin = User.create!(
  first_name: "Admin",
  last_name: "User",
  email: "admin@example.com",
  password: "password123",
  password_confirmation: "password123",
  date_of_birth: "1980-01-01",
  gender: "male"
)
admin.add_role(:admin)
puts "Admin user created: #{admin.email}"

# Create other users
users = [
  { first_name: "John", last_name: "Doe", email: "john@example.com", gender: "male", role: :participant },
  { first_name: "Jane", last_name: "Smith", email: "jane@example.com", gender: "female", role: :organizer },
  { first_name: "Alex", last_name: "Brown", email: "alex@example.com", gender: "other", role: :companion }
]

users.each do |user_data|
  user = User.create!(
    first_name: user_data[:first_name],
    last_name: user_data[:last_name],
    email: user_data[:email],
    password: "password123",
    password_confirmation: "password123",
    date_of_birth: "1990-06-15",
    gender: user_data[:gender]
  )
  user.add_role(user_data[:role])
  puts "User created: #{user.email} (Role: #{user_data[:role]})"
end

# Create events
5.times do |i|
  event = Event.create!(
    title: "Event ##{i + 1}",
    description: "This is a sample event description for event ##{i + 1}.",
    start_time: Time.now + (i + 1).days,
    end_time: Time.now + (i + 1).days + 2.hours,
    maximum_participants: rand(10..100),
    user: User.where.not(id: admin.id).sample
  )

  # Add event location
  event.create_event_location!(
    laltitude: rand(-90.0..90.0).round(6),
    longitude: rand(-180.0..180.0).round(6),
    name: "Sample Location ##{i + 1}"
  )

  puts "Event created: #{event.title} (Organizer: #{event.user.email})"
end

puts "Database seeding completed successfully!"
