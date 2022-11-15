One Offs
========

Track and manage your one off scripts, in rails applications.

Can be used to move stuff out from your rails migrations that dont belong there. For example data migrations can be moved from schema and into one-offs.

## Installation

Add this line to your application's Gemfile:

    gem 'one_offs'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install one_offs

## Usage

After installing the gem, In your Rakefile (/Rakefile) add the following line

    require 'one_offs/tasks'


And setup a tracker table (creates migration).

    rake one_offs:generate_tracker_table

OR using SQL query if you want to avoid a migration (Useful if you need to setup one off tasks before db:migrate).

    rake one_offs:create_tracker_table_using_sql

To turn on notifications for pending one-offs in the development environment (optional).

    rake one_offs:turn_on_pending_notification

Add scripts to `lib/one_offs/`
  * File name should be <code>\<number\>_class_name_inside_file.rb</code> (Rails convention for file name to class name with the order number before that)

    Example:

        File: 1_hello_world.rb
        Contents:
            class HelloWorld
                def self.process
                puts("You may write your code in this process method").
            end
        end

To run pending one_off scripts.

    rake one_offs:run

To baseline one_offs seed them into to the tracker table.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
