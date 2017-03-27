namespace :recommend do
  desc 'calculate recommended users for each user from follow relationships'
  task start_from_scratch: :environment do
    User.ids.sort.each do |id_1|
      User.where('id > ?', id_1).ids.each do |id_2|
        similarity = ApplicationController.helpers.cos_similarity(id_1, id_2)
        similarity_create_service = SimilarityCreateService.new(id_1, id_2, similarity)
        similarity_create_service.create_similarity
      end
    end
  end

  task daily_update: :environment do
    # new users => new empty similarity
    new_user_ids = User.where(created_at: 1.day.ago.all_day).ids
    existing_user_ids = User.ids - new_user_ids
    new_user_ids.each do |id_1|
      existing_user_ids.each do |id_2|
        similarity_create_service = SimilarityCreateService.new(id_1, id_2, 0)
        similarity_create_service.create_similarity
      end
      new_user_ids.select { |item| item > id_1 }.each do |id_2|
        similarity_create_service = SimilarityCreateService.new(id_1, id_2, 0)
        similarity_create_service.create_similarity
      end
    end

    # new follow_relationships => update similarity score
    new_relationships = FollowRelationship.where(created_at: 1.day.ago.all_day)
    changed_user_ids = new_relationships.uniq.pluck(:follower_user_id) | \
                       new_relationships.uniq.pluck(:followee_user_id)
    unchanged_user_ids = User.ids - changed_user_ids
    changed_user_ids.each do |id_1|
      unchanged_user_ids.each do |id_2|
        array1 = SimilaritiesUser.where(user_id: id_1).pluck(:similarity_id)
        array2 = SimilaritiesUser.where(user_id: id_2).pluck(:similarity_id)
        next unless (array1 & array2).present?
        similarity = Similarity.find((array1 & array2)[0])
        next unless similarity.update( \
          similarity: ApplicationController.helpers.cos_similarity(id_1, id_2))
      end
      changed_user_ids.select { |item| item > id_1 }.each do |id_2|
        array1 = SimilaritiesUser.where(user_id: id_1).pluck(:similarity_id)
        array2 = SimilaritiesUser.where(user_id: id_2).pluck(:similarity_id)
        next unless (array1 & array2).present?
        similarity = Similarity.find((array1 & array2)[0])
        next unless similarity.update( \
          similarity: ApplicationController.helpers.cos_similarity(id_1, id_2))
      end
    end
  end

  task hoge: :environment do
    puts 'hello world'
  end

  task hello: :environment do
    puts Time.current
  end
end
