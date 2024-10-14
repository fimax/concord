competence_1 = Competence.create(name: 'Competence 1')
competence_2 = Competence.create(name: 'Competence 2')
competence_3 = Competence.create(name: 'Competence 3')
competence_4 = Competence.create(name: 'Competence 4')
competence_5 = Competence.create(name: 'Competence 5')

author_1 = Author.create(first_name: 'First', last_name: 'Author')
author_2 = Author.create(first_name: 'Second', last_name: 'Author')
author_3 = Author.create(first_name: 'Third', last_name: 'Author')

course_1_1 = Course.create(author: author_1, name: 'Course 11', description: 'Description 11')
CourseCompetence.insert_all([
  { course_id: course_1_1.id, competence_id: competence_1.id, created_at: Time.current, updated_at: Time.current },
  { course_id: course_1_1.id, competence_id: competence_3.id, created_at: Time.current, updated_at: Time.current },
  { course_id: course_1_1.id, competence_id: competence_4.id, created_at: Time.current, updated_at: Time.current }
])

course_1_2 = Course.create(author: author_1, name: 'Course 12', description: 'Description 12')
CourseCompetence.insert_all([
  { course_id: course_1_2.id, competence_id: competence_3.id, created_at: Time.current, updated_at: Time.current },
  { course_id: course_1_2.id, competence_id: competence_4.id, created_at: Time.current, updated_at: Time.current }
])

course_2_1 = Course.create(author: author_2, name: 'Course 21', description: 'Description 21')
CourseCompetence.insert_all([
  { course_id: course_2_1.id, competence_id: competence_2.id, created_at: Time.current, updated_at: Time.current },
  { course_id: course_2_1.id, competence_id: competence_5.id, created_at: Time.current, updated_at: Time.current }
])

course_2_2 = Course.create(author: author_2, name: 'Course 22', description: 'Description 22')
CourseCompetence.insert_all([
  { course_id: course_2_2.id, competence_id: competence_2.id, created_at: Time.current, updated_at: Time.current }
])

course_3_1 = Course.create(author: author_3, name: 'Course 31', description: 'Description 31')

course_3_2 = Course.create(author: author_3, name: 'Course 32', description: 'Description 32')
CourseCompetence.insert_all([
  { course_id: course_3_2.id, competence_id: competence_1.id, created_at: Time.current, updated_at: Time.current },
  { course_id: course_3_2.id, competence_id: competence_2.id, created_at: Time.current, updated_at: Time.current }
])

course_3_3 = Course.create(author: author_3, name: 'Course 33', description: 'Description 33')
CourseCompetence.insert_all([
  { course_id: course_3_3.id, competence_id: competence_1.id, created_at: Time.current, updated_at: Time.current },
  { course_id: course_3_3.id, competence_id: competence_2.id, created_at: Time.current, updated_at: Time.current },
  { course_id: course_3_3.id, competence_id: competence_3.id, created_at: Time.current, updated_at: Time.current },
  { course_id: course_3_3.id, competence_id: competence_4.id, created_at: Time.current, updated_at: Time.current },
  { course_id: course_3_3.id, competence_id: competence_5.id, created_at: Time.current, updated_at: Time.current }
])
