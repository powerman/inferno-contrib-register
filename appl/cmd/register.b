implement Register;

include "sys.m";
	sys: Sys;
	sprint, FD: import sys;
include "draw.m";
include "arg.m";
	arg: Arg;
include "opt/powerman/logger/module/logger.m";
	logger: Logger;
	log, ERR, WARN, NOTICE, INFO, DEBUG: import logger;
include "registries.m";
	registries: Registries;
	Service, Registry, Attributes: import registries;

Register: module
{
	init: fn(nil: ref Draw->Context, argv: list of string);
};

verbose := 0;

init(nil: ref Draw->Context, argv: list of string)
{
	sys = load Sys Sys->PATH;
	logger = load Logger Logger->PATH;
	if(logger == nil)
		raise sprint("load: Logger: %r");
	logger->init();
	arg = checkload(load Arg Arg->PATH, "Arg");
	arg->init(argv);
	logger->progname(arg->progname());
	registries = checkload(load Registries Registries->PATH, "Registries");
	registries->init();

	attrs := Attributes.new(nil);

	arg->setusage(sprint("%s [-v] [[-a attr val] …] addr", arg->progname()));
	while((p := arg->opt()) != 0)
		case p {
		'v' =>	verbose++;
		'a' =>	attr := arg->earg();
                        val := arg->earg();
			attrs.set(attr, val);
		* =>	arg->usage();
		}
	argv = arg->argv();
	if(len argv != 1)
		arg->usage();
	addr := hd argv;

	regmon(addr, attrs);
}

regmon(addr: string, attrs: ref Attributes)
{
	for(;;){
		register(addr, attrs);
	} exception {
		"fail:*" => sys->sleep(1000);
	}
}

register(addr: string, attrs: ref Attributes)
{
	reg := Registry.new(nil);
	if(reg == nil)
		fail(sprint("Registry.new: %r"));

	(srv, err) := reg.register(addr, attrs, 0);
	if(err != nil)
		fail(sprint("Registries.register: %r"));
	if(verbose)
		log(INFO,"registered: "+srv.addr+" "+attrs2str(attrs.attrs));

	e := sys->open(reg.dir+"/event", Sys->OREAD);
	if(e == nil)
		fail(sprint("open(event): %r"));
	buf := array[Sys->ATOMICIO] of byte;
	while(sys->read(e, buf, len buf) > 0)
		;
	fail(sprint("read(event): %r"));
}

attrs2str(attrs: list of (string, string)): string
{
	s := "";
	for(; attrs != nil; attrs = tl attrs)
		s += (hd attrs).t0 + "=" + (hd attrs).t1 + " ";
	if(len s > 0)
		s = s[0:len s - 1];
	return s;
}

###

fail(s: string)
{
	log(ERR, s);
	raise "fail:"+s;
}

checkload[T](x: T, s: string): T
{
	if(x == nil)
		fail(sprint("load: %s: %r", s));
	return x;
}

