# frozen_string_literal: true

require_relative "test_helper"

def check_input_with_as_option(user)
  (HexletCode.form_for(user, url: "/users") do |f|
    f.input :name
    f.input :job, as: :text
  end) == "<form action=\"/users\" method=\"post\">" \
          "<label for=&quot;name&quot;>Name</label>" \
          "<input name=&quot;name&quot; type=&quot;text&quot; value=&quot;Zigreal&quot;>" \
          "<label for=&quot;job&quot;>Job</label>" \
          "<textarea cols=&quot;20&quot; rows=&quot;40&quot; name=&quot;job&quot;>Elins</textarea>" \
          "</form>"
end

def check_missing_input(user)
  assert_raises NoMethodError do
    HexletCode.form_for user, url: "/users" do |f|
      f.input :name
      f.input :job, as: :text
      # Поля age у пользователя нет
      f.input :age
    end
  end
end

def check_submit(user)
  (HexletCode.form_for(user, url: "/users") do |f|
    f.input :name
    f.submit
  end) == "<form action=\"/users\" method=\"post\">" \
          "<label for=&quot;name&quot;>Name</label>" \
          "<input name=&quot;name&quot; type=&quot;text&quot; value=&quot;Zigreal&quot;>" \
          "<input name=&quot;commit&quot; type=&quot;submit&quot; value=&quot;Save&quot;>" \
          "</form>"
end

class TestHexletCode < Minitest::Test
  autoload :HexletCode, "hexlet_code"

  User = Struct.new(:name, :job, :gender, keyword_init: true)

  def test_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_build
    assert { HexletCode::Tag.build("br") == "<br>" }
    assert { HexletCode::Tag.build("img", src: "path/to/image") == "<img src=&quot;path/to/image&quot;>" }
    assert do
      HexletCode::Tag.build("input", type: "submit", value: "Save") ==
        "<input type=&quot;submit&quot; value=&quot;Save&quot;>"
    end
    assert { HexletCode::Tag.build("label") { "Email" } == "<label>Email</label>" }
    assert { HexletCode::Tag.build("label", for: "email") { "Email" } == "<label for=&quot;email&quot;>Email</label>" }
    assert { HexletCode::Tag.build("div") == "<div></div>" }
  end

  def test_form_for
    user = User.new(name: "Zigreal", job: "Elins", gender: "m")
    assert { check_input_with_as_option(user) }
    assert { check_missing_input(user) }
    assert { check_submit(user) }
  end
end
