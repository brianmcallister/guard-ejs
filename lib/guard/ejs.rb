require 'guard'
require 'guard/guard'
require 'ejs'

module Guard
  class EJS < Guard
    def initialize(watchers = [], options = {})
      super
    end
    
    def start
      puts 'started'
    end
    
    def stop
      puts 'stopped'
    end
    
    def reload
      puts 'reloaded'
    end
    
    def run_all
      puts 'run all'
    end
    
    def run_on_changes(paths)
      puts 'run on changes'
    end
    
    def run_on_additions(paths)
      puts 'run on additions'
    end

    def run_on_modifications(paths)
      puts 'run on modifications'
    end

    def run_on_removals(paths)
      puts 'run on removals'
    end
  end
end
