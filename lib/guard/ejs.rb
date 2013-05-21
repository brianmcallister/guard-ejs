require 'guard'
require 'guard/guard'
require 'ejs'

module Guard
  class EJS < Guard
    def initialize(watchers = [], options = {})
      super
      @options = {
        run_on_start: true,
        input: 'public/templates',
        output: 'public/templates/compiled.js'
      }.update(options)
    end
    
    def start
      UI.info 'Guard::EJS is now watching at somewhere'
      
      # Run all if the option is true.
      run_all() if @options[:run_on_start]
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
      paths.each do |path|
        file = File.read path
        compiled = ::EJS.compile file
        # puts 'compiled: ' + compiled
      end
    end

    def run_on_removals(paths)
      puts 'run on removals'
    end
  end
end
