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
          return content_tag(:h1, [options[:header], @title, options[:trailer]].compact.join(' '), options.except(:error, :header, :trailer))
        end
      when Hash
        sitename = arguments[:site_name]
        default = arguments[:default]
        if @title
          return "#{strip_tags(@title).gsub(' &ndash; ', ' - ')} - #{sitename}"
        else
          return "#{default || sitename}"
        end
      end
    end

    def meta_descr arguments, options = {}
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
        return %Q{<meta name="description" content="#{descr}" />} if descr
      end
    end

    def meta_keywords arguments
      case arguments
      when String
        @meta_keywords ||= []
        @meta_keywords += arguments.split(",").map { |part| part.strip }
        return nil
      when Hash
        default_keywords = []
        unless arguments[:default].blank?
          default_keywords = arguments[:default].split(",").map { |part| part.strip }
        end
        
        if @meta_keywords && @meta_keywords.size > 0
          keywords = @meta_keywords + default_keywords
        else
          keywords = default_keywords
        end
        return %Q{<meta name="keywords" content="#{keywords.uniq.join(",")}" />} if keywords.size > 0
      end
    end
  end
end