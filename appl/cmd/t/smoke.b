implement T;

include "opt/powerman/tap/module/t.m";
include "sh.m";


test()
{
	plan(1);

	register := load Command "/opt/powerman/register/dis/cmd/register.dis";
	ok(register != nil, "register loaded as Command");
}
