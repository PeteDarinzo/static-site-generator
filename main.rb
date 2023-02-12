# Static site generator
#
# Based on https://blog.hamaluik.ca/posts/build-your-own-static-site-generator/
# by Kenton Hamaluik, 2020-01-05
#
# Translated to Ruby by Peter Darinzo 2023-02-11

require 'Redcarpet'

markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)

unless Dir.exist?('public')
    Dir.mkdir('public')
end

Dir.glob('book/*.md').each do |f|

    raw = File.read(f)
    html = markdown.render(raw)

    file_name = File.basename(f, '.md')
    destination = File.join('public', file_name + '.html')

    File.open(destination, 'w') {|file| file.write(%q(<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <title>My Great Site</title>
</head>
<body>
    ))

    file.write(html)

    file.write(%q(
        </body>
        </html>
    ))
}
end
