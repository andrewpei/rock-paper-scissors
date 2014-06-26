require 'spec_helper'
require_relative '../lib/scripts/dashboard_logic.rb'

describe "The Dashboard" do
  before(:all) do
    RPS.orm.instance_variable_set(:@db_adapter, PG.connect(host: 'localhost', dbname: 'rps-db-test'))
    RPS.orm.create_tables
  end

  before(:each) do
    RPS.orm.delete_tables
    RPS.orm.create_tables
  end

  after(:all) do
    RPS.orm.delete_tables
  end

  describe RPS::RetrieveDashboardData do

  end

  describe RPS::StartNewGame do

  end

  describe RPS::ContinueGame do
    
  end

end

