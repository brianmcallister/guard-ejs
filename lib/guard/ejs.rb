require 'guard'
require 'guard/guard'
require 'guard/watcher'
require 'ejs'

module Guard
  class EJS < Guard
    DEFAULT_OPTIONS = {
      run_on_start: true,
      namespace: 'app',
      input: 'public/templates',
      output: 'public/js/templates.js'      
    }
    
    def initialize(watchers = [], options = {})
      defaults = DEFAULT_OPTIONS.clone
      
      if options[:input]
        defaults.merge!(output: options[:input])
        watchers << ::Guard::Watcher.new(%r{^#{options[:input]}/.+$})
      end
      
      super(watchers, defaults.merge(options))
    end
    
    def start
      UI.info 'Guard::EJS is now watching for changes.'
      
      # Run all if the option is true.
      run_all() if @options[:run_on_start]
    end
    
    # Compile all templates.
    def run_all
      run_on_modifications()
    end
    
    # Run when the guardfile changes.
    def run_on_changes(paths)
      run_all()
    end
    
    def run_on_additions(paths)
      run_all()
    end
    
    # Compile each template at the passed in paths.
    def run_on_modifications(paths = [])
      hash = {}
      
      # Get all files.
      paths = Dir.glob("#{@options[:input]}/**/*").select do |path|
        not File.directory? path
      end
      
      paths.each do |path|
        file = File.read path
        compiled = ::EJS.compile file
        hash[path] = compiled
        
        UI.info "[Guard::EJS] Compiled #{path}."
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
      UI.info "Recompiling templates without #{paths}"
      run_all()
    end
  end
end
