desc "Rebuild the ferret index"
task :ferret_rebuild => [ :environment ] do | t |
  Category.rebuild_index
  Document.rebuild_index
  puts "Completed Ferret Index Rebuild"
end 
