class Cloner < Thor
  desc 'clone DATABASE.YML SERVER USER', 'Clone the database'
  long_desc <<-LONGDESC
    Clone the production database from the provided SERVER to the development database on the local machine
  LONGDESC
  def clone(yml_file, server, user = 'deploy')
    yml = YAML.load_file(yml_file)

    prod = yml['production']
    dev_db = prod['database'].gsub(/_production$/, '_development')

    file_name = "#{prod['database']}-#{Time.now.to_i}.sql"
    input = ask "Okay to DROP DATABASE #{dev_db}? (yes/no)"
    if input == 'yes'
      `ssh #{user}@#{server} PGPASSWORD=#{prod['password']} pg_dump -U#{prod['username']} -O #{prod['database']} > #{file_name}`
      `psql -d postgres -c "DROP DATABASE #{dev_db};"`
      `psql -d postgres -c "CREATE DATABASE #{dev_db};"`
      `psql #{dev_db} < #{file_name}`
      `rm #{file_name}`
      puts "Copied #{prod['database']} to #{dev_db}."
    else
      puts 'Exiting without doing anything.'
    end
  end
end

