require 'spec_helper'

describe 'ORM' do
  before(:all) do
    RPS.orm.instance_variable_set(:@db_adapter, PG.connect(host: 'localhost', dbname: 'rps-db-test'))
    RPS.orm.create_tables
  end

  before(:each) do
    RPS.orm.delete_tables
    RPS.orm.create_tables
    proj1 = RPS.orm.add_project("do stuff")
  end

  after(:all) do
    RPS.orm.delete_tables
  end

end