require "test_helper"

class LinkTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "valid link" do
    link = links(:one)
    assert link.valid?
  end

  test "insert new valid link" do
    link = Link.create(slug: "r4Nd0m", url: "https://random.site", user: @user)

    assert link.valid?
    assert_equal "r4Nd0m", link.slug
    assert_equal "https://random.site", link.url
    assert_equal 0, link.visit_count
  end

  test "insert empty slug" do
    assert_raises ActiveRecord::RecordInvalid do
      Link.create!(slug: "", url: "https://random.site", user: @user)
    end
  end

  test "insert nil slug" do
    assert_raises ActiveRecord::RecordInvalid do
      Link.create!(slug: nil, url: "https://random.site", user: @user)
    end
  end

  test "insert duplicate slug" do
    slug = links(:one).slug

    assert_raises ActiveRecord::RecordInvalid do
      Link.create!(slug: slug, url: "https://random.site", user: @user)
    end
  end

  test "insert duplicate slug with different case" do
    slug = links(:one).slug.upcase

    assert_raises ActiveRecord::RecordInvalid do
      Link.create!(slug: slug, url: "https://random.site", user: @user)
    end
  end

  test "insert invalid character" do
    assert_raises ActiveRecord::RecordInvalid do
      Link.create!(slug: "sl/ug", url: "https://random.site", user: @user)
    end
  end

  test "create root link" do
    link = Link.create(slug: "/", url: "https://home.site", user: @user)

    assert link.valid?
    assert_equal "/", link.slug
    assert_equal "https://home.site", link.url
    assert_equal 0, link.visit_count
  end
end
