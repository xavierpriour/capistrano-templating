# Capistrano::Templating

A [Capistrano](http://capistranorb.com/) gem to generate files from templates on deployment.

In a typical application, configuration files contain lots of code common to all stages, and a few differences (like database or mail server and credentials).
This gem lets you put common code in ERB templates,
and manage variable parts using Capistrano variables (`set :var_name, 'value'`)
or [capistrano-secret](https://github.com/xavierpriour/capistrano-secret).

This is especially useful to generate configuration files for various server elements, based on DRY secret files + single template for each configuration file.


## Quick start

In a shell:
```bash
gem install capistrano-templating
echo "require 'capistrano/templating'" >> Capfile
mkdir -p lib/capistrano/templates
echo "Deployed to <%= fetch(:stage) %> at <%= Time.new() %>" > lib/capistrano/templates/deploy.html.erb
```

Then in `deploy.rb`:
```ruby
set_template 'www/deploy.html', 'deploy.html.erb';
```


## Features

Capistrano::Templating advantages:
* all common code is centralized in the template: no duplication (DRY).
* file can be generated anywhere (even in multiple places), with any name.
* any file format can be generated.

When combined with [capistrano-secret](https://github.com/xavierpriour/capistrano-secret),
enables perfect separation of responsibilities:
* all secret information in easy-to-read JSON, stored in dedicated folder
* syntax wrapping (for configuration file, deployment pages, or else) concentrated in templates

In details:
* 2-step generation: files are generated in a separate build local folder, then copied into release dir. This allows local view of the generated files for debugging.
* generated file path and name is specified separately from template file. This lets you put all templates in the same folder, yet dispatch generated files everywhere.

Compared to [capistrano-template](https://github.com/faber-lotto/capistrano-template) gem,
Capistrano::Templating uses a declarative syntax (`set_template` then automatic generation),
whereas capistrano-template uses an imperative syntax (ask for render using `template`).
Pick the one that suits you best!


## Requirements

* [Capistrano 3](http://capistranorb.com/)

All dependencies are listed in the .gemspec file so if using `bundler` you just need to `bundle install` in your project directory.


## Installation

Add this line to your application's Gemfile:
```
gem 'capistrano-templating'
```

And then execute:
```bash
bundle
```

Or install it yourself as:
```bash
gem install capistrano-templating
```


## Usage

An example application is included in the `example` folder.

Include gem in your `Capfile`:
```ruby
require 'capistrano/templating'
```

Create directory where templates will be stored.
Default is `lib/capistrano/template`, to use a different one define `template_src_dir` in `deploy.rb`:
```ruby
set :template_src_dir, 'new/template/dir'
```

Define directory where generated files will be stored.
Default is `build`, to use a different one define `template_build_dir` in `deploy.rb`:
```ruby
set :template_build_dir, 'new/build/dir'
```
Ensure the build directory stays out of repository (for git, add it to `.gitignore`):
```bash
echo 'build' >> .gitignore
```

Then in the template directory, create one ERB file per model of file needed.
As a naming convention, we suggest `name_and_ext_of_target.erb`. For example, `.htaccess.erb` to generate `.htaccess`.

Finally, declare the files to generate in `deploy.rb` or the stage files (like `production.rb`):
```ruby
set_template 'path/to/result.html', 'template.html.erb'
```
Destination filepaths are relative to application root folder, template paths are relative to template directory.

At the end of deployment, capistrano will automatically generate the files in the local build dir (including sub-directory creation),
then upload them in the remote release directories.


## Contributing
1. Fork it ( https://github.com/xavierpriour/capistrano-templating/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request