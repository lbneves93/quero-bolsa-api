unless Rails.env.production?
  p 'Creating Universities...'
  universities = FactoryBot.create_list(:university, 10)

  p 'Creating Campus...'
  universities.each do |university|
    FactoryBot.create_list(:campus, 3, university: university)
  end

  p 'Creating Courses...'
  campus = Campus.all
  courses = FactoryBot.create_list(:course, 30)
  courses.each do |course|
    course.campus << campus.sample(3)
    course.save!
  end

  p 'Creating Offers...'
  courses.each do |course|
    course.campus.each do |campus|
      FactoryBot.create(:offer, campus: campus, course: course)
    end
  end

  p 'Creating Admin User...'
  User.create(username: 'admin', password: '123456', age: 28)
end
