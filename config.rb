# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end
activate :directory_indexes
activate :livereload
activate :i18n, :langs => [:fr]

set :app_url, "https://app.badgeenligne.fr"


# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
articles = YAML.load_file("./locales/fr/faq.yml")['fr']['faq']['articles']
articles.each do |name|
  proxy "/faq/#{name['url']}/index.html", "/templates/faq_article.html", :locals => { :name => name }, :ignore => true
end

# Ignore templates
ignore "/templates/faq_article.html"

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

activate :blog do |blog|
  blog.prefix = "blog"
  blog.permalink = "/{title}.html"
  blog.sources = "{title}.html"
  blog.new_article_template = "article"
  blog.layout = "article"
end

helpers do
  def include_svg(filename)
    File.read("source/images/#{filename}")
  end

  def base_url
    protocol = "https://www."
    domain = "badgeenligne.fr"
    protocol + domain
  end

  def full_url
    protocol = "https://www."
    domain = "badgeenligne.fr"
    protocol + domain + current_page.url
  end

end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

configure :build do
  activate :minify_css
  # activate :minify_javascript <= BUG
end
