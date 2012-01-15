# This lets sunspot fail silently.
Sunspot.session = Sunspot::SessionProxy::SilentFailSessionProxy.new(Sunspot.session)
