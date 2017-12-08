require "application_system_test_case"

class CoursesTest < ApplicationSystemTestCase
  test "visiting the index as publisher" do
    login_as users(:peter)
    visit "/"
    assert_selector ".course-name", count: Course.count
    assert_selector "a", text: "Add Course"
    assert_selector "a", text: "Show", count: Course.count
    assert_selector "a", text: "Edit", count: Course.count
    assert_selector "a", text: "Delete", count: Course.count
  end

  test "visiting the index as student" do
    login_as users(:stewie)

    visit "/"
    assert_selector ".course-name", count: Course.count
    refute_selector "a", text: "Add Course"
    assert_selector "a", text: "Show", count: Course.count
    assert_selector "a", text: "Edit", count: 0
    assert_selector "a", text: "Delete", count: 0
  end

  test "lets a signed in publisher create and update new course" do
    login_as users(:peter)
    visit "/courses/new"

    fill_in "course_name", with: "Le Wagn"
    fill_in "course_description", with: "Change your life: Learn to code"
    click_on 'Create Course'
    assert_current_path edit_course_path(Course.last.id)
    assert Course.last.name == "Le Wagn"
    assert Course.last.description =="Change your life: Learn to code"
    fill_in "course_name", with: "Le Wagon"
    fill_in "course_description", with: "Change your life: Learn to code!"
    click_on 'Update Course'
    assert Course.last.name == "Le Wagon"
    assert Course.last.description =="Change your life: Learn to code!"
  end

end

