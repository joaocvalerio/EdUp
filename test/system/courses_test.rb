require "application_system_test_case"

class CoursesTest < ApplicationSystemTestCase
  test "visiting the index as publisher" do
    login_as users(:peter)
    visit "/"
    assert_selector "h2", text: "Course"
    assert_selector ".course-name", count: Course.count
  end
end
