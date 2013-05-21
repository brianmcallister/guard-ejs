require 'guard'
require 'guard/guard'
require 'ejs'

module Guard
  class EJS < Guard
    def initialize(watchers = [], options = {})
      super
      @options = {
        run_on_start: true,
        namespace: 'app',
        input: 'public/templates',
        output: 'public/compiled/compiled.js'
      }.update(options)
    end
    
    def start
      UI.info 'Guard::EJS is now watching for changes.'
      
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
      run_on_modifications paths
    end
    
    def run_on_additions(paths)
      run_on_modifications paths
    end
    
    # Compile each template at the passed in paths.
    def run_on_modifications(paths)
      hash = {}
      
      paths.each do |path|
        file = File.read path
        compiled = ::EJS.compile file
        hash[path] = compiled
      end
      
      # Just overwrite the whole thing for now.
      FileUtils.mkdir_p File.dirname(@options[:output])
      
      File.open(@options[:output], 'w+') do |file|
        file.write "window.#{@options[:namespace]} = window.#{@options[:namespace]} || {}\n"
        file.write "window.#{@options[:namespace]}.templates = {"
        
        hash.each do |name, template|
          file.write "\"#{name}\": #{template},"
        end
        
        file.write "}"
      end
    end

    def run_on_removals(paths)
      
    end
  end
end
