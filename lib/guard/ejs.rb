require 'guard'
require 'guard/guard'
require 'ejs'

module Guard
  class EJS < Guard
    def initialize(watchers = [], options = {})
      super
      @options = {
        run_on_start: true,
        namespace: 'JST',
        input: 'public/templates',
        output: 'public/templates/compiled.js'
      }.update(options)
    end
    
    def start
      UI.info 'Guard::EJS is now watching at somewhere'
      
      # Run all if the option is true.
      run_all() if @options[:run_on_start]
    end
    
    # Compile all templates.
    def run_all
      # Get all files.
      files = Dir.glob("#{@options[:input]}/**/*").select do |path|
        not File.directory? path
      end
      
      run_on_modifications files
    end
    
    # Run when the guardfile changes.
    def run_on_changes(paths)
      puts 'guardfile changed'
    end
    
    def run_on_additions(paths)
      run_on_modifications paths
    end
    
    # Compile each template at the passed in paths.
    def run_on_modifications(paths)
      hash = {
        @options[:namespace] => {}
      }
      
      paths.each do |path|
        file = File.read path
        compiled = ::EJS.compile file
        hash[@options[:namespace]][path] = compiled
      end
      
      puts hash.inspect
    end

    def run_on_removals(paths)
      puts 'run on removals'
    end
  end
end
