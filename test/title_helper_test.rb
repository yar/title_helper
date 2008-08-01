require 'test/unit'
require File.dirname(__FILE__) + '/../../../../config/boot.rb'
require File.dirname(__FILE__) + '/../../../../config/environment.rb'


class TitleHelperTest < Test::Unit::TestCase
  def setup
    @helper = ActionView::Base.new
  end
  
  def test_title_method_with_no_title_set
    assert_equal "foobar", @helper.title(:site_name => 'foobar')
  end
   
  def test_title_method_with_a_title_set
    assert_equal "<h1>HomePage</h1>", @helper.title("HomePage")
    assert_equal "HomePage - foobar", @helper.title(:site_name => 'foobar')
  end
  
  def test_strip_tags
    assert_equal "<h1>This is <strong>GREAT</strong></h1>", @helper.title("This is <strong>GREAT</strong>")
    assert_equal "This is GREAT - foobar", @helper.title(:site_name => 'foobar')
  end
  
  def test_error_on_h1
    assert_equal "<h1 class=\"error\">This is wrong</h1>", @helper.title("This is wrong", :error => true)
  end
  
  def test_class_on_h1
    assert_equal "<h1 class=\"my-class\">Header with class</h1>", @helper.title("Header with class", :class => 'my-class')
  end
  
  def test_id_on_h1
    assert_equal "<h1 id=\"my-id\">Header with id</h1>", @helper.title("Header with id", :id => 'my-id')
  end
  
  def test_class_and_id_on_h1
    assert_equal "<h1 class=\"my-class\" id=\"my-id\">Header with class and id</h1>", @helper.title("Header with class and id", :class => 'my-class', :id => 'my-id')
  end
  
  def test_class_and_error_on_h1
    assert_equal "<h1 class=\"my-class error\">Header with error and class</h1>", @helper.title("Header with error and class", :class => 'my-class', :error => true)
  end
  
  # And if we do not need a matching h1 tag...

  def test_title_method_with_no_title_set_without_header
    assert_equal "foobar", @helper.title(:site_name => 'foobar', :header => false)
  end
 
  def test_title_method_with_a_title_set_without_header
    assert_nil @helper.title("HomePage", :header => false)
    assert_equal "HomePage - foobar", @helper.title(:site_name => 'foobar', :header => false)
  end
  
  # Meta descriptions
  
  def test_meta_descr_method_with_no_descr_set
    assert_equal '<meta name="description" content="default description" />', 
      @helper.meta_descr(:default => "default description")
  end

  def test_meta_descr_method_with_a_descr_set
    assert_nil @helper.meta_descr("specific description")
    assert_equal '<meta name="description" content="specific description" />', 
      @helper.meta_descr(:default => "default description")
  end
  
  def test_meta_descr_nothing_in_nothing_out
    assert_nil @helper.meta_descr(:default => nil)
  end
  
  def test_meta_descr_method_with_a_descr_set_and_no_default
    assert_nil @helper.meta_descr("specific description")
    assert_equal '<meta name="description" content="specific description" />', 
      @helper.meta_descr(:default => nil)
  end

  # Meta keywords
  
  def test_meta_keywords_method_with_no_keywords_set
    assert_equal '<meta name="keywords" content="phrase one,phrase two" />', 
      @helper.meta_keywords(:default => "phrase one,phrase two")
  end

  def test_meta_keywords_method_with_keyword
    assert_nil @helper.meta_keywords("phrase three")
    assert_equal '<meta name="keywords" content="phrase three,phrase one,phrase two" />', 
      @helper.meta_keywords(:default => "phrase one,phrase two")
  end

  def test_meta_keywords_method_with_keywords
    assert_nil @helper.meta_keywords("phrase one,phrase three")
    assert_equal '<meta name="keywords" content="phrase one,phrase three,phrase two" />', 
      @helper.meta_keywords(:default => "phrase one,phrase two")
  end

  def test_meta_keywords_method_stripping_whitespace
    assert_nil @helper.meta_keywords("phrase one, phrase three")
    assert_equal '<meta name="keywords" content="phrase one,phrase three,phrase two" />', 
      @helper.meta_keywords(:default => "phrase one, phrase two")
  end

  def test_meta_keywords_method_nothing_in_nothing_out
    assert_nil @helper.meta_keywords(:default => nil)
  end

  def test_meta_keywords_method_with_keywords_and_no_default
    assert_nil @helper.meta_keywords("phrase one,phrase three")
    assert_equal '<meta name="keywords" content="phrase one,phrase three" />', 
      @helper.meta_keywords(:default => nil)
  end
end
