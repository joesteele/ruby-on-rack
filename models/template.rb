class Template
  VIEW_DIR = File.join((ROOT || File.dirname(__FILE__)), 'views')

  def self.templates
    @templates ||= {}
  end

  def self.template_for(opts={})
    path = File.join(*[VIEW_DIR, opts[:controller], opts[:action]].compact)
    path += '.erb'
    if File.exists?(path)
      templates[path] ||= Erubis::Eruby.new(File.read(path))
    end
    templates[path]
  end

  def self.render(opts={})
    if template = template_for(opts)
      template.result(opts[:locals]).to_s
    end
  end
end
