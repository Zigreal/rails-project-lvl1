# frozen_string_literal: true

require_relative "test_helper"

def check_input_with_as_option(user)
  (HexletCode.form_for(user, url: "/users") do |f|
    f.input :name
    f.input :job, as: :text, cols: 30
  end) == "<form action=\"/users\" method=\"post\">" \
          "<label for=\"name\">Name</label>" \
          "<input name=\"name\" type=\"text\" value=\"Zigreal\">" \
          "<label for=\"job\">Job</label>" \
          "<textarea cols=\"30\" rows=\"40\" name=\"job\">Elins</textarea>" \
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
          "<label for=\"name\">Name</label>" \
          "<input name=\"name\" type=\"text\" value=\"Zigreal\">" \
          "<input name=\"commit\" type=\"submit\" value=\"Save\">" \
          "</form>"
end

def check_submit_with_custom_label(user)
  (HexletCode.form_for user, url: "/users" do |f|
    f.submit "Wow"
  end) == "<form action=\"/users\" method=\"post\">" \
          "<input name=\"commit\" type=\"submit\" value=\"Wow\">" \
          "</form>"
end

class TestHexletCode < Minitest::Test
  User = Struct.new(:name, :job, :gender, keyword_init: true)

  def test_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_build
    assert { HexletCode::Tag.build("br") == "<br>" }
    assert { HexletCode::Tag.build("img", src: "path/to/image") == "<img src=\"path/to/image\">" }
    assert do
      HexletCode::Tag.build("input", type: "submit", value: "Save") ==
        "<input type=\"submit\" value=\"Save\">"
    end
    assert { HexletCode::Tag.build("label") { "Email" } == "<label>Email</label>" }
    assert { HexletCode::Tag.build("label", for: "email") { "Email" } == "<label for=\"email\">Email</label>" }
    assert { HexletCode::Tag.build("div") == "<div></div>" }
  end

  def test_form_for
    user = User.new(name: "Zigreal", job: "Elins", gender: "m")
    assert { check_input_with_as_option(user) }
    assert { check_missing_input(user) }
    assert { check_submit(user) }
    assert { check_submit_with_custom_label(user) }
  end
end
