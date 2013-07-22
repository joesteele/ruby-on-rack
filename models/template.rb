class Template
  VIEW_DIR = File.join(RackDemo::ROOT, 'views')

  def self.templates
    @templates ||= {}
  end

  def self.template_for(opts={})
    path = File.join(*[VIEW_DIR, opts[:controller].to_s, opts[:action].to_s].compact)
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
