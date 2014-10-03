require 'spec_helper'

describe "Creating todo lists" do

def create_todo_list(options={})
options[:title] ||= "My todo list"
options[:description] ||= "My first Todo list item"

 visit "/todo_lists"
  click_link "New Todo list"
  expect(page).to have_content("New todo_list")
  fill_in "Title", with: options[:title]
  fill_in "Description", with: options[:description]
  click_button "Create Todo list"

end


it "redirects to the todo list index page on success" do
  create_todo_list
  expect(page).to have_content("My todo list")
end
#Title vaidation

it "displays an error when no title is given todo list" do

  expect(TodoList.count).to eq(0)
  create_todo_list title: ""
  expect(page).to have_content("error")
  expect(TodoList.count).to eq(0)

  visit "/todo_lists"
  expect(page).to_not have_content("My first list item 1")

 end

 it "displays an error when  title is less than 5 characters" do

  expect(TodoList.count).to eq(0)
  create_todo_list title:"Todo"
  expect(page).to have_content("error")
  expect(TodoList.count).to eq(0)

  visit "/todo_lists"
  expect(page).to_not have_content("My first list item 1")

 end

#Description Validation

it "displays an error when no description is given todo list" do
  expect(TodoList.count).to eq(0)
  create_todo_list description: ""
  expect(page).to have_content("error")
  expect(TodoList.count).to eq(0)

  visit "todo_lists"
  expect(page).to_not have_content("My first todo list")
end

it "displays an error when description is less than 10 characters" do
  expect(TodoList.count).to eq(0)
  create_todo_list description: "My first"
  expect(page).to have_content("error")
  expect(TodoList.count).to eq(0)

  visit "todo_lists"
  expect(page).to_not have_content("My first todo list")
end

end