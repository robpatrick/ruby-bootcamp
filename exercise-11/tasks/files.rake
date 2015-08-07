namespace :files do
  desc 'Lists the contents of a directory, note pattern is optional and will default to *.*'
  task :list, [:path, :pattern] do |_t, args|
    args.with_defaults(pattern: '*.*')
    path = args['path'] + File::SEPARATOR if args['path']
    puts `ls #{path}#{args['pattern']} | xargs -n 1 basename`
  end
end