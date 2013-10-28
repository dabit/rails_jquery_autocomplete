require 'test_helper'

class Author
  attr_accessor :id, :name

  def initialize(id, name)
    self.id   = id
    self.name = name
  end
end

class AuthorsController < ActionController::Base
  autocomplete :author, :name
end

class TestControllerMethods < Test::Unit::TestCase
  def subject
    @subject ||= AuthorsController.new
  end

  def test_where_clause
    assert_equal ["name LIKE ?", "query%"], subject.where_clause("query")
  end

  def test_autocomplete_items
    items = stub!

    stub(subject).where_clause("query") { "WHERE_CLAUSE" }
    mock(Author).where("WHERE_CLAUSE") { items }
    assert_same items, subject.autocomplete_items("query")
  end

  def test_item_hash
    items = [
      Author.new(1, "John Scalzi"),
      Author.new(2, "Neil Gaiman")
    ]

    expected_hash = [
      {id: 1, value: "John Scalzi", label: "John Scalzi"},
      {id: 2, value: "Neil Gaiman", label: "Neil Gaiman"}
    ]

    stub(subject).autocomplete_items("query") { items }
    assert_equal expected_hash, subject.item_hash("query")
  end

  def test_items_to_json
    json = stub!

    mock(subject).item_hash("query").mock!.to_json { json }
    assert_same json, subject.items_to_json("query")
  end

  def test_show
    json = stub!
    stub(subject).params { {term: "query"} }
    stub(subject).items_to_json("query") { json }
    mock(subject).respond_with(json)

    subject.show
  end
end
