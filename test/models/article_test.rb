require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
	test "presence" do
		article = Article.new
		assert article.invalid?
		assert article.errors.include?(:title)
		assert article.errors.include?(:body)
		assert article.errors.include?(:released_at)
	end

	test "length" do
		article = FactoryGirl.build(:article)
		article.title = "A"*201
		assert article.invalid?
		assert article.errors.include?(:title)
	end

	test "exipired_at" do
		article = FactoryGirl.build(:article) # FactoryGirl.build(:article)
		article.released_at = Time.current
		article.expired_at = 1.days.ago
		article.save
		assert article.invalid?
		assert article.errors.include?(:expired_at)
	end

	test "no_exiration" do
		article = FactoryGirl.build(:article)
		article.no_expiration = true
		assert article.valid?
		assert_nil article.expired_at
	end

	test "open" do
		article1 = FactoryGirl.create(:article, title: "now", released_at: 1.days.ago, expired_at: 1.days.from_now)
		article2 = FactoryGirl.create(:article, title: "past", released_at: 2.days.ago, expired_at: 1.days.ago)
		article3 = FactoryGirl.create(:article, title: "future", released_at: 1.days.from_now, expired_at: 2.days.from_now)
		article4 = FactoryGirl.create(:article, title: "No expiration", released_at: 1.days.ago, expired_at: nil)


		articles = Article.open # scope
		assert_includes articles, article1, "include article of now"
		assert_not_includes articles, article2, "Not include article of past"
		assert_not_includes articles, article3, "Not include article of future"
		assert_includes articles, article4, "Case exipired is nil"
	end
end
