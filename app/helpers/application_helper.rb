module ApplicationHelper

  def swf_path(source)
    asset_paths.compute_public_path(source, 'flash')
  end

end
