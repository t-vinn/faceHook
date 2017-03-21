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
    new_relationships = FollowRelationship.where('created_at > ?', Time.now - 1.days)
    changed_user_ids = new_relationships.uniq.pluck(:follower_user_id) & \
      new_relationships.uniq.pluck(:followee_user_id)
    unchanged_user_ids = User.ids - changed_user_ids
    changed_user_ids.each do |id_1|
      unchanged_user_ids.each do |id_2|
        a = Similarity.create(similarity: ApplicationController.helpers.cos_similarity(id_1, id_2))
        SimilaritiesUser.create(similarity_id: a.id, user_id: id_1)
        SimilaritiesUser.create(similarity_id: a.id, user_id: id_2)
      end
      changed_user_ids.where('id > ?', id_1).each do |id_2|
        a = Similarity.create(similarity: ApplicationController.helpers.cos_similarity(id_1, id_2))
        SimilaritiesUser.create(similarity_id: a.id, user_id: id_1)
        SimilaritiesUser.create(similarity_id: a.id, user_id: id_2)
      end
    end
  end
end
