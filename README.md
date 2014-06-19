# Capistrano::Template

A [Capistrano](http://capistranorb.com/) gem to generate files from templates on deployment.

In a typical application, configuration files contain lots of code common to all stages, and a few differences (like database or mail server and credentials).
This gem lets you put common code in ERB templates,
and variable parts using Capistrano variables (`set :var_name, 'value'`)
or [capistrano-secret](https://github.com/xavierpriour/capistrano-secret).


## Quick start

In a shell:
```bash
gem install capistrano-template
echo "require 'capistrano/template'" >> Capfile
mkdir -p lib/capistrano/templates
echo "Deployed to <%= fetch(:stage) %> at <%= Time.new() %>" > lib/capistrano/templates/deploy.html.erb
```






Then in any Capistrano task:
```ruby
puts "I know the secret, it is #{secret('secret.of.life')}";
```


## Features

Capistrano::Secret advantages:

* All secret information in one unique place: no duplication, easy to keep out of repository.
* Files contain only secret: no mixing with other, non-sensitive information (like configuration directives).
* Standard JSON syntax.
* Each stages has its own set of secrets.
* Method name makes it explicit to developer this is sensitive information (it's called `secret()`!).

It really shines when used in conjunction with a templating library like [capistrano-template](https://github.com/xavierpriour/capistrano-template),
to generate configuration files at deployment. Check it out!

## Requirements

* [Capistrano 3](http://capistranorb.com/)

All dependencies are listed in the .gemspec file so if using `bundler` you just need to `bundle install` in your project directory.


## Installation

Add this line to your application's Gemfile:
```
gem 'capistrano-template'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install capistrano-template
```


## Usage

Include gem in your `Capfile`:
```ruby
require 'capistrano/secret'
```

Create directory where secret information will be stored.
Default is `config/secret`, to use a different one define `secret_dir` in `deploy.rb`:
```ruby
set :secret_dir, 'new/secret/dir'
```

Ensure the directory stays out of repository (for git, add it to `.gitignore`):
```bash
echo 'config/secret' >> .gitignore
```

Then in the directory, create one JSON file per stage (same name as the stage):
```bash
touch config/secret/production.json
```

In the files, define keys as needed, using JSON syntax. For example:
```JSON
{
    "db" : {
        "user" : "user_db",
        "password" : "srwhntseithenrsnrsnire",
        "host" : "sql.yourdomain.com",
        "name" : "yourDB"
    },
    "mail" : {
        "mode" : "smtp",
        "user" : "myapp@yourdomain.com",
        "password" : "rastenhrtrethernhtr",
        "host" : "ssl://smtp.yourdomain.com",
    }
}
```

Then in your Capistrano tasks you can access any value using `secret('path.to.key')`.
The call is safe and will just return `nil` if all or part of the path leads nowhere.
So you can test the return value of any part of the path to see if an option is present - for example:
```ruby
if secret('mail') then
    # do something with mail info, like send a msg after deploy
end
```

## Contributing
1. Fork it ( https://github.com/xavierpriour/capistrano-secret/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request