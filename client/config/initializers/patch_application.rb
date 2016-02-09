# -*- encoding : utf-8 -*-

if Rails.env.development?
  def puts(input, hirb=true)
    if hirb
      if input.is_a?(String)
        super("==> #{input}")
      else
        super( Hirb::Helpers::AutoTable.render(input) )
      end
    else
      super(input)
    end
  end
end
