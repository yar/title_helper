module DefV
  module TitleHelper

    # This method should be used in your layout and your actions.
    # 
    # In your action:
    #   <%= title "Edit user #{@user.name}" %>
    # => <h1>Edit user Jan De Poorter</h1>
    #
    # In your layout:
    #   <head>
    #     <title><%= title :site_name => 'Foobar' %></title>
    #     ...
    # => <title>Edit user Jan De Poorter - Foobar</title>
    # 
    def title arguments, options = {}
      case arguments
      when String
        @title = arguments
        options[:class] = [options[:class], 'error'].compact.join(' ') if options[:error]
        unless options[:header] == false
          return content_tag(:h1, [options[:header], @title, options[:trailer]].compact.join(' ').html_safe, options.except(:error, :header, :trailer))
        end
      when Hash
        sitename = arguments[:site_name]
        default = arguments[:default]
        if @title
          result = "#{strip_tags(@title.gsub("&ndash;", "-"))}"
          result += " - #{sitename}" unless sitename.blank?
          return result.html_safe
        else
          return "#{default || sitename}".html_safe
        end
      end
    end

    def meta_descr(arguments={})
      case arguments
      when String
        @meta_descr = arguments
        return nil
      when Hash
        default = arguments[:default]
        if @meta_descr
          descr = @meta_descr
        else
          descr = default
        end
        return %Q{<meta name="description" content="#{descr}" />}.html_safe if descr
      end
    end

    def meta_keywords(arguments={})
      case arguments
      when String
        @meta_keywords ||= []
        @meta_keywords += arguments.split(",").map { |part| part.strip }
        return nil
      when false
        @meta_keywords = []
      when Hash
        default_keywords = []
        unless arguments[:default].blank?
          default_keywords = arguments[:default].split(",").map { |part| part.strip }
        end
        
        if @meta_keywords 
          if @meta_keywords.empty?
            return ""
          else
            keywords = @meta_keywords# + default_keywords
          end
        else
          keywords = default_keywords
        end
        return %Q{<meta name="keywords" content="#{keywords.uniq.join(",")}" />}.html_safe if keywords.size > 0
      end
    end
  end
end

ActionView::Base.send(:include, DefV::TitleHelper)