namespace :recommend do
  desc 'calculate recommended users for each user from follow relationships'
  task start_from_scratch: :environment do
    User.ids.sort.each do |id_1|
      User.where('id > ?', id_1).ids.each do |id_2|
        a = Similarity.create(similarity: ApplicationController.helpers.cos_similarity(id_1, id_2))
        SimilaritiesUser.create(similarity_id: a.id, user_id: id_1)
        SimilaritiesUser.create(similarity_id: a.id, user_id: id_2)
      end
    end
  end

  task daily_update: :environment do
    new_relationships = FollowRelationship.where(created_at: 1.day.ago.all_day)
    changed_user_ids = new_relationships.uniq.pluck(:follower_user_id) & \
                       new_relationships.uniq.pluck(:followee_user_id)
    unchanged_user_ids = User.ids - changed_user_ids
    changed_user_ids.each do |id_1|
      unchanged_user_ids.each do |id_2|
        array1 = SimilarityUser.where(user_id: id_1).pluck(:similarity_id)
        array2 = SimilarityUser.where(user_id: id_2).pluck(:similarity_id)
        similarity = Similarity.find((array1 & array2)[0])
        next unless similarity.update( \
          similarity: ApplicationController.helpers.cos_similarity(id_1, id_2))
      end
      changed_user_ids.where('id > ?', id_1).each do |id_2|
        array1 = SimilarityUser.where(user_id: id_1).pluck(:similarity_id)
        array2 = SimilarityUser.where(user_id: id_2).pluck(:similarity_id)
        similarity = Similarity.find((array1 & array2)[0])
        next unless similarity.update( \
          similarity: ApplicationController.helpers.cos_similarity(id_1, id_2))
      end
    end
  end
end
