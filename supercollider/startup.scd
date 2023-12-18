// Local server
// o = Server.default.options;
// o.inDevice_("ASIO : Focusrite USB ASIO");
// o.outDevice_("ASIO : Focusrite USB ASIO");
// o.sampleRate = 48000;
// o.numBuffers = 64;
// o.memSize = 65536;
// o.bindAddress = "0.0.0.0:42024";
// o.maxLogins = 3;
// o.recHeaderFormat = "wav";
// Server.default = s = Server.new(\aby, NetAddr("127.0.0.1", 42024), o);
// s.boot;

// Remote server
o = ServerOptions.new;
o.maxLogins = 3;
Server.default = s = Server.remote(\abyRemote, NetAddr("192.168.0.42", 42024), o);
s.ping;
s.serverRunning;
s.options.safetyClipThreshold = 1;
s.options.recHeaderFormat = "wav";
