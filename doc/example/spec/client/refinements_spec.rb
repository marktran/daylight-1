require 'spec_helper'

describe 'refinements' do

  let(:server_blog)   { Blog.create(name: "Freely's Feels") }
  let(:server_author) { User.create(name: "I.P. Freely") }

  describe 'conditions additions' do
    let!(:server_post) do
      Post.create(
        title:        "5 amazing things you probably didn't know about APIs",
        author:       server_author,
        blog:         server_blog,
        published:    true,
        published_at: 1.week.ago
      )
    end

    it 'has a list of attriubtes that can be refined' do
      post = API::Post.find(server_post.id)
      post.attributes.keys.should include('id', 'title', 'body', 'published_at', 'slug', 'published', 'author_id')
    end

    it 'can be queried using find_by' do
      post = API::Post.find_by(slug:"5-amazing-things-you-probably-didnt-know-about-apis")
      post.slug.should == "5-amazing-things-you-probably-didnt-know-about-apis"
    end

    # Not using the published: true clause here because of an active record bug with type casting boolean values for sqlite3
    # More details here: https://github.com/att-cloud/daylight/issues/16
    it 'can chain where clauses' do
      posts = API::Post.where(author_id: server_author.id).where(blog_id: server_blog.id)
      posts.size.should == 1
      posts.first.author_id.should == server_author.id
      posts.first.blog_id.should == server_blog.id
    end
  end

  describe 'order' do
    before do
      Post.create(title: "one",   published_at: 1.day.ago)
      Post.create(title: "two",   published_at: 2.days.ago)
      Post.create(title: "three", published_at: 3.days.ago)
    end

    it 'can refine by order' do
      posts = API::Post.order(:published_at)
      posts.map(&:title).should == %w[three two one]
    end

    it 'can reverse the order' do
      posts = API::Post.order('published_at DESC')
      posts.map(&:title).should == %w[one two three]
    end
  end

end