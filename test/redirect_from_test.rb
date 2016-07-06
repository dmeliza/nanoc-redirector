require 'test_helper'

class RedirectFromTest < MiniTest::Test
  def test_it_renders_redirect_from_string
    with_site(name: FIXTURES_DIR) do |site|

      site = Nanoc::Int::SiteLoader.new.new_from_cwd
      site.compile

      output_file = read_output_file('redirect_from', 'string')
      test_file = read_test_file('redirect_from', 'string')
      assert_equal output_file, test_file

      assert test_output_file(['here', 'is-a-place'])
      output_file = read_output_file(['here', 'is-a-place'])
      assert_includes output_file, 'redirect_from/string'
    end
  end

  def test_it_renders_redirect_from_array
    with_site(name: FIXTURES_DIR) do |site|

      site = Nanoc::Int::SiteLoader.new.new_from_cwd
      site.compile

      output_file = read_output_file('redirect_from', 'array')
      test_file = read_test_file('redirect_from', 'array')
      assert_equal output_file, test_file

      assert test_output_file(['this-is-old'])
      output_file = read_output_file(['this-is-old'])
      assert_includes output_file, 'redirect_from/array'

      assert test_output_file(['articles', 'this-is-older'])
      output_file = read_output_file(['articles', 'this-is-older'])
      assert_includes output_file, 'redirect_from/array'
    end
  end

  def test_it_does_not_clobber_existing_files
    with_site(name: FIXTURES_DIR) do |site|
      site = Nanoc::Int::SiteLoader.new.new_from_cwd
      site.compile

      output_file = read_output_file('redirect_from', 'existing-content')
      test_file = read_test_file('redirect_from', 'existing-content')
      assert_equal output_file, test_file
    end
  end
end
