require 'test_helper'

class RevisionTest < ActiveSupport::TestCase
  def setup
    @groupie = users(:groupie)
    @patron = users(:patron)
    @regular = users(:regular)
    @admin = users(:admin)

    @cool_kids = groups(:cool_kids)
    @patroons = groups(:patroons)

    @cat = Category.new({:name => "Root Level", :description => "Root Level Category"})
    @cat.group = @cool_kids
    @cat.user = @admin
    @cat.save

    @doc = Document.new({:title => "Test Doc", :category => @cat, :user => @groupie})
    @doc.save

    @txt_file = File.open("#{RAILS_ROOT}/test/binaries/sample.txt")
  end

  def test_validations
    revision = Revision.new()
    assert !revision.valid?, "Revisions require user, documant, and file"

    revision.user = @patron
    assert !revision.valid?

    revision.document = @doc
    assert !revision.valid?

    revision.upload = @txt_file
    assert revision.valid?
  end

  def test_autosets_owner
    revision = Revision.new({:document => @doc, :upload => @txt_file})
    assert !revision.valid?

    ActiveRecord::Base.accessor = @groupie
    assert revision.valid?
    assert revision.save
    assert_equal revision.user, @groupie
  end

  def test_current
    revision1 = Revision.new({:document => @doc, :upload => @txt_file, :user => @groupie})
    revision1.save
    assert_equal @doc.current_revision, revision1
    assert revision1.current?

    revision2 = Revision.new({:document => @doc, :upload => @txt_file, :user => @regular})
    revision2.save
    assert_equal @doc.current_revision, revision2
    assert !revision1.current?
    assert revision2.current?   
  end

end
