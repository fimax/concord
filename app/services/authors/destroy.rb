class Authors::Destroy
  def call(author)
    errors = []

    author.transaction do
      new_courses_author = Author.where.not(id: author.id).last

      # Что делать в случае, если это был последний автор в базе, в требованиях не сказано
      if new_courses_author.blank?
        new_courses_author = Author.new(first_name: 'System', last_name: 'Author')

        unless new_courses_author.save
          errors = new_courses_author.errors.full_messages
          raise ActiveRecord::Rollback
        end
      end

      author.courses.update_all(author_id: new_courses_author.id)

      unless author.destroy
        errors = author.errors.full_messages
        raise ActiveRecord::Rollback
      end
    end

    {
      success: errors.blank?,
      errors:  errors
    }
  end
end
