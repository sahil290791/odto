require 'spec_helper'

describe "Creating todo lists" do

it "redirects to the todo list index page on success" do
  visit "/todo_lists"
  click_link "New Todo list"
  expect(page).to have_content("New todo_list")
  fill_in "Title", with: "My todo list"
  fill_in "Description", with: "My first list item"
  click_button "Create Todo list"
  expect(page).to have_content("My todo list")
end

it "displays an error when no title is given todo list" do

  expect(TodoList.count).to eq(0)

  visit "/todo_lists"
  click_link "New Todo list"
  expect(page).to have_content("New todo_list")
  fill_in "Title", with: ""
  fill_in "Description", with: "My first list item 1"
  click_button "Create Todo list"

  expect(page).to have_content("error")
  expect(TodoList.count).to eq(0)

  visit "/todo_lists"
  expect(page).to_not have_content("My first list item 1")

 end

 it "displays an error when  title is less than 5 characters" do

  expect(TodoList.count).to eq(0)

  visit "/todo_lists"
  click_link "New Todo list"
  expect(page).to have_content("New todo_list")
  fill_in "Title", with: "List"
  fill_in "Description", with: "My first list item 1"
  click_button "Create Todo list"

  expect(page).to have_content("error")
  expect(TodoList.count).to eq(0)

  visit "/todo_lists"
  expect(page).to_not have_content("My first list item 1")

 end

end