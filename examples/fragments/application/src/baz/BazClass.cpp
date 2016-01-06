
#include <iostream>
#include "baz/BazClass.h"

namespace Baz {

BazClass::BazClass()
{
}

BazClass::~BazClass()
{
}

void BazClass::doSomething()
{
    std::cout << "BazCalss::doSomething()\n";
}

} // namespace Baz
