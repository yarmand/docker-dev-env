# use chruby to set default ruby to latest version available
source /usr/local/share/chruby/chruby.sh
latest=$(ls /opt/rubies | sort | tail -1 | sed 's:/::g')
if [ -n "$latest" ] ; then
  chruby $latest
fi
export PATH RUBIES RUBYOPT RUBY_ENGINE RUBY_ROOT RUBY_VERSION
