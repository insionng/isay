Sequel::Model.plugin(:schema)
dbname='postgres://postgres:pgsqlpw@localhost/postgres'
#dbname='sqlite://db/sexys.db'
Sequel::Model.db = Sequel.connect(dbname)

class User < Sequel::Model
	unless table_exists?
		set_schema do
			primary_key :id
			varchar :username
			varchar :password
			varchar :email
			DateTime :lastlogin
			DateTime :created_at
			DateTime :updated_at
		end
		create_table
	end
end

class Topic < Sequel::Model
	unless table_exists?
		set_schema do
			primary_key :id
			varchar :title
			text :topic
			varchar :by_username
			varchar :by_email
			varchar :by_url
			varchar :ups
			varchar :downs
			varchar :views
			DateTime :created_at
			DateTime :updated_at
		end
		create_table
	end
end

class Comment < Sequel::Model
	unless table_exists?
		set_schema do
			primary_key :id
			varchar :sort
			varchar :by_username
			varchar :by_email
			varchar :by_url
			text :comment
			DateTime :created_at
			DateTime :updated_at
		end
		create_table
	end
end

class Link < Sequel::Model
  unless table_exists?
    set_schema do
		primary_key :id
		varchar :title
		varchar :link
    end
    create_table
  end
end
